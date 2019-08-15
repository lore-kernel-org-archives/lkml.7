Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D8EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1D5208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OKJCAs9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfHOAIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 20:08:20 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34010 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfHOAIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 20:08:19 -0400
Received: by mail-ot1-f65.google.com with SMTP id c7so2347104otp.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 17:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uGI92pBT4wjU7CSUDxKnDPZXXoJ9HToSaovQyHjBUqw=;
        b=OKJCAs9QM3AQySC5VmY3lRiFA5MWMAETr0ugV15cv4Aprd1TPNnyqWUFW/SPkg3XAb
         dG4SQnLnLNpeNVv6OF8pNrI+Ii/HuXLS1SnSi0j/YJHHrskBUP+DLQGZiU4IXcS9EuAZ
         uODfEMLKiHgJekyiQYhN4lNqH24O0XFze7YEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uGI92pBT4wjU7CSUDxKnDPZXXoJ9HToSaovQyHjBUqw=;
        b=Ox5HySW0AmQLV7C6U7A/8Vi4K2HSRiq1FsWW3iK6YpzgIyfsc5d11fyM6Sd1MA1kpz
         RAStOramRkktyua+CsM1L9s/f6iSdE33oXXNp2KPwDjZeWPhbq7XQ3cr9fGtrZPyVsx5
         xuGk+PlHo5pskS4D8FvAvs4cQ8stCVzeukzMjmxoC9WdWrbolvAIE6YL0bWVlm5ORTuV
         restA+wbBAXXNAlIE9W2yCq2SXWODncXu2UNfKQ7NlabsVcPL2U61aWzY+3urSukP2Ix
         PaKyNouqSgC2IoWjrglGlDRxFaYGMZal8qlUl/IYFiFPAgKMkilS4VEEdTVmNtUAl445
         V8ng==
X-Gm-Message-State: APjAAAV6IinTUUmhprJ0Zcrvaha5qoAv+epn5u2Yr/siEu8Qi4z7CbpD
        qSa5CNd6d/AzqKvs7hjKftxjV1wwT18=
X-Google-Smtp-Source: APXvYqx27zpTj5J6KefGrjPMrz7hKviYS9WkTrVL4ZM47jLXXxHYP74ymxuOPtTax21Cg3DcQCFpMg==
X-Received: by 2002:a9d:da1:: with SMTP id 30mr1266657ots.299.1565827697556;
        Wed, 14 Aug 2019 17:08:17 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id w21sm438792oti.52.2019.08.14.17.08.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2019 17:08:16 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id g17so1465444otl.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 17:08:16 -0700 (PDT)
X-Received: by 2002:a9d:70c6:: with SMTP id w6mr236433otj.349.1565827695529;
 Wed, 14 Aug 2019 17:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHX4x86QCrkrnPEfrup8k96wyqg=QR_vgetYLqP1AEa02fx1vw@mail.gmail.com>
 <20190813060249.GD6670@kroah.com> <CAHX4x87DbJ4cKuwVO3OS=UzwtwSucFCV073W8bYHOPHW8NiA=A@mail.gmail.com>
 <20190814212012.GB22618@kroah.com>
In-Reply-To: <20190814212012.GB22618@kroah.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Wed, 14 Aug 2019 18:08:03 -0600
X-Gmail-Original-Message-ID: <CAHX4x84YM0PcoQw17FxMz=6=NPq2+HUUw2GWZarAKzZxr+ax=A@mail.gmail.com>
Message-ID: <CAHX4x84YM0PcoQw17FxMz=6=NPq2+HUUw2GWZarAKzZxr+ax=A@mail.gmail.com>
Subject: Re: Policy to keep USB ports powered in low-power states
To:     Duncan Laurie <dlaurie@google.com>
Cc:     linux-usb@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Kurtz <djkurtz@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Duncan Laurie who I think has some more intimate knowledge
of how this is implemented in HW. Duncan, could you correct or elaborate
on my answers below as you see fit? Also, sorry if I make some beginner
mistakes here, I'm just getting familiar with the USB subsystem, and thanks for
your patience.

On Wed, Aug 14, 2019 at 3:20 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Aug 14, 2019 at 02:12:07PM -0600, Nick Crews wrote:
> > Thanks for the fast response!
> >
> > On Tue, Aug 13, 2019 at 12:02 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Aug 12, 2019 at 06:08:43PM -0600, Nick Crews wrote:
> > > > Hi Greg!
> > >
> > > Hi!
> > >
> > > First off, please fix your email client to not send html so that vger
> > > does not reject your messages :)
> >
> > Thanks, should be good now.
> >
> > >
> > > > I am working on a Chrome OS device that supports a policy called "USB Power
> > > > Share," which allows users to turn the laptop into a charge pack for their
> > > > phone. When the policy is enabled, power will be supplied to the USB ports
> > > > even when the system is in low power states such as S3 and S5. When
> > > > disabled, then no power will be supplied in S3 and S5. I wrote a driver
> > > > <https://lore.kernel.org/patchwork/patch/1062995/> for this already as part
> > > > of drivers/platform/chrome/, but Enric Balletbo i Serra, the maintainer,
> > > > had the reasonable suggestion of trying to move this into the USB subsystem.
> > >
> > > Correct suggestion.
> > >
> > > > Has anything like this been done before? Do you have any preliminary
> > > > thoughts on this before I start writing code? A few things that I haven't
> > > > figured out yet:
> > > > - How to make this feature only available on certain devices. Using device
> > > > tree? Kconfig? Making a separate driver just for this device that plugs
> > > > into the USB core?
> > > > - The feature is only supported on some USB ports, so we need a way of
> > > > filtering on a per-port basis.
> > >
> > > Look at the drivers/usb/typec/ code, I think that should do everything
> > > you need here as this is a typec standard functionality, right?
> >
> > Unfortunately this is for USB 2.0 ports, so it's not type-C.
> > Is the type-C code still worth looking at?
>
> If this is for USB 2, does it use the "non-standard" hub commands to
> turn on and off power?  If so, why not just use the usbreset userspace
> program for that?

It does not use the standard hub commands. The USB ports are controlled
by an Embedded Controller (EC), so to control this policy we send a command
to the EC. Since the command to send to the EC is very specific, this would need
to go into a "hub driver" unique for these Wilco devices. We would make it so
that the normal hub registration is intercepted by something that sees this is a
Wilco device, and instead register the hub as a "wilco-hub", which has its own
special "power_share" sysfs attribute, but still is treated as a normal USB hub
otherwise?

>
> And how are you turning a USB 2 port into a power source?  That feels
> really odd given the spec.  Is this part of the standard somewhere or
> just a firmware/hardware hack that you are adding to a device?

The EC twiddles something in the port' HW so that the port turns into a
DCP (Dedicated Charging Port) and only supplies power, not data. So I
think yes, this is a bit of a hack that does not conform to the spec.

>
> Is there some port information in the firmware that describes this
> functionality?  If so, can you expose it through sysfs to the port that
> way?

[I'm not sure I'm answering your question, but] I believe that we could
make the BIOS firmware describe the USB ports' capabilities, and the
kernel's behavior would be gated upon what the firmware reports. I see
that struct usb_port already contains a "quirks" field, should we add a
POWER_SHARE quirk to include/linux/usb/quirks.h? I would guess that
should that should be reserved for quirks shared between many USB
devices/hubs?

Thanks,
Nick

>
> thanks,
>
> greg k-h
