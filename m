Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D15C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E322190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krqNq8BY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfGYSnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:43:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36272 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfGYSnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:43:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id k8so23751537plt.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 11:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LM9NWAF0ytItmg0/3xpjnjQuBlW33GrdHmnGHnte6C8=;
        b=krqNq8BY5iqPotlUCYVvRufSup7u484ap7vtqZd62DT2YWJEqbTuNrdJTyFS82Mkea
         hPnbBetkES1Rvog7BV2oxtRGemWD4UOcShyg2zmX4DylmLCFGJCDH+s+mzWkGSxcQDNw
         b25pt0y1cHH0PgDHQn2U5Ow1DhZOo0oKsPafZ2Jv7BFkasNaRMU6JfiXcAPftzmREhig
         FYvKASoujJVMb4NVJkkIh7VdpX34SFyfuqDhYxxWuixLh4PiXkhu7Zv4mU3NUf3RFFir
         CXY8SVle6QCQzIxSmTY8eMcAONROL7UUy41QRIDeHYLZ36OOfQCSiA68Xakw8SURkUF1
         5dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LM9NWAF0ytItmg0/3xpjnjQuBlW33GrdHmnGHnte6C8=;
        b=BUNNZ6Git5bG4U4Ab4yihvyj6AKGIpkqiKkOZRanXLT9U22C3fWSoTGWbI1mIj333a
         QgZQtp7dEGczWvQoES0N3kQxuGzF86svE7B7Iaa+pPxXF2NG6p6KrfNWR5wVJgTve/MB
         KDyq795RuOHt/2Hs2KwR/3+GITHww4mayz+OxxJk/lhNoUMixa/CXcK8CmNKHZ+8D8N6
         m2utwLgfv2sZutA8+aL1fcgITxw/1PWfZPXsvsNdoqxtQP+pnGjW9zpYAt3NI9RX1PXy
         m8OUCtGnWgeEfA/BZGhKD8KBGM5s9+TTDaOiLm01cg6Bu4flUy+hLQwg9W0tx5VHx0gd
         V02A==
X-Gm-Message-State: APjAAAVa192Bpgggr17o4O9+SDnr1DGiJrMw29z71+ms2wVZAYbzH9iv
        ESexER9W219j2KIjgChgff8=
X-Google-Smtp-Source: APXvYqwCMV2H21NxKRfDRuTd//qs/r8C/uZOE9OxuJpJ+luZG7UGVHuPafSzsoUwS45u1kHkEPcFGw==
X-Received: by 2002:a17:902:54d:: with SMTP id 71mr90210854plf.140.1564080210878;
        Thu, 25 Jul 2019 11:43:30 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:624:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id w3sm43818257pgl.31.2019.07.25.11.43.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 11:43:30 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@suse.com, vbabka@suse.cz,
        cai@lca.pw, aryabinin@virtuozzo.com, osalvador@suse.de,
        rostedt@goodmis.org, mingo@redhat.com,
        pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH 00/10] make "order" unsigned int
Date:   Fri, 26 Jul 2019 02:42:43 +0800
Message-Id: <20190725184253.21160-1-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Objective
----
The motivation for this series of patches is use unsigned int for
"order" in compaction.c, just like in other memory subsystems.

In addition, did some cleanup about "order" in page_alloc
and vmscan.


Description
----
Directly modifying the type of "order" to unsigned int is ok in most
places, because "order" is always non-negative.

But there are two places that are special, one is next_search_order()
and the other is compact_node().

For next_search_order(), order may be negative. It can be avoided by
some modifications.

For compact_node(), order = -1 means performing manual compaction.
It can be avoided by specifying order = MAX_ORDER.

Key changes in [PATCH 05/10] mm/compaction: make "order" and
"search_order" unsigned.

More information can be obtained from commit messages.


Test
----
I have done some stress testing locally and have not found any problems.

In addition, local tests indicate no performance impact.


Pengfei Li (10):
  mm/page_alloc: use unsigned int for "order" in should_compact_retry()
  mm/page_alloc: use unsigned int for "order" in __rmqueue_fallback()
  mm/page_alloc: use unsigned int for "order" in should_compact_retry()
  mm/page_alloc: remove never used "order" in alloc_contig_range()
  mm/compaction: make "order" and "search_order" unsigned int in struct
    compact_control
  mm/compaction: make "order" unsigned int in compaction.c
  trace/events/compaction: make "order" unsigned int
  mm/compaction: use unsigned int for "compact_order_failed" in struct
    zone
  mm/compaction: use unsigned int for "kcompactd_max_order" in struct
    pglist_data
  mm/vmscan: use unsigned int for "kswapd_order" in struct pglist_data

 include/linux/compaction.h        |  30 +++----
 include/linux/mmzone.h            |   8 +-
 include/trace/events/compaction.h |  40 +++++-----
 include/trace/events/kmem.h       |   6 +-
 include/trace/events/oom.h        |   6 +-
 include/trace/events/vmscan.h     |   4 +-
 mm/compaction.c                   | 127 +++++++++++++++---------------
 mm/internal.h                     |   6 +-
 mm/page_alloc.c                   |  16 ++--
 mm/vmscan.c                       |   6 +-
 10 files changed, 126 insertions(+), 123 deletions(-)

-- 
2.21.0

