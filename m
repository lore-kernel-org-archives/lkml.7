Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800CFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480F8206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713338;
	bh=lfiBhph8mEY6ye+tzJJ3XXwVknBO83oluTVaVYOqDFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M9OUs0S7K2krpqfPY6/1oR5WN0NF4U+v2oJ7Xx5u+/d7heZJOCUx9EgVvzLZOOdp2
	 sIUwtgeDe0q9vzY9eOJcaYkCQs1vBk2YHR0GKd8CHbAyBj/8YIbQCvM/hAu+fgxdnE
	 W8ww9B2WzhGf8I/9iYw8TWP9FRA0dZUU1b9RpEJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389516AbfC0SNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:13:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389494AbfC0SNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:13:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46B1D2186A;
        Wed, 27 Mar 2019 18:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710428;
        bh=lfiBhph8mEY6ye+tzJJ3XXwVknBO83oluTVaVYOqDFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YLMav/pYTjFLsdkI4bQ2yTpKu4keiLOQZNyHnOk+yIFZNNiqjrf4Jqwb0ODCw54hm
         Dq6Q3Qa5sqdgAFfhxRAeRlCgyc4nJ0jESENUb9BcweInKdbHy4TxrviAYbmSgjuvuG
         ELy2VHCOnuBgrt9JPiEk5wH4JJCer5Gag3eBM64k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-bcache@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 114/192] bcache: fix input overflow to sequential_cutoff
Date:   Wed, 27 Mar 2019 14:09:06 -0400
Message-Id: <20190327181025.13507-114-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Coly Li <colyli@suse.de>

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
index 59bf13faf752..01c7c4452a26 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -295,7 +295,9 @@ STORE(__cached_dev)
 		dc->io_disable = v ? 1 : 0;
 	}
 
-	d_strtoi_h(sequential_cutoff);
+	sysfs_strtoul_clamp(sequential_cutoff,
+			    dc->sequential_cutoff,
+			    0, UINT_MAX);
 	d_strtoi_h(readahead);
 
 	if (attr == &sysfs_clear_stats)
-- 
2.19.1

