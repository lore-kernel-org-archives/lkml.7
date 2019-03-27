Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FA2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0256217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710734;
	bh=zZO7vlX8m3+R9UiagOiMG4/45GqUcvXK6M/T3BcGHwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BhlDkIwa9BMyV2kwurGOZMjiDOgKdrcbg70wio5LJGgdwS8dtyHPPPXGNf4TpvYId
	 CRm49AKAYx6oavTvFBwAX2Ge0yfsahrpSAfC/HY9gBAnfhNb2pwOhR+6pgo4VQXK3T
	 jNUmTIk654gRb+YnzPQDJvKUvMyK9L2Uym4h8TUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390611AbfC0SSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:18:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390585AbfC0SSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:18:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EB34217D9;
        Wed, 27 Mar 2019 18:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710729;
        bh=zZO7vlX8m3+R9UiagOiMG4/45GqUcvXK6M/T3BcGHwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T03k+QrS19vT3OWvH292pa5uTwTfAFmIPBqUHQh/3XIQVaWTvMEXE+GltLyRUw7p1
         7BuoY2HyUdksd8pOC0VsrzLoH0zHlsUGwXpjdLqjS7Gi/cdCCw4Ud9cOlTqNUtWR2j
         WPaxOi5QGtMGzLZlHuauCvnANygpbbJpR3SgXa+A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-bcache@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 076/123] bcache: fix input overflow to sequential_cutoff
Date:   Wed, 27 Mar 2019 14:15:40 -0400
Message-Id: <20190327181628.15899-76-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
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
index 43ff7fbcbc7c..def9c3478b89 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -217,7 +217,9 @@ STORE(__cached_dev)
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

