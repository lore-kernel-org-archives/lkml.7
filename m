Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42BCC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CA022DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566308892;
	bh=gfBDCQS/KWN8G6USDgzQ09X68Q9ihpxrUIdhLIr5jV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nmcUgapCLW2p1vbJ6yTiTH/uZdVF6RIJMKbp0LSFocMb5NzVntAP+uMMe6tM99R2W
	 k8ke201ECVLo4I5h/kibBQhEIqgzPrOeVR6TKS+gnzrAu48trzlfs+99MGlDBH0OIO
	 EaTC6K37xgTngo0nGOxB8o5+pDwWQbHWN7jzFBOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfHTNkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730105AbfHTNke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:40:34 -0400
Received: from sasha-vm.mshome.net (unknown [12.236.144.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E227233FD;
        Tue, 20 Aug 2019 13:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566308433;
        bh=gfBDCQS/KWN8G6USDgzQ09X68Q9ihpxrUIdhLIr5jV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H7TvKSUI3id1Xib83d+qGXmdnf4PC+nOEvjzojNeYKiBNRZ0XWaseNNFTN4tgLquu
         DzyCRpBKoSZWgxX4oDLdmCnqxSgInXEKK/jO3jGJPcCIDfqUYvTHR2gHGHCqO7lHFL
         W0/30P1VjQhhkpLt1H/Szwmvm4N1b0Ai3VZIGCAM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org
Subject: [PATCH AUTOSEL 5.2 05/44] fs: afs: Fix a possible null-pointer dereference in afs_put_read()
Date:   Tue, 20 Aug 2019 09:39:49 -0400
Message-Id: <20190820134028.10829-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190820134028.10829-1-sashal@kernel.org>
References: <20190820134028.10829-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

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
index 8fd7d3b9a1b1f..87beabc7114ee 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -191,11 +191,13 @@ void afs_put_read(struct afs_read *req)
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

