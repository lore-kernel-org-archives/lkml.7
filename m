Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B4BC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6532465C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077382;
	bh=S/L1hLiHFY0yuqr31DMWzA3QYET4k3af1LqJ31C86GI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VwRunW942l28ctt/oIw9FPPzfZCFdLoyjfO1ILMb2BlA+YJO3Vg7BEoEM7qaiZD/t
	 acsm9/3+iKjYZclg88DAzSnYoNp29mtpH7pREiy4Hl/8BWB3GDJ+xb3wda78rWiQtn
	 5+i0suWV+4ssE5C6OXffWuCCfr1x+q6OdivSQu70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbfLKPQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:16:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731869AbfLKPQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:16:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E54E62465B;
        Wed, 11 Dec 2019 15:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077373;
        bh=S/L1hLiHFY0yuqr31DMWzA3QYET4k3af1LqJ31C86GI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LCWO1DrYPU/VrkUV7qtHRIV0O9biuXj3c++YPQLMZrniCzm/PICu3ygv3lt8/F0NG
         5zQddOgOTVPLJ40UG/CTVNNggZlfNrifLBh9/XBvzeNeEONBaa9JUpMprJwIC51rnZ
         KU+gf9RyAKkCcLBsTA99km+9FvRG0agt/m6jFxu8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 015/243] audit_get_nd(): dont unlock parent too early
Date:   Wed, 11 Dec 2019 16:02:57 +0100
Message-Id: <20191211150340.078316785@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 69924b89687a2923e88cc42144aea27868913d0e ]

if the child has been negative and just went positive
under us, we want coherent d_is_positive() and ->d_inode.
Don't unlock the parent until we'd done that work...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/audit_watch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 787c7afdf8294..4f7262eba73d8 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -366,12 +366,12 @@ static int audit_get_nd(struct audit_watch *watch, struct path *parent)
 	struct dentry *d = kern_path_locked(watch->path, parent);
 	if (IS_ERR(d))
 		return PTR_ERR(d);
-	inode_unlock(d_backing_inode(parent->dentry));
 	if (d_is_positive(d)) {
 		/* update watch filter fields */
 		watch->dev = d->d_sb->s_dev;
 		watch->ino = d_backing_inode(d)->i_ino;
 	}
+	inode_unlock(d_backing_inode(parent->dentry));
 	dput(d);
 	return 0;
 }
-- 
2.20.1



