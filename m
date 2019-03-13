Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA21C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 02:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5455F217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 02:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552442607;
	bh=+1L31Od5RO4Orjjui2/XbSNLOubFzauT/OrDHbHZLNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U5O6KbxOgvTyo/fOTNiCwrx4hqkZj6lpMVxeiM1im9wJU+t/a4lMBFzki47WCWuF3
	 w5O9HItWNEEzuTq6XEBQL9oFyxNXoe8QDIBu7rHf63zmNQk/uVgDABGc15xiE1aLYa
	 1pfH5jFzINPOCUWdAbiCVSrmmKs1zprB6SUfqUGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfCMCDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 22:03:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbfCMCDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 22:03:24 -0400
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A3652171F;
        Wed, 13 Mar 2019 02:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552442603;
        bh=+1L31Od5RO4Orjjui2/XbSNLOubFzauT/OrDHbHZLNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bt3nuuhHs9Gl2wkHXGlpV1PT6+rxc5gw4aYJvV4vmEpPd9+2QTdFPDSZKmPRx/HlV
         MmZYm35ejTbyEHmlaaXIkeEcwgGOeLIwfFzvYYPyRUwAmHQyeBPrXbQVcuZ20kcZtz
         pSWFlBMaXBv3qyY3CsaIErsq28rv7jXLHxXzkejg=
Date:   Tue, 12 Mar 2019 19:03:22 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: fix to check inline_xattr_size boundary
 correctly
Message-ID: <20190313020322.GA83715@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190214160825.4973-1-chao@kernel.org>
 <82ef0ff8-452c-1894-6776-41c70ad7654b@huawei.com>
 <20190312185057.GB45421@jaegeuk-macbookpro.roam.corp.google.com>
 <7b028daf-538e-a10e-6b79-f686021ee899@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b028daf-538e-a10e-6b79-f686021ee899@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13, Chao Yu wrote:
> On 2019/3/13 2:50, Jaegeuk Kim wrote:
> > On 03/04, Chao Yu wrote:
> >> Hi Jaegeuk,
> >>
> >> On 2019/2/15 0:08, Chao Yu wrote:
> >>> ---
> >>> v2:
> >>> - fix lower bound check, inline xattr size should be larger than
> >>> xattr_header's size at least.
> >>
> >> ...
> >>
> >>> +		if (F2FS_OPTION(sbi).inline_xattr_size <
> >>> +			sizeof(struct f2fs_xattr_header) / sizeof(__le32)
> >>
> >> No sure we should set this low bound as above... now I guess original
> >> non-zero check is enough.
> >>
> >> How do you think of setting inline_xattr_size range as
> >> (0, MAX_INLINE_XATTR_SIZE]?
> > 
> > How about this?
> 
> If you think it's necessary to check low bound with size of xattr header,
> I'm also okay with that.
> 
> And below diff looks good to me, could you please merge this into original one?
> 
> Thanks,

I had to add this on top of branch.

From 70db5b04cbe19e5ae7e85ada2d3e82bcfdf90352 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 12 Mar 2019 11:49:53 -0700
Subject: [PATCH] f2fs: give some messages for inline_xattr_size

This patch adds some kernel messages when user sets wrong inline_xattr_size.

Fixes: 500e0b28ecd3 ("f2fs: fix to check inline_xattr_size boundary correctly")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 42eb5c86330a..324938ec95f3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -821,6 +821,8 @@ static int parse_options(struct super_block *sb, char *options)
 	}
 
 	if (test_opt(sbi, INLINE_XATTR_SIZE)) {
+		int min_size, max_size;
+
 		if (!f2fs_sb_has_extra_attr(sbi) ||
 			!f2fs_sb_has_flexible_inline_xattr(sbi)) {
 			f2fs_msg(sb, KERN_ERR,
@@ -834,15 +836,18 @@ static int parse_options(struct super_block *sb, char *options)
 					"set with inline_xattr option");
 			return -EINVAL;
 		}
-		if (F2FS_OPTION(sbi).inline_xattr_size <
-			sizeof(struct f2fs_xattr_header) / sizeof(__le32) ||
-			F2FS_OPTION(sbi).inline_xattr_size >
-			DEF_ADDRS_PER_INODE -
+
+		min_size = sizeof(struct f2fs_xattr_header) / sizeof(__le32);
+		max_size = DEF_ADDRS_PER_INODE -
 			F2FS_TOTAL_EXTRA_ATTR_SIZE / sizeof(__le32) -
 			DEF_INLINE_RESERVED_SIZE -
-			MIN_INLINE_DENTRY_SIZE / sizeof(__le32)) {
+			MIN_INLINE_DENTRY_SIZE / sizeof(__le32);
+
+		if (F2FS_OPTION(sbi).inline_xattr_size < min_size ||
+				F2FS_OPTION(sbi).inline_xattr_size > max_size) {
 			f2fs_msg(sb, KERN_ERR,
-					"inline xattr size is out of range");
+				"inline xattr size is out of range: %d ~ %d",
+				min_size, max_size);
 			return -EINVAL;
 		}
 	}
-- 
2.19.0.605.g01d371f741-goog

