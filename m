Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98295C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5076D206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KxxqzQc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfKNPIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:08:45 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43064 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfKNPIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:08:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so3944074pgh.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 07:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FS9ecpLcFB1B7piQhDj0gFFInQRBofxBZjpvw4N9uqI=;
        b=KxxqzQc6vbBRDfR8rbxklcNaXWmB2LDIelcXLyZifjPr5b/AsK+D/xAZIo1Dj3d2Bg
         qo4EWLy4k/7swjxaNWtHtluGq0Sr5mCBcZygOY4T/1/+mQo9+ZTyIvQ01vdaJx1LKCIi
         nsDb1JdzQ1AAW42F2i8+wzpyF3qNdUrtX4Jrw3a0MwggTePCvWym1HJmBzeysKoO8ITs
         AcZXYcadv2v8LofuXL4vDaq4RmYPG606tudj74x4duXPX0QHqkRAgBv3tsy6If8zWwZE
         uqKZUvExCNfOG+76qLIjolPkK0pZ6vbzBSNwlyWP8sCf9dO8H1VDxqVZCIxG2r7ldXDP
         CaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FS9ecpLcFB1B7piQhDj0gFFInQRBofxBZjpvw4N9uqI=;
        b=K2vb2FSs/pVG1p9FZrrHErP6O0v8ZUg3mV+CKXpa5bLXntxqEDzPLQlf6pXuihcdlF
         YYx42pdg6BAGEnT+xQpc3mNBw74enBCnRsKPGg5voSWd/Y7m+oPeF1hFzBrD2i1D1q9D
         22LALqlHpCr9fH4hK4bnijLodYhUGtrtRksYu3v4F9NY5ogz8kkeBfd2bErAhkBdhkN6
         Mj5SIv+ROwKQ6nj6Bgl2HH2sBP96FTqBblWRLS6L1NcYBj+SdtMzq5OR8BaNEQ9bzHmU
         wiv3nf+eaI9uagudjmc1NNVPD1ODc4h5M7h1PPWvawmorrYNC0lK5VQnPCU9LtuQkvzT
         n+IA==
X-Gm-Message-State: APjAAAXBc4LLrVNN1cgiCCeuXqib2pIk6nXPqW0uQ3/furYUJUyQ1fpz
        2XGCAiEsQQ5MiTeLzcXG3bg66bBTu5tfwaCTwU07JQ==
X-Google-Smtp-Source: APXvYqxN7eRgHfrCntKntY30RoJYCevqDLjKF47+gGs+0VDNf5xILmbsCcHoZlm1ry9SB/8nTUSlafqpavn+b+GUPJk=
X-Received: by 2002:a63:9d0f:: with SMTP id i15mr10865746pgd.286.1573744121314;
 Thu, 14 Nov 2019 07:08:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573236684.git.andreyknvl@google.com> <282c5da077ad53ce4e5ff9b4350bbf62b33bb6a9.1573236684.git.andreyknvl@google.com>
 <20191108211745.GA1282512@kroah.com>
In-Reply-To: <20191108211745.GA1282512@kroah.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 14 Nov 2019 16:08:29 +0100
Message-ID: <CAAeHK+w-nB4MngSNhazkZAa-Ovdu1C45HaD6XCPoJ79qRo8keQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] usb: gadget: add raw-gadget interface
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Felipe Balbi <balbi@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 10:17 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Nov 08, 2019 at 07:26:55PM +0100, Andrey Konovalov wrote:
> > USB Raw Gadget is a kernel module that provides a userspace interface for
> > the USB Gadget subsystem. Essentially it allows to emulate USB devices
> > from userspace. Enabled with CONFIG_USB_RAW_GADGET. Raw Gadget is
> > currently a strictly debugging feature and shouldn't be used in
> > production.
> >
> > Raw Gadget is similar to GadgetFS, but provides a more low-level and
> > direct access to the USB Gadget layer for the userspace. The key
> > differences are:
> >
> > 1. Every USB request is passed to the userspace to get a response, while
> >    GadgetFS responds to some USB requests internally based on the provided
> >    descriptors. However note, that the UDC driver might respond to some
> >    requests on its own and never forward them to the Gadget layer.
> >
> > 2. GadgetFS performs some sanity checks on the provided USB descriptors,
> >    while Raw Gadget allows you to provide arbitrary data as responses to
> >    USB requests.
> >
> > 3. Raw Gadget provides a way to select a UDC device/driver to bind to,
> >    while GadgetFS currently binds to the first available UDC.
> >
> > 4. Raw Gadget uses predictable endpoint names (handles) across different
> >    UDCs (as long as UDCs have enough endpoints of each required transfer
> >    type).
> >
> > 5. Raw Gadget has ioctl-based interface instead of a filesystem-based one.
>
> I like the idea, and you've shown that you can do neat stuff with this,
> so that's a good proof-of-concept.
>
> But, at the least, use a "real" char device node for this, not debugfs.
> Switch this to a misc device and I'll be glad to review it.

Will do in v2.

>
> Some minor nits that jump out at me other than debugfs:
>
> > +static void raw_event_queue_destroy(struct raw_event_queue *queue)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < queue->size; i++) {
> > +             pr_debug("freeing event[%d] = %px\n", i, queue->events[i]);
>
> You still have a lot of debugging messages in here.  Most of these can
> be removed, as ftrace is useful instead now that you "know" the code
> works properly.

Will do in v2.

>
> > +             kfree(queue->events[i]);
> > +     }
> > +     queue->size = 0;
> > +}
> > +
> > +/*----------------------------------------------------------------------*/
> > +
> > +struct raw_dev;
> > +
> > +#define USB_RAW_MAX_ENDPOINTS 32
> > +
> > +enum ep_state {
> > +     STATE_EP_DISABLED,
> > +     STATE_EP_ENABLED,
> > +};
> > +
> > +struct raw_ep {
> > +     struct raw_dev          *dev;
> > +     enum ep_state           state;
> > +     struct usb_ep           *ep;
> > +     struct usb_request      *req;
> > +     bool                    urb_queued;
> > +     bool                    disabling;
> > +     ssize_t                 status;
> > +};
> > +
> > +enum dev_state {
> > +     STATE_DEV_INVALID = 0,
> > +     STATE_DEV_OPENED,
> > +     STATE_DEV_INITIALIZED,
> > +     STATE_DEV_RUNNING,
> > +     STATE_DEV_CLOSED,
> > +     STATE_DEV_FAILED
> > +};
> > +
> > +struct raw_dev {
> > +     refcount_t                      count;
>
> Why not just use a "real" struct device?
>
> Or a kref at the least, no need to roll your own refcount logic here,
> right?

Will do in v2.

>
> > +     spinlock_t                      lock;
> > +
> > +     const char                      *udc_name;
> > +     struct usb_gadget_driver        driver;
> > +
> > +     /* Protected by lock: */
> > +     enum dev_state                  state;
> > +     bool                            gadget_registered;
> > +     struct usb_gadget               *gadget;
> > +     struct usb_request              *req;
> > +     bool                            ep0_in_pending;
> > +     bool                            ep0_out_pending;
> > +     bool                            ep0_urb_queued;
> > +     ssize_t                         ep0_status;
> > +     struct raw_ep                   eps[USB_RAW_MAX_ENDPOINTS];
> > +
> > +     struct completion               ep0_done;
> > +     struct raw_event_queue          queue;
> > +};
> > +
> > +static struct raw_dev *dev_new(void)
> > +{
> > +     struct raw_dev *dev;
> > +
> > +     dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> > +     if (!dev)
> > +             return NULL;
> > +     refcount_set(&dev->count, 1); /* Matches dev_put() in raw_release(). */
> > +     spin_lock_init(&dev->lock);
> > +     init_completion(&dev->ep0_done);
> > +     raw_event_queue_init(&dev->queue);
> > +     pr_debug("device created\n");
> > +     return dev;
> > +}
> > +
> > +static inline void dev_get(struct raw_dev *dev)
> > +{
> > +     refcount_inc(&dev->count);
> > +}
> > +
> > +static void dev_put(struct raw_dev *dev)
> > +{
> > +     int i;
> > +
> > +     if (likely(!refcount_dec_and_test(&dev->count)))
> > +             return;
>
> unless you can measure it, don't use likely/unlikely as the compiler and
> cpu can almost always get it right instead.

Will do in v2.

>
> > +     kfree(dev->udc_name);
> > +     kfree(dev->driver.udc_name);
> > +     if (dev->req) {
> > +             if (dev->ep0_urb_queued)
> > +                     usb_ep_dequeue(dev->gadget->ep0, dev->req);
> > +             usb_ep_free_request(dev->gadget->ep0, dev->req);
> > +     }
> > +     raw_event_queue_destroy(&dev->queue);
> > +     for (i = 0; i < USB_RAW_MAX_ENDPOINTS; i++) {
> > +             if (dev->eps[i].state != STATE_EP_ENABLED)
> > +                     continue;
> > +             usb_ep_disable(dev->eps[i].ep);
> > +             usb_ep_free_request(dev->eps[i].ep, dev->eps[i].req);
> > +             kfree(dev->eps[i].ep->desc);
> > +             dev->eps[i].state = STATE_EP_DISABLED;
> > +     }
> > +     kfree(dev);
> > +     pr_debug("device freed\n");
>
> ftrace :)
>
> > +static void gadget_unbind(struct usb_gadget *gadget)
> > +{
> > +     struct raw_dev *dev = get_gadget_data(gadget);
> > +     unsigned long flags;
> > +
> > +     if (WARN_ON(!dev))
> > +             return;
>
> Why warn?  How can this happen?

This shouldn't happen and I initially had BUG_ON there, but checkpatch
complained. I can use BUG_ON of leave it as WARN_ON, which would you
prefer?

>
> > +     spin_lock_irqsave(&dev->lock, flags);
> > +     set_gadget_data(gadget, NULL);
> > +     spin_unlock_irqrestore(&dev->lock, flags);
> > +     dev_put(dev); /* Matches dev_get() in gadget_bind(). */
> > +     pr_debug("unbound\n");
> > +}
> > +
> > +static int gadget_setup(struct usb_gadget *gadget,
> > +                     const struct usb_ctrlrequest *ctrl)
> > +{
> > +     int ret = 0;
> > +     struct raw_dev *dev = get_gadget_data(gadget);
> > +     unsigned long flags;
> > +
> > +     pr_debug("bRequestType: 0x%x (%s), bRequest: 0x%x,\n"
> > +             "                   wValue: 0x%x, wIndex: 0x%x, wLength: %d\n",
> > +             ctrl->bRequestType,
> > +             (ctrl->bRequestType & USB_DIR_IN) ? "IN" : "OUT",
> > +             ctrl->bRequest, ctrl->wValue, ctrl->wIndex, ctrl->wLength);
> > +
> > +     if (WARN_ON(!dev))
> > +             return -ENODEV;
>
> Same here.
>
> > +     spin_lock_irqsave(&dev->lock, flags);
> > +     if (dev->state != STATE_DEV_RUNNING) {
> > +             pr_err("ignoring, device is not running\n");
> > +             ret = -ENODEV;
> > +             goto out_unlock;
> > +     }
> > +     pr_debug("in_pending: %d, out_pending: %d\n",
> > +                     dev->ep0_in_pending, dev->ep0_out_pending);
> > +     if (dev->ep0_in_pending || dev->ep0_out_pending) {
> > +             pr_debug("stalling, already have pending request\n");
> > +             ret = -EBUSY;
> > +             goto out_unlock;
> > +     }
> > +     if ((ctrl->bRequestType & USB_DIR_IN) && ctrl->wLength) {
> > +             pr_debug("ep0_in_pending <= true\n");
> > +             dev->ep0_in_pending = true;
> > +     } else {
> > +             pr_debug("ep0_out_pending <= true\n");
> > +             dev->ep0_out_pending = true;
> > +     }
> > +     spin_unlock_irqrestore(&dev->lock, flags);
> > +
> > +     ret = raw_queue_event(dev, USB_RAW_EVENT_CONTROL, sizeof(*ctrl), ctrl);
> > +     if (ret < 0)
> > +             pr_err("failed to queue event\n");
> > +     pr_debug("event queued\n");
> > +     goto out;
> > +
> > +out_unlock:
> > +     spin_unlock_irqrestore(&dev->lock, flags);
> > +out:
> > +     return ret;
> > +}
> > +
> > +static void gadget_disconnect(struct usb_gadget *gadget)
> > +{
> > +     pr_debug("ignoring\n");
> > +}
> > +
> > +static void gadget_suspend(struct usb_gadget *gadget)
> > +{
> > +     pr_debug("ignoring\n");
> > +}
> > +
> > +static void gadget_resume(struct usb_gadget *gadget)
> > +{
> > +     pr_debug("ignoring\n");
> > +}
> > +
> > +static void gadget_reset(struct usb_gadget *gadget)
> > +{
> > +     pr_debug("ignoring\n");
> > +}
>
> I think you don't even need functions for these, right?  If not, just
> remove.  If you do, we should fix the gadget core to not require them :)

Will do in v2.

>
> > +
> > +/*----------------------------------------------------------------------*/
> > +
> > +static int raw_open(struct inode *inode, struct file *fd)
> > +{
> > +     struct raw_dev *dev;
> > +
> > +     dev = dev_new();
> > +     if (!dev) {
> > +             pr_err("failed to created device");
>
> So many error messages printed on failures, you only needed the original
> one if memory was gone that the core sent out.

What do you mean by the original one? I see only one error printed in
case dev_new() fails. However I'm not sure if there's much value in
printing an error in case the kernel ran out of memory, as it doesn't
handle this very well anyway AFAIK. Should I remove this pr_err?

>
> > +             return -ENOMEM;
> > +     }
> > +     fd->private_data = dev;
> > +     dev->state = STATE_DEV_OPENED;
> > +     pr_debug("device opened");
> > +     return 0;
> > +}
> > +
> > +static int raw_release(struct inode *inode, struct file *fd)
> > +{
> > +     int ret = 0;
> > +     struct raw_dev *dev = fd->private_data;
> > +     unsigned long flags;
> > +     bool unregister = false;
> > +
> > +     if (!dev)
> > +             return -EBUSY;
>
> How can that happen?

It shouldn't, will switch to WARN_ON/BUG_ON.

>
> > +
> > +     spin_lock_irqsave(&dev->lock, flags);
> > +     dev->state = STATE_DEV_CLOSED;
> > +     pr_debug("device is closed\n");
> > +     if (!dev->gadget) {
> > +             spin_unlock_irqrestore(&dev->lock, flags);
> > +             goto out_put;
> > +     }
> > +     if (dev->gadget_registered)
> > +             unregister = true;
> > +     dev->gadget_registered = false;
> > +     spin_unlock_irqrestore(&dev->lock, flags);
> > +
> > +     if (unregister) {
> > +             ret = usb_gadget_unregister_driver(&dev->driver);
> > +             WARN_ON(ret != 0);
> > +             dev_put(dev); /* Matches dev_get() in raw_ioctl_run(). */
> > +     }
> > +
> > +out_put:
> > +     dev_put(dev); /* Matches dev_new() in raw_open(). */
> > +     pr_debug("device released");
> > +     return ret;
> > +}
> > +
> > +/*----------------------------------------------------------------------*/
> > +
> > +#define UDC_NAME_LENGTH_MAX 128
> > +
> > +static int raw_ioctl_init(struct raw_dev *dev, unsigned long value)
> > +{
> > +     int ret = 0;
> > +     struct usb_raw_init arg;
> > +     char *udc_driver_name;
> > +     char *udc_device_name;
> > +     unsigned long flags;
> > +
> > +     ret = copy_from_user(&arg, (void __user *)value, sizeof(arg));
> > +     if (ret)
> > +             return ret;
> > +
> > +     switch (arg.speed) {
> > +     case USB_SPEED_LOW:
> > +     case USB_SPEED_FULL:
> > +     case USB_SPEED_HIGH:
> > +     case USB_SPEED_SUPER:
> > +             break;
> > +     default:
> > +             arg.speed = USB_SPEED_HIGH;
> > +     }
> > +
> > +     udc_driver_name = kmalloc(UDC_NAME_LENGTH_MAX, GFP_KERNEL);
> > +     if (!udc_driver_name)
> > +             return -ENOMEM;
> > +     ret = strncpy_from_user(udc_driver_name, arg.driver_name,
> > +                                     UDC_NAME_LENGTH_MAX);
> > +     if (ret < 0) {
> > +             kfree(udc_driver_name);
> > +             return ret;
> > +     }
> > +     ret = 0;
> > +     pr_debug("udc_driver_name: %s\n", udc_driver_name);
> > +
> > +     udc_device_name = kmalloc(UDC_NAME_LENGTH_MAX, GFP_KERNEL);
> > +     if (!udc_device_name) {
> > +             kfree(udc_driver_name);
> > +             return -ENOMEM;
> > +     }
> > +     ret = strncpy_from_user(udc_device_name, arg.device_name,
> > +                                     UDC_NAME_LENGTH_MAX);
>
> You are burying the max size of names in the .c code, put it in the .h
> to give userspace a chance.

Will do in v2.

>
> > +static bool check_ep_caps(struct usb_ep *ep,
> > +                             struct usb_endpoint_descriptor *desc)
> > +{
> > +     switch (desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) {
> > +     case USB_ENDPOINT_XFER_ISOC:
>
> We have functions/macros for endpoint types, right?  Can't you use them
> here?

Will do in v2.

>
> > +             if (!ep->caps.type_iso)
> > +                     return false;
> > +             break;
> > +     case USB_ENDPOINT_XFER_BULK:
> > +             if (!ep->caps.type_bulk)
> > +                     return false;
> > +             break;
> > +     case USB_ENDPOINT_XFER_INT:
> > +             if (!ep->caps.type_int)
> > +                     return false;
> > +             break;
> > +     default:
> > +             return false;
> > +     }
> > +
> > +     switch (desc->bEndpointAddress & USB_ENDPOINT_DIR_MASK) {
> > +     case USB_DIR_IN:
>
> Same here, we have macros for this.

Will do in v2.

>
> > +static int __init raw_init(void)
> > +{
> > +     raw_file = debugfs_create_file("raw-gadget", 0600,
> > +                     usb_debug_root, NULL, &raw_ops);
> > +     if (!raw_file) {
>
> this return value will never be NULL no matter what.  So you just tested
> for an impossiblity :)
>
> In the future, there's never a new to check any return value for any
> debugfs calls, it's not an issue.
>
> > +             pr_err("failed to create raw-gadget in debugfs\n");
> > +             return -ENOMEM;
> > +     }
> > +     return 0;
> > +}
> > +
> > +static void __exit raw_exit(void)
> > +{
> > +     if (!raw_file)
> > +             return;
>
> No need to check:
>
> > +     debugfs_remove(raw_file);
>
> that call can take NULL
>
> > +     raw_file = NULL;
>
> No need for this :)
>
> > +/*
> > + * struct usb_raw_init - argument for USB_RAW_IOCTL_INIT ioctl.
> > + * @speed: The speed of the emulated USB device, takes the same values as
> > + *     the usb_device_speed enum: USB_SPEED_FULL, USB_SPEED_HIGH, etc.
> > + * @driver_name: The name of the UDC driver.
> > + * @device_name: The name of a UDC instance.
> > + *
> > + * The last two fields identify a UDC the gadget driver should bind to.
> > + * For example, Dummy UDC has "dummy_udc" as its driver_name and "dummy_udc.N"
> > + * as its device_name, where N in the index of the Dummy UDC instance.
> > + * At the same time the dwc2 driver that is used on Raspberry Pi Zero, has
> > + * "20980000.usb" as both driver_name and device_name.
> > + */
> > +struct usb_raw_init {
> > +     uint64_t        speed;
> > +     const char      *driver_name;
> > +     const char      *device_name;
>
> If you have structures crossing the user/kernel boundry, always use the
> correct data types.  Those start with "__".  So this would be __u32 and
> __u8 * instead.

Will do in v2, here and below.

>
> > +};
> > +
> > +/* The type of event fetched with the USB_RAW_IOCTL_EVENT_FETCH ioctl. */
> > +enum usb_raw_event_type {
> > +     USB_RAW_EVENT_INVALID,
> > +
> > +     /* This event is queued when the driver has bound to a UDC. */
> > +     USB_RAW_EVENT_CONNECT,
> > +
> > +     /* This event is queued when a new control request arrived to ep0. */
> > +     USB_RAW_EVENT_CONTROL,
> > +
> > +     /* The list might grow in the future. */
> > +};
> > +
> > +/*
> > + * struct usb_raw_event - argument for USB_RAW_IOCTL_EVENT_FETCH ioctl.
> > + * @type: The type of the fetched event.
> > + * @length: Length of the data buffer. Updated by the driver and set to the
> > + *     actual length of the fetched event data.
> > + * @data: A buffer to store the fetched event data.
> > + *
> > + * Currently the fetched data buffer is empty for USB_RAW_EVENT_CONNECT,
> > + * and contains struct usb_ctrlrequest for USB_RAW_EVENT_CONTROL.
> > + */
> > +struct usb_raw_event {
> > +     uint32_t        type;
> > +     uint32_t        length;
> > +     char            data[0];
>
> __u32 please.
>
> > +};
> > +
> > +#define USB_RAW_IO_FLAGS_ZERO        0x0001
> > +#define USB_RAW_IO_FLAGS_MASK        0x0001
> > +
> > +static int usb_raw_io_flags_valid(uint16_t flags)
> > +{
> > +     return (flags & ~USB_RAW_IO_FLAGS_MASK) == 0;
> > +}
> > +
> > +static int usb_raw_io_flags_zero(uint16_t flags)
> > +{
> > +     return (flags & USB_RAW_IO_FLAGS_ZERO);
> > +}
> > +
> > +/*
> > + * struct usb_raw_ep_io - argument for USB_RAW_IOCTL_EP0/EP_WRITE/READ ioctls.
> > + * @ep: Endpoint handle as returned by USB_RAW_IOCTL_EP_ENABLE for
> > + *     USB_RAW_IOCTL_EP_WRITE/READ. Ignored for USB_RAW_IOCTL_EP0_WRITE/READ.
> > + * @flags: When USB_RAW_IO_FLAGS_ZERO is specified, the zero flag is set on
> > + *     the submitted USB request, see include/linux/usb/gadget.h for details.
> > + * @length: Length of data.
> > + * @data: Data to send for USB_RAW_IOCTL_EP0/EP_WRITE. Buffer to store received
> > + *     data for USB_RAW_IOCTL_EP0/EP_READ.
> > + */
> > +struct usb_raw_ep_io {
> > +     uint16_t        ep;
> > +     uint16_t        flags;
>
> __u16
>
> > +     uint32_t        length;
> > +     char            data[0];
> > +};
> > +
> > +/*
> > + * Initializes a Raw Gadget instance.
> > + * Accepts a pointer to the usb_raw_init struct as an argument.
> > + * Returns 0 on success or negative error code on failure.
> > + */
> > +#define USB_RAW_IOCTL_INIT           _IOW('U', 0, struct usb_raw_init)
> > +
> > +/*
> > + * Instructs Raw Gadget to bind to a UDC and start emulating a USB device.
> > + * Returns 0 on success or negative error code on failure.
> > + */
> > +#define USB_RAW_IOCTL_RUN            _IO('U', 1)
> > +
> > +/*
> > + * A blocking ioctl that waits for an event and returns fetched event data to
> > + * the user.
> > + * Accepts a pointer to the usb_raw_event struct.
> > + * Returns 0 on success or negative error code on failure.
> > + */
> > +#define USB_RAW_IOCTL_EVENT_FETCH    _IOR('U', 2, struct usb_raw_event)
> > +
> > +/*
> > + * Queues an IN (OUT for READ) urb as a response to the last control request
> > + * received on endpoint 0, provided that was an IN (OUT for READ) request and
> > + * waits until the urb is completed. Copies received data to user for READ.
> > + * Accepts a pointer to the usb_raw_ep_io struct as an argument.
> > + * Returns length of trasferred data on success or negative error code on
> > + * failure.
> > + */
> > +#define USB_RAW_IOCTL_EP0_WRITE              _IOW('U', 3, struct usb_raw_ep_io)
> > +#define USB_RAW_IOCTL_EP0_READ               _IOWR('U', 4, struct usb_raw_ep_io)
> > +
> > +/*
> > + * Finds an endpoint that supports the transfer type specified in the
> > + * descriptor and enables it.
> > + * Accepts a pointer to the usb_endpoint_descriptor struct as an argument.
> > + * Returns enabled endpoint handle on success or negative error code on failure.
> > + */
> > +#define USB_RAW_IOCTL_EP_ENABLE              _IOW('U', 5, struct usb_endpoint_descriptor)
> > +
> > +/* Disables specified endpoint.
> > + * Accepts endpoint handle as an argument.
> > + * Returns 0 on success or negative error code on failure.
> > + */
> > +#define USB_RAW_IOCTL_EP_DISABLE     _IOW('U', 6, int)
>
> __u32, right?
>
>
> > +
> > +/*
> > + * Queues an IN (OUT for READ) urb as a response to the last control request
> > + * received on endpoint usb_raw_ep_io.ep, provided that was an IN (OUT for READ)
> > + * request and waits until the urb is completed. Copies received data to user
> > + * for READ.
> > + * Accepts a pointer to the usb_raw_ep_io struct as an argument.
> > + * Returns length of trasferred data on success or negative error code on
> > + * failure.
> > + */
> > +#define USB_RAW_IOCTL_EP_WRITE               _IOW('U', 7, struct usb_raw_ep_io)
> > +#define USB_RAW_IOCTL_EP_READ                _IOWR('U', 8, struct usb_raw_ep_io)
> > +
> > +/*
> > + * Switches the gadget into the configured state.
> > + * Returns 0 on success or negative error code on failure.
> > + */
> > +#define USB_RAW_IOCTL_CONFIGURE              _IO('U', 9)
> > +
> > +/*
> > + * Constrains UDC VBUS power usage.
> > + * Accepts current limit in 2 mA units as an argument.
> > + * Returns 0 on success or negative error code on failure.
> > + */
> > +#define USB_RAW_IOCTL_VBUS_DRAW              _IOW('U', 10, uint32_t)
>
> __u32
>
> thanks,
>
> greg k-h

Thanks!
