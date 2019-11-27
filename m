Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4462EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD1A2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889898;
	bh=EQZ7mfCriInnZRn9UMpQSDdMM3ZNFHm+aa73nZvvwtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zUseK2hs9HOW+IxCPp6X5zYQkDIUsnHLYeOIltPVkZbMSYer+BnaGbk02VrSPrsLG
	 isi6XisR9Ytk2bj+XUPz2Lquv291RMtXevZz/mFDppR2kFat7u/HIeMrrsd1CSwB8L
	 VBdOLsxNa7w7DzMW5J/98LW9RdgtP2iJQk/jWvxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732675AbfK0VY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:24:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:55272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731496AbfK0VCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:02:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD704215A5;
        Wed, 27 Nov 2019 21:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888552;
        bh=EQZ7mfCriInnZRn9UMpQSDdMM3ZNFHm+aa73nZvvwtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AgYduGC2ZdS5387eaQho2TeweJspTCEe0trdZwJhOOM6KRf6vpA1rx2Bh5ZJIlsac
         nI51fR8wXSZ/wSWSTTbgMdVajWm2+bRcAu6CFjlJLqlwXyhT8Ar2IGvZQAIGEJ9i2z
         BzUlZiF5T9Vf6ruYG9Yzjfw5tmA1qlcBFy7prV18=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "=?UTF-8?q?Ernesto=20A . =20Fern=C3=A1ndez?=" 
        <ernesto.mnd.fernandez@gmail.com>,
        Vyacheslav Dubeyko <slava@dubeyko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 177/306] hfs: update timestamp on truncate()
Date:   Wed, 27 Nov 2019 21:30:27 +0100
Message-Id: <20191127203128.278019724@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>

[ Upstream commit 8cd3cb5061730af085a3f9890a3352f162b4e20c ]

The vfs takes care of updating mtime on ftruncate(), but on truncate() it
must be done by the module.

Link: http://lkml.kernel.org/r/e1611eda2985b672ed2d8677350b4ad8c2d07e8a.1539316825.git.ernesto.mnd.fernandez@gmail.com
Signed-off-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
Reviewed-by: Vyacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index a2dfa1b2a89c7..da243c84e93b0 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -642,6 +642,8 @@ int hfs_inode_setattr(struct dentry *dentry, struct iattr * attr)
 
 		truncate_setsize(inode, attr->ia_size);
 		hfs_file_truncate(inode);
+		inode->i_atime = inode->i_mtime = inode->i_ctime =
+						  current_time(inode);
 	}
 
 	setattr_copy(inode, attr);
-- 
2.20.1



