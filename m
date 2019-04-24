Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D7CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9121F20835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556129178;
	bh=EWe8M8hvLyUBpyhIGhjmksfqK98LSI5ywUbOVWJCwN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OOMWi9urPaESZd8x12cmf9ZR3/0gzlRgGGsTPGY12wuZQQ8OkR1k3WZlsdU45Caoe
	 S4H8aCfZ/uvLzcnQXJxIzjvQOboiGMyYAt3hcwySiMnkTzV0Xtg5vWwIxDspV+BLF5
	 XPlwDcQjTqDeUXpvnXeWuXpsg4XH9rjEpCE4fZdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388760AbfDXRSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732331AbfDXRR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:17:56 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE0BB21907;
        Wed, 24 Apr 2019 17:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126275;
        bh=EWe8M8hvLyUBpyhIGhjmksfqK98LSI5ywUbOVWJCwN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DBChF9WeAd+XDEOKoe+1YqVsXtZUzKdvwQtOtnxhY7yfAF8NcU7EbCfF6mwTM4AYM
         x4sZCHyOMzl2BJinJrBql08CokQn/G9j2lqFb1VonCeUSD/ebJluxy2QdXCkJ3PoTU
         h1geHQVbGm3cNzg/AaP1gwXkCUCmNPt19dW+J+Io=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 047/168] bcache: fix input overflow to sequential_cutoff
Date:   Wed, 24 Apr 2019 19:08:11 +0200
Message-Id: <20190424170926.582158426@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8c27a3953e92eb0b22dbb03d599f543a05f9574e ]

People may set sequential_cutoff of a cached device via sysfs file,
but current code does not check input value overflow. E.g. if value
4294967295 (UINT_MAX) is written to file sequential_cutoff, its value
is 4GB, but if 4294967296 (UINT_MAX + 1) is written into, its value
will be 0. This is an unexpected behavior.

This patch replaces d_strtoi_h() by sysfs_strtoul_clamp() to convert
input string to unsigned integer value, and limit its range in
[0, UINT_MAX]. Then the input overflow can be fixed.

Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 87daccbbc61b..463ce6757338 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -215,7 +215,9 @@ STORE(__cached_dev)
 	d_strtoul(writeback_rate_d_term);
 	d_strtoul_nonzero(writeback_rate_p_term_inverse);
 
-	d_strtoi_h(sequential_cutoff);
+	sysfs_strtoul_clamp(sequential_cutoff,
+			    dc->sequential_cutoff,
+			    0, UINT_MAX);
 	d_strtoi_h(readahead);
 
 	if (attr == &sysfs_clear_stats)
-- 
2.19.1



