Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27E0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0BA2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368235;
	bh=HwT4S1LMgP7NkfXQ0N+Qjxbb0wvi7rtuDj05zYFIQ2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q+/v9u2oHaTic4/mhgY2flh7inpxh4zdX+XTropxLaUElWod4dpYJgbi5KCQRTMzx
	 AWSYZlJd9burr0zQUt6YxM+snSev8q2cVedRDLsiTa4BMqR96ZPtaucoYsyfBqMb15
	 8BY637PbQ+LCTFyJy0R6PBDKyZfuqW6SX1DYpj1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbfDDI5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730631AbfDDI5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:57:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 209532186A;
        Thu,  4 Apr 2019 08:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368230;
        bh=HwT4S1LMgP7NkfXQ0N+Qjxbb0wvi7rtuDj05zYFIQ2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FuNDAjzfoaEK8M0Ph2hfnu02/PvKO99xPbVS/yBmcFbK97GHuyOsSxj/jqQAR0AtE
         +E05j3SbXw34m7btYhImDqp9Rs4Z4R1s47xVkvyRsthcZYplAVvSc8AjtYg84c+XsG
         JcEBhVeAlt1/S3+Ein5ssN0NpfW154uHrUxk2hHs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 077/121] bcache: fix input overflow to sequential_cutoff
Date:   Thu,  4 Apr 2019 10:47:45 +0200
Message-Id: <20190404084549.443621559@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



