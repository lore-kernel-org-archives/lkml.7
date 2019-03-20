Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F67FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3995221873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Ft0YhVKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfCTT07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:26:59 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43549 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCTT06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:26:58 -0400
Received: by mail-qk1-f196.google.com with SMTP id c20so10112098qkc.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=I3tdl5L6G+L4wZtfr4ffg2pY8PDniLnkmBZEEfgscCA=;
        b=Ft0YhVKA30FM2Hwf8vkspCk3n5ip2zIvvmvY8RV6Ov4RmZuHWO/F8Pbxr/iUKEqVlw
         y8whAbF9u6PEGSfEICgZ6zeRjmzrrO15PILAI9Pktg3ZtlEeDZrs6ZHYM5IpK+JtSPFN
         hLBakyVyvIqg21r1zK/+wSUzwviT/36jB8HcKaXXAwc+Zfm3Ep7iY0K1d5FcVptnDog8
         mmy4LCACnW5kFoa4AHr9YBHtvqczueRLG6AOA/a6EiJa8VGWrE+AEPv84EjmHJxEf8Mt
         ByIbVHbx4HP63LY0J6SZPQ29df3o5ll/EdioGYcLtNIgmDjLhki/QMx8KQ+SA65E3DYU
         2KdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I3tdl5L6G+L4wZtfr4ffg2pY8PDniLnkmBZEEfgscCA=;
        b=NqgDqLO1o79bzMpcA6qBQgRMM6azA00DCSRfthqk4GEfdtKQPqUoR3LP0zVR0EAQYJ
         Z+zpAN1C9MiKeLIhrdgkGprvtbqgwZ/1ePuylMYPauw73AqkQ9ciPWCydkJt5lKqmjld
         Nt/hejhTQQLe7MHUHx5XCfz5QeLDFcziXEbvv+tIfucyXvSSv00c8fHJEnHTM8c6MNST
         vX3zzrDnT6E08dDmdh2mWW1/XdvCKJuHlO7GFYTMDzFbyoxA4medXVFbIpl0LxDukEyz
         l4GHehqWqDEnTC9H6v3So/6Gqb/vrkSnLL6Som+pa0chR/knhLdgeRSxbqWXXneSamwx
         wrZg==
X-Gm-Message-State: APjAAAUjXmdTnWb+z4cP97EKP+OVMbuHwJyXpxpKUHwSp1oUb6p0ecAB
        tvmOXnQInL78qy1IhaLZmw1jYFUAAoo=
X-Google-Smtp-Source: APXvYqxwQ+rf8Hlos+xrj8IgGII+vS1qst7ATAFPtfT/DhH5vTyzU1J9HFNoCoBzBoK1fqcP7TpElQ==
X-Received: by 2002:a37:27d4:: with SMTP id n203mr8028336qkn.105.1553110017618;
        Wed, 20 Mar 2019 12:26:57 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l129sm1449292qkb.44.2019.03.20.12.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 12:26:56 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, daniel.m.jordan@oracle.com,
        mikhail.v.gavrilov@gmail.com, vbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] mm/compaction: abort search if isolation fails
Date:   Wed, 20 Mar 2019 15:26:48 -0400
Message-Id: <20190320192648.52499-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running LTP oom01 in a tight loop or memory stress testing put the
system in a low-memory situation could triggers random memory
corruption like page flag corruption below due to in
fast_isolate_freepages(), if isolation fails, next_search_order() does
not abort the search immediately could lead to improper accesses.

UBSAN: Undefined behaviour in ./include/linux/mm.h:1195:50
index 7 is out of range for type 'zone [5]'
Call Trace:
 dump_stack+0x62/0x9a
 ubsan_epilogue+0xd/0x7f
 __ubsan_handle_out_of_bounds+0x14d/0x192
 __isolate_free_page+0x52c/0x600
 compaction_alloc+0x886/0x25f0
 unmap_and_move+0x37/0x1e70
 migrate_pages+0x2ca/0xb20
 compact_zone+0x19cb/0x3620
 kcompactd_do_work+0x2df/0x680
 kcompactd+0x1d8/0x6c0
 kthread+0x32c/0x3f0
 ret_from_fork+0x35/0x40
------------[ cut here ]------------
kernel BUG at mm/page_alloc.c:3124!
invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
RIP: 0010:__isolate_free_page+0x464/0x600
RSP: 0000:ffff888b9e1af848 EFLAGS: 00010007
RAX: 0000000030000000 RBX: ffff888c39fcf0f8 RCX: 0000000000000000
RDX: 1ffff111873f9e25 RSI: 0000000000000004 RDI: ffffed1173c35ef6
RBP: ffff888b9e1af898 R08: fffffbfff4fc2461 R09: fffffbfff4fc2460
R10: fffffbfff4fc2460 R11: ffffffffa7e12303 R12: 0000000000000008
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000007
FS:  0000000000000000(0000) GS:ffff888ba8e80000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc7abc00000 CR3: 0000000752416004 CR4: 00000000001606a0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 compaction_alloc+0x886/0x25f0
 unmap_and_move+0x37/0x1e70
 migrate_pages+0x2ca/0xb20
 compact_zone+0x19cb/0x3620
 kcompactd_do_work+0x2df/0x680
 kcompactd+0x1d8/0x6c0
 kthread+0x32c/0x3f0
 ret_from_fork+0x35/0x40

Fixes: dbe2d4e4f12e ("mm, compaction: round-robin the order while searching the free lists for a target")
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: abort the search by causing a wrap-around, so cc->search_order can be
    updated for the next search.

 mm/compaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 6aebf1eb8d98..0d1156578114 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1365,7 +1365,7 @@ fast_isolate_freepages(struct compact_control *cc)
 				count_compact_events(COMPACTISOLATED, nr_isolated);
 			} else {
 				/* If isolation fails, abort the search */
-				order = -1;
+				order = cc->search_order + 1;
 				page = NULL;
 			}
 		}
-- 
2.17.2 (Apple Git-113)

