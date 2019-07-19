Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750B2C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4268F2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510861;
	bh=LuC0CZgJqwGJfnyVzc/N2ZoFrXBTl4AyfQvI6e5COAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PMFRLpeUvlYfcHISRMkSVI8nBlYdRjCcI+xf12Af4rRUoIzooDQl0nV0SNKLYGasO
	 FHfZjeDk3q500Wf7oextbKc3Oz9b2Bya3QabBOAizyVAq0Cax7kfmkPzqJdx66pg1o
	 HwkNfDH+gNYDGYgdsQm7XijUftwy7N5lln1At3xo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbfGSEB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:01:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729596AbfGSEBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:01:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7B37218A5;
        Fri, 19 Jul 2019 04:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508899;
        bh=LuC0CZgJqwGJfnyVzc/N2ZoFrXBTl4AyfQvI6e5COAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IlttinHq8bNU6YJkFbsOMo+3W5Fan0lB+uWP3higS34unL4/jhHQke7Eg3pvSAUiD
         ScLsXqxdUPCKrRMTynlZNSV0cg6Ms/Cdcp2La2VeRaDaW+6aFw8ht6PX54uiYjfpCW
         BoMtbFRZJHfNh8u0EodTXy9G2XZ7XYZEDDSDUgY0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Windsor <dwindsor@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>, cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 5.2 147/171] dlm: check if workqueues are NULL before flushing/destroying
Date:   Thu, 18 Jul 2019 23:56:18 -0400
Message-Id: <20190719035643.14300-147-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Windsor <dwindsor@redhat.com>

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

