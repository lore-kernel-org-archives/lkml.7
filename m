Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ACBCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CAB214B2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="UVWgsN7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbfJ1TtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 15:49:09 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40116 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbfJ1TtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 15:49:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id o49so16404106qta.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 12:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dLsRzU9RkO90ampJ/ozomhEJBGNXuMvmD2GIBvPi1PE=;
        b=UVWgsN7MDJBDqZEC/aH7j8f4kdFYvqLrpU5YPyhYkH65DL0OwJpjqIgM0CqEPEliug
         qf+qD7H2gUe2WTYiJyhqmoGkTHLgO868gW4I2UuZBv9HtpROn0wr6tjYFO9yDmDRT56L
         eysXr6MnwGteSIKg9RMiOPw1T1/6FAA+1m9lbot8CZETjyNNZz5bRKddYL9h+3QDAyWu
         dWtqcTGfel6j6VgVjeJRr9FJ3rpd+cvf4foy8Kb0ViGgbO4a9v/H1tDemW0z5c3Ktv9X
         gYQBkCcPJwa5ip9mUlZOf9ZYP9f0xiIVoS2pZvNymR1Pdsz2h0jl2atZejkvUw+evSuM
         9kUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dLsRzU9RkO90ampJ/ozomhEJBGNXuMvmD2GIBvPi1PE=;
        b=nEIOnznJa85zfcpWYOCUaBfFd4KBjsfwsIV/K2KHbtgrq74Uy45yJNsJZaC22a9HoW
         O6gWN4tE8aZkxBjWW/Ls0YMCywe6G1H7Mp/ShwoBrYFkfiCWEWqw6HBXdQAdng/ZJRzv
         qMM/ycp/Ob1gbLKQYqlEH6SJ3/xn+rEag/8l6bgD+iZP+LOSQAdwCN3ibNnOUnJnvChc
         NQyLFROo0lCa06Jpbor+Y95vTbNUhiJaIBcNTlUtJI6hfXXxWI4YkjSbBRvTfYWNQUZk
         h0GHYfhwfC5oppXNtdI6SFCb3ci4XBxQadNMVfk2Un2uDJXDwdT58fKEkfhVuPbRRUTq
         gPcg==
X-Gm-Message-State: APjAAAWJHjJczIsTqIi7XATK8L5gXpmcEARMlFbDL2GuiwhURaMnWdhD
        bn8kha33Y0w2hnXm8WZrYjilgw==
X-Google-Smtp-Source: APXvYqxW0JuhBdSHqh1EzJLwHZde1whPR3+3jW8HLxrMtoXyA45o/FcdwwOyaVNavQityBmUQSA4Ug==
X-Received: by 2002:ac8:75c2:: with SMTP id z2mr201363qtq.216.1572292148163;
        Mon, 28 Oct 2019 12:49:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:831b])
        by smtp.gmail.com with ESMTPSA id q34sm8099967qte.50.2019.10.28.12.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 12:49:07 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] mm: rate-limit allocation failure warnings more aggressively
Date:   Mon, 28 Oct 2019 15:49:06 -0400
Message-Id: <20191028194906.26899-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While investigating a bug related to higher atomic allocation
failures, we noticed the failure warnings positively drowning the
console, and in our case trigger lockup warnings because of a serial
console too slow to handle all that output.

But even if we had a faster console, it's unclear what additional
information the current level of repetition provides.

Allocation failures happen for three reasons: The machine is OOM, the
VM is failing to handle reasonable requests, or somebody is making
unreasonable requests (and didn't acknowledge their opportunism with
__GFP_NOWARN). Having the memory dump, a callstack, and the ratelimit
stats on skipped failure warnings should provide enough information to
let users/admins/developers know whether something is wrong and point
them in the right direction for debugging, bpftracing etc.

Limit allocation failure warnings to 1 spew every ten seconds.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 791c018314b3..f412b17b5d59 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3720,10 +3720,6 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 static void warn_alloc_show_mem(gfp_t gfp_mask, nodemask_t *nodemask)
 {
 	unsigned int filter = SHOW_MEM_FILTER_NODES;
-	static DEFINE_RATELIMIT_STATE(show_mem_rs, HZ, 1);
-
-	if (!__ratelimit(&show_mem_rs))
-		return;
 
 	/*
 	 * This documents exceptions given to allocations in certain
@@ -3744,8 +3740,7 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
-	static DEFINE_RATELIMIT_STATE(nopage_rs, DEFAULT_RATELIMIT_INTERVAL,
-				      DEFAULT_RATELIMIT_BURST);
+	static DEFINE_RATELIMIT_STATE(nopage_rs, 10*HZ, 1);
 
 	if ((gfp_mask & __GFP_NOWARN) || !__ratelimit(&nopage_rs))
 		return;
-- 
2.23.0

