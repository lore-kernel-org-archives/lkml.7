Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639EFC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C51220873
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387642AbfJCTKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 15:10:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56168 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbfJCTKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:10:44 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dan.streetman@canonical.com>)
        id 1iG6Ur-0007Ff-Eg
        for linux-kernel@vger.kernel.org; Thu, 03 Oct 2019 19:10:41 +0000
Received: by mail-io1-f69.google.com with SMTP id r5so6902288iop.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 12:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zN8BjvlVM6Yfmn/ry19EbJlWmoqgSPYEwTG104xKOok=;
        b=qpn1wmjlqwzYV6tzDxT4RkvC7vcRh/HLJYL5UFAU32pkKCKfzRfJp8AY28ZChOvbC6
         sastHWXu8Q1GUAfT68AwT6iLPYuO/Y9Q3HqlUXTjbUO39742p5iUVPj+7S5nxfRQ2hXO
         X6E8/jyzLpsoMbGBlp7JJ+Ek5PQqeMdXWbjz1lLwPkd5DXB/cuwTGPKUcxo1njnH9kWi
         oenWDgLMDrGOxxn03IpS8UtqGy4M1eZmUVhIT9b13R8KwBWUymp2n7ewsYd76pwvtQPz
         wgqcaS4LOfNWzeOzh1074f3824b8mWKaV/r1uGIbyiE+RbEQPxVUz6mSsmDyR3NHVQ8P
         ELTg==
X-Gm-Message-State: APjAAAVMZrEXnhUBsHUm1JZQX+ba+muZbB1f2l8HP2KqNUFHLJX/BNfj
        nEUPZiLsj00nfv6Ee0fTz5Oc0C1m7g4f/ynU1W4p/qtm6hnA4aTf6X4lLepymhzBX8DbT0X6P3P
        C5cNr/ElfMCljEzAGoJ8a2xPu5fnbeyogjuHPBRpwCtFwhMa8XIXdL+HDOg==
X-Received: by 2002:a5e:990f:: with SMTP id t15mr9541007ioj.270.1570129840425;
        Thu, 03 Oct 2019 12:10:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy26sjHplQ5R9JDlngxIv5FBinKJp1W9/0TUghKMgjbwSflwXhiPbCTEtAtCFOgD+s1gxXlZTcQYgC4B3bmccg=
X-Received: by 2002:a5e:990f:: with SMTP id t15mr9540974ioj.270.1570129840027;
 Thu, 03 Oct 2019 12:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190927130402.687-1-ddstreet@canonical.com> <20190927181856.GD1804168@kroah.com>
In-Reply-To: <20190927181856.GD1804168@kroah.com>
From:   Dan Streetman <ddstreet@canonical.com>
Date:   Thu, 3 Oct 2019 15:10:03 -0400
Message-ID: <CAOZ2QJM+qgiYR+15rydwT6ebuL7UBfPcVp9vXCug6NSWDRS-Cg@mail.gmail.com>
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

so, I looked again and it seems quite a few places appear to do
exactly this, is it something that should be fixed?

$ git grep 'static struct device [^*{]*{'
arch/arm/kernel/dma-isa.c:static struct device isa_dma_dev = {
arch/arm/mach-rpc/dma.c:static struct device isa_dma_dev = {
arch/arm/mach-s3c24xx/s3c2410.c:static struct device s3c2410_dev = {
arch/arm/mach-s3c24xx/s3c2412.c:static struct device s3c2412_dev = {
arch/arm/mach-s3c24xx/s3c2416.c:static struct device s3c2416_dev = {
arch/arm/mach-s3c24xx/s3c2440.c:static struct device s3c2440_dev = {
arch/arm/mach-s3c24xx/s3c2442.c:static struct device s3c2442_dev = {
arch/arm/mach-s3c24xx/s3c2443.c:static struct device s3c2443_dev = {
arch/arm/mach-s3c64xx/common.c:static struct device s3c64xx_dev = {
arch/arm/mach-s3c64xx/s3c6400.c:static struct device s3c6400_dev = {
arch/arm/mach-s3c64xx/s3c6410.c:static struct device s3c6410_dev = {
arch/mips/sgi-ip22/ip22-gio.c:static struct device gio_bus = {
arch/parisc/kernel/drivers.c:static struct device root = {
arch/powerpc/platforms/ps3/system-bus.c:static struct device ps3_system_bus = {
arch/powerpc/platforms/pseries/ibmebus.c:static struct device
ibmebus_bus_device = { /* fake "parent" device */
arch/powerpc/platforms/pseries/vio.c:static struct device vio_bus = {
arch/um/drivers/virtio_uml.c:static struct device vu_cmdline_parent = {
drivers/base/isa.c:static struct device isa_bus = {
drivers/block/rbd.c:static struct device rbd_root_dev = {
drivers/gpu/drm/ttm/ttm_module.c:static struct device ttm_drm_class_device = {
drivers/iio/dummy/iio_dummy_evgen.c:static struct device iio_evgen_dev = {
drivers/iio/trigger/iio-trig-sysfs.c:static struct device iio_sysfs_trig_dev = {
drivers/misc/sgi-gru/grumain.c:static struct device gru_device = {
drivers/nubus/bus.c:static struct device nubus_parent = {
drivers/sh/maple/maple.c:static struct device maple_bus = {
drivers/sh/superhyway/superhyway.c:static struct device
superhyway_bus_device = {
drivers/soc/fsl/qe/qe_ic.c:static struct device device_qe_ic = {
drivers/virtio/virtio_mmio.c:static struct device vm_cmdline_parent = {
kernel/time/clockevents.c:static struct device tick_bc_dev = {
kernel/time/clocksource.c:static struct device device_clocksource = {


>
> What's wrong with a simple call to device_create() for your "fake"
> device you want to make here?  That's what it is there for :)
>
> thanks,
>
> greg k-h
