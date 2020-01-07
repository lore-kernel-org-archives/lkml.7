Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AFCC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BE12077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431956;
	bh=yvSUdJhR7bHfZSJeyF6n2xh+oZ3xjRsEN5JHfOLFMfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tmexfr5aPNY0Do7WJ8dKdGCBsZzT2VKfWJAebzj/46jCI0RP41PB4XwWqTuDiBv9Q
	 Bwna8TDUqT+3mx4b7sgs3QHJxmiKXANkreg+pocL2H+dBaa/itI/2/unxv7oR+rZSp
	 tKIfZNZANo0DP0+iew0ciWd+p/u3g083N341+3cQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgAGVEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:04:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:49554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729079AbgAGVEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:04:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 687CF20678;
        Tue,  7 Jan 2020 21:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431082;
        bh=yvSUdJhR7bHfZSJeyF6n2xh+oZ3xjRsEN5JHfOLFMfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QgsJ1A/f/ZY9gdICzS8cx3OdJER0eUM9GmyxrbKJPmszBqMh2rZCPfGv1/QmhYujx
         GCq/QgnKgYx+o0i5XErXdf5GK8M3X7akPhDuEJc7eqmZA6AtVnXEHr1Cmes68reifr
         gNKWHLuhiZqfHijsbQAYBISIcXkR4g89Jg4S/o6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jonathan Billings <jsbillings@jsbillings.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 026/115] afs: Fix creation calls in the dynamic root to fail with EOPNOTSUPP
Date:   Tue,  7 Jan 2020 21:53:56 +0100
Message-Id: <20200107205259.109355598@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit 1da4bd9f9d187f53618890d7b66b9628bbec3c70 ]

Fix the lookup method on the dynamic root directory such that creation
calls, such as mkdir, open(O_CREAT), symlink, etc. fail with EOPNOTSUPP
rather than failing with some odd error (such as EEXIST).

lookup() itself tries to create automount directories when it is invoked.
These are cached locally in RAM and not committed to storage.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
Tested-by: Jonathan Billings <jsbillings@jsbillings.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/dynroot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index f29c6dade7f6..069273a2483f 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -145,6 +145,9 @@ static struct dentry *afs_dynroot_lookup(struct inode *dir, struct dentry *dentr
 
 	ASSERTCMP(d_inode(dentry), ==, NULL);
 
+	if (flags & LOOKUP_CREATE)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (dentry->d_name.len >= AFSNAMEMAX) {
 		_leave(" = -ENAMETOOLONG");
 		return ERR_PTR(-ENAMETOOLONG);
-- 
2.20.1



