Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA51C10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3862120857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="oOQpDEP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfCHWrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:47:05 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39085 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfCHWrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 17:47:05 -0500
Received: by mail-qt1-f196.google.com with SMTP id i14so994798qtp.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 14:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SLDY+eriUJJSKq4W6Dwhx/si0YT+O7+wGloz1ULmQTU=;
        b=oOQpDEP9evP6fSuVmOI0LzQexDVdxNzccGiHwo5R+FegnFSCVdAbeWGK2AOfbA3K//
         3aR6qgBlzozzeOWgaZCmI55wtaCoQF1Ql6z//pVfi9ub5N4RISvwd7EkRMXbEvNvwB7D
         45YercVK3kb7X5QEjl62rOAAeI3AbzhZOwhyEXGYzibyCvQoRcQt8oXpfI3baAIdS2n6
         XYpZ+xeAhC6Q55eyOlV79WYktAn/TdvmENl2sW07UzZqsphqmqMZ+Gm0CQ6TGJipCV0P
         0mX6zfbjLwzGIzBL+gT+y0yYRil9wlU3LjyZM+hwlY4sIV64K+Jl+RrqkQezUSt92mJc
         DsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SLDY+eriUJJSKq4W6Dwhx/si0YT+O7+wGloz1ULmQTU=;
        b=s+DMQqIz0Ch3YJ1JshH+zuyvTk4aB00H0GR+tG4P8ED9hL7XWa+Y9KPp0S+7mcKKnP
         ardOkyYftqUwsPY8M3Pgg3jvDQ/1AUxXJToN4kOHswWFKBQOVa/QHEjhVoqf17+wMIoi
         85b42eIQ77aK7HJNZqO2XL289UPCD/P11xRfKTnRpCvNz6nxPaPckVgJv9DUPZFHoLE0
         21O+5hj0iOVB1GJxRSHiO/B8LlIh7Q8dz6/i81fArOKAGsJ1prMGJwOIda3kMO6rHKls
         cX3LL3VBqCakC8hvsY3bTll6qTt3kLJN1ifjbR3ToKzh/T2pfjKqzm8F2mHNplv2o1aS
         iAiA==
X-Gm-Message-State: APjAAAUbZJYJv+amAi81GgpaXPrrUV7/J/EDExjtV0cyoa+r6NY5bjc7
        BgnZosc8zbUhs9I4sIOupCz1LCLEiVg=
X-Google-Smtp-Source: APXvYqzCPtblkSBKWUEyR9rRRlxzrEv6PwwKFyPnyYkxKn57Os1ZcK9NiV4YklZkkhAOwJVb3Kmykw==
X-Received: by 2002:ac8:2fda:: with SMTP id m26mr16733925qta.312.1552085224207;
        Fri, 08 Mar 2019 14:47:04 -0800 (PST)
Received: from ovpn-121-103.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s49sm5429876qtk.7.2019.03.08.14.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 14:47:03 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/compaction: fix an undefined behaviour
Date:   Fri,  8 Mar 2019 17:46:50 -0500
Message-Id: <20190308224650.68955-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a low-memory situation, cc->fast_search_fail can keep increasing as
it is unable to find an available page to isolate in
fast_isolate_freepages(). As the result, it could trigger an error
below, so just compare with the maximum bits can be shifted first.

UBSAN: Undefined behaviour in mm/compaction.c:1160:30
shift exponent 64 is too large for 64-bit type 'unsigned long'
CPU: 131 PID: 1308 Comm: kcompactd1 Kdump: loaded Tainted: G
W    L    5.0.0+ #17
Call trace:
 dump_backtrace+0x0/0x450
 show_stack+0x20/0x2c
 dump_stack+0xc8/0x14c
 __ubsan_handle_shift_out_of_bounds+0x7e8/0x8c4
 compaction_alloc+0x2344/0x2484
 unmap_and_move+0xdc/0x1dbc
 migrate_pages+0x274/0x1310
 compact_zone+0x26ec/0x43bc
 kcompactd+0x15b8/0x1a24
 kthread+0x374/0x390
 ret_from_fork+0x10/0x18

Fixes: 70b44595eafe ("mm, compaction: use free lists to quickly locate a migration source")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/compaction.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index f171a83707ce..6aebf1eb8d98 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1157,7 +1157,9 @@ static bool suitable_migration_target(struct compact_control *cc,
 static inline unsigned int
 freelist_scan_limit(struct compact_control *cc)
 {
-	return (COMPACT_CLUSTER_MAX >> cc->fast_search_fail) + 1;
+	return (COMPACT_CLUSTER_MAX >>
+		min((unsigned short)(BITS_PER_LONG - 1), cc->fast_search_fail))
+		+ 1;
 }
 
 /*
-- 
2.17.2 (Apple Git-113)

