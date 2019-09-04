Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690E2C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449A522CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620401;
	bh=VByHN+JhKK1rTl7BBvMhaT4Wo6ZFnH8N0Gy5znAXg8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TVNag3Ej1ZZYyFe1lddwggzjqCsyoHPVzr6aY35WFPaGlr1cVPNAOdCHgTAU8/p/c
	 Uw2K940e0KUGVzqWfkI9nbvGn3jWLX9yybHN686SNJ+AxCldkdTODu3GFdz7PHvi/D
	 fMb2lR/D+XskXfgJi0TsUzIYu3b7TCSssALvNEoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389479AbfIDSGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389452AbfIDSGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:06:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9606208E4;
        Wed,  4 Sep 2019 18:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620398;
        bh=VByHN+JhKK1rTl7BBvMhaT4Wo6ZFnH8N0Gy5znAXg8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjriZjMBUeGFO3fbIhfWaj/3YZl58UrBUeDqEfDLyDAcq5pD75qAzmgd2VB5DZ8vS
         Vbuflgbs8uboS256i+1r1mMcRjs7vcq+K8Awor4Tssjh2+amhqKs0SQWb/aW+txxRw
         YN/FahizGi1voO2gFjyLbR9Izt8zSnviOeeoaRbY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 05/93] fs: afs: Fix a possible null-pointer dereference in afs_put_read()
Date:   Wed,  4 Sep 2019 19:53:07 +0200
Message-Id: <20190904175303.450657522@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175302.845828956@linuxfoundation.org>
References: <20190904175302.845828956@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a6eed4ab5dd4bfb696c1a3f49742b8d1846a66a0 ]

In afs_read_dir(), there is an if statement on line 255 to check whether
req->pages is NULL:
	if (!req->pages)
		goto error;

If req->pages is NULL, afs_put_read() on line 337 is executed.
In afs_put_read(), req->pages[i] is used on line 195.
Thus, a possible null-pointer dereference may occur in this case.

To fix this possible bug, an if statement is added in afs_put_read() to
check req->pages.

This bug is found by a static analysis tool STCheck written by us.

Fixes: f3ddee8dc4e2 ("afs: Fix directory handling")
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/file.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 7d4f26198573d..843d3b970b845 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -193,11 +193,13 @@ void afs_put_read(struct afs_read *req)
 	int i;
 
 	if (refcount_dec_and_test(&req->usage)) {
-		for (i = 0; i < req->nr_pages; i++)
-			if (req->pages[i])
-				put_page(req->pages[i]);
-		if (req->pages != req->array)
-			kfree(req->pages);
+		if (req->pages) {
+			for (i = 0; i < req->nr_pages; i++)
+				if (req->pages[i])
+					put_page(req->pages[i]);
+			if (req->pages != req->array)
+				kfree(req->pages);
+		}
 		kfree(req);
 	}
 }
-- 
2.20.1



