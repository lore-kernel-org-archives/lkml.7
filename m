Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F894C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216A121916
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="sUDzCgc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfCTUdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:33:53 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45082 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfCTUdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:33:53 -0400
Received: by mail-qk1-f196.google.com with SMTP id z76so14998152qkb.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AaIGgQ6l0pg6MA+6fDH4Ohm3I1c+gTXhunmzDnC08GQ=;
        b=sUDzCgc3g92zkPjp5gZaZsgMuUoKcHlZ+BerWXrs4Tun7VHg2liJUyZdDUJnbmPsJQ
         06U3Vj8H93WY78f9zi2h/VUxscRkk4oLad5dy+D8J1hLUd+fZ7oAE0yOl8b2XZwNZ0Hh
         da7o6hPLVxFtra69mx1b+/EV9/xHT4o+aPVc0hErHbvEVZ8mtcz9F3EyhvfMe0KdyGNI
         C/udn1N+uX0H4h1uvJtmzC288wB5Vh/QeU6jMwUxIPE1I9LnoXq91oYwZx2FMe9TdVC6
         BXQ1a0eIT8rLU9+rwzKkaHGxFyER9BapoVuK3NwHVJQdeoVYqAE4kwDAfkz5N4K32750
         2PVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AaIGgQ6l0pg6MA+6fDH4Ohm3I1c+gTXhunmzDnC08GQ=;
        b=szUPycIldGdJivAoESOa69i/PmZuEIDB9BVHJaRFafiN2tS9rfV20O2eN7PXZYx2Ho
         bczU6UYXe7Z58P0A2VYb13kMLFKr8hsd3NuoX1bu3JBr//oKLWEyKQtmqhjJcugYWfVB
         +tIeUIIHYlPGiPDQx6zOwDsPuRaSpYL886A+EyHBgbhQNkX6WbR3fgHpIrxjVQiLPRF7
         oAb+jKw7D9lYSo3Lk4+3n/bdPtaA2KXI0HKT+DmZuw+A0kjNsjEXfwrui2omy5TGLW39
         18JSegc95jo22kGTcJSrn2HQC9yDweFOaehufwt8HSEb2CxJjqU+uOBbCp/EhKUkhVad
         e8xA==
X-Gm-Message-State: APjAAAXkrJGIqhtMDpvxcvAbEmOltlEWh+vzSX1kfoKJZ1/LBI9DT5k7
        L/55a26jpfVk4RYQ2B20XSDL8Qv1SUI=
X-Google-Smtp-Source: APXvYqy4ygr9/xFHWmOkEa7gumgHQNm9Ra0ihtvJ5bWpOtSJ5zM6W8U9kmJykElEjNpBdlRfZ/KMog==
X-Received: by 2002:a37:5d06:: with SMTP id r6mr8206494qkb.148.1553114031984;
        Wed, 20 Mar 2019 13:33:51 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t12sm2094634qkl.58.2019.03.20.13.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 13:33:50 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [RESEND#2 PATCH] mm/compaction: fix an undefined behaviour
Date:   Wed, 20 Mar 2019 16:33:38 -0400
Message-Id: <20190320203338.53367-1-cai@lca.pw>
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
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/compaction.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index e1a08fc92353..0d1156578114 100644
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

