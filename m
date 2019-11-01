Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A07CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21E52067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="IdTl1JZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfKAMmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:42:17 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:46535 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfKAMmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:17 -0400
Received: by mail-lf1-f42.google.com with SMTP id 19so1970436lft.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=12SepDs6/FSflannDoWCyxi6C7tLQuH0xm/jM6LnU3g=;
        b=IdTl1JZl2Sowp/CbFfHVjBvj+ZNIOJhJcsZVu5j4ngE7H8QtjC9lfpfMVMKQwG1SRl
         RaOVI23pzPqAMol8XCO8qVHxMQ3KgFWhy12T90k72rofCGkA0WwAYL0hmluuk7yS3WAN
         Oaim1pVJnpfFfye8kGM2J63GHb6wKtChR5uWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=12SepDs6/FSflannDoWCyxi6C7tLQuH0xm/jM6LnU3g=;
        b=KSk4afo3j8NTmPOJxdd8A6L0zfUFKjD5ovpoGByK+cUqwQ4KKMHVHWj4ZIlMqfVEMb
         NJlKTio6pwULb71eDZg0NrCnsQN19RMmZzF5N/Y8b7hGJCltBTfZ3s/r3gPqz7UhLgd2
         gHWxJuFsnROl1upG9I+9jgMwvz0QajclyjUyYkX0ql6dgV9htbvuiX0NI9Zkj3X852Hf
         qQukKAPksJwVDDXdNelpykdZEM458qas8XWeiQRlKauWKGEBVNUe4CKHoKVuVgEjHgCJ
         25IUbI4ADbR9gcWiH2s6GUSVJEbOjy4xzzTrD4yPT8hXV3jsHkWhpWdyzgJzqMJU3MiC
         IExg==
X-Gm-Message-State: APjAAAV1Yz+bB0WAEU0s4uv9GOaD5lpRpQqCPgCF8VieikCYv8hrOmQD
        JME271w52g8NYEmy/OArAwfHVQ==
X-Google-Smtp-Source: APXvYqyiWfNPCkE6rwOxYzYsiGbZYM7XmHPALK2+Uq1oKakULYdJwJJRnIu5ucPt8Lmpb7MKrL7Rtw==
X-Received: by 2002:a19:655b:: with SMTP id c27mr7112242lfj.122.1572612134709;
        Fri, 01 Nov 2019 05:42:14 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:13 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 00/36] QUICC Engine support on ARM
Date:   Fri,  1 Nov 2019 13:41:34 +0100
Message-Id: <20191101124210.14510-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been several attempts in the past few years to allow
building the QUICC engine drivers for platforms other than PPC. This
is yet another attempt.

Changes in v3:

- Address the performance impact on ppc from replacing out_be32 by
  iowrite32be by instead introducing a qe_iowrite32be wrapper and
  using that - patches 3 and 4 in this series.

- Extend the series so that both the QE core as well as ucc_uart
  builds for ARM - patches 26-33.

- Reorganize things a bit to avoid touching code that gets killed
  anyway in a later patch.

Also the patches are now better grouped:

1-5 are about replacing in_be32 etc. in the core QE code (drivers/soc/fsl/qe).

6-8 handle miscellaneous other ppcisms.

9-21 deal with qe_ic: Simplifying the driver significantly by removing
unused code, and removing the platform-specific initialization from
arch/powerpc/.

22-25 deal with raw access to devicetree properties in native endianness.

26-33 makes drivers/tty/serial/ucc_uart.c (CONFIG_SERIAL_QE) ready to build on arm.

34-36 remove the PPC32 dependency from QUICC_ENGINE. Two drivers that
depend on QUICC_ENGINE get an explicit PPC32 dependency to prevent
allmodconfig build failures.

The series has been built and booted on both an mpc8309-based platform
(ppc) as well as an ls1021a-based platform (arm). The core QE code is
exercised on both, while I could only test the ucc_uart on arm, since
the uarts are not wired up on our mpc8309 board.

Rasmus Villemoes (36):
  soc: fsl: qe: remove space-before-tab
  soc: fsl: qe: drop volatile qualifier of struct qe_ic::regs
  soc: fsl: qe: rename qe_(clr/set/clrset)bit* helpers
  soc: fsl: qe: introduce qe_io{read,write}* wrappers
  soc: fsl: qe: avoid ppc-specific io accessors
  soc: fsl: qe: replace spin_event_timeout by readx_poll_timeout_atomic
  soc: fsl: qe: qe.c: guard use of pvr_version_is() with CONFIG_PPC32
  soc: fsl: qe: drop unneeded #includes
  soc: fsl: qe: drop assign-only high_active in qe_ic_init
  soc: fsl: qe: remove pointless sysfs registration in qe_ic.c
  soc: fsl: qe: use qe_ic_cascade_{low,high}_mpic also on 83xx
  soc: fsl: qe: move calls of qe_ic_init out of arch/powerpc/
  powerpc/83xx: remove mpc83xx_ipic_and_qe_init_IRQ
  powerpc/85xx: remove mostly pointless mpc85xx_qe_init()
  soc: fsl: qe: move qe_ic_cascade_* functions to qe_ic.c
  soc: fsl: qe: rename qe_ic_cascade_low_mpic -> qe_ic_cascade_low
  soc: fsl: qe: remove unused qe_ic_set_* functions
  soc: fsl: qe: don't use NO_IRQ in qe_ic.c
  soc: fsl: qe: make qe_ic_get_{low,high}_irq static
  soc: fsl: qe: simplify qe_ic_init()
  soc: fsl: qe: merge qe_ic.h headers into qe_ic.c
  soc: fsl: qe: qe.c: use of_property_read_* helpers
  soc: fsl: qe: qe_io.c: don't open-code of_parse_phandle()
  soc: fsl: qe: qe_io.c: access device tree property using be32_to_cpu
  soc: fsl: qe: qe_io.c: use of_property_read_u32() in par_io_init()
  soc: fsl: move cpm.h from powerpc/include/asm to include/soc/fsl
  soc/fsl/qe/qe.h: update include path for cpm.h
  serial: ucc_uart: explicitly include soc/fsl/cpm.h
  serial: ucc_uart: replace ppc-specific IO accessors
  serial: ucc_uart: factor out soft_uart initialization
  serial: ucc_uart: stub out soft_uart_init for !CONFIG_PPC32
  serial: ucc_uart: use of_property_read_u32() in ucc_uart_probe()
  serial: ucc_uart: access __be32 field using be32_to_cpu
  net: ethernet: freescale: make UCC_GETH explicitly depend on PPC32
  net/wan: make FSL_UCC_HDLC explicitly depend on PPC32
  soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE

 arch/powerpc/include/asm/cpm.h                | 172 +-------
 arch/powerpc/platforms/83xx/km83xx.c          |   3 +-
 arch/powerpc/platforms/83xx/misc.c            |  23 --
 arch/powerpc/platforms/83xx/mpc832x_mds.c     |   3 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c     |   3 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c     |   3 +-
 arch/powerpc/platforms/83xx/mpc836x_rdk.c     |   3 +-
 arch/powerpc/platforms/83xx/mpc83xx.h         |   7 -
 arch/powerpc/platforms/85xx/common.c          |  23 --
 arch/powerpc/platforms/85xx/corenet_generic.c |  12 -
 arch/powerpc/platforms/85xx/mpc85xx.h         |   2 -
 arch/powerpc/platforms/85xx/mpc85xx_mds.c     |  28 --
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c     |  18 -
 arch/powerpc/platforms/85xx/twr_p102x.c       |  16 -
 drivers/net/ethernet/freescale/Kconfig        |   2 +-
 drivers/net/wan/Kconfig                       |   2 +-
 drivers/net/wan/fsl_ucc_hdlc.c                |   4 +-
 drivers/soc/fsl/qe/Kconfig                    |   2 +-
 drivers/soc/fsl/qe/gpio.c                     |  34 +-
 drivers/soc/fsl/qe/qe.c                       |  95 ++---
 drivers/soc/fsl/qe/qe_ic.c                    | 285 ++++++-------
 drivers/soc/fsl/qe/qe_ic.h                    |  99 -----
 drivers/soc/fsl/qe/qe_io.c                    |  70 ++--
 drivers/soc/fsl/qe/qe_tdm.c                   |   8 +-
 drivers/soc/fsl/qe/ucc.c                      |  26 +-
 drivers/soc/fsl/qe/ucc_fast.c                 |  71 ++--
 drivers/soc/fsl/qe/ucc_slow.c                 |  38 +-
 drivers/soc/fsl/qe/usb.c                      |   2 +-
 drivers/tty/serial/ucc_uart.c                 | 383 +++++++++---------
 include/soc/fsl/cpm.h                         | 171 ++++++++
 include/soc/fsl/qe/qe.h                       |  42 +-
 include/soc/fsl/qe/qe_ic.h                    | 135 ------
 32 files changed, 701 insertions(+), 1084 deletions(-)
 delete mode 100644 drivers/soc/fsl/qe/qe_ic.h
 create mode 100644 include/soc/fsl/cpm.h
 delete mode 100644 include/soc/fsl/qe/qe_ic.h

-- 
2.23.0

