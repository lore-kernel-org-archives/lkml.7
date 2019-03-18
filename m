Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D922C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0D52087C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901594;
	bh=h/n/E1j4Vm6JxjLBeHhDqsWf2DoPXbCgCLfxkbqWvjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j3/ezdsvcV92R5SMbfba0F4BvEhMyrsPz4p+mszdgLsU4YHxOT5hXM05TfcLXd0bM
	 QSbocmdRXUnFxo67jIwc02H49aaH7NjVDB0pvj94/0WvyWHWuNaFrRw5enNI45pxf3
	 NStG4jYVjCcHYyysMhFNWA7mQpo5837MZGRmsiRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfCRJdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:33:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727907AbfCRJdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:33:08 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3CBA2075C;
        Mon, 18 Mar 2019 09:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901587;
        bh=h/n/E1j4Vm6JxjLBeHhDqsWf2DoPXbCgCLfxkbqWvjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s0kUHILRZ8zOVus+sGgToBt1GQ92KP5m5hPaYHijizLr5MDsqjMB9c77ScXcYbMJj
         TYpHVSLQt5QPs9j1HoqpEoLFgWFAufBlbYex1ZP3r1Q2C/nqXMPzBYw8IjS2IBCH4V
         TkmNBYO6Wa5sBwGgiUE3JeeOIU2xHRHOc8GO7UoQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bryan Whitehead <Bryan.Whitehead@microchip.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 06/52] lan743x: Fix TX Stall Issue
Date:   Mon, 18 Mar 2019 10:25:03 +0100
Message-Id: <20190318084014.310908126@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084013.532280682@linuxfoundation.org>
References: <20190318084013.532280682@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bryan Whitehead <Bryan.Whitehead@microchip.com>

[ Upstream commit deb6bfabdbb634e91f36a4e9cb00a7137d72d886 ]

It has been observed that tx queue may stall while downloading
from certain web sites (example www.speedtest.net)

The cause has been tracked down to a corner case where
the tx interrupt vector was disabled automatically, but
was not re enabled later.

The lan743x has two mechanisms to enable/disable individual
interrupts. Interrupts can be enabled/disabled by individual
source, and they can also be enabled/disabled by individual
vector which has been mapped to the source. Both must be
enabled for interrupts to work properly.

The TX code path, primarily uses the interrupt enable/disable of
the TX source bit, while leaving the vector enabled all the time.

However, while investigating this issue it was noticed that
the driver requested the use of the vector auto clear feature.

The test above revealed a case where the vector enable was
cleared unintentionally.

This patch fixes the issue by deleting the lines that request
the vector auto clear feature to be used.

Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x driver")
Signed-off-by: Bryan Whitehead <Bryan.Whitehead@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/microchip/lan743x_main.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -585,8 +585,7 @@ static int lan743x_intr_open(struct lan7
 
 		if (adapter->csr.flags &
 		   LAN743X_CSR_FLAG_SUPPORTS_INTR_AUTO_SET_CLR) {
-			flags = LAN743X_VECTOR_FLAG_VECTOR_ENABLE_AUTO_CLEAR |
-				LAN743X_VECTOR_FLAG_VECTOR_ENABLE_AUTO_SET |
+			flags = LAN743X_VECTOR_FLAG_VECTOR_ENABLE_AUTO_SET |
 				LAN743X_VECTOR_FLAG_SOURCE_ENABLE_AUTO_SET |
 				LAN743X_VECTOR_FLAG_SOURCE_ENABLE_AUTO_CLEAR |
 				LAN743X_VECTOR_FLAG_SOURCE_STATUS_AUTO_CLEAR;
@@ -599,12 +598,6 @@ static int lan743x_intr_open(struct lan7
 			/* map TX interrupt to vector */
 			int_vec_map1 |= INT_VEC_MAP1_TX_VEC_(index, vector);
 			lan743x_csr_write(adapter, INT_VEC_MAP1, int_vec_map1);
-			if (flags &
-			    LAN743X_VECTOR_FLAG_VECTOR_ENABLE_AUTO_CLEAR) {
-				int_vec_en_auto_clr |= INT_VEC_EN_(vector);
-				lan743x_csr_write(adapter, INT_VEC_EN_AUTO_CLR,
-						  int_vec_en_auto_clr);
-			}
 
 			/* Remove TX interrupt from shared mask */
 			intr->vector_list[0].int_mask &= ~int_bit;


