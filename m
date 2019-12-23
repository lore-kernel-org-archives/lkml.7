Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C286DC2D0D2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 04:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96949206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 04:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfLWE3v convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 23:29:51 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47818 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfLWE3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 23:29:51 -0500
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1ijFLo-0007Pe-R3
        for linux-kernel@vger.kernel.org; Mon, 23 Dec 2019 04:29:48 +0000
Received: by mail-wr1-f70.google.com with SMTP id 90so7371595wrq.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 20:29:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dpoHWFqcQ1TpfseO0Nokc21cLrtit4YIE7VtBBHccsA=;
        b=JEH56UsIE4wHOcKO0UARt8wrad8pV1JJqmxaiMDtuI0dQdMrwq8lt8ICOtko6GRU74
         6l6QZCHtcuCB9REos0DzR1XduI18JhtDn0mVVTeD8bnVzsFj9EE4w8eECj8SQOvM01cL
         GcYRn0I+qsIVNCvlnwKpHoX8GCqD6xBP7aNIZ6E4PNc/5vabzuV1I9OjUtOHYatfzVQs
         taRGLbKOgpPtV3dwtAXlv4Oqd8BTK3FLpNCtvyrfZnqb1DfPXW4si6R2NRyAyoaHCRTG
         Pg1bcnkUkdPRed46kCCp9Q/QYT7GkbBxAmT/+JMpT2MPZqHy2zP3J+3XtjDAcmqjqTIm
         JX6w==
X-Gm-Message-State: APjAAAUqW0MEAoHZ18SBoOrXcPmC6zvRbpfftWdXYcBL+HtqsEstyaBj
        9IdHZuiw4tb+wfv6uei1EKFF50JC9u9UGf4pHTO8YOBPU1PCwoDonzqPD7gj0G5yZByhxmIA0mM
        r5bOMm/3PqVh/HUOHjAhxxkUFAq4DR+m/w8OZW/6+Pfp5dlDrt3GNspQyyw==
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr28533289wmd.102.1577075388553;
        Sun, 22 Dec 2019 20:29:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqzXUVi+UA1DavsCkDJBWIA4JcWT51MR9k+QDkiXMWpluAHzH7/yMod/quGq56oywTJgiXzqZ6cyOPbczgqW8Mk=
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr28533284wmd.102.1577075388321;
 Sun, 22 Dec 2019 20:29:48 -0800 (PST)
MIME-Version: 1.0
References: <20191220025917.11886-1-acelan.kao@canonical.com> <Pine.LNX.4.44L0.1912201040000.2513-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1912201040000.2513-100000@netrider.rowland.org>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Mon, 23 Dec 2019 12:29:37 +0800
Message-ID: <CAFv23Qn9h=pwaHkiMB2ci-OaR54gY6fdc1Q_7ZMz5mH7wHr9+w@mail.gmail.com>
Subject: Re: [PATCH] usb: hub: move resume delay at the head of all USB access functions
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Harry Pan <harry.pan@intel.com>,
        David Heinzelmann <heinzelmann.david@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mathieu Malaterre <malat@debian.org>,
        linux-usb@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> 於 2019年12月20日 週五 下午11:48寫道：
>
> On Fri, 20 Dec 2019, AceLan Kao wrote:
>
> > usb_control_msg() function should be called after the resume delay, or
>
> Which usb_control_msg() call are you referring to?  Is it the call
> under hub_port_status()?
usb_port_resume() -> hub_port_status() -> hub_ext_port_status()
-> get_port_status() -> usb_control_msg()

>
> > you'll encounter the below errors sometime.
> > After the issue happens, have to re-plug the USB cable to recover.
> >
> > [ 837.483573] hub 2-3:1.0: hub_ext_port_status failed (err = -71)
> > [ 837.490889] hub 2-3:1.0: hub_ext_port_status failed (err = -71)
> > [ 837.506780] usb 2-3-port4: cannot disable (err = -71)
>
> You need to do a better job of figuring out why these errors occur.  It
> is not connected to the resume delay; there must be a different reason.
> Hint: This is the sort of error you would expect to see if the kernel
> tried to resume a device while its parent hub was still suspended.
Once this error shows, the USB port doesn't work until re-plug the cable.
I have no idea what else I can do to this, do you have any idea that I
could try?
Thanks.

>
> > Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
> > ---
> >  drivers/usb/core/hub.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index f229ad6952c0..2fb2816b0d38 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -3522,6 +3522,7 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
> >               }
> >       }
> >
> > +     msleep(USB_RESUME_TIMEOUT);
>
> This makes no sense at all.  At this point we haven't even started to
> do the resume signalling, so there's no reason to wait for it to
> finish.
I thought the h/w need some time to be back to stable status when resuming.
>
> >       usb_lock_port(port_dev);
> >
> >       /* Skip the initial Clear-Suspend step for a remote wakeup */
> > @@ -3544,7 +3545,6 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
> >               /* drive resume for USB_RESUME_TIMEOUT msec */
> >               dev_dbg(&udev->dev, "usb %sresume\n",
> >                               (PMSG_IS_AUTO(msg) ? "auto-" : ""));
> > -             msleep(USB_RESUME_TIMEOUT);
>
> This is wrong also.  At this point the resume signal _is_ being sent,
> and the USB spec requires that we wait a minimum amount of time for the
> device to fully resume.
I don't see the difference that after the delay, it calls hub_port_status(), but
in the beginning of usb_port_resume() it call the same function, too.
So, I think it should be good to move the delay before the first
hub_port_status()
>
> Alan Stern
>
