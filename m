Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83430C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F97F20863
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558638807;
	bh=5RmkLvk7knbL+rmP+iB/6/q9Ll0m41LXNGKFi+pBfdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zvqCBBGOYqd7Czx3a3gxeeQi1UacoUJn4H+MG9PELVIe/7cpSfFNeNtG4Srn9YOxD
	 NfKXVFFceO5qp06oKT/nEXEkn2AsvqGoeUwKoaU4ni/RpomjjKv7oGWUepMqe81BJV
	 bki8e6Vih1SbwIcd3nUU5ip9SVZxM3Gs4ZBiTNkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388587AbfEWTN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388571AbfEWTNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:13:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0463920863;
        Thu, 23 May 2019 19:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638801;
        bh=5RmkLvk7knbL+rmP+iB/6/q9Ll0m41LXNGKFi+pBfdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uhAtpRAz9BqYd3/5LBrry1OYp/wFAUwW+ej1ElVq1NXIXDkV5vtqgq9s4z8fUMo0d
         ypxW4F2puR45FKtgVhy2l4PRCTUZyEYLgaWXMaZaViloW6bTXnPn0UY6QO6OzEA7KF
         OdofzLnpfrMf7MwIvViYRrHJ77/Rv43FCIhB3oZw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 70/77] ufs: fix braino in ufs_get_inode_gid() for solaris UFS flavour
Date:   Thu, 23 May 2019 21:06:28 +0200
Message-Id: <20190523181729.649101311@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181719.982121681@linuxfoundation.org>
References: <20190523181719.982121681@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 4e9036042fedaffcd868d7f7aa948756c48c637d ]

To choose whether to pick the GID from the old (16bit) or new (32bit)
field, we should check if the old gid field is set to 0xffff.  Mainline
checks the old *UID* field instead - cut'n'paste from the corresponding
code in ufs_get_inode_uid().

Fixes: 252e211e90ce
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ufs/util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 1907be6d58085..f3092d513551a 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -229,7 +229,7 @@ ufs_get_inode_gid(struct super_block *sb, struct ufs_inode *inode)
 	case UFS_UID_44BSD:
 		return fs32_to_cpu(sb, inode->ui_u3.ui_44.ui_gid);
 	case UFS_UID_EFT:
-		if (inode->ui_u1.oldids.ui_suid == 0xFFFF)
+		if (inode->ui_u1.oldids.ui_sgid == 0xFFFF)
 			return fs32_to_cpu(sb, inode->ui_u3.ui_sun.ui_gid);
 		/* Fall through */
 	default:
-- 
2.20.1



