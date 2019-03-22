Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719C9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E8C2196E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256162;
	bh=qKuALAZD3SfH1e3viT63fSrJ+/ujr5hJWbAWn2IZza8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CRyOK8FmDPE1BaFkjOjg2pgYDuCDhG+95PQfsmS7p1da9blPMnci9t97Xja1fUCDL
	 cTO0Shulj7j4jx2s9sirKKxn6s4uZ/YWGhM67/88WTGRoOFCtZXrvpoxUnNCkIp5px
	 2UIeBm12crokrl8p441PwHx+dZ5Zzflah8z1PESs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388396AbfCVMCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:02:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388387AbfCVMCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:02:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0D4321B1A;
        Fri, 22 Mar 2019 12:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256155;
        bh=qKuALAZD3SfH1e3viT63fSrJ+/ujr5hJWbAWn2IZza8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GoNMoNTq8G0Qjm5I7EG3x/tJ9Hg/d2Qq7FGJJaecZ9u2oSpqH//+8QyUMOtQ10lCF
         rkO1G9eGOHCTnsNZIfEd+dMT2+pb6oN0Rx7Z1BP7k0nzBR1HwzXS+e1n1IoUwnbiT2
         9tCDTtu8AAoMdN3jYZYvArQXh+c7a4IqxSzFVSeY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 107/280] bnxt_en: Fix typo in firmware message timeout logic.
Date:   Fri, 22 Mar 2019 12:14:20 +0100
Message-Id: <20190322111312.958962797@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

[ Upstream commit 67681d02aaa1db9044a16df4ca9c77cde1221a3e ]

The logic that polls for the firmware message response uses a shorter
sleep interval for the first few passes.  But there was a typo so it
was using the wrong counter (larger counter) for these short sleep
passes.  The result is a slightly shorter timeout period for these
firmware messages than intended.  Fix it by using the proper counter.

Fixes: 9751e8e71487 ("bnxt_en: reduce timeout on initial HWRM calls")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1fdaf86bbe8f..63b97289f4fe 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3542,7 +3542,7 @@ static int bnxt_hwrm_do_send_msg(struct bnxt *bp, void *msg, u32 msg_len,
 			if (len)
 				break;
 			/* on first few passes, just barely sleep */
-			if (i < DFLT_HWRM_CMD_TIMEOUT)
+			if (i < HWRM_SHORT_TIMEOUT_COUNTER)
 				usleep_range(HWRM_SHORT_MIN_TIMEOUT,
 					     HWRM_SHORT_MAX_TIMEOUT);
 			else
-- 
2.19.1



