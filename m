Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABD0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC5F206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfKLUpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:45:33 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42675 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfKLUpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:45:33 -0500
Received: by mail-ot1-f67.google.com with SMTP id b16so15549664otk.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 12:45:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qp7qCKznyn9kzrOI/DVJJyUZ22We1ef8DoOVvNKUl/E=;
        b=gjREWoMdNeB+x8bKC4cefMQ4HUE2uJmwn60dXAluI4bwxIG79Sid9DRtHEUEZcT8vB
         JpvHs//8usykmP5V3Izq9MqTeQY+qU86djzmT0MUQFLhjadubrqvyHOS1Jz6KPdVUEIG
         2OKZTxgbocrznPO6NHBVpKdcxrRdzHbtt9BlbtSBqvnNXZi5D2yAXknKW0brEH9lJifx
         6LBBiZTjcBdGoLIKi+r8IzDJ/d3kObHGiOa6IFCGdEV7oVMhiPaRcO2g9dL2rZ9erPMD
         GJJxYMA9nmboXZWZX2KxdU49id3WjIzEPnaFnQ5PqE9GIMxFqWeKbHw15oxJWvCYv5Rn
         NZuQ==
X-Gm-Message-State: APjAAAWy7u7evv2R3keVZpmSQmmfUu3KuTofyQr99Wub8iYIheWay31y
        xUnOXUMlxVoTITXPGKkwK/1SQNPU
X-Google-Smtp-Source: APXvYqyNCZwpCdtVPH7MngcFqeUZl137d8xx0Q9C7PLGO8PCh0NCAX7+aekEjSuJsDrDDZaMt+uxMg==
X-Received: by 2002:a05:6830:1e53:: with SMTP id e19mr27723674otj.161.1573591530174;
        Tue, 12 Nov 2019 12:45:30 -0800 (PST)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com. [209.85.167.174])
        by smtp.gmail.com with ESMTPSA id n5sm4430753oie.16.2019.11.12.12.45.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 12:45:29 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id n14so16089277oie.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 12:45:29 -0800 (PST)
X-Received: by 2002:aca:4891:: with SMTP id v139mr748524oia.175.1573591528822;
 Tue, 12 Nov 2019 12:45:28 -0800 (PST)
MIME-Version: 1.0
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk> <CADRPPNSeEvFnVzGeZW6RPo_LP8mq14G2ZmmDAuwNdC3hT8Ekcg@mail.gmail.com>
In-Reply-To: <CADRPPNSeEvFnVzGeZW6RPo_LP8mq14G2ZmmDAuwNdC3hT8Ekcg@mail.gmail.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 12 Nov 2019 14:45:17 -0600
X-Gmail-Original-Message-ID: <CADRPPNQFiPMvRcSkVgM8p2_AxhqBOVFus=cX5UC-8NYYUvf+0A@mail.gmail.com>
Message-ID: <CADRPPNQFiPMvRcSkVgM8p2_AxhqBOVFus=cX5UC-8NYYUvf+0A@mail.gmail.com>
Subject: Re: [PATCH v4 00/47] QUICC Engine support on ARM and ARM64
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Miller <davem@davemloft.net>,
        Scott Wood <oss@buserror.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Timur Tabi <timur@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 5:39 PM Li Yang <leoyang.li@nxp.com> wrote:
>
> On Fri, Nov 8, 2019 at 7:05 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> >
>
> I'm generally ok with these enhencements and cleanups.  But as the
> whole patch series touched multiple subsystems, I would like to
> collect the Acked-by from Scott, Greg and David if we want the whole
> series to go through the fsl/soc tree.

Rasmus,

Since the patches also touched net and serial subsystem.  Can you also
repost these patches(maybe just related ones) onto netdev and
linux-serial mailing list?

Regards,
Leo
>
> Also Qiang, can you help to test the latest version and provide you
> Tested-by?  Thanks.
>
> > There have been several attempts in the past few years to allow
> > building the QUICC engine drivers for platforms other than PPC. This
> > is yet another attempt.
> >
> > v3 can be found here: https://lore.kernel.org/lkml/20191101124210.14510-1-linux@rasmusvillemoes.dk/
> >
> > v4 adds a some patches to fix (ab)use of IS_ERR_VALUE which fails when
> > sizeof(u32) != sizeof(long), i.e. on 64-bit platforms. Freescale
> > drivers are some of the last holdouts using that macro (outside of
> > arch/ and core mm code), so I decided trying to simply get rid of it
> > instead of papering over it by using a temporary long to store the
> > result in. Doing that I stumbled on some other things that should be
> > fixed. These are the new patches 34-45.
> >
> > Patch 35 from v3 (which added a PPC32 dependency to FSL_UCC_HDLC) is
> > gone from this version, so that that driver can indeed now be built
> > for arm and arm64.
> >
> > 1-5 are about replacing in_be32 etc. in the core QE code (drivers/soc/fsl/qe).
> >
> > 6-8 handle miscellaneous other ppcisms.
> >
> > 9-21 deal with qe_ic: Simplifying the driver significantly by removing
> > unused code, and removing the platform-specific initialization from
> > arch/powerpc/.
> >
> > 22-25 deal with raw access to devicetree properties in native endianness.
> >
> > 26-33 makes drivers/tty/serial/ucc_uart.c (CONFIG_SERIAL_QE) ready to build on arm.
> >
> > 34-45 deal with IS_ERR_VALUE() and some other things found while
> > digging around that part of the code.
> >
> > 46 adds a PPC32 dependency to UCC_GETH - it has some of the same
> > issues that have been fixed in the ucc_uart and ucc_hdlc cases. Nobody
> > has requested that I allow that driver to be built for arm{,64}, so
> > instead of growing this series even bigger, I kept that addition. It's
> > trivial to remove if somebody cares enough to fix the build
> > errors/warnings and actually has a platform to test the result on.
> >
> > Finally patch 47 lifts the PPC32 restriction from QUICC_ENGINE. At the
> > request of Li Yang, it doesn't remove the PPC32 dependency but instead
> > changes it to PPC32 || ARM || ARM64 (or COMPILE_TEST), i.e. listing
> > the platforms that may have a QE.
> >
> > The series has been built and booted on both an mpc8309-based platform
> > (ppc) as well as an ls1021a-based platform (arm). The core QE code is
> > exercised on both, while I could only test the ucc_uart on arm, since
> > the uarts are not wired up on our mpc8309 board. Qiang Zhao reports
> > that the ucc_hdlc driver does indeed work on a ls1043ardb (arm64)
> > board, I hope he'll formally add a Tested-by: to the relevant patches
> > since I don't have any arm64 board with QE.
> >
> > Rasmus Villemoes (47):
> >   soc: fsl: qe: remove space-before-tab
> >   soc: fsl: qe: drop volatile qualifier of struct qe_ic::regs
> >   soc: fsl: qe: rename qe_(clr/set/clrset)bit* helpers
> >   soc: fsl: qe: introduce qe_io{read,write}* wrappers
> >   soc: fsl: qe: avoid ppc-specific io accessors
> >   soc: fsl: qe: replace spin_event_timeout by readx_poll_timeout_atomic
> >   soc: fsl: qe: qe.c: guard use of pvr_version_is() with CONFIG_PPC32
> >   soc: fsl: qe: drop unneeded #includes
> >   soc: fsl: qe: drop assign-only high_active in qe_ic_init
> >   soc: fsl: qe: remove pointless sysfs registration in qe_ic.c
> >   soc: fsl: qe: use qe_ic_cascade_{low,high}_mpic also on 83xx
> >   soc: fsl: qe: move calls of qe_ic_init out of arch/powerpc/
> >   powerpc/83xx: remove mpc83xx_ipic_and_qe_init_IRQ
> >   powerpc/85xx: remove mostly pointless mpc85xx_qe_init()
>
> Scott,
> What do you think about the PPC changes?
>
> >   soc: fsl: qe: move qe_ic_cascade_* functions to qe_ic.c
> >   soc: fsl: qe: rename qe_ic_cascade_low_mpic -> qe_ic_cascade_low
> >   soc: fsl: qe: remove unused qe_ic_set_* functions
> >   soc: fsl: qe: don't use NO_IRQ in qe_ic.c
> >   soc: fsl: qe: make qe_ic_get_{low,high}_irq static
> >   soc: fsl: qe: simplify qe_ic_init()
> >   soc: fsl: qe: merge qe_ic.h headers into qe_ic.c
> >   soc: fsl: qe: qe.c: use of_property_read_* helpers
> >   soc: fsl: qe: qe_io.c: don't open-code of_parse_phandle()
> >   soc: fsl: qe: qe_io.c: access device tree property using be32_to_cpu
> >   soc: fsl: qe: qe_io.c: use of_property_read_u32() in par_io_init()
> >   soc: fsl: move cpm.h from powerpc/include/asm to include/soc/fsl
> >   soc/fsl/qe/qe.h: update include path for cpm.h
> >   serial: ucc_uart: explicitly include soc/fsl/cpm.h
> >   serial: ucc_uart: replace ppc-specific IO accessors
> >   serial: ucc_uart: factor out soft_uart initialization
> >   serial: ucc_uart: stub out soft_uart_init for !CONFIG_PPC32
> >   serial: ucc_uart: use of_property_read_u32() in ucc_uart_probe()
> >   serial: ucc_uart: access __be32 field using be32_to_cpu
>
> Greg and Timur,
> What do you think about these serial changes.
>
> >   soc: fsl: qe: change return type of cpm_muram_alloc() to s32
> >   soc: fsl: qe: make cpm_muram_free() return void
> >   soc: fsl: qe: make cpm_muram_free() ignore a negative offset
> >   soc: fsl: qe: drop broken lazy call of cpm_muram_init()
> >   soc: fsl: qe: refactor cpm_muram_alloc_common to prevent BUG on error
> >     path
> >   soc: fsl: qe: avoid IS_ERR_VALUE in ucc_slow.c
> >   soc: fsl: qe: drop use of IS_ERR_VALUE in qe_sdma_init()
> >   soc: fsl: qe: drop pointless check in qe_sdma_init()
> >   soc: fsl: qe: avoid IS_ERR_VALUE in ucc_fast.c
> >   net/wan/fsl_ucc_hdlc: avoid use of IS_ERR_VALUE()
> >   net/wan/fsl_ucc_hdlc: fix reading of __be16 registers
> >   net/wan/fsl_ucc_hdlc: reject muram offsets above 64K
> >   net: ethernet: freescale: make UCC_GETH explicitly depend on PPC32
>
> David and Qiang,
> What do you think of the net changes?
>
> >   soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE
> >
> >  arch/powerpc/include/asm/cpm.h                | 172 +-------
> >  arch/powerpc/platforms/83xx/km83xx.c          |   3 +-
> >  arch/powerpc/platforms/83xx/misc.c            |  23 --
> >  arch/powerpc/platforms/83xx/mpc832x_mds.c     |   3 +-
> >  arch/powerpc/platforms/83xx/mpc832x_rdb.c     |   3 +-
> >  arch/powerpc/platforms/83xx/mpc836x_mds.c     |   3 +-
> >  arch/powerpc/platforms/83xx/mpc836x_rdk.c     |   3 +-
> >  arch/powerpc/platforms/83xx/mpc83xx.h         |   7 -
> >  arch/powerpc/platforms/85xx/common.c          |  23 --
> >  arch/powerpc/platforms/85xx/corenet_generic.c |  12 -
> >  arch/powerpc/platforms/85xx/mpc85xx.h         |   2 -
> >  arch/powerpc/platforms/85xx/mpc85xx_mds.c     |  28 --
> >  arch/powerpc/platforms/85xx/mpc85xx_rdb.c     |  18 -
> >  arch/powerpc/platforms/85xx/twr_p102x.c       |  16 -
> >  drivers/net/ethernet/freescale/Kconfig        |   2 +-
> >  drivers/net/wan/fsl_ucc_hdlc.c                |  23 +-
> >  drivers/net/wan/fsl_ucc_hdlc.h                |   2 +-
> >  drivers/soc/fsl/qe/Kconfig                    |   3 +-
> >  drivers/soc/fsl/qe/gpio.c                     |  34 +-
> >  drivers/soc/fsl/qe/qe.c                       | 104 ++---
> >  drivers/soc/fsl/qe/qe_common.c                |  50 +--
> >  drivers/soc/fsl/qe/qe_ic.c                    | 285 ++++++-------
> >  drivers/soc/fsl/qe/qe_ic.h                    |  99 -----
> >  drivers/soc/fsl/qe/qe_io.c                    |  70 ++--
> >  drivers/soc/fsl/qe/qe_tdm.c                   |   8 +-
> >  drivers/soc/fsl/qe/ucc.c                      |  26 +-
> >  drivers/soc/fsl/qe/ucc_fast.c                 |  86 ++--
> >  drivers/soc/fsl/qe/ucc_slow.c                 |  60 ++-
> >  drivers/soc/fsl/qe/usb.c                      |   2 +-
> >  drivers/tty/serial/ucc_uart.c                 | 383 +++++++++---------
> >  include/soc/fsl/cpm.h                         | 171 ++++++++
> >  include/soc/fsl/qe/qe.h                       |  59 ++-
> >  include/soc/fsl/qe/qe_ic.h                    | 135 ------
> >  include/soc/fsl/qe/ucc_fast.h                 |   4 +-
> >  include/soc/fsl/qe/ucc_slow.h                 |   6 +-
> >  35 files changed, 770 insertions(+), 1158 deletions(-)
> >  delete mode 100644 drivers/soc/fsl/qe/qe_ic.h
> >  create mode 100644 include/soc/fsl/cpm.h
> >  delete mode 100644 include/soc/fsl/qe/qe_ic.h
> >
> > --
> > 2.23.0
> >
