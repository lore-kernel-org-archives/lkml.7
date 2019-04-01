Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BF8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED72320856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139851;
	bh=sj56pi+oNBZ8sAnlCZtiXvd7qWVHcqU3jYhcOtSdcDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c10LXBak2TqG39fB6aiZ3nH72MyqFsFuKKQRiftUvQlxw1NHFDXwZNJPi7EVo4CnV
	 3Oaw9rXzFlE+XOwXQsdKoO2zDg72OZC+THOS0iz5OYvRduKiHFBt9oSKQPzf6F9Uc6
	 G/3tJEKYKPL2gFMzngUtldYVGTvNH1BRN8akGoQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732599AbfDARat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732925AbfDARao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:30:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 983042070B;
        Mon,  1 Apr 2019 17:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139843;
        bh=sj56pi+oNBZ8sAnlCZtiXvd7qWVHcqU3jYhcOtSdcDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bXu0/cqqExDG8yETtiHVAuGc1mAu4NFUJ8aS+XscPr1BZBTkSELeiAf3E2leK6qjh
         GdL2mdBQp2UTJWhhEbUK3al2r48Un4pgsUGrDOGklRdtP4L0eRVtASGpqWyxjBtzNk
         3pojt6vtmt6VCsrMgVxAcP02D37WVYSPvQi4saYw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 030/131] Hang/soft lockup in d_invalidate with simultaneous calls
Date:   Mon,  1 Apr 2019 19:01:40 +0200
Message-Id: <20190401170054.608426428@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@ZenIV.linux.org.uk>

commit 81be24d263dbeddaba35827036d6f6787a59c2c3 upstream.

It's not hard to trigger a bunch of d_invalidate() on the same
dentry in parallel.  They end up fighting each other - any
dentry picked for removal by one will be skipped by the rest
and we'll go for the next iteration through the entire
subtree, even if everything is being skipped.  Morevoer, we
immediately go back to scanning the subtree.  The only thing
we really need is to dissolve all mounts in the subtree and
as soon as we've nothing left to do, we can just unhash the
dentry and bugger off.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/dcache.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1510,7 +1510,7 @@ static void check_and_drop(void *_data)
 {
 	struct detach_data *data = _data;
 
-	if (!data->mountpoint && !data->select.found)
+	if (!data->mountpoint && list_empty(&data->select.dispose))
 		__d_drop(data->select.start);
 }
 
@@ -1552,17 +1552,15 @@ void d_invalidate(struct dentry *dentry)
 
 		d_walk(dentry, &data, detach_and_collect, check_and_drop);
 
-		if (data.select.found)
+		if (!list_empty(&data.select.dispose))
 			shrink_dentry_list(&data.select.dispose);
+		else if (!data.mountpoint)
+			return;
 
 		if (data.mountpoint) {
 			detach_mounts(data.mountpoint);
 			dput(data.mountpoint);
 		}
-
-		if (!data.mountpoint && !data.select.found)
-			break;
-
 		cond_resched();
 	}
 }


