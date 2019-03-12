Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906B5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C54B21734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413657;
	bh=/T24Lt6Xyax4gZFoasqL3Mw664TMKyKEyy9L57HOtXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MGd4shEjFDMzmODEEJcXMc6mx2Xp7uQbBUUXvEHYvGjbcIxpcFHAe7X0BE5Fl8M55
	 29DeKmKwOapz0td8VuzSnkFtz9/LjqPxmNop+LaPs8oVTXMN1ueYvhGYY10j6qTBz8
	 +8Gl4Dziiy+doGqhdhh6YSzYSufihmT4lbq5e1L8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfCLSA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:00:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbfCLRNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:17 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BE892183F;
        Tue, 12 Mar 2019 17:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410796;
        bh=/T24Lt6Xyax4gZFoasqL3Mw664TMKyKEyy9L57HOtXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZAAy2e6iSlMWulO1/RmI64BBNs6r6bsqTpmwIe388UYHLLgrcw5so+lJV0RJMSiUF
         rZS5+IdiNEuNT73mU32LLwQs8q2HWGVD1dsIedFQEiGXztJO+kJ+qaP6E+9F8XkL1i
         klPIDA0KZaGxbenbZSobrXy6r+A56CSmyol3Usb8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 142/171] qed: Fix EQ full firmware assert.
Date:   Tue, 12 Mar 2019 10:08:42 -0700
Message-Id: <20190312170359.870344981@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index 3157c0d99441..dae2896e1d8e 100644
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
index 0a9c5bb0fa48..a721b9348b6c 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_spq.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_spq.c
@@ -402,6 +402,11 @@ int qed_eq_completion(struct qed_hwfn *p_hwfn, void *cookie)
 
 	qed_eq_prod_update(p_hwfn, qed_chain_get_prod_idx(p_chain));
 
+	/* Attempt to post pending requests */
+	spin_lock_bh(&p_hwfn->p_spq->lock);
+	rc = qed_spq_pend_post(p_hwfn);
+	spin_unlock_bh(&p_hwfn->p_spq->lock);
+
 	return rc;
 }
 
@@ -744,7 +749,7 @@ static int qed_spq_post_list(struct qed_hwfn *p_hwfn,
 	return 0;
 }
 
-static int qed_spq_pend_post(struct qed_hwfn *p_hwfn)
+int qed_spq_pend_post(struct qed_hwfn *p_hwfn)
 {
 	struct qed_spq *p_spq = p_hwfn->p_spq;
 	struct qed_spq_entry *p_ent = NULL;
@@ -882,7 +887,6 @@ int qed_spq_completion(struct qed_hwfn *p_hwfn,
 	struct qed_spq_entry	*p_ent = NULL;
 	struct qed_spq_entry	*tmp;
 	struct qed_spq_entry	*found = NULL;
-	int			rc;
 
 	if (!p_hwfn)
 		return -EINVAL;
@@ -940,12 +944,7 @@ int qed_spq_completion(struct qed_hwfn *p_hwfn,
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



