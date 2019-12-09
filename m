Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9449EC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6166D205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfLIUSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:18:42 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34922 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfLIUSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:18:41 -0500
Received: by mail-ot1-f65.google.com with SMTP id o9so13411326ote.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 12:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7V0G8JfUu86bq/RP6YxmwxwHbYcUhJINxbxqczRAcM=;
        b=HOG1ZJVokTXgPWw2jjELrhY67sOeQFDruwfYBUP09gwxbM/jY0NVlJkFCXgDTUaemE
         UmgzkWepnk/4sIlj/47LttZ96Khd/Cl4J6pD8SBkdzQ1e5B89WL3ggEgbXiGJblOEYD8
         CtF3EszTXQm7weHr5d4li6Vj68GULxAljqU7a4WvlVgoHpcxG2E2afb/6PX6lrXk+On3
         X89lqez6K0hrd6/oSyZKvmxLl9zWUBxDPtY2J4ThVd6DXCp5j2hW2wpspYAhrQ8uuMKt
         KxLnw3fEdamFOSKcGu3eXpC8Bj+ZuQ6BR91sfqYixqU35IO5er3yYrYu71O2sZ4WszeU
         dZFw==
X-Gm-Message-State: APjAAAUUorRWWkzjyAE+Ql6KlsfpjAzB2RDACKWy7r9N69TJ6tpfWkJS
        TZrFVqpNtsYJCpU9y65O4ZWm48S0
X-Google-Smtp-Source: APXvYqyOcFAKVfCX4fue294nHn7aoqDA00JpBtlCUNW7iL9epQWLYX0B+lDbsYKT5odN8F4koLgyxg==
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr23467981otk.363.1575922720425;
        Mon, 09 Dec 2019 12:18:40 -0800 (PST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id a17sm347924otq.49.2019.12.09.12.18.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 12:18:40 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id i4so13420561otr.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 12:18:39 -0800 (PST)
X-Received: by 2002:a05:6830:11c3:: with SMTP id v3mr24197866otq.74.1575922719436;
 Mon, 09 Dec 2019 12:18:39 -0800 (PST)
MIME-Version: 1.0
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 9 Dec 2019 14:18:27 -0600
X-Gmail-Original-Message-ID: <CADRPPNQBucGPaG0p5SDneVQYt9Wqgv8PuqFF0HFmj2LD8wybtA@mail.gmail.com>
Message-ID: <CADRPPNQBucGPaG0p5SDneVQYt9Wqgv8PuqFF0HFmj2LD8wybtA@mail.gmail.com>
Subject: Re: [PATCH v6 00/49] QUICC Engine support on ARM, ARM64, PPC64
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 8:59 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> There have been several attempts in the past few years to allow
> building the QUICC engine drivers for platforms other than PPC32. This
> is yet another attempt.
>
> v5 can be found here: https://lore.kernel.org/lkml/20191118112324.22725-1-linux@rasmusvillemoes.dk/
>
> Changes in v6:
>
> - add various R-b, A-b tags
>
> - add a patch (48/49) fixing a build issue on ARM with CONFIG_SMP=y
>
> I added that patch last in the series, apart from the "allow to build
> on ARM" Kconfig change, to preserve the enumeration of the other
> patches from v5.
>
> 1-5 are about replacing in_be32 etc. in the core QE code (drivers/soc/fsl/qe).
>
> 6-8 handle miscellaneous other ppcisms.
>
> 9-21 deal with qe_ic: Simplifying the driver significantly by removing
> unused code, and removing the platform-specific initialization from
> arch/powerpc/.
>
> 22-25 deal with raw access to devicetree properties in native endianness.
>
> 26-34 makes drivers/tty/serial/ucc_uart.c (CONFIG_SERIAL_QE) ready to build on non-ppc.
>
> 35-46 deal with IS_ERR_VALUE() and some other things found while
> digging around that part of the code.
>
> 47 adds a PPC32 dependency to UCC_GETH - it has some of the same
> issues that have been fixed in the ucc_uart and ucc_hdlc cases. Nobody
> has requested that I allow that driver to be built for arm{,64} and
> reportedly, the hardware has only ever shipped on PPC SOCs. So instead
> of growing this series even bigger, I kept that addition. It's trivial
> to remove if somebody cares enough to fix the build errors/warnings
> and actually has a platform to test the result on.
>
> 48 fixes a build issue on ARM reported by the kbuild bot.
>
> Finally patch 49 lifts the PPC32 restriction from QUICC_ENGINE. At the
> request of Li Yang, it doesn't remove the PPC32 dependency but instead
> changes it to PPC|| ARM || ARM64 (or COMPILE_TEST), i.e. listing
> the platforms that may have a QE.
>
> The series has been built and booted on both an mpc8309-based platform
> (ppc) as well as an ls1021a-based platform (arm). The core QE code is
> exercised on both, while I could only test the ucc_uart on arm, since
> the uarts are not wired up on our mpc8309 board. Qiang Zhao reports
> that the ucc_hdlc driver does indeed work on a ls1043ardb (arm64)
> board.

Series applied for next on my soc tree.  Thanks!

Regards,
Leo
>
> Rasmus Villemoes (49):
>   soc: fsl: qe: remove space-before-tab
>   soc: fsl: qe: drop volatile qualifier of struct qe_ic::regs
>   soc: fsl: qe: rename qe_(clr/set/clrset)bit* helpers
>   soc: fsl: qe: introduce qe_io{read,write}* wrappers
>   soc: fsl: qe: avoid ppc-specific io accessors
>   soc: fsl: qe: replace spin_event_timeout by readx_poll_timeout_atomic
>   soc: fsl: qe: qe.c: guard use of pvr_version_is() with CONFIG_PPC32
>   soc: fsl: qe: drop unneeded #includes
>   soc: fsl: qe: drop assign-only high_active in qe_ic_init
>   soc: fsl: qe: remove pointless sysfs registration in qe_ic.c
>   soc: fsl: qe: use qe_ic_cascade_{low,high}_mpic also on 83xx
>   soc: fsl: qe: move calls of qe_ic_init out of arch/powerpc/
>   powerpc/83xx: remove mpc83xx_ipic_and_qe_init_IRQ
>   powerpc/85xx: remove mostly pointless mpc85xx_qe_init()
>   soc: fsl: qe: move qe_ic_cascade_* functions to qe_ic.c
>   soc: fsl: qe: rename qe_ic_cascade_low_mpic -> qe_ic_cascade_low
>   soc: fsl: qe: remove unused qe_ic_set_* functions
>   soc: fsl: qe: don't use NO_IRQ in qe_ic.c
>   soc: fsl: qe: make qe_ic_get_{low,high}_irq static
>   soc: fsl: qe: simplify qe_ic_init()
>   soc: fsl: qe: merge qe_ic.h headers into qe_ic.c
>   soc: fsl: qe: qe.c: use of_property_read_* helpers
>   soc: fsl: qe: qe_io.c: don't open-code of_parse_phandle()
>   soc: fsl: qe: qe_io.c: access device tree property using be32_to_cpu
>   soc: fsl: qe: qe_io.c: use of_property_read_u32() in par_io_init()
>   soc: fsl: move cpm.h from powerpc/include/asm to include/soc/fsl
>   soc/fsl/qe/qe.h: update include path for cpm.h
>   serial: ucc_uart: explicitly include soc/fsl/cpm.h
>   serial: ucc_uart: replace ppc-specific IO accessors
>   serial: ucc_uart: factor out soft_uart initialization
>   serial: ucc_uart: stub out soft_uart_init for !CONFIG_PPC32
>   serial: ucc_uart: use of_property_read_u32() in ucc_uart_probe()
>   serial: ucc_uart: limit brg-frequency workaround to PPC32
>   serial: ucc_uart: access __be32 field using be32_to_cpu
>   soc: fsl: qe: change return type of cpm_muram_alloc() to s32
>   soc: fsl: qe: make cpm_muram_free() return void
>   soc: fsl: qe: make cpm_muram_free() ignore a negative offset
>   soc: fsl: qe: drop broken lazy call of cpm_muram_init()
>   soc: fsl: qe: refactor cpm_muram_alloc_common to prevent BUG on error
>     path
>   soc: fsl: qe: avoid IS_ERR_VALUE in ucc_slow.c
>   soc: fsl: qe: drop use of IS_ERR_VALUE in qe_sdma_init()
>   soc: fsl: qe: drop pointless check in qe_sdma_init()
>   soc: fsl: qe: avoid IS_ERR_VALUE in ucc_fast.c
>   net/wan/fsl_ucc_hdlc: avoid use of IS_ERR_VALUE()
>   net/wan/fsl_ucc_hdlc: fix reading of __be16 registers
>   net/wan/fsl_ucc_hdlc: reject muram offsets above 64K
>   net: ethernet: freescale: make UCC_GETH explicitly depend on PPC32
>   soc: fsl: qe: remove unused #include of asm/irq.h from ucc.c
>   soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE
>
>  arch/powerpc/include/asm/cpm.h                | 172 +-------
>  arch/powerpc/platforms/83xx/km83xx.c          |   3 +-
>  arch/powerpc/platforms/83xx/misc.c            |  23 --
>  arch/powerpc/platforms/83xx/mpc832x_mds.c     |   3 +-
>  arch/powerpc/platforms/83xx/mpc832x_rdb.c     |   3 +-
>  arch/powerpc/platforms/83xx/mpc836x_mds.c     |   3 +-
>  arch/powerpc/platforms/83xx/mpc836x_rdk.c     |   3 +-
>  arch/powerpc/platforms/83xx/mpc83xx.h         |   7 -
>  arch/powerpc/platforms/85xx/common.c          |  23 --
>  arch/powerpc/platforms/85xx/corenet_generic.c |  12 -
>  arch/powerpc/platforms/85xx/mpc85xx.h         |   2 -
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c     |  28 --
>  arch/powerpc/platforms/85xx/mpc85xx_rdb.c     |  18 -
>  arch/powerpc/platforms/85xx/twr_p102x.c       |  16 -
>  drivers/net/ethernet/freescale/Kconfig        |   2 +-
>  drivers/net/wan/fsl_ucc_hdlc.c                |  23 +-
>  drivers/net/wan/fsl_ucc_hdlc.h                |   2 +-
>  drivers/soc/fsl/qe/Kconfig                    |   3 +-
>  drivers/soc/fsl/qe/gpio.c                     |  34 +-
>  drivers/soc/fsl/qe/qe.c                       | 104 ++---
>  drivers/soc/fsl/qe/qe_common.c                |  50 +--
>  drivers/soc/fsl/qe/qe_ic.c                    | 285 ++++++-------
>  drivers/soc/fsl/qe/qe_ic.h                    |  99 -----
>  drivers/soc/fsl/qe/qe_io.c                    |  70 ++--
>  drivers/soc/fsl/qe/qe_tdm.c                   |   8 +-
>  drivers/soc/fsl/qe/ucc.c                      |  27 +-
>  drivers/soc/fsl/qe/ucc_fast.c                 |  86 ++--
>  drivers/soc/fsl/qe/ucc_slow.c                 |  60 ++-
>  drivers/soc/fsl/qe/usb.c                      |   2 +-
>  drivers/tty/serial/ucc_uart.c                 | 385 +++++++++---------
>  include/soc/fsl/cpm.h                         | 171 ++++++++
>  include/soc/fsl/qe/qe.h                       |  59 ++-
>  include/soc/fsl/qe/qe_ic.h                    | 135 ------
>  include/soc/fsl/qe/ucc_fast.h                 |   4 +-
>  include/soc/fsl/qe/ucc_slow.h                 |   6 +-
>  35 files changed, 775 insertions(+), 1156 deletions(-)
>  delete mode 100644 drivers/soc/fsl/qe/qe_ic.h
>  create mode 100644 include/soc/fsl/cpm.h
>  delete mode 100644 include/soc/fsl/qe/qe_ic.h
>
> --
> 2.23.0
>
