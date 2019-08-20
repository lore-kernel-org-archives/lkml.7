Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5052FC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC3222DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566308778;
	bh=U1wmmqt8IFCCBee96fUQLklIQ9/Yo6GEXftgBp6Hmrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ppg29EELSo9Wz288wBS2gjAu3sFjEjnhc1pGnJOMrFNlUgVTVmn11TFd5kE2gx26q
	 RZpVzcNKAFHWvXnmBwJ4OkyoGT6Men/Ha6ot8dA4OoqBFz7koeSXERijWe7H5erah8
	 s4Z7hywhGlIz6+S6dI4IM+xcZyen6dGdOYepyN/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbfHTNqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:46:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730576AbfHTNmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:42:20 -0400
Received: from sasha-vm.mshome.net (unknown [12.236.144.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA1F82332B;
        Tue, 20 Aug 2019 13:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566308539;
        bh=U1wmmqt8IFCCBee96fUQLklIQ9/Yo6GEXftgBp6Hmrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDbCA0OHHzSjVMSCVxjueD0FjeJ1oRRwRhEl6v6DUOQg+ZJVBajG06xh3H3vZJ1+7
         Io0UCQmJHm4Hu97vduBJxQng1RaWjKy0RguzfPPeQuYcg6xyHRZroX41vX1lj4uagh
         ekKaLy0acvmwaWcLl9OM+vXmgff7GYBNzhBK/MGo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 06/27] afs: Only update d_fsdata if different in afs_d_revalidate()
Date:   Tue, 20 Aug 2019 09:41:52 -0400
Message-Id: <20190820134213.11279-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190820134213.11279-1-sashal@kernel.org>
References: <20190820134213.11279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit 5dc84855b0fc7e1db182b55c5564fd539d6eff92 ]

In the in-kernel afs filesystem, d_fsdata is set with the data version of
the parent directory.  afs_d_revalidate() will update this to the current
directory version, but it shouldn't do this if it the value it read from
d_fsdata is the same as no lock is held and cmpxchg() is not used.

Fix the code to only change the value if it is different from the current
directory version.

Fixes: 260a980317da ("[AFS]: Add "directory write" support.")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 855bf2b79fed4..54e7f6f1405e2 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -937,7 +937,7 @@ static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 	dir_version = (long)dir->status.data_version;
 	de_version = (long)dentry->d_fsdata;
 	if (de_version == dir_version)
-		goto out_valid;
+		goto out_valid_noupdate;
 
 	dir_version = (long)dir->invalid_before;
 	if (de_version - dir_version >= 0)
@@ -1001,6 +1001,7 @@ static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 
 out_valid:
 	dentry->d_fsdata = (void *)dir_version;
+out_valid_noupdate:
 	dput(parent);
 	key_put(key);
 	_leave(" = 1 [valid]");
-- 
2.20.1

