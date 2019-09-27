Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970C7C388F3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 19:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6617220863
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 19:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="KYg3Joiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfI0Trg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 15:47:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41150 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfI0Trg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 15:47:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id n1so8734428qtp.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 12:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CpiHlbdSJgA7oNhfLPbam9bU8AoSRoaasUJ79GcGGdM=;
        b=KYg3Joiqi0dgLpVnPBoifnlamgdRmdamw/pWkEjT+py6KobWsUC4YKlcL3qcUNyE9U
         mURIdsUbSIDq4QOREm0lQ0lbZL5BZCB24tHynzNGd4fEtPsBLmIl0JvP49fq95pnCj78
         EDYxUaec2tjtGkVW3jPkf8QBdDucD2qLzOEwxQnAEM3tTOfbhmnF4U4cAn2u8smmsDkr
         62DT3/qxM35LmOQJIRaMPUX97QzzZBjtze0L6yAkbDSAJOsUgPrIQJWC5uzb9ZYnSSSv
         6vK4a72kRPbDwP6wodmVyfL4dDZp/fuP9qatcrNzJ1xjW7sZxEh5Ikem8+nsIWe7GEUh
         qvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CpiHlbdSJgA7oNhfLPbam9bU8AoSRoaasUJ79GcGGdM=;
        b=i8dTk2AXdGDCAQCV2LPpb4qAKN2LmkwmKC2EeZKhfne2ZZNynhkRlvtzsCdTcrB3Xe
         emMBW7DGttOC+C5x4qw+xye6+c8L34fvpY70jFPdf07wWr7sH+cSf8cNnHmXBIWHJ77p
         ZOztH6MGyLZR+Z3V81bdwnEwPltvPeF/dlshcXSlVFBVdp1IjJ44QzKoXQh5k009Eh0P
         1se5JP5k3mXkIYf2aog03WT3G9SEMJ9NDq7UqtFsxwivFqxtItZmHQNA+TvY9Z6WAQ5a
         +dsq/c/gdoWOFpPrf8Y0g8lNy2aYseszGEqujxEX0804d40ziB/PxX9HBE0MCY/LN3mI
         zN5g==
X-Gm-Message-State: APjAAAWtfmR2NHdKE8xb9CO1jtvb1H6369VWbwxyxjCAv3ng2Q5MEW0a
        OUW8t/Gaj0myDwwVXmfkRkgG1w==
X-Google-Smtp-Source: APXvYqxia/G4KZmMGp3jkyBTaUUMaIIwx/DITUdL5Idif3NH6OJGxOhMRHzslgHRShiqn9EqfNH+DA==
X-Received: by 2002:ac8:2e94:: with SMTP id h20mr12236883qta.234.1569613654163;
        Fri, 27 Sep 2019 12:47:34 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 44sm3980781qtt.13.2019.09.27.12.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 12:47:33 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/page_alloc: fix a crash in free_pages_prepare()
Date:   Fri, 27 Sep 2019 15:47:03 -0400
Message-Id: <1569613623-16820-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On architectures like s390, arch_free_page() could mark the page unused
(set_page_unused()) and any access later would trigger a kernel panic.
Fix it by moving arch_free_page() after all possible accessing calls.

 Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)
 Krnl PSW : 0404e00180000000 0000000026c2b96e
(__free_pages_ok+0x34e/0x5d8)
            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
 Krnl GPRS: 0000000088d43af7 0000000000484000 000000000000007c
 000000000000000f
            000003d080012100 000003d080013fc0 0000000000000000
 0000000000100000
            00000000275cca48 0000000000000100 0000000000000008
 000003d080010000
            00000000000001d0 000003d000000000 0000000026c2b78a
 000000002717fdb0
 Krnl Code: 0000000026c2b95c: ec1100b30659 risbgn %r1,%r1,0,179,6
            0000000026c2b962: e32014000036 pfd 2,1024(%r1)
           #0000000026c2b968: d7ff10001000 xc 0(256,%r1),0(%r1)
           >0000000026c2b96e: 41101100  la %r1,256(%r1)
            0000000026c2b972: a737fff8  brctg %r3,26c2b962
            0000000026c2b976: d7ff10001000 xc 0(256,%r1),0(%r1)
            0000000026c2b97c: e31003400004 lg %r1,832
            0000000026c2b982: ebff1430016a asi 5168(%r1),-1
 Call Trace:
 __free_pages_ok+0x16a/0x5d8)
 memblock_free_all+0x206/0x290
 mem_init+0x58/0x120
 start_kernel+0x2b0/0x570
 startup_continue+0x6a/0xc0
 INFO: lockdep is turned off.
 Last Breaking-Event-Address:
 __free_pages_ok+0x372/0x5d8
 Kernel panic - not syncing: Fatal exception: panic_on_oops
00: HCPGIR450W CP entered; disabled wait PSW 00020001 80000000 00000000
26A2379C

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3334a769eb91..a54ff6a60649 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1175,11 +1175,11 @@ static __always_inline bool free_pages_prepare(struct page *page,
 		debug_check_no_obj_freed(page_address(page),
 					   PAGE_SIZE << order);
 	}
-	arch_free_page(page, order);
 	if (want_init_on_free())
 		kernel_init_free_pages(page, 1 << order);
 
 	kernel_poison_pages(page, 1 << order, 0);
+	arch_free_page(page, order);
 	if (debug_pagealloc_enabled())
 		kernel_map_pages(page, 1 << order, 0);
 
-- 
1.8.3.1

