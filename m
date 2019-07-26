Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3173FC76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FFB22CE9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564149443;
	bh=vI5iw0MG05HU8CPbcPgbv7iD1GRe5l+5hLKrCKPuBC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HAwE1DId2dPwqTQ4vYza+uYBLb49/RY54gRVgHoZ14JPqPcqOBOq/jxYsppQ0RYEq
	 PTgTDCnvj8NupP7CiZIqHSo39mPR4qkbfQVR51P41H+T8FEaw/t+UXn+M+vwGAAk3K
	 r/p8tITY3RdadZblpG5qQpAN48WgmOXOQpQMMZCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfGZN5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727467AbfGZNlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:41:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C16B22CBE;
        Fri, 26 Jul 2019 13:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148474;
        bh=vI5iw0MG05HU8CPbcPgbv7iD1GRe5l+5hLKrCKPuBC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c15dw/Zm+2pf57JsRsYBerrUUHBiYxnZ6MRw2CKX2BcLhKGrlPGaJRnqErcbWH1F0
         zXjAZo0k1x5/O9SRv1FiZxGgyDMqqFkIeeMvhqeqkoQgy20w85f7nwVCN1CZxFiB3w
         Lnt+GfElcphZ7dqKZuA/r7K4vz1hZzck0TqmD9Us=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 58/85] lib/test_string.c: avoid masking memset16/32/64 failures
Date:   Fri, 26 Jul 2019 09:39:08 -0400
Message-Id: <20190726133936.11177-58-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726133936.11177-1-sashal@kernel.org>
References: <20190726133936.11177-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

[ Upstream commit 33d6e0ff68af74be0c846c8e042e84a9a1a0561e ]

If a memsetXX implementation is completely broken and fails in the first
iteration, when i, j, and k are all zero, the failure is masked as zero
is returned.  Failing in the first iteration is perhaps the most likely
failure, so this makes the tests pretty much useless.  Avoid the
situation by always setting a random unused bit in the result on
failure.

Link: http://lkml.kernel.org/r/20190506124634.6807-3-peda@axentia.se
Fixes: 03270c13c5ff ("lib/string.c: add testcases for memset16/32/64")
Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_string.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/test_string.c b/lib/test_string.c
index bf8def01ed20..b5117ae59693 100644
--- a/lib/test_string.c
+++ b/lib/test_string.c
@@ -36,7 +36,7 @@ static __init int memset16_selftest(void)
 fail:
 	kfree(p);
 	if (i < 256)
-		return (i << 24) | (j << 16) | k;
+		return (i << 24) | (j << 16) | k | 0x8000;
 	return 0;
 }
 
@@ -72,7 +72,7 @@ static __init int memset32_selftest(void)
 fail:
 	kfree(p);
 	if (i < 256)
-		return (i << 24) | (j << 16) | k;
+		return (i << 24) | (j << 16) | k | 0x8000;
 	return 0;
 }
 
@@ -108,7 +108,7 @@ static __init int memset64_selftest(void)
 fail:
 	kfree(p);
 	if (i < 256)
-		return (i << 24) | (j << 16) | k;
+		return (i << 24) | (j << 16) | k | 0x8000;
 	return 0;
 }
 
-- 
2.20.1

