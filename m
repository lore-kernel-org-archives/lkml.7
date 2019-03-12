Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67E6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DAA82147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552416661;
	bh=DEqyzLHUHAyMTqMI0/4aM5ydiivX4x8vNjvsXrpZOLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NrR7OUyjGvx0Zsu62WdlRB85udos7fuqhhwoCFMxUoAWtS1vFA4NVGRu0C0oiP2Eu
	 pWimD/VgHzBUoOa3dxPSiP2lltu778K26IcAxXbCTMtXqkxgseppxev0E65IqmS+5Q
	 ii3Za1PHkuaTckkqj4EwMC5VaA2DI321kIXW6do4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfCLSvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:51:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbfCLSu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:50:59 -0400
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF376206BA;
        Tue, 12 Mar 2019 18:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552416658;
        bh=DEqyzLHUHAyMTqMI0/4aM5ydiivX4x8vNjvsXrpZOLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sfn/u6VuUrd87OGYfaR05JJtVFKZfRl+WG6yqtn+TEp2n8NA8nFWLZnxFosLv876k
         A8gDdom8awK4gN88W8UTstHzi0ReON/Ud4aEfojuts0L4P5zOKPuDsldNTi/QYpVk4
         4OJPeVMl079ML8JJeChBYy6PVPmFFzI0Idsb3W70=
Date:   Tue, 12 Mar 2019 11:50:57 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: fix to check inline_xattr_size boundary
 correctly
Message-ID: <20190312185057.GB45421@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190214160825.4973-1-chao@kernel.org>
 <82ef0ff8-452c-1894-6776-41c70ad7654b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82ef0ff8-452c-1894-6776-41c70ad7654b@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2019/2/15 0:08, Chao Yu wrote:
> > ---
> > v2:
> > - fix lower bound check, inline xattr size should be larger than
> > xattr_header's size at least.
> 
> ...
> 
> > +		if (F2FS_OPTION(sbi).inline_xattr_size <
> > +			sizeof(struct f2fs_xattr_header) / sizeof(__le32)
> 
> No sure we should set this low bound as above... now I guess original
> non-zero check is enough.
> 
> How do you think of setting inline_xattr_size range as
> (0, MAX_INLINE_XATTR_SIZE]?

How about this?

---
 fs/f2fs/super.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 42eb5c86330a..96302a428fdc 100644
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
+		if (F2FS_OPTION(sbi).inline_xattr_size < min ||
+				F2FS_OPTION(sbi).inline_xattr_size > max) {
 			f2fs_msg(sb, KERN_ERR,
-					"inline xattr size is out of range");
+				"inline xattr size is out of range: %d ~ %d",
+				min, max);
 			return -EINVAL;
 		}
 	}
-- 
2.19.0.605.g01d371f741-goog

