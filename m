Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBB5C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22512071A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141935;
	bh=38A7lZnLtnGmRLXkDKXv2Syi9AZbbMf5E6dfb84ep1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PeE7lx+ke72q8k7ldbwiF+ZlQRzt/0H1JpwGwj3pfc6SNC7l85f8Kxv7zw55O2b0/
	 i2BEpMZixNe8TC7iSewDDgrReQyspvK2/rwAXhfGh6xytLPIQGGxQTRnx1Dcmv9+pZ
	 5wPhuHA5e6oCbZZWVFK+QZpZnDMqMAvrs9hbyB1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbfKSFix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:38:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:32776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730217AbfKSFiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:38:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7478B21823;
        Tue, 19 Nov 2019 05:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141930;
        bh=38A7lZnLtnGmRLXkDKXv2Syi9AZbbMf5E6dfb84ep1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O6nwwdBSSVnL5eiGnb7w4WKjjLy7wxFNVHicuIg4SEpMC8MIybAu1mpGMn+6TShn4
         zcDkHOfb/L1+s0CpFh0+NS6AfooFARQYslgaFMpCR8391oVDxU6SGDMTMB7fCPLQAh
         0hqT6qbwmSjZPZkMaLSiB1vJD0mGwfTdNSOX8b08=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shahed Shaikh <Shahed.Shaikh@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 312/422] bnx2x: Ignore bandwidth attention in single function mode
Date:   Tue, 19 Nov 2019 06:18:29 +0100
Message-Id: <20191119051419.213854472@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shahed Shaikh <Shahed.Shaikh@cavium.com>

[ Upstream commit 75a110a1783ef8324ffd763b24f4ac268253cbca ]

This is a workaround for FW bug -
MFW generates bandwidth attention in single function mode, which
is only expected to be generated in multi function mode.
This undesired attention in SF mode results in incorrect HW
configuration and resulting into Tx timeout.

Signed-off-by: Shahed Shaikh <Shahed.Shaikh@cavium.com>
Signed-off-by: Ariel Elior <ariel.elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 68c62e32e8820..af57568c922eb 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -3540,6 +3540,16 @@ static void bnx2x_drv_info_iscsi_stat(struct bnx2x *bp)
  */
 static void bnx2x_config_mf_bw(struct bnx2x *bp)
 {
+	/* Workaround for MFW bug.
+	 * MFW is not supposed to generate BW attention in
+	 * single function mode.
+	 */
+	if (!IS_MF(bp)) {
+		DP(BNX2X_MSG_MCP,
+		   "Ignoring MF BW config in single function mode\n");
+		return;
+	}
+
 	if (bp->link_vars.link_up) {
 		bnx2x_cmng_fns_init(bp, true, CMNG_FNS_MINMAX);
 		bnx2x_link_sync_notify(bp);
-- 
2.20.1



