Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D56C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD4C20880
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="2L8T+6k4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfDGWyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 18:54:51 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54117 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfDGWyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 18:54:50 -0400
Received: by mail-it1-f194.google.com with SMTP id y204so17834725itf.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 15:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Ki1jfNcBHACAtc8apsauXngU3rDTU8VC3hy7HIfILQ=;
        b=2L8T+6k4a/ge/CyCa3xH/AprAbCEt0t+bAxxGfqkxH98zrk+AJ20tWm8JXf7HpQNSF
         oum6V0a4ODZvEEcXd9EBwK31SXBthqe1/EH2Lk7KSXMKdAEgCT9D6wBtGiA4XI57B+ST
         kOmmLxaajXIPdBWgJbktQ6Qqlbre2F06mkZgjQd844a7w5Y9TgTBdpau1/gHKFxVNtc+
         2ygrUZ2ODn3omEBeeKDmWUati52LlcGlyvDqOH7ONY5q1ZYz81tdPGd/PWm07q3uFAjo
         4PXOTDf1Ep3mLAIpexpoYG1qebJmmjVAO/4h4mbDhZl5s5U8v21U0XARQu9lVicODsn9
         c+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Ki1jfNcBHACAtc8apsauXngU3rDTU8VC3hy7HIfILQ=;
        b=WUpzm6lf4XqnDOHBT/3M0UmPho2EDqPGJyYCc5w4nrmW1IB4810KVN/FYBzEVuwY1G
         cORtVV3T/lda5IADNKBw7oAduBkwffqkxDuO3gjY6kFV1tB+6zQEYESUDbiVeoBEQa9L
         TiJi7GC9SH+V+AWwez8FiUNVSTZ4r0zaV1RzAm1X899pabz/a8EXI+RdOhU622P68m58
         B09em4sifKHPfHdMvOtw9qO34w6VPf06ZwJC1eLmipU0IH5bxx5CmKvVeKKkN3iQcDUB
         H8AsEAjBRyHGzjQk+tXbEteLaGPwpvI7YbZ1pxdf5+KuPD+zVAx9A0Fjm8WLbg/EGhkK
         1GlA==
X-Gm-Message-State: APjAAAXzntk1Ea8x+qyXqa2tpXGWK9vAkgVIvmk6GSNE1F9L8wm8S6Um
        ijdGnf4SAyxBfjf5a261O72MZkfzcjFVWqTblR2fzQ==
X-Google-Smtp-Source: APXvYqzH6yshPTYjP8C1vZnfrYLC05eLcFSMV0pJAMYT7OBS2coMy0cWyFCrRQ50xLaWfqWuGp/ofAnyI7d2af/32P8=
X-Received: by 2002:a02:c7c8:: with SMTP id s8mr18953807jao.13.1554677689093;
 Sun, 07 Apr 2019 15:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190407225020.64gf2b57mv47vfuv@localhost>
In-Reply-To: <20190407225020.64gf2b57mv47vfuv@localhost>
From:   Olof Johansson <olof@lixom.net>
Date:   Sun, 7 Apr 2019 15:54:37 -0700
Message-ID: <CAOesGMiJMD1et0rCichHgE+sAUT4_WiXS6f0pkWTiiaJEgYCGQ@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ARM-SoC Maintainers <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 7, 2019 at 3:50 PM Olof Johansson <olof@lixom.net> wrote:
>
> Hi Linus,
>
> The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:
>
>   Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes
>
> for you to fetch changes up to 9a8f32038a74cb800e9649afbf4b3dba2b7d6539:
>
>   ARM: milbeaut: fix build with !CONFIG_HOTPLUG_CPU (2019-04-07 15:29:55 -0700)
>
> ----------------------------------------------------------------
> ARM: SoC fixes
>
> A collection of fixes from the last few weeks. Most of them are smaller
> tweaks and fixes to DT and hardware descriptions for boards. Some of the
> more significant ones are:
>
>  - eMMC and RGMII stability tweaks for rk3288
>  - DDC fixes for Rock PI 4
>  - Audio fixes for two TI am335x eval boards
>  - D_CAN clock fix for am335x
>  - Compilation fixes for clang
>  - !SMP compilation fix for one of the new platforms this release (milbeaut)

Whoops: CONFIG_HOTPLUG_CPU=n, not CONFIG_SMP=n.


-Olof

>  - A revert of a gpio fix for nomadik that instead was fixed in the gpio
>    subsystem
>  - Whitespace fix for the DT JSON schema (no tabs allowed)
>
> ----------------------------------------------------------------
> Arnd Bergmann (3):
>       ARM: orion: don't use using 64-bit DMA masks
>       ARM: iop: don't use using 64-bit DMA masks
>       ARM: milbeaut: fix build with !CONFIG_HOTPLUG_CPU
>
> Axel Lin (1):
>       reset: meson-audio-arb: Fix missing .owner setting of reset_controller_dev
>
> David Engraf (1):
>       ARM: dts: at91: Fix typo in ISC_D0 on PC9
>
> David Summers (1):
>       ARM: dts: rockchip: Fix SD card detection on rk3288-tinker
>
> Dinh Nguyen (1):
>       arm64: dts: stratix10: add the sysmgr-syscon property from the gmac's
>
> Douglas Anderson (3):
>       ARM: dts: rockchip: Fix gpu opp node names for rk3288
>       ARM: dts: rockchip: Remove #address/#size-cells from rk3288 mipi_dsi
>       ARM: dts: rockchip: Remove #address/#size-cells from rk3288-veyron gpio-keys
>
> Ezequiel Garcia (1):
>       arm64: dts: rockchip: add DDC bus on Rock Pi 4
>
> Janusz Krzysztofik (1):
>       ARM: OMAP1: ams-delta: Fix broken GPIO ID allocation
>
> Jonas Karlman (1):
>       ARM: dts: rockchip: fix rk3288 cpu opp node reference
>
> Julia Lawall (1):
>       ARM: OMAP2+: add missing of_node_put after of_device_is_available
>
> Leonidas P. Papadakos (1):
>       arm64: dts: rockchip: fix rk3328-roc-cc gmac2io tx/rx_delay
>
> Maxime Ripard (1):
>       dt-bindings: cpu: Fix JSON schema
>
> Neil Armstrong (1):
>       dt-bindings: reset: meson-g12a: Add missing USB2 PHY resets
>
> Olof Johansson (6):
>       Merge tag 'reset-fixes-for-v5.1' of git://git.pengutronix.de/pza/linux into arm/fixes
>       Merge tag 'stratix10_fix_for_v5.1' of git://git.kernel.org/.../dinguyen/linux into arm/fixes
>       Merge tag 'v5.1-rockchip-dtfixes-1' of git://git.kernel.org/.../mmind/linux-rockchip into arm/fixes
>       Merge tag 'at91-5.1-fixes' of git://git.kernel.org/.../at91/linux into arm/fixes
>       Merge tag 'omap-for-v5.1/fixes-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/fixes
>       Revert "ARM: dts: nomadik: Fix polarity of SPI CS"
>
> Peng Hao (1):
>       arm/mach-at91/pm : fix possible object reference leak
>
> Peter Geis (2):
>       arm64: dts: rockchip: fix rk3328 rgmii high tx error rate
>       arm64: dts: rockchip: fix rk3328 sdmmc0 write errors
>
> Peter Ujfalusi (2):
>       ARM: dts: am335x-evm: Correct the regulators for the audio codec
>       ARM: dts: am335x-evmsk: Correct the regulators for the audio codec
>
> Tomohiro Mayama (1):
>       arm64: dts: rockchip: Fix vcc_host1_5v GPIO polarity on rk3328-rock64
>
> Tony Lindgren (2):
>       ARM: dts: Fix dcan clkctrl clock for am3
>       Merge commit '7d56bedb2730dc2ea8abf0fd7240ee99ecfee3c9' into omap-for-v5.1/fixes
>
>  Documentation/devicetree/bindings/arm/cpus.yaml    |  2 +-
>  arch/arm/boot/dts/am335x-evm.dts                   | 26 ++++++++--
>  arch/arm/boot/dts/am335x-evmsk.dts                 | 26 ++++++++--
>  arch/arm/boot/dts/am33xx-l4.dtsi                   |  4 +-
>  arch/arm/boot/dts/rk3288-tinker.dtsi               |  3 +-
>  arch/arm/boot/dts/rk3288-veyron.dtsi               |  2 -
>  arch/arm/boot/dts/rk3288.dtsi                      | 20 ++++----
>  arch/arm/boot/dts/sama5d2-pinfunc.h                |  2 +-
>  arch/arm/boot/dts/ste-nomadik-nhk15.dts            |  9 ++--
>  arch/arm/mach-at91/pm.c                            |  6 ++-
>  arch/arm/mach-iop13xx/setup.c                      |  8 +--
>  arch/arm/mach-iop13xx/tpmi.c                       | 10 ++--
>  arch/arm/mach-milbeaut/platsmp.c                   |  4 ++
>  arch/arm/mach-omap1/board-ams-delta.c              |  2 +
>  arch/arm/mach-omap2/display.c                      |  4 +-
>  arch/arm/plat-iop/adma.c                           |  6 +--
>  arch/arm/plat-orion/common.c                       |  4 +-
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  3 ++
>  arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts     |  4 +-
>  arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |  3 +-
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi           | 58 +++++++++++-----------
>  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts  |  1 +
>  drivers/reset/reset-meson-audio-arb.c              |  1 +
>  .../dt-bindings/reset/amlogic,meson-g12a-reset.h   |  5 +-
>  24 files changed, 131 insertions(+), 82 deletions(-)
