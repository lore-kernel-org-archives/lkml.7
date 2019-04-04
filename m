Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22F2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B78E20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369030;
	bh=iDGQD9qiaYfPJgmJlsBcjonOvoZufFMvJKajNQ+v5xE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iHUSk0zx2NwxEn4aF976bqe/y5MBYxZsd9WWXSM1iA/wGllzD9672lOjRhsOTbuP2
	 tnx/nuRWAoPk2aOSG18vtm9jBWJ7q0pAcRjpwesar/uJHBfZ2PFfZ6hsSTmZohVmUB
	 M0FmXIk0mr2oUiZDbMAOBe8MCmTrfaJSehiH6zMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733024AbfDDJK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730867AbfDDJK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:10:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E263720693;
        Thu,  4 Apr 2019 09:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369026;
        bh=iDGQD9qiaYfPJgmJlsBcjonOvoZufFMvJKajNQ+v5xE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dACTriJwNwdzXulR4FuEKgF5PwxyY1cTsdAymPPzIQ7L+GDIaV/+1Q07adsL7Zo3r
         ggpyLm0yxXXYhzRkmsdvvLRIER7MArhALvasPjL2jl/LISLHIhp6kWpW8SdRs/Mfm2
         fvHOc5DiYfXFDhqJPgbWJ/J3Q01+YeyTkef2tNko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, luojiajun <luojiajun3@huawei.com>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 053/246] jbd2: fix invalid descriptor block checksum
Date:   Thu,  4 Apr 2019 10:45:53 +0200
Message-Id: <20190404084620.874016268@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6e876c3dd205d30b0db6850e97a03d75457df007 ]

In jbd2_journal_commit_transaction(), if we are in abort mode,
we may flush the buffer without setting descriptor block checksum
by goto start_journal_io. Then fs is mounted,
jbd2_descriptor_block_csum_verify() failed.

[  271.379811] EXT4-fs (vdd): shut down requested (2)
[  271.381827] Aborting journal on device vdd-8.
[  271.597136] JBD2: Invalid checksum recovering block 22199 in log
[  271.598023] JBD2: recovery failed
[  271.598484] EXT4-fs (vdd): error loading journal

Fix this problem by keep setting descriptor block checksum if the
descriptor buffer is not NULL.

This checksum problem can be reproduced by xfstests generic/388.

Signed-off-by: luojiajun <luojiajun3@huawei.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/commit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 2eb55c3361a8..efd0ce9489ae 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -694,9 +694,11 @@ void jbd2_journal_commit_transaction(journal_t *journal)
                            the last tag we set up. */
 
 			tag->t_flags |= cpu_to_be16(JBD2_FLAG_LAST_TAG);
-
-			jbd2_descriptor_block_csum_set(journal, descriptor);
 start_journal_io:
+			if (descriptor)
+				jbd2_descriptor_block_csum_set(journal,
+							descriptor);
+
 			for (i = 0; i < bufs; i++) {
 				struct buffer_head *bh = wbuf[i];
 				/*
-- 
2.19.1



