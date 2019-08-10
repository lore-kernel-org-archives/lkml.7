Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3FDC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 17:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11CDA208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 17:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIrCtW1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfHJRqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 13:46:21 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42430 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfHJRqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 13:46:21 -0400
Received: by mail-vs1-f66.google.com with SMTP id 190so67496964vsf.9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AEntuySBG0zsBLly2aDJ07C0bQOMPNvcDrp9bNgL/cI=;
        b=qIrCtW1X14qDRT8lxlAKjRvjVL6/7deCL7/HGYVQgXs3i0ESfXZN3z9SB4XZ6tE4rZ
         iTUOrP+eC9LmszKZgP+IcsStR/oxotFKDN5ysttH7O9gHqyXL33i3grv1VfOWedbOMi0
         fdyHFSKE7xr4R2KAAbNF1V620qBq9GDPB0UG8AUwNO6UZYFZ8jDMtDHucbBcO2Be5i8k
         7s9mX2Y2y9nIu3QFPYswtIo32618Q6m0dZ3l5Tpi09S/urVdvqUypmorcODukwGYfp0X
         3sjXnZktz37IMIcFIMEcxp6JERleM6rWNyDeXtzwqgbT07+FfzViAFpLr6lNnCzT/XUs
         9W5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AEntuySBG0zsBLly2aDJ07C0bQOMPNvcDrp9bNgL/cI=;
        b=qOY5ypD2r8WF58x1T3bF1bThf5NSfV19lF0+LAJhe2bzHRhKeYJrIUe4F3Klqw3llv
         KFexa8124qQBAdWpj90gC/nxgL/FiFOQEkH8U5/QQXkldA4xdBm8Fl4s/T4baWDyQAc0
         ocO7BKPQhz6sfxVHpU5tX4PtVqdhEDoCQk8dDSfsTNFvWApjfnuEeO9Va3dJkfKs1qih
         qrPaTYpLHgAgld2mOkBC1HW10tkbGeWtA3FS/XCHOJrkEnxMIRP9yyHlGBecDLw6B2o5
         tmOUS8DiZDIdA8ykNX/2j950F/5GA1CkRkad1MlqDg+tiSHQMQBPqtwS02fnbxCWzWi3
         AhOw==
X-Gm-Message-State: APjAAAUUaQs7cZgdI1yG4avaiE1w7Pp1NYW7lsqRqo4zNkeX2M6Mrl0G
        gBOmT4b8Asz/8mjfrsFklZzi8vNIzWySip/Lvas43g8h
X-Google-Smtp-Source: APXvYqyqlE2xP/rDwv0+NTyUZrM3z46u5d1DNq4VdqvLiHty0lcKBZQFi0e60e1NCK8Wq7K4IKeA49IbD3W0XK3j/iE=
X-Received: by 2002:a67:d410:: with SMTP id c16mr18067758vsj.61.1565459180353;
 Sat, 10 Aug 2019 10:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190810123808.13845-1-oded.gabbay@gmail.com> <20190810125344.GE15251@kroah.com>
 <CAFCwf10SV0w-HQHuONSmdcDYFjmCJN3PLzc89MQMO4j37Qum=w@mail.gmail.com> <20190810172317.GA4482@kroah.com>
In-Reply-To: <20190810172317.GA4482@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sat, 10 Aug 2019 20:45:54 +0300
Message-ID: <CAFCwf12E7CQFG1=etvYogp7rvg8+R=hYR0OBD3j1Zqba1u5Hug@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: print to kernel log when reset is finished
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 8:23 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Aug 10, 2019 at 06:29:16PM +0300, Oded Gabbay wrote:
> > On Sat, Aug 10, 2019 at 3:53 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sat, Aug 10, 2019 at 03:38:08PM +0300, Oded Gabbay wrote:
> > > > Now that we don't print the queue testing messages, we need to print when
> > > > the reset is finished so whoever looks at the kernel log will know the
> > > > reset process was finished successfully and the driver is not stuck.
> > > >
> > > > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > > > ---
> > > >  drivers/misc/habanalabs/device.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
> > > > index 9a5926888b99..1fac808c2546 100644
> > > > --- a/drivers/misc/habanalabs/device.c
> > > > +++ b/drivers/misc/habanalabs/device.c
> > > > @@ -907,6 +907,8 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
> > > >       else
> > > >               hdev->soft_reset_cnt++;
> > > >
> > > > +     dev_info(hdev->dev, "Successfully finished resetting the device\n");
> > >
> > > Really?  For doing things "properly" there is no need to spam the kernel
> > > log.  Only spit stuff out if an error happens.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > I beg to differ for two reasons:
> > 1. Reset happens very rarely, if at all. So this message (that get
> > printed after reset is done) will definitely not spam the kernel log.
> > 2. When a reset starts we print an appropriate error message. I think
> > it is expected by the user that we will also print if and when the
> > reset has finished successfully. I really believe that lack of this
> > printing might be deceiving for users.
>
> How is anyone going to parse the kernel log for anything to know if
> something happens?

Actually our jenkins server parse the kernel log and look for bad
messages from the driver...
But the main reason for this, IMO, is for developers (in userspace)
that run with a terminal open on the kernel log to see if something
bad happens while they run their applications.

>
> How do you trigger a reset?  Is it done by userspace?  If so, just
> notify them then.

Reset can be triggered by two main reasons, but a userspace
application is *not* one of them.
It can be due to a command submission not finishing in time or from a
major error in the device (e.g. double ECC error).
That's why I think it is important to tell them the reset +
re-initialization flow was finished successfully.
Of course all this information, let's call it operational status, can
be acquired by the INFO IOCTL the driver provides, but it is *really*
convenient, IMHO, to see these type of messages in the kernel log
while they happen.

>
> thanks,
>
> greg k-h
