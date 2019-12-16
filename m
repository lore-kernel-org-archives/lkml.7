Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7D8C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77ED020726
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518700;
	bh=rABFBufeE2chTN2Rb3oufunvCziO/+h2macQIz7EMV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tgdyx6xlIIgOnjy8V1jCLiXW0JU/BAGNk1KgUerqQptrvFhswnyJPDoM6kKcuqln5
	 Zfqw5tDHqqzPPg0zyY23mp+BbLqQ+5rAl0xjvyJjGVVMxMMJpfmQyNJebpTMOnWbFp
	 A3oO9xeOtcYDmUVx/b/C9eQGEIlHovkYwxJDD7zk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfLPRvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:51:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbfLPRvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:51:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CED2120717;
        Mon, 16 Dec 2019 17:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518695;
        bh=rABFBufeE2chTN2Rb3oufunvCziO/+h2macQIz7EMV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IqiB0uN3KeXJu8gYHftXLTSvxFrhaezjMrPSrUKZjN1oxmx1kiXlEScSicd4/3f0o
         pCAJgyQ0ll8meHeV+QQV0SKF6qwzPGJZZ8xEEmkcejYrygRjbNfMPEGztWyL/E8BPx
         WY8gff7TxZkyn68hD69cez041a8zViExZczpiZlQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Denis V. Lunev" <den@openvz.org>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 029/267] dlm: fix possible call to kfree() for non-initialized pointer
Date:   Mon, 16 Dec 2019 18:45:55 +0100
Message-Id: <20191216174852.099551871@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis V. Lunev <den@openvz.org>

[ Upstream commit 58a923adf4d9aca8bf7205985c9c8fc531c65d72 ]

Technically dlm_config_nodes() could return error and keep nodes
uninitialized. After that on the fail path of we'll call kfree()
for that uninitialized value.

The patch is simple - we should just initialize nodes with NULL.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/member.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/member.c b/fs/dlm/member.c
index cad6d85911a80..0bc43b35d2c53 100644
--- a/fs/dlm/member.c
+++ b/fs/dlm/member.c
@@ -671,7 +671,7 @@ int dlm_ls_stop(struct dlm_ls *ls)
 int dlm_ls_start(struct dlm_ls *ls)
 {
 	struct dlm_recover *rv, *rv_old;
-	struct dlm_config_node *nodes;
+	struct dlm_config_node *nodes = NULL;
 	int error, count;
 
 	rv = kzalloc(sizeof(*rv), GFP_NOFS);
-- 
2.20.1



