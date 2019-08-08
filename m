Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8016FC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FDB2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r3sjBSxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732857AbfHHOoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 10:44:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36262 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730170AbfHHOob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:44:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so44178210pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 07:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ery/8JOuxtfMq+997gLuixOu9Kzm0qZPa0qj2ihavNQ=;
        b=r3sjBSxlIRVNM3p0qxMQNO5BC+O2DsWYch1Y05KnQn/ZjQLQz6ylRSrUSQjwGE43gh
         oXr/vlDORE6L0YRx1csiwZ9EstQVA1JG/XUpyqwfIcvJnmgW/3I0iw2CU4joPoLEOmxT
         r7UGKaHHpPXXtUcZ+5QYqzgfsnVXT2Zvl1bRBbsVjMNoNuC/F18u+IzLi/3x1FnkAKoL
         D9W+cw7fQ5YttHjXycEbfZVZmoZaR4P8sMC0s4IUc78tOn9vXmC4KcdcAj//+4xGtCwT
         q7+oJ0LlaUBL7Xg8aS0qqHThUrvTpcI8rbykNacS+mpdaqVqcV1JVnfoZ9rgmpHoRlVL
         hc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ery/8JOuxtfMq+997gLuixOu9Kzm0qZPa0qj2ihavNQ=;
        b=cc6s/HstLmk2vpv9mRfEydQ0ZdBAgmvXKZeN6nvSIWwLD6xC/jrg4FLJqUxIGhfSEA
         ExI+I/gJvnoDdmXOUVfBnjDwvQ1UMmJCuozXEpHLiATMBTRJwrHZoO0eKXWF1q0u3owL
         QBBn5u46BmKLbdNqWja1HDOzaOWedD6dfwnFOtGzirbgT6tOowxy+rkA85qC9YwERYhq
         aL+ZFGea8zFZALui9QpZOGw2dP5e7iK9zr6nKV2B/tr1A2kOoHpta8nm9RvaDItJWh/a
         sv270DBVt/70vzgvVbUnfyNfp9mG419m7G88mRUlyDFN24XeBU+OFOKlb4LFw9Liw9+X
         YPEQ==
X-Gm-Message-State: APjAAAVImphiKkAiXt2NF0bnl25LNKmevanCRcFRqtOPgkYMyAzsrIdx
        bNHWLT/va5qlMoXw4sOIxXVL2u6UlVl7v+LtShpkUA==
X-Google-Smtp-Source: APXvYqxR4xNCgPIxwobF6Y1wFngTF634/sibsaWyv1sUcM4JWvjmNEijzvGZmVRpLPO8QFxMzx4i8MEnUS9JDmLXl8k=
X-Received: by 2002:a63:c442:: with SMTP id m2mr13337853pgg.286.1565275469838;
 Thu, 08 Aug 2019 07:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <1565187142.15973.3.camel@neukum.org> <Pine.LNX.4.44L0.1908081027560.1652-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1908081027560.1652-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 8 Aug 2019 16:44:18 +0200
Message-ID: <CAAeHK+z7a3R+Lvo_0VeeMYZZqjWXgcX0qBmi0-Gcx=rDQsBPNA@mail.gmail.com>
Subject: Re: possible deadlock in open_rio
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Oliver Neukum <oliver@neukum.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzbot <syzbot+7bbcbe9c9ff0cd49592a@syzkaller.appspotmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 4:33 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, 7 Aug 2019, Oliver Neukum wrote:
>
> > Am Mittwoch, den 07.08.2019, 10:07 -0400 schrieb Alan Stern:
> > > On Wed, 7 Aug 2019, Oliver Neukum wrote:
>
> > > > technically yes. However in practical terms the straight revert I sent
> > > > out yesterday should fix it.
> > >
> > > I didn't see the revert, and it doesn't appear to have reached the
> > > mailing list archive.  Can you post it again?
> >
> > As soon as our VPN server is back up again.
>
> The revert may not be necessay; a little fix should get rid of the
> locking violation.  The key is to avoid calling the registration or
> deregistration routines while holding the rio500_mutex, and to
> recognize that the probe and disconnect routines are both protected by
> the device mutex.
>
> How does this patch look?
>
> Alan Stern
>
>
> #syz test: https://github.com/google/kasan.git 7f7867ff

There's no reproducer yet (it should appear at some point, I've
enabled fuzzing of USB char devices). I've tested your patch manually
and the deadlock report is gone. Thanks!

Tested-by: Andrey Konovalov <andreyknvl@google.com>

>
> Index: usb-devel/drivers/usb/misc/rio500.c
> ===================================================================
> --- usb-devel.orig/drivers/usb/misc/rio500.c
> +++ usb-devel/drivers/usb/misc/rio500.c
> @@ -454,52 +454,54 @@ static int probe_rio(struct usb_interfac
>  {
>         struct usb_device *dev = interface_to_usbdev(intf);
>         struct rio_usb_data *rio = &rio_instance;
> -       int retval = 0;
> +       int retval;
> +       char *ibuf, *obuf;
>
> -       mutex_lock(&rio500_mutex);
>         if (rio->present) {
>                 dev_info(&intf->dev, "Second USB Rio at address %d refused\n", dev->devnum);
> -               retval = -EBUSY;
> -               goto bail_out;
> -       } else {
> -               dev_info(&intf->dev, "USB Rio found at address %d\n", dev->devnum);
> +               return -EBUSY;
>         }
> +       dev_info(&intf->dev, "USB Rio found at address %d\n", dev->devnum);
>
>         retval = usb_register_dev(intf, &usb_rio_class);
>         if (retval) {
>                 dev_err(&dev->dev,
>                         "Not able to get a minor for this device.\n");
> -               retval = -ENOMEM;
> -               goto bail_out;
> +               goto err_register;
>         }
>
> -       rio->rio_dev = dev;
> -
> -       if (!(rio->obuf = kmalloc(OBUF_SIZE, GFP_KERNEL))) {
> +       obuf = kmalloc(OBUF_SIZE, GFP_KERNEL);
> +       if (!obuf) {
>                 dev_err(&dev->dev,
>                         "probe_rio: Not enough memory for the output buffer\n");
> -               usb_deregister_dev(intf, &usb_rio_class);
> -               retval = -ENOMEM;
> -               goto bail_out;
> +               goto err_obuf;
>         }
> -       dev_dbg(&intf->dev, "obuf address:%p\n", rio->obuf);
> +       dev_dbg(&intf->dev, "obuf address: %p\n", obuf);
>
> -       if (!(rio->ibuf = kmalloc(IBUF_SIZE, GFP_KERNEL))) {
> +       ibuf = kmalloc(IBUF_SIZE, GFP_KERNEL);
> +       if (!ibuf) {
>                 dev_err(&dev->dev,
>                         "probe_rio: Not enough memory for the input buffer\n");
> -               usb_deregister_dev(intf, &usb_rio_class);
> -               kfree(rio->obuf);
> -               retval = -ENOMEM;
> -               goto bail_out;
> +               goto err_ibuf;
>         }
> -       dev_dbg(&intf->dev, "ibuf address:%p\n", rio->ibuf);
> +       dev_dbg(&intf->dev, "ibuf address: %p\n", ibuf);
>
> +       mutex_lock(&rio500_mutex);
> +       rio->rio_dev = dev;
> +       rio->ibuf = ibuf;
> +       rio->obuf = obuf;
>         usb_set_intfdata (intf, rio);
>         rio->present = 1;
> -bail_out:
>         mutex_unlock(&rio500_mutex);
>
>         return retval;
> +
> + err_ibuf:
> +       kfree(obuf);
> + err_obuf:
> +       usb_deregister_dev(intf, &usb_rio_class);
> + err_register:
> +       return -ENOMEM;
>  }
>
>  static void disconnect_rio(struct usb_interface *intf)
> @@ -507,10 +509,10 @@ static void disconnect_rio(struct usb_in
>         struct rio_usb_data *rio = usb_get_intfdata (intf);
>
>         usb_set_intfdata (intf, NULL);
> -       mutex_lock(&rio500_mutex);
>         if (rio) {
>                 usb_deregister_dev(intf, &usb_rio_class);
>
> +               mutex_lock(&rio500_mutex);
>                 if (rio->isopen) {
>                         rio->isopen = 0;
>                         /* better let it finish - the release will do whats needed */
> @@ -524,8 +526,8 @@ static void disconnect_rio(struct usb_in
>                 dev_info(&intf->dev, "USB Rio disconnected.\n");
>
>                 rio->present = 0;
> +               mutex_unlock(&rio500_mutex);
>         }
> -       mutex_unlock(&rio500_mutex);
>  }
>
>  static const struct usb_device_id rio_table[] = {
>
