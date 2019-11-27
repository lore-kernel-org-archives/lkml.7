Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66105C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3001F2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890850;
	bh=8Kv7niCE8O2wh2JRY/jGBmWd1SUqQ/uG75wLCFEuY+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JyzhhqcKL97JGjDGOnreMWRW/3UQ47NdubyR2s5zdjJTdfGHj23toQB9ola2x6iuB
	 Wk7Ii22vdJgZpQnM7bfiGOqkk5ZdSf4nkiDOMMD76Wss1WjwnIFlQ/Fgodca5dAFK0
	 vPG/ausoWwnOzXCqiyVWyIrdjjCcm55qq+AxYv3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfK0Vkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:40:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:48930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728800AbfK0Umb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:42:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2F7C21787;
        Wed, 27 Nov 2019 20:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887351;
        bh=8Kv7niCE8O2wh2JRY/jGBmWd1SUqQ/uG75wLCFEuY+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iaBhIPW6ryjmqkWRw+1/OG1rmmWlgROGuj6nNJBFqNZ1/Ce3xV5R281EtnVK6g/dx
         0dFHbvTcQ7Bq8wAP9kKwEsDn1SMqoA/mgrywybqg4iXv/wtiqw05Zpfts8Teng9wKb
         D4MLJdqR2M1JKbXECeIm1hejCBksvmcBhWEtS/+4=
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
Subject: [PATCH 4.9 078/151] hfs: update timestamp on truncate()
Date:   Wed, 27 Nov 2019 21:31:01 +0100
Message-Id: <20191127203035.544961197@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
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
index f776acf2378a1..de0d6d4c46b68 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -641,6 +641,8 @@ int hfs_inode_setattr(struct dentry *dentry, struct iattr * attr)
 
 		truncate_setsize(inode, attr->ia_size);
 		hfs_file_truncate(inode);
+		inode->i_atime = inode->i_mtime = inode->i_ctime =
+						  current_time(inode);
 	}
 
 	setattr_copy(inode, attr);
-- 
2.20.1



