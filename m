Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6896AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5B4206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367337;
	bh=6qAy4wSo1bOF5/hiSMgd6EsUTUPKnLFa8uzFX8v2fkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B58nyvFcrvUUkKE+oYvpFKzI4pWoCuplcnA84dq/BJy1bpoX+5CoY6ifnaYOwBTDG
	 HXNpR142WsyeKp8m5nh0ELZ0DwFHnv7H7U1NkQDZpq9zQFqESM6srVGKd4hWSiOkzj
	 H4XhIfHKBmZ852OuLQKhm3tBCTcgD3gyYNo733l8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388505AbfB1PNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:13:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:47526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388444AbfB1PNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:13:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2D80218D9;
        Thu, 28 Feb 2019 15:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366810;
        bh=6qAy4wSo1bOF5/hiSMgd6EsUTUPKnLFa8uzFX8v2fkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wSVbIXwJflswueUhDdJ5QnmfKiztc4JbdXX6Rw0il8t6Za4LDqXMMpyNdLiwixvSU
         T3wYBT/dCq95Cec3z8cj5RI4hhmExAnrdENRTy24YElAen+UimZXjUz1sHwSwd5sJj
         pRhBVXvn5loeqHsM8lWcq4cHzIuPl3xUa/eHEfxA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 61/64] qed: Fix EQ full firmware assert.
Date:   Thu, 28 Feb 2019 10:11:02 -0500
Message-Id: <20190228151105.11277-61-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manish Chopra <manishc@marvell.com>

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
index 3157c0d994417..dae2896e1d8e4 100644
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
index 7106ad17afe2e..a0ee847f379bb 100644
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
 
@@ -745,7 +750,7 @@ static int qed_spq_post_list(struct qed_hwfn *p_hwfn,
 	return 0;
 }
 
-static int qed_spq_pend_post(struct qed_hwfn *p_hwfn)
+int qed_spq_pend_post(struct qed_hwfn *p_hwfn)
 {
 	struct qed_spq *p_spq = p_hwfn->p_spq;
 	struct qed_spq_entry *p_ent = NULL;
@@ -883,7 +888,6 @@ int qed_spq_completion(struct qed_hwfn *p_hwfn,
 	struct qed_spq_entry	*p_ent = NULL;
 	struct qed_spq_entry	*tmp;
 	struct qed_spq_entry	*found = NULL;
-	int			rc;
 
 	if (!p_hwfn)
 		return -EINVAL;
@@ -941,12 +945,7 @@ int qed_spq_completion(struct qed_hwfn *p_hwfn,
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

