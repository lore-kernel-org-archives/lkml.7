Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4532C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB224208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AAPN71YV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfHLL2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:28:54 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4775 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfHLL2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:28:52 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d514d750000>; Mon, 12 Aug 2019 04:28:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 12 Aug 2019 04:28:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 12 Aug 2019 04:28:51 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 11:28:51 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 12 Aug 2019 11:28:51 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d514d700000>; Mon, 12 Aug 2019 04:28:50 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ahung Cheng <ahcheng@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 04/14] serial: tegra: protect IER against LCR.DLAB
Date:   Mon, 12 Aug 2019 16:58:13 +0530
Message-ID: <1565609303-27000-5-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565609333; bh=ADUXU22pbKxAc6su3ZyKW+PXLicjlm3CyfngVyySigY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=AAPN71YVilUkhMM4ZQLASP2z7l32sRtguhSU2VWXBOK7/hLj2llV8hCl7PZ+IR3ov
         l/23CpAoXY791yeV1Uv089//c9X94MFaQhXymycIa1jry2/N3YyXjdVQk4qVIUaByn
         1GKqZBzti8q/PPEh9LdqG4h0e4oP1KvNN5nHHDSjajcN7XcBF/ZU3NoXLNRPn5WCuV
         IMLSU8/lC0xZv0GMthmETTJUs7K+sFnYovKV/7sl9BISOyPhOlSDz4mmDyw6GjSVny
         owwBuGfWElnB06LjTO/mf/oGInzwto8K4ry8M1NdNvujSviOsPyPB9hMtsWKmHGz8l
         0fuNceNWr0pWg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahung Cheng <ahcheng@nvidia.com>

The IER and DLH registers occupy the same address space, selected by
the LCR.DLAB bit. Hence, add port lock to protect IER when LCR.DLAB bit
is set.

Signed-off-by: Ahung Cheng <ahcheng@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index d908465..ae7225c 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -296,6 +296,7 @@ static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int baud)
 	unsigned long rate;
 	unsigned int divisor;
 	unsigned long lcr;
+	unsigned long flags;
 	int ret;
 
 	if (tup->current_baud == baud)
@@ -315,6 +316,7 @@ static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int baud)
 		divisor = DIV_ROUND_CLOSEST(rate, baud * 16);
 	}
 
+	spin_lock_irqsave(&tup->uport.lock, flags);
 	lcr = tup->lcr_shadow;
 	lcr |= UART_LCR_DLAB;
 	tegra_uart_write(tup, lcr, UART_LCR);
@@ -327,6 +329,7 @@ static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int baud)
 
 	/* Dummy read to ensure the write is posted */
 	tegra_uart_read(tup, UART_SCR);
+	spin_unlock_irqrestore(&tup->uport.lock, flags);
 
 	tup->current_baud = baud;
 
-- 
2.7.4

