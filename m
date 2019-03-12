Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D836C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FE3206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412124;
	bh=HLwUd72mDoW4h2pAq8JlDL7IXIsRe8w8TjGbEh52p70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cg8CbPpv9Wt25LSQ3TYWpU6NRLwMuVFOQG/Thg9NaJWt9Ennem1L+BaiKqGotVyCu
	 XO74Jzf/EEGT3oUTpdCvxuJTch1jPEiMt0kUde8mIzkDvz0bds63bFPcgaKcNnmIMc
	 FaLN13C1jE5PqCe0Q2XQoM2Tqxxt8OTFYAI95/js=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbfCLRfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729361AbfCLRQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:54 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EE4B217D8;
        Tue, 12 Mar 2019 17:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411014;
        bh=HLwUd72mDoW4h2pAq8JlDL7IXIsRe8w8TjGbEh52p70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zyvJ1VCEk/HHtf9ZlMxdOd+SobO4zjLVqaeU5JjeZZQQ/1+/mTntd/UCgSTAiLT37
         zaP9jfMatNCgR0T15rO2crd/kGb4JtEGV6OOaRkWDyD3qq8HxeJXvUQOhPVYxBqc32
         He7q7G90J8LHR1ZltBoICHpccp6HN9hw5AcfkkJ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <skalluru@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 119/135] qed: Consider TX tcs while deriving the max num_queues for PF.
Date:   Tue, 12 Mar 2019 10:09:26 -0700
Message-Id: <20190312170352.171128707@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit fb1faab74ddef9ec2d841d54e5d0912a097b3abe ]

Max supported queues is derived incorrectly in the case of multi-CoS.
Need to consider TCs while calculating num_queues for PF.

Signed-off-by: Sudarsana Reddy Kalluru <skalluru@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_l2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.c b/drivers/net/ethernet/qlogic/qed/qed_l2.c
index 4ffdde755db7..62cde3854a5c 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.c
@@ -2170,7 +2170,7 @@ static int qed_fill_eth_dev_info(struct qed_dev *cdev,
 			u16 num_queues = 0;
 
 			/* Since the feature controls only queue-zones,
-			 * make sure we have the contexts [rx, tx, xdp] to
+			 * make sure we have the contexts [rx, xdp, tcs] to
 			 * match.
 			 */
 			for_each_hwfn(cdev, i) {
@@ -2180,7 +2180,8 @@ static int qed_fill_eth_dev_info(struct qed_dev *cdev,
 				u16 cids;
 
 				cids = hwfn->pf_params.eth_pf_params.num_cons;
-				num_queues += min_t(u16, l2_queues, cids / 3);
+				cids /= (2 + info->num_tc);
+				num_queues += min_t(u16, l2_queues, cids);
 			}
 
 			/* queues might theoretically be >256, but interrupts'
-- 
2.19.1



