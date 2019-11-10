Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F291C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DD122582
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354193;
	bh=5UItLLFjlDhOXz3KBCG5KhmUDXK4+F73pnrDOEoTvcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=crFuETDfNm0ZKzgdby3AiBe+sTprBTW5nJil3Zmsz18d+JidZPhElM8jvcVnPEYDn
	 CbwZbaG1WJ1elz3VbSyL8/R+1yDKaXv0h58Tka9EL5HFyv2NyvP/Ph+1eAyipnWJJg
	 IO6jEodb2NUjCfvdcSAvofUOb4VTdKI8aLlU1OfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfKJCtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:49:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:59030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729459AbfKJCtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:49:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8716322593;
        Sun, 10 Nov 2019 02:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354171;
        bh=5UItLLFjlDhOXz3KBCG5KhmUDXK4+F73pnrDOEoTvcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/eoAWfV5kprP1dzZHFa/NhV2oO1Wo3GJ5O2GlRW5lv5aZQiaZxGRlqbh1mQuv5oe
         zkRgH8JpCpKX6yvsDbYhlgsEM+1qRO1HfQLrN45+pj2hdYZeiyJBGsqauqVzurJfps
         j2OMMU9xUZBQK5LvrTYgcxoAkzEFPSvN016pV64c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shahed Shaikh <Shahed.Shaikh@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 26/66] bnx2x: Ignore bandwidth attention in single function mode
Date:   Sat,  9 Nov 2019 21:48:05 -0500
Message-Id: <20191110024846.32598-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024846.32598-1-sashal@kernel.org>
References: <20191110024846.32598-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index a9681b191304a..ce8a777b1e975 100644
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

