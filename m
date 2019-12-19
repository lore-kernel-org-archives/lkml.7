Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F9CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DA4222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782765;
	bh=FqKwnTSG7AcKY1Bv6PdyhFFgeWBJYYKoNEjWXCwJtiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XuGuThsahUwsjnHqC3qB9478n4Xhl/dzzq2YTwnkRDqJZPQTesIsV823v2RfDD3lG
	 lxELNXBQPRYVH6P8Piyh7QT+MjM82Q9rqzkBjF+XyWVQPSqwE+NKeKzcBlrFk6EaZi
	 C385eeHdJYw1ny0/U1t58mzT805R2GHjV6OAJdZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfLSSgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:36:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:53294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727513AbfLSSgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:36:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2D7124672;
        Thu, 19 Dec 2019 18:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780581;
        bh=FqKwnTSG7AcKY1Bv6PdyhFFgeWBJYYKoNEjWXCwJtiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ouToXktXS+dyQii2Rk8J4ymK7214oVjgm848WCXHCQl44bFewFPJAGQYDEQ5mO1l5
         PEkJan88CMQm94Oj9skckeDhSvkSy7A4WJOZsmXiDANYH1zUTbc9nQD1PbAwFgRt7/
         Nn90zZ/muQkqOVpk5XkdI0vXZfnbTPtRtHSWeCWU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 007/162] autofs: fix a leak in autofs_expire_indirect()
Date:   Thu, 19 Dec 2019 19:31:55 +0100
Message-Id: <20191219183158.676146177@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 03ad0d703df75c43f78bd72e16124b5b94a95188 ]

if the second call of should_expire() in there ends up
grabbing and returning a new reference to dentry, we need
to drop it before continuing.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/autofs4/expire.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index 0d8b9c4f27f21..5124f06c32bcc 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -467,9 +467,10 @@ struct dentry *autofs4_expire_indirect(struct super_block *sb,
 		 */
 		flags &= ~AUTOFS_EXP_LEAVES;
 		found = should_expire(expired, mnt, timeout, how);
-		if (!found || found != expired)
-			/* Something has changed, continue */
+		if (found != expired) { // something has changed, continue
+			dput(found);
 			goto next;
+		}
 
 		if (expired != dentry)
 			dput(dentry);
-- 
2.20.1



