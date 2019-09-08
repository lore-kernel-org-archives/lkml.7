Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178BEC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96DC20693
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947174;
	bh=iWdWvQj/QygSKnUvQWENMH98qfzOfZ2rLxO+WiunLmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aJkt9FiqNvTFIXSCCJNhXTa7FG5sb107QKxBLa+02Y/7BQPRIW/bL1A4itNjQPHAg
	 hPW5Ge7LczVakEUqVef3qTGVOmP1bINpJQ4lSRd87/dDMGwcCYCw9ko/tpONfS9Qx2
	 TMf63Qw+J6vnBiVKLyDm/+AqsndwiXywgANYlfEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733242AbfIHMww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733204AbfIHMws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:52:48 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 362A820693;
        Sun,  8 Sep 2019 12:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567947167;
        bh=iWdWvQj/QygSKnUvQWENMH98qfzOfZ2rLxO+WiunLmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ndRi8wD2Clzos6Me8Qn3LH4TfkDYP8DNNzn7Hjp296PC+B66K+ATD4YksZHb1gkS9
         bEKr/YfcbFyPoWehOhH318mZygTl27/w2zC4YOlLavwSnbyZvShIYQnsaymf/iIgmL
         FEEU6zJGc5hTTgPJV7nT3PQleCjEmts4aNbtcF5c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 86/94] afs: use correct afs_call_type in yfs_fs_store_opaque_acl2
Date:   Sun,  8 Sep 2019 13:42:22 +0100
Message-Id: <20190908121152.893198930@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121150.420989666@linuxfoundation.org>
References: <20190908121150.420989666@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7533be858f5b9a036b9f91556a3ed70786abca8e ]

It seems that 'yfs_RXYFSStoreOpaqueACL2' should be use in
yfs_fs_store_opaque_acl2().

Fixes: f5e4546347bc ("afs: Implement YFS ACL setting")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/yfsclient.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 18722aaeda33a..a1baf3f1f14d1 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -2155,7 +2155,7 @@ int yfs_fs_store_opaque_acl2(struct afs_fs_cursor *fc, const struct afs_acl *acl
 	       key_serial(fc->key), vnode->fid.vid, vnode->fid.vnode);
 
 	size = round_up(acl->size, 4);
-	call = afs_alloc_flat_call(net, &yfs_RXYFSStoreStatus,
+	call = afs_alloc_flat_call(net, &yfs_RXYFSStoreOpaqueACL2,
 				   sizeof(__be32) * 2 +
 				   sizeof(struct yfs_xdr_YFSFid) +
 				   sizeof(__be32) + size,
-- 
2.20.1



