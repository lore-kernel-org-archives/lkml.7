Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619DFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347E221582
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413627;
	bh=/3HkWOlR2dU9QLO0moTsiH4d2QGGmw01hAMxrei0oLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qyOFHYK6/SnvwiJhJ0QrHIXRwSMGVoPiHpWCzd0VKT4Jxw6avqyr0PpH0tWc/Iyqf
	 SkxgNVYBEjTz0ao2D4nWrx8XSKimExPWU4GZJPhW3rvs1lEBklCaYxUQku4B8xJkNZ
	 lOx8NcJdn272vqYhKcqsvG3sWuSsE8tQc10Gq7BI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbfLCWxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:53:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:47142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730161AbfLCWxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:53:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 709BF20656;
        Tue,  3 Dec 2019 22:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413623;
        bh=/3HkWOlR2dU9QLO0moTsiH4d2QGGmw01hAMxrei0oLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zvWj5JobzDMk9dB8Lk4Po+Na0oHvzTsr9r2D5T9pGH+9+woHCkBjMg0vbM55S2a95
         q/M1MTq1WWbuAlyin0ldqcmTT+h/e56+3uv74Ty0Oq/XEETfwYM4SOcPfgtEnANA2U
         IlPGZ981vyDzltbJtmaEpxlJ6fzmMwq5IahEoSDs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 172/321] drbd: reject attach of unsuitable uuids even if connected
Date:   Tue,  3 Dec 2019 23:33:58 +0100
Message-Id: <20191203223436.080930198@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Ellenberg <lars.ellenberg@linbit.com>

[ Upstream commit fe43ed97bba3b11521abd934b83ed93143470e4f ]

Multiple failure scenario:
a) all good
   Connected Primary/Secondary UpToDate/UpToDate
b) lose disk on Primary,
   Connected Primary/Secondary Diskless/UpToDate
c) continue to write to the device,
   changes only make it to the Secondary storage.
d) lose disk on Secondary,
   Connected Primary/Secondary Diskless/Diskless
e) now try to re-attach on Primary

This would have succeeded before, even though that is clearly the
wrong data set to attach to (missing the modifications from c).
Because we only compared our "effective" and the "to-be-attached"
data generation uuid tags if (device->state.conn < C_CONNECTED).

Fix: change that constraint to (device->state.pdsk != D_UP_TO_DATE)
compare the uuids, and reject the attach.

This patch also tries to improve the reverse scenario:
first lose Secondary, then Primary disk,
then try to attach the disk on Secondary.

Before this patch, the attach on the Secondary succeeds, but since commit
drbd: disconnect, if the wrong UUIDs are attached on a connected peer
the Primary will notice unsuitable data, and drop the connection hard.

Though unfortunately at a point in time during the handshake where
we cannot easily abort the attach on the peer without more
refactoring of the handshake.

We now reject any attach to "unsuitable" uuids,
as long as we can see a Primary role,
unless we already have access to "good" data.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/drbd/drbd_nl.c       |  6 +++---
 drivers/block/drbd/drbd_receiver.c | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 319fabdd63a3f..3366c1a91ee00 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1935,9 +1935,9 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	if (device->state.conn < C_CONNECTED &&
-	    device->state.role == R_PRIMARY && device->ed_uuid &&
-	    (device->ed_uuid & ~((u64)1)) != (nbc->md.uuid[UI_CURRENT] & ~((u64)1))) {
+	if (device->state.pdsk != D_UP_TO_DATE && device->ed_uuid &&
+	    (device->state.role == R_PRIMARY || device->state.peer == R_PRIMARY) &&
+            (device->ed_uuid & ~((u64)1)) != (nbc->md.uuid[UI_CURRENT] & ~((u64)1))) {
 		drbd_err(device, "Can only attach to data with current UUID=%016llX\n",
 		    (unsigned long long)device->ed_uuid);
 		retcode = ERR_DATA_NOT_CURRENT;
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index c9e8d61dea248..cbb6ef719978f 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -4395,6 +4395,25 @@ static int receive_state(struct drbd_connection *connection, struct packet_info
 	if (peer_state.conn == C_AHEAD)
 		ns.conn = C_BEHIND;
 
+	/* TODO:
+	 * if (primary and diskless and peer uuid != effective uuid)
+	 *     abort attach on peer;
+	 *
+	 * If this node does not have good data, was already connected, but
+	 * the peer did a late attach only now, trying to "negotiate" with me,
+	 * AND I am currently Primary, possibly frozen, with some specific
+	 * "effective" uuid, this should never be reached, really, because
+	 * we first send the uuids, then the current state.
+	 *
+	 * In this scenario, we already dropped the connection hard
+	 * when we received the unsuitable uuids (receive_uuids().
+	 *
+	 * Should we want to change this, that is: not drop the connection in
+	 * receive_uuids() already, then we would need to add a branch here
+	 * that aborts the attach of "unsuitable uuids" on the peer in case
+	 * this node is currently Diskless Primary.
+	 */
+
 	if (device->p_uuid && peer_state.disk >= D_NEGOTIATING &&
 	    get_ldev_if_state(device, D_NEGOTIATING)) {
 		int cr; /* consider resync */
-- 
2.20.1



