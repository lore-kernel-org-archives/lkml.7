Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695B1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D6020675
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126513;
	bh=sw9H24epQW9/Af7jHO2PWiJfxcptJ5gcqbX7GE0OQuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rQpPOQC1/OlMs83hmrYMQmWZoDSkf1TKvl8Hym7YNeE1DDv9oJVzl3XNhInT4YsKA
	 AD4hdm3VZ2iueOCCWxCpMjX+1E42g1X/ImgXJ8EFXCqoGIxQx7BlS7m3eqNH3lhfNI
	 TseMikhGLpx7KBUk61ys9Ix7lkDQ3QoteNqam/jM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389428AbfDXRVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389403AbfDXRVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:21:48 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C5D12190A;
        Wed, 24 Apr 2019 17:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126508;
        bh=sw9H24epQW9/Af7jHO2PWiJfxcptJ5gcqbX7GE0OQuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W22X8FjMdx69Ad1IwoJpj3HrHk0I135AARzpzyctkDE9lwuRiIo5PMK6xTEY9ggB4
         kN3Mcqly2VYKCpncj2LAB1ctcJtudJMbHdkjdksyAatR7THZm6a+kWo60DDCn7s2id
         nT85rWjrIxPBU7uI8xeE9hi8jaUkL8fmukepNr0o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanislaw Gruszka <sgruszka@redhat.com>,
        Siarhei Volkau <lis8215@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 132/168] lib/div64.c: off by one in shift
Date:   Wed, 24 Apr 2019 19:09:36 +0200
Message-Id: <20190424170931.099727440@linuxfoundation.org>
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

[ Upstream commit cdc94a37493135e355dfc0b0e086d84e3eadb50d ]

fls counts bits starting from 1 to 32 (returns 0 for zero argument).  If
we add 1 we shift right one bit more and loose precision from divisor,
what cause function incorect results with some numbers.

Corrected code was tested in user-space, see bugzilla:
   https://bugzilla.kernel.org/show_bug.cgi?id=202391

Link: http://lkml.kernel.org/r/1548686944-11891-1-git-send-email-sgruszka@redhat.com
Fixes: 658716d19f8f ("div64_u64(): improve precision on 32bit platforms")
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Reported-by: Siarhei Volkau <lis8215@gmail.com>
Tested-by: Siarhei Volkau <lis8215@gmail.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/div64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/div64.c b/lib/div64.c
index 62a698a432bc..75b8521c2146 100644
--- a/lib/div64.c
+++ b/lib/div64.c
@@ -100,7 +100,7 @@ u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder)
 		quot = div_u64_rem(dividend, divisor, &rem32);
 		*remainder = rem32;
 	} else {
-		int n = 1 + fls(high);
+		int n = fls(high);
 		quot = div_u64(dividend >> n, divisor >> n);
 
 		if (quot != 0)
@@ -138,7 +138,7 @@ u64 div64_u64(u64 dividend, u64 divisor)
 	if (high == 0) {
 		quot = div_u64(dividend, divisor);
 	} else {
-		int n = 1 + fls(high);
+		int n = fls(high);
 		quot = div_u64(dividend >> n, divisor >> n);
 
 		if (quot != 0)
-- 
2.19.1



