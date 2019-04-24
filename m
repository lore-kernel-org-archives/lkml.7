Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E638C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529C921773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="S4IKo4iC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfDXKrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:47:20 -0400
Received: from chill.innovation.ch ([216.218.245.220]:41038 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfDXKrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:47:19 -0400
Date:   Wed, 24 Apr 2019 03:47:18 -0700
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch C32DB640133
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1556102838;
        bh=6BDXPJ2ZJFu8vDGvEWvUwhWSHyx64CfI8MFsQ3HJLqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S4IKo4iCubUjt2y7hjPT0bMLacVFFGsjnsjkTlim0jhDycE7x2/EXbr0X5H4PWK00
         0JFKsRy7DUeK4ObcDEJ70xDxNM1FgsnnyeXENWAI+x8kevq0U64EmfOT/Vx/TsE/mV
         ASO2q4Bo84bu9uHCi4SfweFqh5bcXlnHg/9oKXpNaFldcadv9RcoLv0/o3/YtpoUWM
         GaiKCYtFTH/yzecBsaF0W04fy3tZr6fA3S1btwidzt+7SW0q3dYbC5aXfUJCxhigN6
         WA1zEQAKQWHih2dhUXBe1jnovX/XX6jYbt0U5h8Sebo/Ictx5dPXZTmYy3aSh3QrDE
         aJqnEKYY7B0BQ==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mfd: apple-ibridge: Add Apple iBridge MFD driver.
Message-ID: <20190424104718.GA31301@innovation.ch>
References: <20190422031251.11968-1-ronald@innovation.ch>
 <20190422031251.11968-2-ronald@innovation.ch>
 <20190422123426.2d0b4bdf@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190422123426.2d0b4bdf@archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi Jonathan,

On Mon, Apr 22, 2019 at 12:34:26PM +0100, Jonathan Cameron wrote:
> On Sun, 21 Apr 2019 20:12:49 -0700
> Ronald Tschalär <ronald@innovation.ch> wrote:
> 
> > The iBridge device provides access to several devices, including:
> > - the Touch Bar
> > - the iSight webcam
> > - the light sensor
> > - the fingerprint sensor
> > 
> > This driver provides the core support for managing the iBridge device
> > and the access to the underlying devices. In particular, since the
> > functionality for the touch bar and light sensor is exposed via USB HID
> > interfaces, and the same HID device is used for multiple functions, this
> > driver provides a multiplexing layer that allows multiple HID drivers to
> > be registered for a given HID device. This allows the touch bar and ALS
> > driver to be separated out into their own modules.
> > 
> > Signed-off-by: Ronald Tschalär <ronald@innovation.ch
> Hi Ronald,
> 
> I've only taken a fairly superficial look at this.  A few global
> things to note though.

Thanks for this review.

> 1. Please either use kernel-doc style for function descriptions, or
>    do not.  Right now you are sort of half way there.

Apologies, on re-reading the docs I realize what you mean here. Should
be fixed now (next rev).

> 2. There is quite a complex nest of separate structures being allocated,
>    so think about whether they can be simplified.  In particular
>    use of container_of macros can allow a lot of forwards and backwards
>    pointers to be dropped if you embed the various structures directly.

Done (see also below).

[snip]
> > +#define	call_void_driver_func(drv_info, fn, ...)			\
> 
> This sort of macro may seem like a good idea because it saves a few lines
> of code.  However, that comes at the cost of readability, so just
> put the code inline.
> 
> > +	do {								\
> > +		if ((drv_info)->driver->fn)				\
> > +			(drv_info)->driver->fn(__VA_ARGS__);		\
> > +	} while (0)
> > +
> > +#define	call_driver_func(drv_info, fn, ret_type, ...)			\
> > +	({								\
> > +		ret_type rc = 0;					\
> > +									\
> > +		if ((drv_info)->driver->fn)				\
> > +			rc = (drv_info)->driver->fn(__VA_ARGS__);	\
> > +									\
> > +		rc;							\
> > +	})

Just to clarify, you're only talking about removing/inlining the
call_void_driver_func() macro, not the call_driver_func() macro,
right?

[snip]
> > +static struct appleib_hid_dev_info *
> > +appleib_add_device(struct appleib_device *ib_dev, struct hid_device *hdev,
> > +		   const struct hid_device_id *id)
> > +{
> > +	struct appleib_hid_dev_info *dev_info;
> > +	struct appleib_hid_drv_info *drv_info;
> > +
> > +	/* allocate device-info for this device */
> > +	dev_info = kzalloc(sizeof(*dev_info), GFP_KERNEL);
> > +	if (!dev_info)
> > +		return NULL;
> > +
> > +	INIT_LIST_HEAD(&dev_info->drivers);
> > +	dev_info->device = hdev;
> > +	dev_info->device_id = id;
> > +
> > +	/* notify all our sub drivers */
> > +	mutex_lock(&ib_dev->update_lock);
> > +
> This is interesting. I'd like to see a comment here on what
> this flag is going to do. 

I'm not sure I follow: update_lock is simply a mutex protecting all
driver and device update (i.e. add/remove) functions. Are you
therefore looking for something like:

	/* protect driver and device lists against concurrent updates */
	mutex_lock(&ib_dev->update_lock);

[snip]
> > +static int appleib_probe(struct acpi_device *acpi)
> > +{
> > +	struct appleib_device *ib_dev;
> > +	struct appleib_platform_data *pdata;
> Platform_data has a lot of historical meaning in Linux.
> Also you have things in here that are not platform related
> at all, such as the dev pointer.  Hence I would rename it
> as device_data or private or something like that.

Ok. I guess I called in platform_data because it's stored in the mfd
cell's "platform_data" field. Anyway, changed it per your suggestion.

> > +	int i;
> > +	int ret;
> > +
> > +	if (appleib_dev)
> This singleton bothers me a bit. I'm really not sure why it
> is necessary.  You can just put a pointer to this in
> the pdata for the subdevs and I think that covers most of your
> usecases.  It's generally a bad idea to limit things to one instance
> of a device unless that actually major simplifications.
> I'm not seeing them here.

Yes, this one is quite ugly. appleib_dev is static so that
appleib_hid_probe() can find it. I could not find any other way to
pass the appleib_dev instance to that probe function.

However, on looking at this again, I realized that hid_device_id has
a driver_data field which can be used for this; so if I added the
hid_driver and hid_device_id structs to the appleib_device (instead of
making them static like now) I could fill in the driver_data and avoid
this hack. This looks much cleaner.

Thanks for pointing this uglyness out again.

[snip]
> > +	if (!ib_dev->subdevs) {
> > +		ret = -ENOMEM;
> > +		goto free_dev;
> > +	}
> > +
> > +	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
> 
> Might as well embed this in ib_dev as well.

Agreed.

> That would let
> you used container_of to avoid having to carry the ib_dev pointer
> around in side pdata.

I see. I guess my main reservation is that the functions exported to
the sub-drivers would now take a 'struct appleib_device_data *'
argument instead of a 'struct appleib_device *', which just seems a
bit unnatural. E.g.

  int appleib_register_hid_driver(struct appleib_device_data *ib_ddata,
                                  struct hid_driver *driver, void *data);

instead of (the current)

  int appleib_register_hid_driver(struct appleib_device *ib_dev,
                                  struct hid_driver *driver, void *data);

[snip]
> > +	ret = mfd_add_devices(&acpi->dev, PLATFORM_DEVID_NONE,
> > +			      ib_dev->subdevs, ARRAY_SIZE(appleib_subdevs),
> > +			      NULL, 0, NULL);
> > +	if (ret) {
> > +		dev_err(LOG_DEV(ib_dev), "Error adding MFD devices: %d\n", ret);
> > +		goto free_pdata;
> > +	}
> > +
> > +	acpi->driver_data = ib_dev;
> > +	appleib_dev = ib_dev;
> > +
> > +	ret = hid_register_driver(&appleib_hid_driver);
> > +	if (ret) {
> > +		dev_err(LOG_DEV(ib_dev), "Error registering hid driver: %d\n",
> > +			ret);
> > +		goto rem_mfd_devs;
> > +	}
> > +
> > +	return 0;
> > +
> > +rem_mfd_devs:
> > +	mfd_remove_devices(&acpi->dev);
> > +free_pdata:
> > +	kfree(pdata);
> > +free_subdevs:
> > +	kfree(ib_dev->subdevs);
> > +free_dev:
> > +	appleib_dev = NULL;
> > +	acpi->driver_data = NULL;
> Why at this point?  It's not set to anything until much later in the
> probe flow.

If the hid_register_driver() call fails, we get here after driver_data
has been assigned. However, looking at this again, acpi->driver_data
is only used by the remove, suspend, and resume callbacks, and those
will not be called until a successful return from probe; therefore I
can safely move the setting of driver_data to after the
hid_register_driver() call and avoid having to set it to NULL in the
error cleanup.

> May be worth thinking about devm_ managed allocations
> to cleanup some of these allocations automatically and simplify
> the error handling.

Good point, thanks.

[snip]
> > +
> > +	rc = acpi_execute_simple_method(ib_dev->asoc_socw, NULL, 0);
> > +	if (ACPI_FAILURE(rc))
> > +		dev_warn(LOG_DEV(ib_dev), "SOCW(0) failed: %s\n",
> 
> I can sort of see you might want to do the LOG_DEV for consistency
> but here I'm fairly sure it's just dev which might be clearer.

Sorry, you mean rename the macro LOG_DEV() to just DEV()?


  Cheers,

  Ronald

