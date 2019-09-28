Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB11EC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 13:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D2520866
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 13:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfI1N30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 09:29:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39565 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfI1N30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 09:29:26 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dan.streetman@canonical.com>)
        id 1iECmq-00061s-N1
        for linux-kernel@vger.kernel.org; Sat, 28 Sep 2019 13:29:24 +0000
Received: by mail-io1-f69.google.com with SMTP id g15so18895355ioc.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 06:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bF3USLrRtGOtWkc8DEqoHbqfqpfLY1dkn/s/U0IIv9I=;
        b=OBr5d99XFX92AJheDQuivbR99j8AOVmvi2MqUrU2JqJKMaKsnd3yfxk+d+cyQZPkyY
         t4bXWTVoOHBZ3ExwAfR/9mCtIw2VAPugmKjnicqrSKTAWPzemufE0TjfqKtltk94x9ew
         QYxSS6QQwJxvJcBIX3BLRXuyA7O0MUCKUjRXFuuxYrfp0FSnQ2HnNiSbGC52LDd13vDn
         lD71viPNeDTGhYTBgAJfK5axoVB5o0bEdZzdPff7xcbNtH0uhP2Z9UkTjW754I50PWBm
         QdPWlpi7f5pAe0d6lqg4Cg/a1UChoOdASXnzbuRKDcHUpnPn9kaw8nBvJD+QwMViksA5
         mtTA==
X-Gm-Message-State: APjAAAUMPIS0Fj1aS1oBKvWy+0VU6XLDtWN4FZOU41mdLktysEvrrxbf
        MJiWrKu+NRRcaX253mRd4RZn51UrrJP/SczDNcQZqmvwfYxXiNt2knk0BUIpQjo8gNffxRqNhUQ
        tJIJABF13JdCXFMAHtWvU84aE/d8/886r6uNAZTtAmRlIlLSN55aT+bE+KQ==
X-Received: by 2002:a92:1a4f:: with SMTP id z15mr10893522ill.199.1569677363756;
        Sat, 28 Sep 2019 06:29:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw6TG/+XKfdalDvEwdVWY/LzoTroAcnh5FMg0wYJDGSjRqFcDHyDFELZbFI2E1ITE0cL5+p2Aqm0Z7tLRCF42Y=
X-Received: by 2002:a92:1a4f:: with SMTP id z15mr10893493ill.199.1569677363423;
 Sat, 28 Sep 2019 06:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190927130402.687-1-ddstreet@canonical.com> <20190927181856.GD1804168@kroah.com>
 <CAOZ2QJNNnkM_0ZTULHOYGY2wEz1GxZWzHjosnM=j98zxZXUvYA@mail.gmail.com> <20190928074124.GD1836895@kroah.com>
In-Reply-To: <20190928074124.GD1836895@kroah.com>
From:   Dan Streetman <ddstreet@canonical.com>
Date:   Sat, 28 Sep 2019 09:28:47 -0400
Message-ID: <CAOZ2QJP2bf=MpKgnTaW4vbLAbOpivyXgdmcijGTMezOpJWaufQ@mail.gmail.com>
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

On Sat, Sep 28, 2019 at 3:41 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Sep 27, 2019 at 03:48:49PM -0400, Dan Streetman wrote:
> > On Fri, Sep 27, 2019 at 2:19 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Fri, Sep 27, 2019 at 09:04:02AM -0400, Dan Streetman wrote:
> > > > The dummy vio_bus_device creates the /sys/devices/vio directory, which
> > > > contains real vio devices under it; since it represents itself as having
> > > > a bus = &vio_bus_type, its /sys/devices/vio/uevent does call the bus's
> > > > .uevent function, vio_hotplug(), and as that function won't find a real
> > > > device for the dummy vio_dev, it will return -ENODEV.
> > > >
> > > > One of the main users of the uevent node is udevadm, e.g. when it is called
> > > > with 'udevadm trigger --devices'.  Up until recently, it would ignore any
> > > > errors returned when writing to devices' uevent file, but it was recently
> > > > changed to start returning error if it gets an error writing to any uevent
> > > > file:
> > > > https://github.com/systemd/systemd/commit/97afc0351a96e0daa83964df33937967c75c644f
> > > >
> > > > since the /sys/devices/vio/uevent file has always returned ENODEV from
> > > > any write to it, this now causes the udevadm trigger command to return
> > > > an error.  This may be fixed in udevadm to ignore ENODEV errors, but the
> > > > vio driver should still be fixed.
> > > >
> > > > This patch changes the arch/powerpc/platform/pseries/vio.c 'dummy'
> > > > parent device into a real dummy device with no .bus, so its uevent
> > > > file will stop returning ENODEV and simply do nothing and return 0.
> > > >
> > > > Signed-off-by: Dan Streetman <ddstreet@canonical.com>
> > > > ---
> > > >  arch/powerpc/platforms/pseries/vio.c | 11 ++++-------
> > > >  1 file changed, 4 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
> > > > index 79e2287991db..63bc16631680 100644
> > > > --- a/arch/powerpc/platforms/pseries/vio.c
> > > > +++ b/arch/powerpc/platforms/pseries/vio.c
> > > > @@ -32,11 +32,8 @@
> > > >  #include <asm/page.h>
> > > >  #include <asm/hvcall.h>
> > > >
> > > > -static struct vio_dev vio_bus_device  = { /* fake "parent" device */
> > > > -     .name = "vio",
> > > > -     .type = "",
> > > > -     .dev.init_name = "vio",
> > > > -     .dev.bus = &vio_bus_type,
> > > > +static struct device vio_bus = {
> > > > +     .init_name      = "vio",
> > >
> > > Eeek, no!  Why are you creating a static device that will then be
> > > reference counted?  Not nice :(
> >
> > sorry!  I'll admit that I simply copied what drivers/base/platform.c
> > seemed to be doing.
>
> I don't see platform.c having a 'static struct device' anywhere in it,
> am I missing it in my searching?

no, you are right, what I meant was:

struct device platform_bus = {
        .init_name      = "platform",
};


>
> thanks,
>
> greg k-h
