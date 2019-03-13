Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9241CC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E701213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="kVz4Ty34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfCMSGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:06:46 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42399 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfCMSGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:06:45 -0400
Received: by mail-qk1-f195.google.com with SMTP id b74so1666080qkg.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 11:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WKEbSNObSyJ0eVcku+AA9Y4x0Cyfh20haiejK86KEDE=;
        b=kVz4Ty34FFrT8TEAFM7VD0XKFSo0HuQnisSzWEtLt6G1bfUA28YUHcbOmpskNEvQ1x
         wblA5PRMy0lj1OslEop4e64zR9EUCQ1O8LJRVXrIQu0B5PqHp9+9JLtKYsr4I39DLlrv
         Ol3p3u/tuoTOWptnXiZ76MOGouXR8RCiG5WX29vmZriPndVfFxt5Scledi/EnMVhpkxS
         awpxGE97HXR+B7Bb5vEyMWiqhY1f6xaFvoaPh29mT8qyy5sKwRpCbtFJ6F8ta7DW2W7q
         t1LrDdyLL/uFDC198a/R1X2F7sGGbjc4pWbH3R13vE31IElIeONwtwISI2lQE0nQtHNy
         A9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WKEbSNObSyJ0eVcku+AA9Y4x0Cyfh20haiejK86KEDE=;
        b=bsrSXFm07rQatBWcm2utS5uN1CfPMDIqA5Rtakr6gon/p/lqPqF6WOQWwG4arzMfY6
         pnEKPQRosleDrtLX/d6TwAa6wvjwMxOO5H7CeN7hCqQzfwdDzlNCyZYeQ3GQorTkaFO1
         bjFFkh14RENf5QREPBrpnlITv7USoH1FyO+Jc12Ub+6Cc8Bd007U+Yffx/LY2b2l32Vy
         PUcjfqrDLXJplsOnr+BWBWCzqMZbHtAxUPJbtq2vF1jNTsefzezvoIcsrDIs0OuDBa20
         f9ZLT126xS0dt3/AIoXqR46bihjM2WlJvu2L3nhuBP6X0YtkRMNbq6rPxWd7+0JlKXEP
         ZfCQ==
X-Gm-Message-State: APjAAAXWo3tY1sfXcQbHoRaeOCfZeKQ1X7EIMoJp0C2i2DyqxnZI334w
        355ApVhBRquH4vg1QzT7X7CAMg==
X-Google-Smtp-Source: APXvYqxsM9B99gVY4PtfaQMbrsc3613hCE9cUFX3iItJClNNTE+Fr5Uh52mLFQgE3jR0K6wmJkjztQ==
X-Received: by 2002:a05:620a:16c5:: with SMTP id a5mr9943313qkn.200.1552500404794;
        Wed, 13 Mar 2019 11:06:44 -0700 (PDT)
Received: from ovpn-121-103.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y2sm10665535qty.63.2019.03.13.11.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 11:06:44 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [RESEND PATCH] mm/compaction: fix an undefined behaviour
Date:   Wed, 13 Mar 2019 14:06:16 -0400
Message-Id: <20190313180616.47908-1-cai@lca.pw>
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
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Qian Cai <cai@lca.pw>
---

Resend because Andrew's email was bounced back at some point.

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

