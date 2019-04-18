Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED59C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3373720643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611680;
	bh=sr2/c6ZFz6S1DDcVXG5GRSj4R2z+zr6gULZPI7eLkxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H3OdpQlybQh9t6/7NrdBWokwZMR901GxUq+UFD1rFXynIBiDqL6M7AgYvzt4e2L1e
	 ZokXRyWTyqfTeyU2HmOjI3wGUT8MAkxTdtglMYxkEoQIqagx1PdEb+6h+BETHM2BVD
	 IB+Vx+TWzUaDTDk6qohs8ta3BybegJvuwvLuombU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403989AbfDRSVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:21:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391661AbfDRSHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:07:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17C4A218AF;
        Thu, 18 Apr 2019 18:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610873;
        bh=sr2/c6ZFz6S1DDcVXG5GRSj4R2z+zr6gULZPI7eLkxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oHqzUa45btc/WtX85cmOwteRIQV7odrH0yHODumAdHxUdJZWFR1RBcXoQu3ByeOMN
         FGADqT97+rY3Tksh/UIDsMna3/s6dbbR56iQqr/89ml07RXcAp6T5WMhLHP6kAe+QD
         L2mNzbarMEaMe82Id3nJtk6BE3gVThh8FChsbll4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 04/50] ext4: report real fs size after failed resize
Date:   Thu, 18 Apr 2019 19:57:15 +0200
Message-Id: <20190418160423.405452539@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
References: <20190418160422.455656724@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 6c7328400e0488f7d49e19e02290ba343b6811b2 ]

Currently when the file system resize using ext4_resize_fs() fails it
will report into log that "resized filesystem to <requested block
count>".  However this may not be true in the case of failure.  Use the
current block count as returned by ext4_blocks_count() to report the
block count.

Additionally, report a warning that "error occurred during file system
resize"

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/resize.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index e16fb545d441..aef2a24dc9f9 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -2047,6 +2047,10 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 		free_flex_gd(flex_gd);
 	if (resize_inode != NULL)
 		iput(resize_inode);
-	ext4_msg(sb, KERN_INFO, "resized filesystem to %llu", n_blocks_count);
+	if (err)
+		ext4_warning(sb, "error (%d) occurred during "
+			     "file system resize", err);
+	ext4_msg(sb, KERN_INFO, "resized filesystem to %llu",
+		 ext4_blocks_count(es));
 	return err;
 }
-- 
2.19.1



