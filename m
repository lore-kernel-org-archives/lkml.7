Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38848C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A68C214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OtuO+ZUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfHLL2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:28:42 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4762 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbfHLL2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:28:41 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d514d6a0000>; Mon, 12 Aug 2019 04:28:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 12 Aug 2019 04:28:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 12 Aug 2019 04:28:40 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 11:28:40 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 11:28:40 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 12 Aug 2019 11:28:39 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d514d640001>; Mon, 12 Aug 2019 04:28:39 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andreas Abel <aabel@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 01/14] serial: tegra: add internal loopback functionality
Date:   Mon, 12 Aug 2019 16:58:10 +0530
Message-ID: <1565609303-27000-2-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565609322; bh=huLMVik//9qsikbuYQ83aaymQqzGDhNZnc5EnNtdXjw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=OtuO+ZULaOBbQ1R3eRvbouxEbxYWMGsWzErnvLjigerBB0R6J8rcXoEUUntPLsyee
         XCrU6gpgBOYEMptPl7vUkPheRYJ8xfpZcl+1IQ6T0qZrbYtxsqgBtqcnrvYLZgR19o
         Gq1/RKkFiQv6qnAOr8yA1N4oyj1WsKGWq4SAFdavdoOI/jlcBuhLjtd+Bnu5DUVLbV
         rij1vA6Y3DrceRbshpQkb+BZ5p8A3SbBq/PCFtzEbiExf2ZFhFg40T29HABQYQxoOx
         Yu2EONAoXw+tFnot5Uk98mlsAduss1NsaExQiVnopyBnAJeZmoL0DqcAImHBNsAi7C
         Ar5wNdRmMgeCQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Abel <aabel@nvidia.com>

Add the internal loopback functionality that can be enabled with
TIOCM_LOOP.

Signed-off-by: Andreas Abel <aabel@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index d5269aa..19f4c24 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -4,7 +4,7 @@
  *
  * High-speed serial driver for NVIDIA Tegra SoCs
  *
- * Copyright (c) 2012-2013, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2012-2019, NVIDIA CORPORATION.  All rights reserved.
  *
  * Author: Laxman Dewangan <ldewangan@nvidia.com>
  */
@@ -192,16 +192,34 @@ static void set_dtr(struct tegra_uart_port *tup, bool active)
 	}
 }
 
+static void set_loopbk(struct tegra_uart_port *tup, bool active)
+{
+	unsigned long mcr = tup->mcr_shadow;
+
+	if (active)
+		mcr |= UART_MCR_LOOP;
+	else
+		mcr &= ~UART_MCR_LOOP;
+
+	if (mcr != tup->mcr_shadow) {
+		tegra_uart_write(tup, mcr, UART_MCR);
+		tup->mcr_shadow = mcr;
+	}
+}
+
 static void tegra_uart_set_mctrl(struct uart_port *u, unsigned int mctrl)
 {
 	struct tegra_uart_port *tup = to_tegra_uport(u);
-	int dtr_enable;
+	int enable;
 
 	tup->rts_active = !!(mctrl & TIOCM_RTS);
 	set_rts(tup, tup->rts_active);
 
-	dtr_enable = !!(mctrl & TIOCM_DTR);
-	set_dtr(tup, dtr_enable);
+	enable = !!(mctrl & TIOCM_DTR);
+	set_dtr(tup, enable);
+
+	enable = !!(mctrl & TIOCM_LOOP);
+	set_loopbk(tup, enable);
 }
 
 static void tegra_uart_break_ctl(struct uart_port *u, int break_ctl)
-- 
2.7.4

