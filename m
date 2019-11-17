Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE15FC43215
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 20:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D62206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 20:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAhShT4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfKQUYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 15:24:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38951 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfKQUYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 15:24:41 -0500
Received: by mail-wr1-f66.google.com with SMTP id l7so17026298wrp.6;
        Sun, 17 Nov 2019 12:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IUxQw7G9TADghldCcYoUqe3xol1SpZ9SeCsa+dH2lVI=;
        b=VAhShT4YLFAAEeUX84eHEMF5xj5KMok6kStnxT93Jj+dscCQPsB1ggSGNp8t+Ogc4p
         2cy/9dhfRPGgXqHTCh+fjbPG77D1g/tRPcD/1t5j85Jjuiuk8GwB9Neb1bRiZ+F3OIFc
         nVKNtubcOzIr0lutZuWI+hHhb+Fs9SzYotXdejIKEWAEDkF8IkIoCV/FWTAq75nyGP+w
         uImYzuVnYYbh92C375XOOm55V1a5OtfEwqx5MoEttpN22ISJC/rkm2dILPybLJLN7hsm
         0NX+tBSkeHXPno3O5z8oek+jAw55Th2nDlfclMV4hGGU7WzYw8QCKDErNPu5kjEv55+P
         bJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IUxQw7G9TADghldCcYoUqe3xol1SpZ9SeCsa+dH2lVI=;
        b=Xm2DAJ6EGmpEAKnvLUtrllsBPdY/t7FkoCN2KXVT2VYAzzz0+e8AeHy+jOZz+YfPLE
         4Uqlmc5T52km92mSwXUlLf8Vui+f/a0nHiVtQ3PeNV5hX6ucQ9qtgq0mEIVCeGXk/ef6
         5gD9jgskxKZxj1X5yYHmhvqIFE/5bpBRbkPby0yyHwpRpoefkCBFtf980OEmc3zsKuvV
         i90sVuHm9X3+Rj3/nKJt3JPDitAs0vqugrqT/aVs33vjf/Q0cL79+6h9B+tgvIA1E4Ei
         xcsq2gw0/eqe6H7+VSCgUYhsqhyImDxbG2E6kf1Wsxy1gTO5sTIxfGxlqG0LL/u9eRMw
         Ta4Q==
X-Gm-Message-State: APjAAAXt5X3n9186LRcuuJ5d0vFZgEe3NVQ4yefz51wFzdtgPDivsdhY
        VIGq1sXbiR5W0LRaJHy0nA0=
X-Google-Smtp-Source: APXvYqxRvsFNNbAdZe3wFWBqjruArbkV8Rv6VXA8w1ZrP6Xh5SGeIX8nfBaGOerT4YBs1Y0UJJFVhw==
X-Received: by 2002:a5d:67c2:: with SMTP id n2mr26150338wrw.222.1574022278756;
        Sun, 17 Nov 2019 12:24:38 -0800 (PST)
Received: from debian.lan (host-78-144-219-162.as13285.net. [78.144.219.162])
        by smtp.gmail.com with ESMTPSA id x5sm17045704wmj.7.2019.11.17.12.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2019 12:24:38 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-serial@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2] {tty: serial, nand: onenand}: samsung: rename to fix build warning
Date:   Sun, 17 Nov 2019 20:24:35 +0000
Message-Id: <20191117202435.28127-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any arm config which has 'CONFIG_MTD_ONENAND_SAMSUNG=m' and
'CONFIG_SERIAL_SAMSUNG=m' gives a build warning:

warning: same module names found:
  drivers/tty/serial/samsung.ko
  drivers/mtd/nand/onenand/samsung.ko

Rename both drivers/tty/serial/samsung.c to
drivers/tty/serial/samsung_tty.c and drivers/mtd/nand/onenand/samsung.c
drivers/mtd/nand/onenand/samsung_mtd.c to fix the warning.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---

v1: only renamed drivers/tty/serial/samsung.c
link: https://lore.kernel.org/lkml/20191018194707.27188-1-sudipm.mukherjee@gmail.com

v2: rename both files.

I was not sure if this should have been two different patch, but since
this will be fixing the same problem so it seems its better to have them
in a single patch.

 drivers/mtd/nand/onenand/Makefile                     | 2 +-
 drivers/mtd/nand/onenand/{samsung.c => samsung_mtd.c} | 0
 drivers/tty/serial/Makefile                           | 2 +-
 drivers/tty/serial/{samsung.c => samsung_tty.c}       | 0
 4 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/mtd/nand/onenand/{samsung.c => samsung_mtd.c} (100%)
 rename drivers/tty/serial/{samsung.c => samsung_tty.c} (100%)

diff --git a/drivers/mtd/nand/onenand/Makefile b/drivers/mtd/nand/onenand/Makefile
index f8b624aca9cc..a27b635eb23a 100644
--- a/drivers/mtd/nand/onenand/Makefile
+++ b/drivers/mtd/nand/onenand/Makefile
@@ -9,6 +9,6 @@ obj-$(CONFIG_MTD_ONENAND)		+= onenand.o
 # Board specific.
 obj-$(CONFIG_MTD_ONENAND_GENERIC)	+= generic.o
 obj-$(CONFIG_MTD_ONENAND_OMAP2)		+= omap2.o
-obj-$(CONFIG_MTD_ONENAND_SAMSUNG)       += samsung.o
+obj-$(CONFIG_MTD_ONENAND_SAMSUNG)       += samsung_mtd.o
 
 onenand-objs = onenand_base.o onenand_bbt.o
diff --git a/drivers/mtd/nand/onenand/samsung.c b/drivers/mtd/nand/onenand/samsung_mtd.c
similarity index 100%
rename from drivers/mtd/nand/onenand/samsung.c
rename to drivers/mtd/nand/onenand/samsung_mtd.c
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 863f47056539..d056ee6cca33 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -30,7 +30,7 @@ obj-$(CONFIG_SERIAL_PXA_NON8250) += pxa.o
 obj-$(CONFIG_SERIAL_PNX8XXX) += pnx8xxx_uart.o
 obj-$(CONFIG_SERIAL_SA1100) += sa1100.o
 obj-$(CONFIG_SERIAL_BCM63XX) += bcm63xx_uart.o
-obj-$(CONFIG_SERIAL_SAMSUNG) += samsung.o
+obj-$(CONFIG_SERIAL_SAMSUNG) += samsung_tty.o
 obj-$(CONFIG_SERIAL_MAX3100) += max3100.o
 obj-$(CONFIG_SERIAL_MAX310X) += max310x.o
 obj-$(CONFIG_SERIAL_IP22_ZILOG) += ip22zilog.o
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung_tty.c
similarity index 100%
rename from drivers/tty/serial/samsung.c
rename to drivers/tty/serial/samsung_tty.c
-- 
2.11.0

