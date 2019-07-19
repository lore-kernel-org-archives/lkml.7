Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E3DC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DAA2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563509747;
	bh=wgDEFoMEZZnkTgwi15uvvbhN//07KOr36zRc+Y2UVT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rmZkesEukZBe8AvlMkdUowTsO4BLh2si5XK2eHSyQd496G4In0za15CKjPX2MxViq
	 Ei677ZbfSEA5ADvWbiW1bYsX7dtsjlVci0jYbrXAXy2i0xpTrfY/j6bv6wH4F06Vk9
	 ALCRyfED3HFYa28ZCBGEIwSUFdZC5sht8b5gGOp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390236AbfGSEPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:15:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390121AbfGSEP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:15:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D55F1218A5;
        Fri, 19 Jul 2019 04:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509728;
        bh=wgDEFoMEZZnkTgwi15uvvbhN//07KOr36zRc+Y2UVT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s1T3V+5apYBufgDSPpyGvwmr+J9VdiisL/MaN7wOz+OvU5nD2eL6gshrO/WtYNVHf
         7nvqR467FvaDqnyq2Ux4idDFkow6i/RGkVXTMc4trNmeF4kGEYROazT/y/BT5uz2Me
         hs/UP4EGByiQqr3vxORAZ8/iBxnoe1C/XTDjTPnQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        v9fs-developer@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.4 33/35] 9p: pass the correct prototype to read_cache_page
Date:   Fri, 19 Jul 2019 00:14:21 -0400
Message-Id: <20190719041423.19322-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719041423.19322-1-sashal@kernel.org>
References: <20190719041423.19322-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit f053cbd4366051d7eb6ba1b8d529d20f719c2963 ]

Fix the callback 9p passes to read_cache_page to actually have the
proper type expected.  Casting around function pointers can easily
hide typing bugs, and defeats control flow protection.

Link: http://lkml.kernel.org/r/20190520055731.24538-5-hch@lst.de
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_addr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index e9e04376c52c..e80ad0c7c2a9 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -49,8 +49,9 @@
  * @page: structure to page
  *
  */
-static int v9fs_fid_readpage(struct p9_fid *fid, struct page *page)
+static int v9fs_fid_readpage(void *data, struct page *page)
 {
+	struct p9_fid *fid = data;
 	struct inode *inode = page->mapping->host;
 	struct bio_vec bvec = {.bv_page = page, .bv_len = PAGE_SIZE};
 	struct iov_iter to;
@@ -121,7 +122,8 @@ static int v9fs_vfs_readpages(struct file *filp, struct address_space *mapping,
 	if (ret == 0)
 		return ret;
 
-	ret = read_cache_pages(mapping, pages, (void *)v9fs_vfs_readpage, filp);
+	ret = read_cache_pages(mapping, pages, v9fs_fid_readpage,
+			filp->private_data);
 	p9_debug(P9_DEBUG_VFS, "  = %d\n", ret);
 	return ret;
 }
-- 
2.20.1

