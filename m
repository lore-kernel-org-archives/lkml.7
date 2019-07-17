Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CA4C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B335F21743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="S16V5SXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfGQPUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 11:20:22 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:56947 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfGQPUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 11:20:22 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x6HFKD5P027704
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 00:20:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x6HFKD5P027704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563376814;
        bh=3TozSLK5kMUzH+s4kNW02nDrcR/8bHSgN9boxF7iIZU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S16V5SXn1bRcGa3XaGA4rFkHk/Klcs+4DAUlAcYIBAPpF+fqYH88IuA9biFGQebiI
         f2MwB5Rt91fxroDTD4MQg7RBZ7PdCz7lChtN6JDVPXRcF42a/bNhTePJ3T3q7RhJyX
         n4OLjC7tl8/ZH7fe43aiRjZlR9K9EcTHVfXSHwAsc6ca6rIJFz9J0YUaieiRc4uoCP
         UZpuktuMiSkLeusCbglZtHLrWtgljGzO1zt14Dy77/lJdJlbc4aFmnMQsRbgMWDg/B
         Avs8HYUzF1FpK15kjvkFPge9BYrGN3whZWnhhr5lc84LNfkeNIKb+wnvSUPJUZ0Ikz
         D2qwFkub4EXvA==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id v6so16759462vsq.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 08:20:13 -0700 (PDT)
X-Gm-Message-State: APjAAAVbJm/bXvJ/vtgOorqF2ezhQkgsfEIMrAqvBTEXUY4/qFuwmjfz
        d/NpF42foxDHuZnZam8a7pRm+w5WBy5XQh5WZUg=
X-Google-Smtp-Source: APXvYqz+amaPLmalIGKzj7HLCo48cWg2Brzx8DqvXhMmvforw/gLcEUNcwhkX70aPBJIlyLiq9RqY7LlBaHnjbpHDqk=
X-Received: by 2002:a67:8e0a:: with SMTP id q10mr1719431vsd.215.1563376812735;
 Wed, 17 Jul 2019 08:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190713032106.8509-1-yamada.masahiro@socionext.com>
 <20190713124744.GS14074@gate.crashing.org> <20190713131642.GU14074@gate.crashing.org>
 <CAK7LNASBmZxX+U=LS+dgvet96cA3T6Tf_tiAa2vduUV81DEnBw@mail.gmail.com>
 <20190713235430.GZ14074@gate.crashing.org> <87v9w393r5.fsf@concordia.ellerman.id.au>
 <20190715072959.GB20882@gate.crashing.org> <87pnma89ak.fsf@concordia.ellerman.id.au>
 <20190717143811.GL20882@gate.crashing.org>
In-Reply-To: <20190717143811.GL20882@gate.crashing.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 18 Jul 2019 00:19:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNATesRrJFGZQOkTY+PL7FNyub5FJ0N6NF4s6icdXdPNr+Q@mail.gmail.com>
Message-ID: <CAK7LNATesRrJFGZQOkTY+PL7FNyub5FJ0N6NF4s6icdXdPNr+Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc: remove meaningless KBUILD_ARFLAGS addition
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 11:38 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Tue, Jul 16, 2019 at 10:15:47PM +1000, Michael Ellerman wrote:
> > Segher Boessenkool <segher@kernel.crashing.org> writes:
> > And it's definitely calling ar with no flags, eg:
> >
> >   rm -f init/built-in.a; powerpc-linux-ar rcSTPD init/built-in.a init/main.o init/version.o init/do_mounts.o init/do_mounts_rd.o init/do_mounts_initrd.o init/do_mounts_md.o init/initramfs.o init/init_task.o
>
> This uses thin archives.  Those will work fine.
>
> The failing case was empty files IIRC, stuff created from no inputs.

Actually, empty files are created everywhere.
I do not see any problems whether the target is 32-bit or 64-bit.


Just try allnoconfig, for example.
You can apply the following to debug.


diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index be38198d98b2..9d6b30e50663 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -413,6 +413,7 @@ quiet_cmd_ar_builtin = AR      $@
       cmd_ar_builtin = rm -f $@; $(AR) rcSTP$(KBUILD_ARFLAGS) $@
$(real-prereqs)

 $(builtin-target): $(real-obj-y) FORCE
+       @$(if $(real-prereqs),,echo creating empty archive: $@)
        $(call if_changed,ar_builtin)

 targets += $(builtin-target)

The following are all empty files created from no input.

creating empty archive: usr/built-in.a
creating empty archive: arch/powerpc/crypto/built-in.a
creating empty archive: arch/powerpc/math-emu/built-in.a
  CHK     include/generated/compile.h
creating empty archive: arch/powerpc/net/built-in.a
creating empty archive: arch/powerpc/platforms/built-in.a
creating empty archive: arch/powerpc/sysdev/built-in.a
creating empty archive: certs/built-in.a
creating empty archive: ipc/built-in.a
creating empty archive: block/built-in.a
creating empty archive: drivers/amba/built-in.a
creating empty archive: sound/built-in.a
creating empty archive: drivers/auxdisplay/built-in.a
creating empty archive: crypto/built-in.a
creating empty archive: drivers/block/built-in.a
creating empty archive: net/built-in.a
creating empty archive: drivers/bus/built-in.a
creating empty archive: drivers/cdrom/built-in.a
creating empty archive: drivers/char/ipmi/built-in.a
creating empty archive: arch/powerpc/kernel/trace/built-in.a
creating empty archive: drivers/char/agp/built-in.a
creating empty archive: virt/lib/built-in.a
creating empty archive: drivers/clk/actions/built-in.a
creating empty archive: drivers/clocksource/built-in.a
creating empty archive: drivers/clk/analogbits/built-in.a
creating empty archive: drivers/firewire/built-in.a
creating empty archive: drivers/clk/bcm/built-in.a
creating empty archive: drivers/clk/imx/built-in.a
creating empty archive: drivers/clk/imgtec/built-in.a
creating empty archive: drivers/clk/ingenic/built-in.a
creating empty archive: drivers/clk/mediatek/built-in.a
creating empty archive: drivers/gpu/drm/arm/built-in.a
creating empty archive: drivers/clk/mvebu/built-in.a
creating empty archive: drivers/firmware/broadcom/built-in.a
creating empty archive: drivers/firmware/imx/built-in.a
creating empty archive: drivers/gpu/drm/bridge/synopsys/built-in.a
creating empty archive: drivers/clk/renesas/built-in.a
creating empty archive: drivers/firmware/meson/built-in.a
creating empty archive: drivers/firmware/psci/built-in.a
creating empty archive: drivers/clk/ti/built-in.a
creating empty archive: drivers/gpu/drm/hisilicon/built-in.a
creating empty archive: drivers/firmware/tegra/built-in.a
creating empty archive: drivers/gpu/drm/i2c/built-in.a
creating empty archive: drivers/gpu/drm/omapdrm/displays/built-in.a
creating empty archive: drivers/gpu/drm/omapdrm/dss/built-in.a
creating empty archive: drivers/firmware/xilinx/built-in.a
creating empty archive: drivers/gpu/drm/panel/built-in.a
creating empty archive: drivers/gpu/drm/rcar-du/built-in.a
creating empty archive: drivers/hwtracing/intel_th/built-in.a
creating empty archive: kernel/livepatch/built-in.a
creating empty archive: drivers/gpu/drm/tilcdc/built-in.a
creating empty archive: drivers/base/firmware_loader/builtin/built-in.a
creating empty archive: drivers/base/power/built-in.a
creating empty archive: drivers/gpu/vga/built-in.a
creating empty archive: drivers/base/test/built-in.a
creating empty archive: drivers/i2c/algos/built-in.a
creating empty archive: drivers/i3c/built-in.a
creating empty archive: drivers/i2c/busses/built-in.a
creating empty archive: drivers/idle/built-in.a
creating empty archive: drivers/i2c/muxes/built-in.a
creating empty archive: drivers/iommu/built-in.a
creating empty archive: fs/devpts/built-in.a
creating empty archive: drivers/macintosh/built-in.a
creating empty archive: fs/notify/dnotify/built-in.a
creating empty archive: fs/notify/fanotify/built-in.a
creating empty archive: fs/notify/inotify/built-in.a
creating empty archive: drivers/media/common/b2c2/built-in.a
creating empty archive: drivers/media/common/saa7146/built-in.a
creating empty archive: fs/quota/built-in.a
creating empty archive: drivers/media/firewire/built-in.a
creating empty archive: drivers/media/i2c/built-in.a
creating empty archive: drivers/mfd/built-in.a
creating empty archive: drivers/media/common/siano/built-in.a
creating empty archive: drivers/media/common/v4l2-tpg/built-in.a
creating empty archive: drivers/misc/cardreader/built-in.a
creating empty archive: drivers/media/mmc/siano/built-in.a
creating empty archive: drivers/media/common/videobuf2/built-in.a
creating empty archive: drivers/media/pci/b2c2/built-in.a
creating empty archive: drivers/misc/cb710/built-in.a
creating empty archive: drivers/misc/eeprom/built-in.a
creating empty archive: drivers/media/pci/ddbridge/built-in.a
creating empty archive: drivers/misc/lis3lv02d/built-in.a
creating empty archive: drivers/media/platform/cros-ec-cec/built-in.a
creating empty archive: drivers/media/pci/dm1105/built-in.a
creating empty archive: lib/crypto/built-in.a
creating empty archive: drivers/media/rc/keymaps/built-in.a
creating empty archive: drivers/misc/mic/bus/built-in.a
creating empty archive: drivers/misc/ti-st/built-in.a
creating empty archive: drivers/media/platform/davinci/built-in.a
creating empty archive: drivers/media/pci/intel/ipu3/built-in.a
creating empty archive: drivers/media/platform/meson/built-in.a
creating empty archive: drivers/media/platform/omap/built-in.a
creating empty archive: drivers/media/pci/mantis/built-in.a
creating empty archive: drivers/mmc/built-in.a
creating empty archive: drivers/media/pci/netup_unidvb/built-in.a
creating empty archive: drivers/nfc/built-in.a
creating empty archive: drivers/media/pci/ngene/built-in.a
creating empty archive: drivers/net/dsa/b53/built-in.a
creating empty archive: drivers/media/pci/pluto2/built-in.a
creating empty archive: drivers/media/platform/stm32/built-in.a
creating empty archive: drivers/nvme/host/built-in.a
creating empty archive: drivers/nvme/target/built-in.a
creating empty archive: drivers/media/spi/built-in.a
creating empty archive: drivers/net/dsa/microchip/built-in.a
creating empty archive: drivers/net/dsa/mv88e6xxx/built-in.a
creating empty archive: drivers/media/pci/pt1/built-in.a
creating empty archive: drivers/media/tuners/built-in.a
creating empty archive: drivers/media/pci/pt3/built-in.a
creating empty archive: drivers/media/usb/b2c2/built-in.a
creating empty archive: drivers/net/phy/built-in.a
creating empty archive: drivers/media/usb/dvb-usb/built-in.a
creating empty archive: drivers/media/pci/saa7146/built-in.a
creating empty archive: drivers/net/dsa/sja1105/built-in.a
creating empty archive: drivers/media/usb/s2255/built-in.a
creating empty archive: drivers/media/pci/smipcie/built-in.a
creating empty archive: drivers/media/usb/dvb-usb-v2/built-in.a
creating empty archive: drivers/pci/controller/dwc/built-in.a
creating empty archive: drivers/media/usb/siano/built-in.a
creating empty archive: drivers/media/pci/ttpci/built-in.a
creating empty archive: drivers/pci/switch/built-in.a
creating empty archive: drivers/media/usb/stkwebcam/built-in.a
creating empty archive: drivers/platform/built-in.a
creating empty archive: drivers/power/built-in.a
creating empty archive: drivers/media/usb/ttusb-dec/built-in.a
creating empty archive: drivers/media/usb/zr364xx/built-in.a
creating empty archive: drivers/media/usb/ttusb-budget/built-in.a
creating empty archive: drivers/ptp/built-in.a
creating empty archive: drivers/pwm/built-in.a
creating empty archive: drivers/scsi/built-in.a
creating empty archive: drivers/usb/built-in.a
creating empty archive: drivers/soc/amlogic/built-in.a
creating empty archive: drivers/soc/fsl/built-in.a
creating empty archive: drivers/tty/ipwireless/built-in.a
creating empty archive: drivers/soc/bcm/built-in.a
creating empty archive: drivers/soc/mediatek/built-in.a
creating empty archive: drivers/tty/serial/built-in.a
creating empty archive: drivers/video/backlight/built-in.a
creating empty archive: drivers/tty/vt/built-in.a
creating empty archive: drivers/soc/qcom/built-in.a
creating empty archive: drivers/soc/renesas/built-in.a
creating empty archive: drivers/soc/sunxi/built-in.a
creating empty archive: drivers/soc/ti/built-in.a
creating empty archive: drivers/video/fbdev/core/built-in.a
creating empty archive: drivers/soc/xilinx/built-in.a
creating empty archive: drivers/video/fbdev/omap2/omapfb/displays/built-in.a
creating empty archive: drivers/video/fbdev/omap2/omapfb/dss/built-in.a



BTW, your commit 8995ac8702737147115e1c75879a1a2d75627b9e
dates back to 2008.

At that time, thin archive was not used.


--
Best Regards
Masahiro Yamada
