Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C425FC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9666C208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="g1CNGvFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfHLL26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:28:58 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18419 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfHLL24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:28:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d514d820001>; Mon, 12 Aug 2019 04:29:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 12 Aug 2019 04:28:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 12 Aug 2019 04:28:55 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 11:28:55 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 12 Aug 2019 11:28:55 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d514d730001>; Mon, 12 Aug 2019 04:28:54 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shardar Shariff Md <smohammed@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 05/14] serial: tegra: flush the RX fifo on frame error
Date:   Mon, 12 Aug 2019 16:58:14 +0530
Message-ID: <1565609303-27000-6-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565609346; bh=nCCKGiv628BbZmkkEihGSfqyEdAMaQQZVH2IpiR4RW8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=g1CNGvFzz0+Ne84kxC1sq4a8FVG5Q5msyTbcdeBR05j4FQxlssNV+vF4j8lsS5kLB
         TJlLxpg4KyRUyAxLOQCphdhCg1P9LdnaXNFOdPPWODIxFQK2uIusuiTzE8saA5WIYK
         8kvZnGOa0jDfjS63KWHHMT6QKSm19+jeZDFmfFXoTSudZdYKUIyxSY/6KD9K5JYQw+
         5FgF+bzO3RAy3yUNcH5wPkFg6iQ++1fjLXW6Aji9ITUGya44G8b4RI6FKaZ2RskKOO
         JnvIZmLjuF7yOIluH3iOgEf6qaOp498PsouUy68D1gM1yIQB6mFSvRE9jXwrwNP/qM
         wxG9atHJH3gRA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shardar Shariff Md <smohammed@nvidia.com>

FIFO reset/flush code implemented now does not follow programming
guidelines. RTS line has to be turned off while flushing fifos to
avoid new transfers. Also check LSR bits UART_LSR_TEMT and UART_LSR_DR
to confirm fifos are flushed.

Signed-off-by: Shardar Shariff Md <smohammed@nvidia.com>
Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index ae7225c..f6a3f4e 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -266,6 +266,10 @@ static void tegra_uart_wait_sym_time(struct tegra_uart_port *tup,
 static void tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8 fcr_bits)
 {
 	unsigned long fcr = tup->fcr_shadow;
+	unsigned int lsr, tmout = 10000;
+
+	if (tup->rts_active)
+		set_rts(tup, false);
 
 	if (tup->cdata->allow_txfifo_reset_fifo_mode) {
 		fcr |= fcr_bits & (UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
@@ -289,6 +293,17 @@ static void tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8 fcr_bits)
 	 * to propagate, otherwise data could be lost.
 	 */
 	tegra_uart_wait_cycle_time(tup, 32);
+
+	do {
+		lsr = tegra_uart_read(tup, UART_LSR);
+		if (lsr | UART_LSR_TEMT)
+			if (!(lsr & UART_LSR_DR))
+				break;
+		udelay(1);
+	} while (--tmout);
+
+	if (tup->rts_active)
+		set_rts(tup, true);
 }
 
 static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int baud)
-- 
2.7.4

