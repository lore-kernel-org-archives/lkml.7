Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EE0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A02B206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412115;
	bh=uHqbiq2323LrZfdZEBFK21XzrSuQDYkkN0OT2Xylsdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AbFxFTNYFfiBu339zC2VV/1bj1NCszBv0B1ApVouYUQDOs2OyyXqLUt6xcJC/wggg
	 L+nNFm5ShE3Y8HBd3inXMQCQxewj4k4vJiGSpRDPFWs5qLyfmZO+yBWhqOp7DQo9Wj
	 JarquMhyrwHObjWZWZ8rpY+pbaxQqvuorKEIJa8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfCLRfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbfCLRQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:54 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F7CA2087C;
        Tue, 12 Mar 2019 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411013;
        bh=uHqbiq2323LrZfdZEBFK21XzrSuQDYkkN0OT2Xylsdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GMqqp/OMFOhkJQhj+ccOOTx7jKir5PZJqi7DpMT+TMvKoqfAPImZ5xO1BXEJYJg/1
         z67ont1ftSP39QkHdVtFBpjmPjj2uR++PU7hjlqul+pJufk9djvvNlPewnBCyfTVfN
         RGYjivuQa87R66Sm/QDIpWOCNXdCxQtzxF7FsPfY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 118/135] qed: Fix EQ full firmware assert.
Date:   Tue, 12 Mar 2019 10:09:25 -0700
Message-Id: <20190312170352.094335679@linuxfoundation.org>
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

[ Upstream commit 660492bcf4a7561b5fdc13be0ae0b0c0a8c120be ]

When slowpath messages are sent with high rate, the resulting
events can lead to a FW assert in case they are not handled fast
enough (Event Queue Full assert). Attempt to send queued slowpath
messages only after the newly evacuated entries in the EQ ring
are indicated to FW.

Signed-off-by: Manish Chopra <manishc@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_sp.h  |  1 +
 drivers/net/ethernet/qlogic/qed/qed_spq.c | 15 +++++++--------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_sp.h b/drivers/net/ethernet/qlogic/qed/qed_sp.h
index 01a213d4ee9c..e7192f3babc2 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sp.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_sp.h
@@ -380,6 +380,7 @@ void qed_consq_setup(struct qed_hwfn *p_hwfn);
  * @param p_hwfn
  */
 void qed_consq_free(struct qed_hwfn *p_hwfn);
+int qed_spq_pend_post(struct qed_hwfn *p_hwfn);
 
 /**
  * @file
diff --git a/drivers/net/ethernet/qlogic/qed/qed_spq.c b/drivers/net/ethernet/qlogic/qed/qed_spq.c
index 467755b6dd0b..01f8e2b5cb6c 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_spq.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_spq.c
@@ -404,6 +404,11 @@ int qed_eq_completion(struct qed_hwfn *p_hwfn, void *cookie)
 
 	qed_eq_prod_update(p_hwfn, qed_chain_get_prod_idx(p_chain));
 
+	/* Attempt to post pending requests */
+	spin_lock_bh(&p_hwfn->p_spq->lock);
+	rc = qed_spq_pend_post(p_hwfn);
+	spin_unlock_bh(&p_hwfn->p_spq->lock);
+
 	return rc;
 }
 
@@ -747,7 +752,7 @@ static int qed_spq_post_list(struct qed_hwfn *p_hwfn,
 	return 0;
 }
 
-static int qed_spq_pend_post(struct qed_hwfn *p_hwfn)
+int qed_spq_pend_post(struct qed_hwfn *p_hwfn)
 {
 	struct qed_spq *p_spq = p_hwfn->p_spq;
 	struct qed_spq_entry *p_ent = NULL;
@@ -879,7 +884,6 @@ int qed_spq_completion(struct qed_hwfn *p_hwfn,
 	struct qed_spq_entry	*p_ent = NULL;
 	struct qed_spq_entry	*tmp;
 	struct qed_spq_entry	*found = NULL;
-	int			rc;
 
 	if (!p_hwfn)
 		return -EINVAL;
@@ -937,12 +941,7 @@ int qed_spq_completion(struct qed_hwfn *p_hwfn,
 		 */
 		qed_spq_return_entry(p_hwfn, found);
 
-	/* Attempt to post pending requests */
-	spin_lock_bh(&p_spq->lock);
-	rc = qed_spq_pend_post(p_hwfn);
-	spin_unlock_bh(&p_spq->lock);
-
-	return rc;
+	return 0;
 }
 
 int qed_consq_alloc(struct qed_hwfn *p_hwfn)
-- 
2.19.1



