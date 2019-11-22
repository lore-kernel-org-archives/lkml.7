Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D26C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5145820721
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574401975;
	bh=CQuBCBvKAAsOoZocCAsqj8Qd5e+iFxFP6/c3gZsHpI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EHoPgHO/Vr7tvP8cMPVUZn8IYytIg/E5SuQvRPuk3FsEDeMF1EBLRB4/QV/HLpP6u
	 9ucLHCOgzDbLv2zdbN34ApD/GEQWpJy8FyfwDm2zvrXwZajypN4qklgtGzMXBYUBC3
	 0F6paA09k++rZ3vC/xqiUObI9a7fDJg9IIfg6kyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbfKVFwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:52:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728666AbfKVFwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:52:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA0CE2068F;
        Fri, 22 Nov 2019 05:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401965;
        bh=CQuBCBvKAAsOoZocCAsqj8Qd5e+iFxFP6/c3gZsHpI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u9wRdKFXg0a/NrOLTQLEcbHTwoGj7r7GuCULhLAezsY3vZLjMVpALpi/JItvAeQAk
         3agdSV0JIdRrENnIThmnpezUT0jsaD7Z5DVW8XpR9UUp/plU3l87FA9g1m+Vhf5HkJ
         E7dyroRF6lFhpo43gtSuAXP6x+moIlzkrCFnXnQ8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ursula Braun <ubraun@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 186/219] net/smc: fix byte_order for rx_curs_confirmed
Date:   Fri, 22 Nov 2019 00:48:38 -0500
Message-Id: <20191122054911.1750-179-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ursula Braun <ubraun@linux.ibm.com>

[ Upstream commit ccc8ca9b90acb45a3309f922b2591b07b4e070ec ]

The recent change in the rx_curs_confirmed assignment disregards
byte order, which causes problems on little endian architectures.
This patch fixes it.

Fixes: b8649efad879 ("net/smc: fix sender_free computation") (net-tree)
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_cdc.c |  4 +---
 net/smc/smc_cdc.h | 19 ++++++++++---------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 8f691b5a44ddf..333e4353498f8 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -106,9 +106,7 @@ int smc_cdc_msg_send(struct smc_connection *conn,
 
 	conn->tx_cdc_seq++;
 	conn->local_tx_ctrl.seqno = conn->tx_cdc_seq;
-	smc_host_msg_to_cdc((struct smc_cdc_msg *)wr_buf,
-			    &conn->local_tx_ctrl, conn);
-	smc_curs_copy(&cfed, &((struct smc_host_cdc_msg *)wr_buf)->cons, conn);
+	smc_host_msg_to_cdc((struct smc_cdc_msg *)wr_buf, conn, &cfed);
 	rc = smc_wr_tx_send(link, (struct smc_wr_tx_pend_priv *)pend);
 	if (!rc)
 		smc_curs_copy(&conn->rx_curs_confirmed, &cfed, conn);
diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
index 2377a51772d51..34d2e1450320a 100644
--- a/net/smc/smc_cdc.h
+++ b/net/smc/smc_cdc.h
@@ -186,26 +186,27 @@ static inline int smc_curs_diff_large(unsigned int size,
 
 static inline void smc_host_cursor_to_cdc(union smc_cdc_cursor *peer,
 					  union smc_host_cursor *local,
+					  union smc_host_cursor *save,
 					  struct smc_connection *conn)
 {
-	union smc_host_cursor temp;
-
-	smc_curs_copy(&temp, local, conn);
-	peer->count = htonl(temp.count);
-	peer->wrap = htons(temp.wrap);
+	smc_curs_copy(save, local, conn);
+	peer->count = htonl(save->count);
+	peer->wrap = htons(save->wrap);
 	/* peer->reserved = htons(0); must be ensured by caller */
 }
 
 static inline void smc_host_msg_to_cdc(struct smc_cdc_msg *peer,
-				       struct smc_host_cdc_msg *local,
-				       struct smc_connection *conn)
+				       struct smc_connection *conn,
+				       union smc_host_cursor *save)
 {
+	struct smc_host_cdc_msg *local = &conn->local_tx_ctrl;
+
 	peer->common.type = local->common.type;
 	peer->len = local->len;
 	peer->seqno = htons(local->seqno);
 	peer->token = htonl(local->token);
-	smc_host_cursor_to_cdc(&peer->prod, &local->prod, conn);
-	smc_host_cursor_to_cdc(&peer->cons, &local->cons, conn);
+	smc_host_cursor_to_cdc(&peer->prod, &local->prod, save, conn);
+	smc_host_cursor_to_cdc(&peer->cons, &local->cons, save, conn);
 	peer->prod_flags = local->prod_flags;
 	peer->conn_state_flags = local->conn_state_flags;
 }
-- 
2.20.1

