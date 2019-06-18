Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFE0C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E85B206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfFRIkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:40:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59792 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfFRIkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:40:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5286626023F
Subject: Re: [PATCH 2/2] platform/chrome: wilco_ec: Add circular buffer as
 event queue
To:     Nick Crews <ncrews@chromium.org>, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        djkurtz@chromium.org, dtor@google.com, sjg@chromium.org,
        kernel-janitors@vger.kernel.org, dan.carpenter@oracle.com
References: <20190614205631.90222-1-ncrews@chromium.org>
 <20190614205631.90222-2-ncrews@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <5e8511c7-eb50-de2b-afe9-a51e03ef607c@collabora.com>
Date:   Tue, 18 Jun 2019 10:40:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190614205631.90222-2-ncrews@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/6/19 22:56, Nick Crews wrote:
> The current implementation of the event queue both
> wastes space using a doubly linked list and isn't super
> obvious in how it behaves. This converts the queue to an
> actual circular buffer. The size of the queue is a
> tunable module parameter. This also moves the lock
> inside the queue, so the users of the queue don't have
> to deal with it. In addition, this fixes a memory leak
> that occurred when the ACPI device was removed, but the
> events were not freed from the queue.
> 
> It also fixes a bug in event_read() where the queue
> readers would not wake when the ACPI device was removed.
> This also fixes some logging, removes an unneeded lock()
> from around a check for dev_data->exist in
> hangup_device(), removes an unneeded null event pointer
> check in enqueue_events(), adds some helper macros to
> calculate the size of events, and corrects some
> comments.
> 
> Signed-off-by: Nick Crews <ncrews@chromium.org>
> ---

Applied for chrome-platform-5.3

Thanks,
~ Enric

>  drivers/platform/chrome/wilco_ec/event.c | 246 +++++++++++++----------
>  1 file changed, 143 insertions(+), 103 deletions(-)
> 
> diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
> index 1eed55681598..c975b76e6255 100644
> --- a/drivers/platform/chrome/wilco_ec/event.c
> +++ b/drivers/platform/chrome/wilco_ec/event.c
> @@ -39,6 +39,7 @@
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/poll.h>
> +#include <linux/spinlock.h>
>  #include <linux/uaccess.h>
>  #include <linux/wait.h>
>  
> @@ -69,12 +70,120 @@ static DEFINE_IDA(event_ida);
>  /* Size of circular queue of events. */
>  #define MAX_NUM_EVENTS 64
>  
> +/**
> + * struct ec_event - Extended event returned by the EC.
> + * @size: Number of 16bit words in structure after the size word.
> + * @type: Extended event type, meaningless for us.
> + * @event: Event data words.  Max count is %EC_ACPI_MAX_EVENT_WORDS.
> + */
> +struct ec_event {
> +	u16 size;
> +	u16 type;
> +	u16 event[0];
> +} __packed;
> +
> +#define ec_event_num_words(ev) (ev->size - 1)
> +#define ec_event_size(ev) (sizeof(*ev) + (ec_event_num_words(ev) * sizeof(u16)))
> +
> +/**
> + * struct ec_event_queue - Circular queue for events
> + * @capacity: Number of elements the queue cab hold.
> + * @head: Next index to write to.
> + * @tail: Next index to read from.
> + * @full: head==tail when both full and empty, so use this to differentiate.
> + * @lock: Protect the queue from simultaneous read/writes.
> + * @entries: Array of events.
> + *
> + * If an event is added when the queue is full, the oldest event is overwritten.
> + */
> +struct ec_event_queue {
> +	int capacity;
> +	int head;
> +	int tail;
> +	bool full;
> +	spinlock_t lock;
> +	struct ec_event *entries[0];
> +};
> +
> +/* Maximum number of events to store in ec_event_queue */
> +static int queue_size = 64;
> +module_param(queue_size, int, 0644);
> +
> +static struct ec_event_queue *event_queue_new(int capacity)
> +{
> +	size_t entries_size = sizeof(struct ec_event *) * capacity;
> +	struct ec_event_queue *q = kzalloc(sizeof(*q) + entries_size,
> +					   GFP_KERNEL);
> +
> +	q->capacity = capacity;
> +	spin_lock_init(&q->lock);
> +
> +	return q;
> +}
> +
> +static bool event_queue_empty(struct ec_event_queue *q)
> +{
> +	bool empty;
> +
> +	if (q->full)
> +		return false;
> +
> +	spin_lock(&q->lock);
> +	empty = q->head == q->tail;
> +	spin_unlock(&q->lock);
> +
> +	return empty;
> +}
> +
> +/* If full, free and overwrite the oldest event */
> +static void event_queue_push(struct ec_event_queue *q, struct ec_event *ev)
> +{
> +	spin_lock(&q->lock);
> +	if (q->full) {
> +		kfree(q->entries[q->head]);
> +		q->entries[q->head] = ev;
> +		q->head = (q->head + 1) % q->capacity;
> +	} else {
> +		q->entries[q->head] = ev;
> +		q->head = (q->head + 1) % q->capacity;
> +		q->full = q->head == q->tail;
> +	}
> +	if (q->full)
> +		q->tail = q->head;
> +	spin_unlock(&q->lock);
> +
> +}
> +
> +static struct ec_event *event_queue_pop(struct ec_event_queue *q)
> +{
> +	struct ec_event *ev;
> +
> +	if (event_queue_empty(q))
> +		return NULL;
> +
> +	spin_lock(&q->lock);
> +	ev = q->entries[q->tail];
> +	q->tail = (q->tail + 1) % q->capacity;
> +	q->full = false;
> +	spin_unlock(&q->lock);
> +
> +	return ev;
> +}
> +
> +static void event_queue_free(struct ec_event_queue *q)
> +{
> +	struct ec_event *event;
> +
> +	while ((event = event_queue_pop(q)) != NULL)
> +		kfree(event);
> +
> +	kfree(q);
> +}
> +
>  /**
>   * struct event_device_data - Data for a Wilco EC device that responds to ACPI.
>   * @events: Circular queue of EC events to be provided to userspace.
> - * @num_events: Number of events in the queue.
> - * @lock: Mutex to guard the queue.
> - * @wq: Wait queue to notify processes when events or available or the
> + * @wq: Wait queue to notify processes when events are available or the
>   *	device has been removed.
>   * @cdev: Char dev that userspace reads() and polls() from.
>   * @dev: Device associated with the %cdev.
> @@ -84,14 +193,12 @@ static DEFINE_IDA(event_ida);
>   *
>   * There will be one of these structs for each ACPI device registered. This data
>   * is the queue of events received from ACPI that still need to be read from
> - * userspace (plus a supporting lock and wait queue), as well as the device and
> - * char device that userspace is using, plus a flag on whether the ACPI device
> - * has been removed.
> + * userspace, the device and char device that userspace is using, a wait queue
> + * used to notify different threads when something has changed, plus a flag
> + * on whether the ACPI device has been removed.
>   */
>  struct event_device_data {
> -	struct list_head events;
> -	size_t num_events;
> -	struct mutex lock;
> +	struct ec_event_queue *events;
>  	wait_queue_head_t wq;
>  	struct device dev;
>  	struct cdev cdev;
> @@ -99,31 +206,6 @@ struct event_device_data {
>  	atomic_t available;
>  };
>  
> -/**
> - * struct ec_event - Extended event returned by the EC.
> - * @size: Number of words in structure after the size word.
> - * @type: Extended event type from &enum ec_event_type.
> - * @event: Event data words.  Max count is %EC_ACPI_MAX_EVENT_WORDS.
> - */
> -struct ec_event {
> -	u16 size;
> -	u16 type;
> -	u16 event[0];
> -} __packed;
> -
> -/**
> - * struct ec_event_entry - Event queue entry.
> - * @list: List node.
> - * @size: Number of bytes in event structure.
> - * @event: Extended event returned by the EC.  This should be the last
> - *         element because &struct ec_event includes a zero length array.
> - */
> -struct ec_event_entry {
> -	struct list_head list;
> -	size_t size;
> -	struct ec_event event;
> -};
> -
>  /**
>   * enqueue_events() - Place EC events in queue to be read by userspace.
>   * @adev: Device the events came from.
> @@ -132,7 +214,7 @@ struct ec_event_entry {
>   *
>   * %buf contains a number of ec_event's, packed one after the other.
>   * Each ec_event is of variable length. Start with the first event, copy it
> - * into a containing ev_event_entry, store that entry in a list, move on
> + * into a persistent ec_event, store that entry in the queue, move on
>   * to the next ec_event in buf, and repeat.
>   *
>   * Return: 0 on success or negative error code on failure.
> @@ -140,20 +222,15 @@ struct ec_event_entry {
>  static int enqueue_events(struct acpi_device *adev, const u8 *buf, u32 length)
>  {
>  	struct event_device_data *dev_data = adev->driver_data;
> -	struct ec_event *event;
> -	struct ec_event_entry *entry, *oldest_entry;
> -	size_t event_size, num_words, word_size;
> +	struct ec_event *event, *queue_event;
> +	size_t num_words, event_size;
>  	u32 offset = 0;
>  
>  	while (offset < length) {
>  		event = (struct ec_event *)(buf + offset);
> -		if (!event)
> -			return -EINVAL;
>  
> -		/* Number of 16bit event data words is size - 1 */
> -		num_words = event->size - 1;
> -		word_size = num_words * sizeof(u16);
> -		event_size = sizeof(*event) + word_size;
> +		num_words = ec_event_num_words(event);
> +		event_size = ec_event_size(event);
>  		if (num_words > EC_ACPI_MAX_EVENT_WORDS) {
>  			dev_err(&adev->dev, "Too many event words: %zu > %d\n",
>  				num_words, EC_ACPI_MAX_EVENT_WORDS);
> @@ -170,31 +247,12 @@ static int enqueue_events(struct acpi_device *adev, const u8 *buf, u32 length)
>  		/* Point to the next event in the buffer */
>  		offset += event_size;
>  
> -		/* Create event entry for the queue */
> -		entry = kzalloc(sizeof(struct ec_event_entry) + word_size,
> -				GFP_KERNEL);
> -		if (!entry)
> +		/* Copy event into the queue */
> +		queue_event = kzalloc(event_size, GFP_KERNEL);
> +		if (!queue_event)
>  			return -ENOMEM;
> -		entry->size = event_size;
> -		memcpy(&entry->event, event, entry->size);
> -
> -		mutex_lock(&dev_data->lock);
> -
> -		/* If the queue is full, delete the oldest event */
> -		if (dev_data->num_events >= MAX_NUM_EVENTS) {
> -			oldest_entry = list_first_entry(&dev_data->events,
> -						      struct ec_event_entry,
> -						      list);
> -			list_del(&oldest_entry->list);
> -			kfree(oldest_entry);
> -			dev_data->num_events--;
> -		}
> -
> -		/* Add this event to the queue */
> -		list_add_tail(&entry->list, &dev_data->events);
> -		dev_data->num_events++;
> -
> -		mutex_unlock(&dev_data->lock);
> +		memcpy(queue_event, event, event_size);
> +		event_queue_push(dev_data->events, queue_event);
>  	}
>  
>  	return 0;
> @@ -250,7 +308,7 @@ static void event_device_notify(struct acpi_device *adev, u32 value)
>  	enqueue_events(adev, obj->buffer.pointer, obj->buffer.length);
>  	kfree(obj);
>  
> -	if (dev_data->num_events)
> +	if (!event_queue_empty(dev_data->events))
>  		wake_up_interruptible(&dev_data->wq);
>  }
>  
> @@ -281,7 +339,7 @@ static __poll_t event_poll(struct file *filp, poll_table *wait)
>  	poll_wait(filp, &dev_data->wq, wait);
>  	if (!dev_data->exist)
>  		return EPOLLHUP;
> -	if (dev_data->num_events)
> +	if (!event_queue_empty(dev_data->events))
>  		mask |= EPOLLIN | EPOLLRDNORM | EPOLLPRI;
>  	return mask;
>  }
> @@ -293,8 +351,7 @@ static __poll_t event_poll(struct file *filp, poll_table *wait)
>   * @count: Number of bytes requested. Must be at least EC_ACPI_MAX_EVENT_SIZE.
>   * @pos: File position pointer, irrelevant since we don't support seeking.
>   *
> - * Fills the passed buffer with the data from the first event in the queue,
> - * removes that event from the queue. On error, the event remains in the queue.
> + * Removes the first event from the queue, places it in the passed buffer.
>   *
>   * If there are no events in the the queue, then one of two things happens,
>   * depending on if the file was opened in nonblocking mode: If in nonblocking
> @@ -307,7 +364,7 @@ static ssize_t event_read(struct file *filp, char __user *buf, size_t count,
>  			  loff_t *pos)
>  {
>  	struct event_device_data *dev_data = filp->private_data;
> -	struct ec_event_entry *entry;
> +	struct ec_event *event;
>  	ssize_t n_bytes_written = 0;
>  	int err;
>  
> @@ -315,39 +372,25 @@ static ssize_t event_read(struct file *filp, char __user *buf, size_t count,
>  	if (count != 0 && count < EC_ACPI_MAX_EVENT_SIZE)
>  		return -EINVAL;
>  
> -	mutex_lock(&dev_data->lock);
> -
> -	while (dev_data->num_events == 0) {
> -		if (filp->f_flags & O_NONBLOCK) {
> -			mutex_unlock(&dev_data->lock);
> +	while ((event = event_queue_pop(dev_data->events)) == NULL) {
> +		if (filp->f_flags & O_NONBLOCK)
>  			return -EAGAIN;
> -		}
> -		/* Need to unlock so that data can actually get added to the
> -		 * queue, and since we recheck before use and it's just
> -		 * comparing pointers, this is safe unlocked.
> -		 */
> -		mutex_unlock(&dev_data->lock);
> +
>  		err = wait_event_interruptible(dev_data->wq,
> -					       dev_data->num_events);
> +					!event_queue_empty(dev_data->events) ||
> +					!dev_data->exist);
>  		if (err)
>  			return err;
>  
>  		/* Device was removed as we waited? */
>  		if (!dev_data->exist)
>  			return -ENODEV;
> -		mutex_lock(&dev_data->lock);
>  	}
>  
> -	entry = list_first_entry(&dev_data->events,
> -				 struct ec_event_entry, list);
> -	n_bytes_written = entry->size;
> -	if (copy_to_user(buf, &entry->event, n_bytes_written))
> +	n_bytes_written = ec_event_size(event);
> +	if (copy_to_user(buf, event, n_bytes_written))
>  		n_bytes_written = -EFAULT;
> -	list_del(&entry->list);
> -	kfree(entry);
> -	dev_data->num_events--;
> -
> -	mutex_unlock(&dev_data->lock);
> +	kfree(event);
>  
>  	return n_bytes_written;
>  }
> @@ -384,15 +427,13 @@ static void free_device_data(struct device *d)
>  	struct event_device_data *dev_data;
>  
>  	dev_data = container_of(d, struct event_device_data, dev);
> +	event_queue_free(dev_data->events);
>  	kfree(dev_data);
>  }
>  
>  static void hangup_device(struct event_device_data *dev_data)
>  {
> -	mutex_lock(&dev_data->lock);
>  	dev_data->exist = false;
> -	mutex_unlock(&dev_data->lock);
> -
>  	/* Wake up the waiting processes so they can close. */
>  	wake_up_interruptible(&dev_data->wq);
>  	put_device(&dev_data->dev);
> @@ -420,7 +461,7 @@ static int event_device_add(struct acpi_device *adev)
>  	minor = ida_alloc_max(&event_ida, EVENT_MAX_DEV-1, GFP_KERNEL);
>  	if (minor < 0) {
>  		error = minor;
> -		dev_err(&adev->dev, "Failed to find minor number: %d", error);
> +		dev_err(&adev->dev, "Failed to find minor number: %d\n", error);
>  		return error;
>  	}
>  
> @@ -432,8 +473,7 @@ static int event_device_add(struct acpi_device *adev)
>  
>  	/* Initialize the device data. */
>  	adev->driver_data = dev_data;
> -	INIT_LIST_HEAD(&dev_data->events);
> -	mutex_init(&dev_data->lock);
> +	dev_data->events = event_queue_new(queue_size);
>  	init_waitqueue_head(&dev_data->wq);
>  	dev_data->exist = true;
>  	atomic_set(&dev_data->available, 1);
> @@ -496,14 +536,14 @@ static int __init event_module_init(void)
>  
>  	ret = class_register(&event_class);
>  	if (ret) {
> -		pr_err(DRV_NAME ": Failed registering class: %d", ret);
> +		pr_err(DRV_NAME ": Failed registering class: %d\n", ret);
>  		return ret;
>  	}
>  
>  	/* Request device numbers, starting with minor=0. Save the major num. */
>  	ret = alloc_chrdev_region(&dev_num, 0, EVENT_MAX_DEV, EVENT_DEV_NAME);
>  	if (ret) {
> -		pr_err(DRV_NAME ": Failed allocating dev numbers: %d", ret);
> +		pr_err(DRV_NAME ": Failed allocating dev numbers: %d\n", ret);
>  		goto destroy_class;
>  	}
>  	event_major = MAJOR(dev_num);
> 
