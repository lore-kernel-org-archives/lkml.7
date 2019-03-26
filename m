Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693BCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B60A20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553581972;
	bh=IIjmejFk7PHog+QH64EjrFFrAXw8i0Kuk7FAYEhdWrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qGIxqnUrwJqzDk4xx+inqOxNwqxbn2nj/XrrmXcxhiNX6KLEKNw+xlhqjODn4hf0r
	 DQUSmmaMKnGXMbwcGowJfrvEl0vBve17BoxJrdPpP6NWpb0tFJnDZOb9Cry4mF2kCc
	 S1nZXd3We55omcLF4jNzIxjT8YAOTTf4K0u2z0Kc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbfCZGcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:32:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731497AbfCZGct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:32:49 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7B2D20856;
        Tue, 26 Mar 2019 06:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553581968;
        bh=IIjmejFk7PHog+QH64EjrFFrAXw8i0Kuk7FAYEhdWrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AIJHCvYWavjTYp8OCh7ZC1QL1nkUa479E8NJjIMozmlWyIDmq4fw7WGoloAqO4f2p
         leAnWJigul9ALv5jJW8+LDZ3UGVF7rYl+Hc/l12MzqFehh4cTsuhqPuZUKOmbHaH9G
         VnsJm3dt0uoreWBO+v4tVHfjvIVXUA66XLN31JDI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 21/30] Hang/soft lockup in d_invalidate with simultaneous calls
Date:   Tue, 26 Mar 2019 15:30:00 +0900
Message-Id: <20190326042608.283817743@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042607.558087893@linuxfoundation.org>
References: <20190326042607.558087893@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1522,7 +1522,7 @@ static void check_and_drop(void *_data)
 {
 	struct detach_data *data = _data;
 
-	if (!data->mountpoint && !data->select.found)
+	if (!data->mountpoint && list_empty(&data->select.dispose))
 		__d_drop(data->select.start);
 }
 
@@ -1564,17 +1564,15 @@ void d_invalidate(struct dentry *dentry)
 
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


