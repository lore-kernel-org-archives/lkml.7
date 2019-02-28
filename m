Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D784C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A46206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367191;
	bh=zdw0Kec8AgJnAEpXTFodoUgi2s1gRzsL904grXhqGgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AHetJuaZB75lvXW+Vb9D3tq41T9FrxUevJ+iSj/CnUmUFsH5TUf283GZ8J01NnGdz
	 J3yhxw/jjO6xgKmqLByH7kc7mcn4ZTKYtXdhDXhmOihO9vY6coWsC3vNyh2LHNDnVw
	 N3MLulCF4B5tidCAqvZDQ8+kp9Wz6tvqAsQQYWxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388818AbfB1PTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:19:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:50615 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388787AbfB1PPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:15:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C39B21900;
        Thu, 28 Feb 2019 15:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366913;
        bh=zdw0Kec8AgJnAEpXTFodoUgi2s1gRzsL904grXhqGgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n6SXow+sLeUXRB49j6PI8yQpX4x0JaIFaEdOJqqz8vBMHgyOS93G4FeKY5FaZE+12
         tp33ctAeE/C/lWxm2qSz/JSP0yDD+SGVC3RyRD7IdEJ4d5xNNoIegaxvv/dsHrWJPX
         vqvU4JxVZagtgnm2g1Hnt0/muK6wyG60ukudNbXA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 35/36] qed: Fix EQ full firmware assert.
Date:   Thu, 28 Feb 2019 10:13:36 -0500
Message-Id: <20190228151337.12176-35-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151337.12176-1-sashal@kernel.org>
References: <20190228151337.12176-1-sashal@kernel.org>
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
index 01a213d4ee9c5..e7192f3babc28 100644
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
index 467755b6dd0be..01f8e2b5cb6c3 100644
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

