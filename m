Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B37BC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084AB22CD8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564148595;
	bh=YfDo/63lxPW0sH2O9DcR7uvSG7t0vwBN3OKd1Ls/sr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xN51K5AiyCEghrOWfE2C090keNGhFSXwbVzpF7FdbvJEwnyRsxYkaOBSbyPps5xqw
	 UzphkoZSJp8XEdPi9ORC8gMRpIsD+Cc0HsDE5FSgTOuXciKCJC5dSETk+TwZ2MljwT
	 CHZBy2jr8gEMK6/0ZCLYWsc+y0/At+h2lzLB1c9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388151AbfGZNnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:43:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388130AbfGZNnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:43:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A4A822BF5;
        Fri, 26 Jul 2019 13:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148585;
        bh=YfDo/63lxPW0sH2O9DcR7uvSG7t0vwBN3OKd1Ls/sr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kOjKPC2cNvhvr1IU9Gp8xDqln9D4XZzzRS9W61dYioa0PTpYu4zJgg04TS24pTD/p
         nvKKZ6141Yh5BG7D5wSheIKDlaujnKbmbj5FMwfdmvrmfg6e4hriU/SQ+59PxPne39
         FyB73b9zt+yLyuREzsIL+8zDa81irleL1fl76K9Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 32/47] lib/test_string.c: avoid masking memset16/32/64 failures
Date:   Fri, 26 Jul 2019 09:41:55 -0400
Message-Id: <20190726134210.12156-32-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134210.12156-1-sashal@kernel.org>
References: <20190726134210.12156-1-sashal@kernel.org>
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
index 0fcdb82dca86..98a787e7a1fd 100644
--- a/lib/test_string.c
+++ b/lib/test_string.c
@@ -35,7 +35,7 @@ static __init int memset16_selftest(void)
 fail:
 	kfree(p);
 	if (i < 256)
-		return (i << 24) | (j << 16) | k;
+		return (i << 24) | (j << 16) | k | 0x8000;
 	return 0;
 }
 
@@ -71,7 +71,7 @@ static __init int memset32_selftest(void)
 fail:
 	kfree(p);
 	if (i < 256)
-		return (i << 24) | (j << 16) | k;
+		return (i << 24) | (j << 16) | k | 0x8000;
 	return 0;
 }
 
@@ -107,7 +107,7 @@ static __init int memset64_selftest(void)
 fail:
 	kfree(p);
 	if (i < 256)
-		return (i << 24) | (j << 16) | k;
+		return (i << 24) | (j << 16) | k | 0x8000;
 	return 0;
 }
 
-- 
2.20.1

