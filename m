Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1C8C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C55214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576080310;
	bh=qzz8hoLUA2ByqBcCK1pZMfBl6ixxXnlSmDmXv8/JiI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f9xP87XsCgA+DYP76VutmI5kDxQ7G7NoD7u51LGEmVS9oPQMOYVjOwIDWtNzMe/6+
	 TKOBMmULUBAEftQEAHGnxVHActhi1iQzV6/QQ9o1KiuHPQJup4XEToyD+aIFVsKgB+
	 RH5EAMMMP22el4FW6IesBmFi+1U8/lkZzxqMlxbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388879AbfLKQFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729985AbfLKPMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:12:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1F3A24671;
        Wed, 11 Dec 2019 15:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077174;
        bh=qzz8hoLUA2ByqBcCK1pZMfBl6ixxXnlSmDmXv8/JiI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WbE8Ap8PPtHt25CEKwR/TTZ9+gjdNkCePsJjl9lTaLla55WtdhXVyClIc1MeYYMrX
         bYySOTyMFCJBPUPjFR77cATXUT3CuMkjvcHM6vBi8QHDDvi8m6UU8CaKxIMGnqR9cJ
         ugGOY3b5/I6ydbuieUB3B7v7Su5ajLVMSXpb8emE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Stancek <jstancek@redhat.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 059/134] iomap: fix return value of iomap_dio_bio_actor on 32bit systems
Date:   Wed, 11 Dec 2019 10:10:35 -0500
Message-Id: <20191211151150.19073-59-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211151150.19073-1-sashal@kernel.org>
References: <20191211151150.19073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Stancek <jstancek@redhat.com>

[ Upstream commit e9f930ac88a8936ccc2d021110c98810cf5aa810 ]

Naresh reported LTP diotest4 failing for 32bit x86 and arm -next
kernels on ext4. Same problem exists in 5.4-rc7 on xfs.

The failure comes down to:
  openat(AT_FDCWD, "testdata-4.5918", O_RDWR|O_DIRECT) = 4
  mmap2(NULL, 4096, PROT_READ, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f7b000
  read(4, 0xb7f7b000, 4096)              = 0 // expects -EFAULT

Problem is conversion at iomap_dio_bio_actor() return. Ternary
operator has a return type and an attempt is made to convert each
of operands to the type of the other. In this case "ret" (int)
is converted to type of "copied" (unsigned long). Both have size
of 4 bytes:
    size_t copied = 0;
    int ret = -14;
    long long actor_ret = copied ? copied : ret;

    On x86_64: actor_ret == -14;
    On x86   : actor_ret == 4294967282

Replace ternary operator with 2 return statements to avoid this
unwanted conversion.

Fixes: 4721a6010990 ("iomap: dio data corruption and spurious errors when pipes fill")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/direct-io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 1fc28c2da2790..7c58f51d7da74 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -318,7 +318,9 @@ zero_tail:
 		if (pad)
 			iomap_dio_zero(dio, iomap, pos, fs_block_size - pad);
 	}
-	return copied ? copied : ret;
+	if (copied)
+		return copied;
+	return ret;
 }
 
 static loff_t
-- 
2.20.1

