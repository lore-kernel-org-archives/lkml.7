Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F289C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6790D216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565010600;
	bh=4Oveecdha/pb64ZWvVOdcWAJv5q/swTY08yW+2J80r8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BdKa1ahnJVzHPvs7HBQ66i/R4k4v1slBPlKqE+aSzE3Zt1J3OlYD5q64N+8H8auhX
	 IfZeVUibOMO1TwxtEeS0lHK26QQMJ3eRxU/0TVrTGryonytnRLkounCgPpYu+1CoSw
	 UPmPzmeFfvQIhPPg9pvdcvaC0L9xdSl52Py5+nq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbfHENJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729035AbfHENJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:09:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7226F2075B;
        Mon,  5 Aug 2019 13:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565010593;
        bh=4Oveecdha/pb64ZWvVOdcWAJv5q/swTY08yW+2J80r8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZYs4bL+2+rgbMn2Xh+tdSEMknodjPJCyhSqNh+q30gaAlbYCrm8q69q8Y6XEgIgSk
         OaaPwtruWQw5iPe2HERaulGmqZltBIx8D/dCNPylPbY4S4wL1lX0VTU/Z1V/h0Qe5T
         zoRCwpmHwxvjpJ5MvFoxl9dN1GIH21HOEmyIwb+U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 30/74] lib/test_string.c: avoid masking memset16/32/64 failures
Date:   Mon,  5 Aug 2019 15:02:43 +0200
Message-Id: <20190805124938.186161074@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124935.819068648@linuxfoundation.org>
References: <20190805124935.819068648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 0fcdb82dca866..98a787e7a1fd6 100644
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



