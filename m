Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F86C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E722171F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428782;
	bh=LiGSuNB9y2psHrp6HAu8WaKeI1QQ1uvdJ9SRX8Bhp54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PdwOL7l1axLZIHVj1kS7zDZkWvsZmX+NMSfZYpju0J2HZOCcYNgkoQI13KATPjSlK
	 nBLUMFZ8d78P+U2DX7AoWAV191Q1BvODy0/OMcP+XIyOjfAjScDJSfsizKC6ruLmfI
	 u3Q5gRWEdDhy8gZ2beWYUD3KInTpVfQd1jRC5l3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfG2TdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:33:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfG2Tcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:32:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3127217D6;
        Mon, 29 Jul 2019 19:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428768;
        bh=LiGSuNB9y2psHrp6HAu8WaKeI1QQ1uvdJ9SRX8Bhp54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gCVgdSSyGSijNLKk9q1gBlIaPLHMHgbKrsDVKScpSRKsqMtWEbQZh41pWcT6S8R7f
         5nEMQICSBqLwkEXMBpHqDs1yY/fMGd30SPQKZcZe+t0S1M8lr5AYPssrdURwaOilO0
         mraMVmmTNKvezILyAxNT8JJXKjt5+69g9MX4nFqo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 179/293] compiler.h: Add read_word_at_a_time() function.
Date:   Mon, 29 Jul 2019 21:21:10 +0200
Message-Id: <20190729190838.211695661@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7f1e541fc8d57a143dd5df1d0a1276046e08c083 ]

Sometimes we know that it's safe to do potentially out-of-bounds access
because we know it won't cross a page boundary.  Still, KASAN will
report this as a bug.

Add read_word_at_a_time() function which is supposed to be used in such
cases.  In read_word_at_a_time() KASAN performs relaxed check - only the
first byte of access is validated.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/compiler.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index f490d8d93ec3..f84d332085c3 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -238,6 +238,7 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
  * required ordering.
  */
 #include <asm/barrier.h>
+#include <linux/kasan-checks.h>
 
 #define __READ_ONCE(x, check)						\
 ({									\
@@ -257,6 +258,13 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
  */
 #define READ_ONCE_NOCHECK(x) __READ_ONCE(x, 0)
 
+static __no_kasan_or_inline
+unsigned long read_word_at_a_time(const void *addr)
+{
+	kasan_check_read(addr, 1);
+	return *(unsigned long *)addr;
+}
+
 #define WRITE_ONCE(x, val) \
 ({							\
 	union { typeof(x) __val; char __c[1]; } __u =	\
-- 
2.20.1



