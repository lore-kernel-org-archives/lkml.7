Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326FAC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA74204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429957;
	bh=dzvGZR5DDmGEX6Cf6j5ZTi37Rt4Wn/mZhjl8aYJylCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uVVKWfNhqaiV2WcLFCqrJGk5+hzsez+5s/xaOMpvIwBbXY8lORPX1WjXHT3JA1HPx
	 4cpxqQgkFk2niho9YrsUrjIlT9N6L2P6LjnsTEB/lnS7ac2qh+J9SKZwWnnSiVWzFa
	 bjUOHtgn90iHUUYHuW5RvEM4FOBgkXrw6qrZJg90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390540AbfG2Twf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:52:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403886AbfG2TwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:52:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BE9B2171F;
        Mon, 29 Jul 2019 19:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429942;
        bh=dzvGZR5DDmGEX6Cf6j5ZTi37Rt4Wn/mZhjl8aYJylCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nFWXi4/4kvE3O4Cp7DRSy5b/8vlO8dmLAm7hf0v9ExsF2q6wb/CfWrTVkp9mbkq80
         lX8LeWmBMXoRecQG0h+sInif/ltXVRLHKCQuYBBz66rZFsM/YYNZHcwNWWMwqKkBRy
         OOSh2al47UkGJTz4TpvA0QKXplDC6Vml7wreiFwQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Windsor <dwindsor@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 144/215] dlm: check if workqueues are NULL before flushing/destroying
Date:   Mon, 29 Jul 2019 21:22:20 +0200
Message-Id: <20190729190804.634942706@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b355516f450703c9015316e429b66a93dfff0e6f ]

If the DLM lowcomms stack is shut down before any DLM
traffic can be generated, flush_workqueue() and
destroy_workqueue() can be called on empty send and/or recv
workqueues.

Insert guard conditionals to only call flush_workqueue()
and destroy_workqueue() on workqueues that are not NULL.

Signed-off-by: David Windsor <dwindsor@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/lowcomms.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 114ebfe30929..3951d39b9b75 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1628,8 +1628,10 @@ static void clean_writequeues(void)
 
 static void work_stop(void)
 {
-	destroy_workqueue(recv_workqueue);
-	destroy_workqueue(send_workqueue);
+	if (recv_workqueue)
+		destroy_workqueue(recv_workqueue);
+	if (send_workqueue)
+		destroy_workqueue(send_workqueue);
 }
 
 static int work_start(void)
@@ -1689,13 +1691,17 @@ static void work_flush(void)
 	struct hlist_node *n;
 	struct connection *con;
 
-	flush_workqueue(recv_workqueue);
-	flush_workqueue(send_workqueue);
+	if (recv_workqueue)
+		flush_workqueue(recv_workqueue);
+	if (send_workqueue)
+		flush_workqueue(send_workqueue);
 	do {
 		ok = 1;
 		foreach_conn(stop_conn);
-		flush_workqueue(recv_workqueue);
-		flush_workqueue(send_workqueue);
+		if (recv_workqueue)
+			flush_workqueue(recv_workqueue);
+		if (send_workqueue)
+			flush_workqueue(send_workqueue);
 		for (i = 0; i < CONN_HASH_SIZE && ok; i++) {
 			hlist_for_each_entry_safe(con, n,
 						  &connection_hash[i], list) {
-- 
2.20.1



