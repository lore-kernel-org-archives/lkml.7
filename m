Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9D0C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730C221744
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfIBQY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 12:24:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:33341 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfIBQY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 12:24:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 09:24:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="187032591"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 02 Sep 2019 09:24:22 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i4p7s-0004nA-WD; Mon, 02 Sep 2019 19:24:20 +0300
Date:   Mon, 2 Sep 2019 19:24:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Vincent Palatin <vpalatin@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_chardev: Add a poll handler
 to receive MKBP events
Message-ID: <20190902162420.GU2680@smile.fi.intel.com>
References: <20190902160848.4738-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902160848.4738-1-enric.balletbo@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 06:08:48PM +0200, Enric Balletbo i Serra wrote:
> Allow to poll on the cros_ec device to receive the MKBP events.
> 
> The /dev/cros_[ec|fp|..] file operations now implements the poll
> operation. The userspace can now receive specific MKBP events by doing
> the
> following:
> - Open the /dev/cros_XX file.
> - Call the CROS_EC_DEV_IOCEVENTMASK ioctl with the bitmap of the MKBP
>   events it wishes to receive as argument.
> - Poll on the file descriptor.
> - When it gets POLLIN, do a read on the file descriptor, the first
>   queued event will be returned (using the struct
>   ec_response_get_next_event format: one byte of event type, then
>   the payload).
> 
> The read() operation returns at most one event even if there are several
> queued, and it might be truncated if the buffer is smaller than the
> event (but the caller should know the maximum size of the events it is
> reading).
> 
> read() used to return the EC version string, it still does it when no
> event mask or an empty event is set for backward compatibility (despite
> nobody really using this feature).
> 
> This will be used, for example, by the userspace daemon to receive and
> treat the EC_MKBP_EVENT_FINGERPRINT sent by the FP MCU.
> 

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Note that this patch depends on the immutable branch [1] to apply
> cleanly.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/log/?h=ib-mfd-extcon-hid-i2c-iio-input-media-chrome-power-pwm-rtc-sound-5.4
> 
> 
> Changes in v2:
> - Moved the code to the cros_ec_chardev driver.
> 
>  drivers/platform/chrome/cros_ec_chardev.c     | 177 +++++++++++++++++-
>  include/linux/platform_data/cros_ec_chardev.h |   1 +
>  2 files changed, 173 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
> index 08abd7e5c7bf..eabb1fe85688 100644
> --- a/drivers/platform/chrome/cros_ec_chardev.c
> +++ b/drivers/platform/chrome/cros_ec_chardev.c
> @@ -16,21 +16,42 @@
>  #include <linux/mfd/cros_ec.h>
>  #include <linux/miscdevice.h>
>  #include <linux/module.h>
> +#include <linux/notifier.h>
>  #include <linux/platform_data/cros_ec_chardev.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
>  #include <linux/platform_device.h>
> +#include <linux/poll.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
>  
>  #define DRV_NAME		"cros-ec-chardev"
>  
> +/* Arbitrary bounded size for the event queue */
> +#define CROS_MAX_EVENT_LEN	PAGE_SIZE
> +
>  struct chardev_data {
>  	struct cros_ec_dev *ec_dev;
>  	struct miscdevice misc;
>  };
>  
> +struct chardev_priv {
> +	struct cros_ec_dev *ec_dev;
> +	struct notifier_block notifier;
> +	wait_queue_head_t wait_event;
> +	unsigned long event_mask;
> +	struct list_head events;
> +	size_t event_len;
> +};
> +
> +struct ec_event {
> +	struct list_head node;
> +	size_t size;
> +	u8 event_type;
> +	u8 data[0];
> +};
> +
>  static int ec_get_version(struct cros_ec_dev *ec, char *str, int maxlen)
>  {
>  	static const char * const current_image_name[] = {
> @@ -69,6 +90,71 @@ static int ec_get_version(struct cros_ec_dev *ec, char *str, int maxlen)
>  	return ret;
>  }
>  
> +static int ec_mkbp_event(struct notifier_block *nb,
> +			 unsigned long queued_during_suspend,
> +			 void *_notify)
> +{
> +	struct chardev_priv *priv = container_of(nb, struct chardev_priv,
> +						 notifier);
> +	struct cros_ec_device *ec_dev = priv->ec_dev->ec_dev;
> +	struct ec_event *event;
> +	unsigned long event_bit = 1 << ec_dev->event_data.event_type;
> +	int total_size = sizeof(*event) + ec_dev->event_size;
> +
> +	if (!(event_bit & priv->event_mask) ||
> +	    (priv->event_len + total_size) > CROS_MAX_EVENT_LEN)
> +		return NOTIFY_DONE;
> +
> +	event = kzalloc(total_size, GFP_KERNEL);
> +	if (!event)
> +		return NOTIFY_DONE;
> +
> +	event->size = ec_dev->event_size;
> +	event->event_type = ec_dev->event_data.event_type;
> +	memcpy(event->data, &ec_dev->event_data.data, ec_dev->event_size);
> +
> +	spin_lock(&priv->wait_event.lock);
> +	list_add_tail(&event->node, &priv->events);
> +	priv->event_len += total_size;
> +	wake_up_locked(&priv->wait_event);
> +	spin_unlock(&priv->wait_event.lock);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct ec_event *ec_fetch_event(struct chardev_priv *priv, bool fetch,
> +				       bool block)
> +{
> +	struct ec_event *event;
> +	int err;
> +
> +	spin_lock(&priv->wait_event.lock);
> +	if (!block && list_empty(&priv->events)) {
> +		event = ERR_PTR(-EWOULDBLOCK);
> +		goto out;
> +	}
> +
> +	if (!fetch) {
> +		event = NULL;
> +		goto out;
> +	}
> +
> +	err = wait_event_interruptible_locked(priv->wait_event,
> +					      !list_empty(&priv->events));
> +	if (err) {
> +		event = ERR_PTR(err);
> +		goto out;
> +	}
> +
> +	event = list_first_entry(&priv->events, struct ec_event, node);
> +	list_del(&event->node);
> +	priv->event_len -= sizeof(*event) + event->size;
> +
> +out:
> +	spin_unlock(&priv->wait_event.lock);
> +	return event;
> +}
> +
>  /*
>   * Device file ops
>   */
> @@ -76,11 +162,40 @@ static int cros_ec_chardev_open(struct inode *inode, struct file *filp)
>  {
>  	struct miscdevice *mdev = filp->private_data;
>  	struct cros_ec_dev *ec_dev = dev_get_drvdata(mdev->parent);
> +	struct chardev_priv *priv;
> +	int ret;
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
>  
> -	filp->private_data = ec_dev;
> +	priv->ec_dev = ec_dev;
> +	filp->private_data = priv;
> +	INIT_LIST_HEAD(&priv->events);
> +	init_waitqueue_head(&priv->wait_event);
>  	nonseekable_open(inode, filp);
>  
> -	return 0;
> +	priv->notifier.notifier_call = ec_mkbp_event;
> +	ret = blocking_notifier_chain_register(&ec_dev->ec_dev->event_notifier,
> +					       &priv->notifier);
> +	if (ret) {
> +		dev_err(ec_dev->dev, "failed to register event notifier\n");
> +		kfree(priv);
> +	}
> +
> +	return ret;
> +}
> +
> +static __poll_t cros_ec_chardev_poll(struct file *filp, poll_table *wait)
> +{
> +	struct chardev_priv *priv = filp->private_data;
> +
> +	poll_wait(filp, &priv->wait_event, wait);
> +
> +	if (list_empty(&priv->events))
> +		return 0;
> +
> +	return EPOLLIN | EPOLLRDNORM;
>  }
>  
>  static ssize_t cros_ec_chardev_read(struct file *filp, char __user *buffer,
> @@ -88,14 +203,42 @@ static ssize_t cros_ec_chardev_read(struct file *filp, char __user *buffer,
>  {
>  	char msg[sizeof(struct ec_response_get_version) +
>  		 sizeof(CROS_EC_DEV_VERSION)];
> -	struct cros_ec_dev *ec = filp->private_data;
> +	struct chardev_priv *priv = filp->private_data;
> +	struct cros_ec_dev *ec_dev = priv->ec_dev;
>  	size_t count;
>  	int ret;
>  
> +	if (priv->event_mask) { /* queued MKBP event */
> +		struct ec_event *event;
> +
> +		event = ec_fetch_event(priv, length != 0,
> +				       !(filp->f_flags & O_NONBLOCK));
> +		if (IS_ERR(event))
> +			return PTR_ERR(event);
> +		/*
> +		 * length == 0 is special - no IO is done but we check
> +		 * for error conditions.
> +		 */
> +		if (length == 0)
> +			return 0;
> +
> +		/* The event is 1 byte of type plus the payload */
> +		count = min(length, event->size + 1);
> +		ret = copy_to_user(buffer, &event->event_type, count);
> +		kfree(event);
> +		if (ret) /* the copy failed */
> +			return -EFAULT;
> +		*offset = count;
> +		return count;
> +	}
> +
> +	/*
> +	 * Legacy behavior if no event mask is defined
> +	 */
>  	if (*offset != 0)
>  		return 0;
>  
> -	ret = ec_get_version(ec, msg, sizeof(msg));
> +	ret = ec_get_version(ec_dev, msg, sizeof(msg));
>  	if (ret)
>  		return ret;
>  
> @@ -108,6 +251,24 @@ static ssize_t cros_ec_chardev_read(struct file *filp, char __user *buffer,
>  	return count;
>  }
>  
> +static int cros_ec_chardev_release(struct inode *inode, struct file *filp)
> +{
> +	struct chardev_priv *priv = filp->private_data;
> +	struct cros_ec_dev *ec_dev = priv->ec_dev;
> +	struct ec_event *event, *e;
> +
> +	blocking_notifier_chain_unregister(&ec_dev->ec_dev->event_notifier,
> +					   &priv->notifier);
> +
> +	list_for_each_entry_safe(event, e, &priv->events, node) {
> +		list_del(&event->node);
> +		kfree(event);
> +	}
> +	kfree(priv);
> +
> +	return 0;
> +}
> +
>  /*
>   * Ioctls
>   */
> @@ -181,7 +342,8 @@ static long cros_ec_chardev_ioctl_readmem(struct cros_ec_dev *ec,
>  static long cros_ec_chardev_ioctl(struct file *filp, unsigned int cmd,
>  				   unsigned long arg)
>  {
> -	struct cros_ec_dev *ec = filp->private_data;
> +	struct chardev_priv *priv = filp->private_data;
> +	struct cros_ec_dev *ec = priv->ec_dev;
>  
>  	if (_IOC_TYPE(cmd) != CROS_EC_DEV_IOC)
>  		return -ENOTTY;
> @@ -191,6 +353,9 @@ static long cros_ec_chardev_ioctl(struct file *filp, unsigned int cmd,
>  		return cros_ec_chardev_ioctl_xcmd(ec, (void __user *)arg);
>  	case CROS_EC_DEV_IOCRDMEM:
>  		return cros_ec_chardev_ioctl_readmem(ec, (void __user *)arg);
> +	case CROS_EC_DEV_IOCEVENTMASK:
> +		priv->event_mask = arg;
> +		return 0;
>  	}
>  
>  	return -ENOTTY;
> @@ -198,7 +363,9 @@ static long cros_ec_chardev_ioctl(struct file *filp, unsigned int cmd,
>  
>  static const struct file_operations chardev_fops = {
>  	.open		= cros_ec_chardev_open,
> +	.poll		= cros_ec_chardev_poll,
>  	.read		= cros_ec_chardev_read,
> +	.release	= cros_ec_chardev_release,
>  	.unlocked_ioctl	= cros_ec_chardev_ioctl,
>  #ifdef CONFIG_COMPAT
>  	.compat_ioctl	= cros_ec_chardev_ioctl,
> diff --git a/include/linux/platform_data/cros_ec_chardev.h b/include/linux/platform_data/cros_ec_chardev.h
> index 973b2615aa02..7de8faaf77df 100644
> --- a/include/linux/platform_data/cros_ec_chardev.h
> +++ b/include/linux/platform_data/cros_ec_chardev.h
> @@ -33,5 +33,6 @@ struct cros_ec_readmem {
>  #define CROS_EC_DEV_IOC       0xEC
>  #define CROS_EC_DEV_IOCXCMD   _IOWR(CROS_EC_DEV_IOC, 0, struct cros_ec_command)
>  #define CROS_EC_DEV_IOCRDMEM  _IOWR(CROS_EC_DEV_IOC, 1, struct cros_ec_readmem)
> +#define CROS_EC_DEV_IOCEVENTMASK _IO(CROS_EC_DEV_IOC, 2)
>  
>  #endif /* _CROS_EC_DEV_H_ */
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


