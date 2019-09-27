Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A377C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 19:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC8120863
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 19:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfI0Tt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 15:49:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53858 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfI0Tt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 15:49:27 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dan.streetman@canonical.com>)
        id 1iDwF4-0005ji-9i
        for linux-kernel@vger.kernel.org; Fri, 27 Sep 2019 19:49:26 +0000
Received: by mail-io1-f71.google.com with SMTP id r13so14495784ioj.22
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 12:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QzSszHmZY6R6wBZpwrMnlGiFB4TaLUoa40MZxhfjcUQ=;
        b=ou9wiFS9x2rFHvOVit4SucacHkY8jW0s5+LdTTaTKEND9xB5phjzaYDs97f/kuLhee
         4/hAZFyCTVY2tJZF+/n7E7F0VYueLLo3GMsr79u4VuKCTTzH6WruqQgmC6MyngZinkl0
         SZ5pAgxkS1qHC3tlIHwYSM9CvY+rtXSWVGngNKJQOolIwTMw1J+ylFb+Yd1TxqtNSfah
         LRNnc88xRS/l2GBCB7Y2kjcVUK9NyK1Dq2U0m7b6hKqqEctFQIV1cxSonpj6GXq4h/du
         BJXoPG7BdhGQmSKgDV+aOivYYx2c/SrZbxYhgzlih1UP8MFAur/Vh3NSjuiW3iflJ0wn
         pPxw==
X-Gm-Message-State: APjAAAXfoxfd+q38qNKfvZxIRfOqd3eFbebMZnRNruC8Ow/DfkQcg6zm
        7qaL0S7vHla5ll1r1h00ZLxkVPEkVpzYP5ZjD6cBbXrEnaQYMJ34Q7vJ0xOvf+kOvZg1EGsdTay
        Gn3Bf+sYbZ0V/mUAsrmXyxSloEfvhFayTMqae+Sg2ilkVVYF1679O0ecRPw==
X-Received: by 2002:a05:6602:c9:: with SMTP id z9mr9411767ioe.28.1569613765286;
        Fri, 27 Sep 2019 12:49:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzGvhNv1kaE6ju+QP/5ILJjDu0CVwiSJXPvYACgs/yTF1cbZAIT67ZZEk6c8Kh9eh7t5f1wpnnhgFX0RTxQOCs=
X-Received: by 2002:a05:6602:c9:: with SMTP id z9mr9411730ioe.28.1569613764952;
 Fri, 27 Sep 2019 12:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190927130402.687-1-ddstreet@canonical.com> <20190927181856.GD1804168@kroah.com>
In-Reply-To: <20190927181856.GD1804168@kroah.com>
From:   Dan Streetman <ddstreet@canonical.com>
Date:   Fri, 27 Sep 2019 15:48:49 -0400
Message-ID: <CAOZ2QJNNnkM_0ZTULHOYGY2wEz1GxZWzHjosnM=j98zxZXUvYA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/vio: use simple dummy struct device as bus parent
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 2:19 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Sep 27, 2019 at 09:04:02AM -0400, Dan Streetman wrote:
> > The dummy vio_bus_device creates the /sys/devices/vio directory, which
> > contains real vio devices under it; since it represents itself as having
> > a bus = &vio_bus_type, its /sys/devices/vio/uevent does call the bus's
> > .uevent function, vio_hotplug(), and as that function won't find a real
> > device for the dummy vio_dev, it will return -ENODEV.
> >
> > One of the main users of the uevent node is udevadm, e.g. when it is called
> > with 'udevadm trigger --devices'.  Up until recently, it would ignore any
> > errors returned when writing to devices' uevent file, but it was recently
> > changed to start returning error if it gets an error writing to any uevent
> > file:
> > https://github.com/systemd/systemd/commit/97afc0351a96e0daa83964df33937967c75c644f
> >
> > since the /sys/devices/vio/uevent file has always returned ENODEV from
> > any write to it, this now causes the udevadm trigger command to return
> > an error.  This may be fixed in udevadm to ignore ENODEV errors, but the
> > vio driver should still be fixed.
> >
> > This patch changes the arch/powerpc/platform/pseries/vio.c 'dummy'
> > parent device into a real dummy device with no .bus, so its uevent
> > file will stop returning ENODEV and simply do nothing and return 0.
> >
> > Signed-off-by: Dan Streetman <ddstreet@canonical.com>
> > ---
> >  arch/powerpc/platforms/pseries/vio.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
> > index 79e2287991db..63bc16631680 100644
> > --- a/arch/powerpc/platforms/pseries/vio.c
> > +++ b/arch/powerpc/platforms/pseries/vio.c
> > @@ -32,11 +32,8 @@
> >  #include <asm/page.h>
> >  #include <asm/hvcall.h>
> >
> > -static struct vio_dev vio_bus_device  = { /* fake "parent" device */
> > -     .name = "vio",
> > -     .type = "",
> > -     .dev.init_name = "vio",
> > -     .dev.bus = &vio_bus_type,
> > +static struct device vio_bus = {
> > +     .init_name      = "vio",
>
> Eeek, no!  Why are you creating a static device that will then be
> reference counted?  Not nice :(

sorry!  I'll admit that I simply copied what drivers/base/platform.c
seemed to be doing.

>
> What's wrong with a simple call to device_create() for your "fake"
> device you want to make here?  That's what it is there for :)

ack, will send a new patch using that.  thanks!

>
> thanks,
>
> greg k-h
