Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC843CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7824721D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="gr43qyfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440293AbfJYMlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:41:06 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35473 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440272AbfJYMlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:41:06 -0400
Received: by mail-lf1-f68.google.com with SMTP id y6so1634758lfj.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nNhTW3U2Xf+f8X6ztyGJ0vdPsrVEzgnkoLb09kGESGY=;
        b=gr43qyfKeoGH65CYsJHoPG+YL9Tx4hVUZVoQzYzb9XsMqHySY57WJtUCKdPh98abFb
         978lBekDEIJw3ctIHrCrHNrnVte3xIHmGJW9xZwa+BVM8YrwNCtva1EUvT8mgMQ0+NIk
         RMH0xuXFjObqrkldH+wRmh6xxURbjD8yMaUAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nNhTW3U2Xf+f8X6ztyGJ0vdPsrVEzgnkoLb09kGESGY=;
        b=XzUzr919OZknlvE5P6YaiIaOVdZwh5aSXN7yI8LxQtDL7t2+wKyf5WRjjgyPnqP0sk
         li5doorAnrRnBo+8HVqA3NQWeg5YlNmxgnxMZDQyjgk+R9RwbYbblELJDY1g5/6+HNNz
         hf5uYMqgo3vOBr/EUq2V12SXHa9DIwxuUjGp9sTzt4eZQHKpEyq2ehO+HE2QsLFJXbfu
         jFwDEFn1w3Dzq/UOS9MQofUpndRLIW3vVOdGmyKYFejg4WXu7WOY7kTFPe2Rjij6kY7A
         fCPGiVbAujVNPu1TzBYOg3O+G4oz/gavlx1CfE37ig5UU19zbSoTrgEJV4YRvkLNrxmu
         Sw5A==
X-Gm-Message-State: APjAAAVOq/dFOBv/WdPEqM5Jui0/HHEXOk6jcgt2Wkg/4Hxuyog7RTG0
        7YvFtETyZMcRZw4JW6Qzu6WFjg==
X-Google-Smtp-Source: APXvYqzI54y0qXty0REj/t8bh97dPNgFy2YQ0TG2aFgxJMZvmcPNDi0C+wUJpvWYRj3db7mvv6qlJw==
X-Received: by 2002:ac2:4d04:: with SMTP id r4mr2706461lfi.136.1572007262270;
        Fri, 25 Oct 2019 05:41:02 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 05:41:01 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 00/23] QUICC Engine support on ARM
Date:   Fri, 25 Oct 2019 14:40:35 +0200
Message-Id: <20191025124058.22580-1-linux@rasmusvillemoes.dk>
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

In v2, I've fixed a few style issues. But more importantly, it now
contains enough to actually remove the PPC32 dependency from
CONFIG_QUICC_ENGINE, so that's what the last patch does.

I haven't found a way to address Christophe's concern over the
performance impact of using the (on powerpc) out-of-line iowrite32be
instead of out_be32. I could of course introduce some qe_ prefixed
helpers (similar to the already added qe_clrsetbits ones) and make
their definition dependent on PPC32 or not, but that seems to be a bit
ugly.

Rasmus Villemoes (23):
  soc: fsl: qe: remove space-before-tab
  soc: fsl: qe: drop volatile qualifier of struct qe_ic::regs
  soc: fsl: qe: avoid ppc-specific io accessors
  soc: fsl: qe: replace spin_event_timeout by readx_poll_timeout_atomic
  soc: fsl: qe: qe.c: guard use of pvr_version_is() with CONFIG_PPC32
  soc: fsl: qe: avoid tail comments in qe_ic.h
  soc: fsl: qe: merge qe_ic.h into qe_ic.c
  soc: fsl: qe: drop unneeded #includes
  soc: fsl: qe: move qe_ic_cascade_* functions to qe_ic.c
  soc: fsl: qe: use qe_ic_cascade_{low,high}_mpic also on 83xx
  soc: fsl: qe: rename qe_ic_cascade_low_mpic -> qe_ic_cascade_low
  soc: fsl: qe: drop assign-only high_active in qe_ic_init
  soc: fsl: qe: remove pointless sysfs registration in qe_ic.c
  soc: fsl: qe: move calls of qe_ic_init out of arch/powerpc/
  powerpc/83xx: remove mpc83xx_ipic_and_qe_init_IRQ
  powerpc/85xx: remove mostly pointless mpc85xx_qe_init()
  soc: fsl: qe: make qe_ic_cascade_* static
  soc: fsl: qe: remove unused qe_ic_set_* functions
  net: ethernet: freescale: make UCC_GETH explicitly depend on PPC32
  serial: make SERIAL_QE depend on PPC32
  serial: ucc_uart.c: explicitly include asm/cpm.h
  soc/fsl/qe/qe.h: remove include of asm/cpm.h
  soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE

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
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c     |  18 --
 arch/powerpc/platforms/85xx/twr_p102x.c       |  16 -
 drivers/net/ethernet/freescale/Kconfig        |   1 +
 drivers/soc/fsl/qe/Kconfig                    |   2 +-
 drivers/soc/fsl/qe/gpio.c                     |  30 +-
 drivers/soc/fsl/qe/qe.c                       |  59 ++--
 drivers/soc/fsl/qe/qe_ic.c                    | 289 ++++++++++--------
 drivers/soc/fsl/qe/qe_ic.h                    |  99 ------
 drivers/soc/fsl/qe/qe_io.c                    |  42 ++-
 drivers/soc/fsl/qe/qe_tdm.c                   |   8 +-
 drivers/soc/fsl/qe/ucc.c                      |  16 +-
 drivers/soc/fsl/qe/ucc_fast.c                 |  70 ++---
 drivers/soc/fsl/qe/ucc_slow.c                 |  38 +--
 drivers/soc/fsl/qe/usb.c                      |   2 +-
 drivers/tty/serial/Kconfig                    |   1 +
 drivers/tty/serial/ucc_uart.c                 |   1 +
 include/soc/fsl/qe/qe.h                       |   1 -
 include/soc/fsl/qe/qe_ic.h                    |  69 -----
 29 files changed, 299 insertions(+), 573 deletions(-)
 delete mode 100644 drivers/soc/fsl/qe/qe_ic.h

-- 
2.23.0

