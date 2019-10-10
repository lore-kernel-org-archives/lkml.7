Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B48C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D87208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697205;
	bh=2h/G3cPVDK6EdxonOzXEtqQZ4ws9hg2mdfT/W1q1IDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ijRz3tNFkZwkjrhgkGJLLtyQ9CTl5tHfhR2rSHSEZa81WV38pra246+qPWhbBBo/K
	 lFIew9c7VGWQtxAEr3VVIJmVPV+cwpzPbK3JbD2s2e7Qf65sBvH0jUdy5Zt0xQX9PX
	 zx4w8lykWzZ84KsIXkVLMx1i24E5BWeGWEt8zUBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388086AbfJJIqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389356AbfJJIqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:46:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CDD42064A;
        Thu, 10 Oct 2019 08:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697198;
        bh=2h/G3cPVDK6EdxonOzXEtqQZ4ws9hg2mdfT/W1q1IDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BAp7ySKadS6Kvy+vSL3sXCPg4C/s5z3kS4kMrlIke3RNDK0I5WY8X35VezTHruc4k
         KoXd9vnpbQMgjUX4S1QVmjWWeWXE31kFxZLYuVjw814BbG59FKEYhhR9IXnyMT5iLW
         l+Qa29Nn7HFjEHJ4NMCWxB9exzTmpvwRAIpr8vtE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luis Henriques <lhenriques@suse.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 055/114] ceph: fix directories inode i_blkbits initialization
Date:   Thu, 10 Oct 2019 10:36:02 +0200
Message-Id: <20191010083608.573514350@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083544.711104709@linuxfoundation.org>
References: <20191010083544.711104709@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Henriques <lhenriques@suse.com>

[ Upstream commit 750670341a24cb714e624e0fd7da30900ad93752 ]

When filling an inode with info from the MDS, i_blkbits is being
initialized using fl_stripe_unit, which contains the stripe unit in
bytes.  Unfortunately, this doesn't make sense for directories as they
have fl_stripe_unit set to '0'.  This means that i_blkbits will be set
to 0xff, causing an UBSAN undefined behaviour in i_blocksize():

  UBSAN: Undefined behaviour in ./include/linux/fs.h:731:12
  shift exponent 255 is too large for 32-bit type 'int'

Fix this by initializing i_blkbits to CEPH_BLOCK_SHIFT if fl_stripe_unit
is zero.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index c06845237cbaa..8196c21d8623c 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -807,7 +807,12 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
 
 	/* update inode */
 	inode->i_rdev = le32_to_cpu(info->rdev);
-	inode->i_blkbits = fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
+	/* directories have fl_stripe_unit set to zero */
+	if (le32_to_cpu(info->layout.fl_stripe_unit))
+		inode->i_blkbits =
+			fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
+	else
+		inode->i_blkbits = CEPH_BLOCK_SHIFT;
 
 	__ceph_update_quota(ci, iinfo->max_bytes, iinfo->max_files);
 
-- 
2.20.1



