Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52E8C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEFF2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuimSzZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgAIW5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 17:57:14 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46874 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgAIW5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 17:57:14 -0500
Received: by mail-pf1-f195.google.com with SMTP id n9so110126pff.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 14:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2a7Ek0VQLsAuhJ+XYFWJA3fva0Kgdtmci7QB6XNEMP0=;
        b=YuimSzZu1y5m9DZaeBFiFrcs4NDuyX4BeY681gPjsn3V/IeAf/sqbRvUwwcTyHtfNN
         umoLWe6WPMlrcdGJ0FrwedEmxnj53t9E1Cdld15ykhcJvlxI7rswAM6ZMAB2sOMehdgC
         n4cCwi7DocM+8RUKnFb9CiTA5vocgtyXiruGGYWC6tqBKzgrHYoSAnTKqKCqc0I5c1Pc
         jufAvkwoMSdUDwgwLke6LXNVyHmELFolGkhiPBQPNeVYpIFnGd4dwhSBNfYiqY3a4DNq
         t5qEToWYutjIhZZqIhZsh+ckC2MNihKpjPtIb68mlV7X5EjaftY3uKqzrIOfV7nRu4EA
         zyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2a7Ek0VQLsAuhJ+XYFWJA3fva0Kgdtmci7QB6XNEMP0=;
        b=rRYWvPInm7pUuvxS2HERsFHwho+wqe8dEIyFUz+SJUxA4YpZXW087wXUOjlwTW2eyI
         Kvlerj4Ey1F8R7SirxsPuTai/wV5FgXmm7NCL1AVgG46OPkXzqmkOtXqHU/Sp7GEzZzV
         soD/UtnHPrpFFjBFc/QD/bvehnFHqSsY2PLCjKZgXug8eC0r9P2LRtFaZCkhkEJ1amWG
         UY3X8LLGSbhJjwoeLJUqk7Xatqu02ILW1Bx5JcrjZbMV+Lk2uAmqogRruFLH9gIc69m+
         pT9dj+21WLWdg6yRPdqUSx5rANb54X20sNQNF8+iLNH9NpX3EMGW2QsJ/6SOpLJuSC/Z
         N4Yw==
X-Gm-Message-State: APjAAAVJCUdfTRXGec/7IgMtTv9HioXY9mw3fQLu0MPv6oyqtSWco/es
        zuUZ4oiaRc0DCXpaCwT/Ta3qu+57r8E=
X-Google-Smtp-Source: APXvYqySJ6jZ9DdfLLZGXudWsLWOQEN++HZ/J0SXS8CbNiwlcs4ZPLLbJ21gQqbWU1f5s62O3Fxn2g==
X-Received: by 2002:a65:4c8b:: with SMTP id m11mr453079pgt.208.1578610633203;
        Thu, 09 Jan 2020 14:57:13 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id v9sm65662pja.26.2020.01.09.14.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 14:57:12 -0800 (PST)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org
Subject: [PATCH] mm: avoid blocking lock_page() in kcompactd
Date:   Thu,  9 Jan 2020 14:56:46 -0800
Message-Id: <20200109225646.22983-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We observed kcompactd hung at __lock_page():

 INFO: task kcompactd0:57 blocked for more than 120 seconds.
       Not tainted 4.19.56.x86_64 #1
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 kcompactd0      D    0    57      2 0x80000000
 Call Trace:
  ? __schedule+0x236/0x860
  schedule+0x28/0x80
  io_schedule+0x12/0x40
  __lock_page+0xf9/0x120
  ? page_cache_tree_insert+0xb0/0xb0
  ? update_pageblock_skip+0xb0/0xb0
  migrate_pages+0x88c/0xb90
  ? isolate_freepages_block+0x3b0/0x3b0
  compact_zone+0x5f1/0x870
  kcompactd_do_work+0x130/0x2c0
  ? __switch_to_asm+0x35/0x70
  ? __switch_to_asm+0x41/0x70
  ? kcompactd_do_work+0x2c0/0x2c0
  ? kcompactd+0x73/0x180
  kcompactd+0x73/0x180
  ? finish_wait+0x80/0x80
  kthread+0x113/0x130
  ? kthread_create_worker_on_cpu+0x50/0x50
  ret_from_fork+0x35/0x40

which faddr2line maps to:

  migrate_pages+0x88c/0xb90:
  lock_page at include/linux/pagemap.h:483
  (inlined by) __unmap_and_move at mm/migrate.c:1024
  (inlined by) unmap_and_move at mm/migrate.c:1189
  (inlined by) migrate_pages at mm/migrate.c:1419

Sometimes kcompactd eventually got out of this situation, sometimes not.

I think for memory compaction, it is a best effort to migrate the pages,
so it doesn't have to wait for I/O to complete. It is fine to call
trylock_page() here, which is pretty much similar to
buffer_migrate_lock_buffers().

Given MIGRATE_SYNC_LIGHT is used on compaction path, just relax the
check for it.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 mm/migrate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 86873b6f38a7..df60026779d2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1010,7 +1010,8 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 	bool is_lru = !__PageMovable(page);
 
 	if (!trylock_page(page)) {
-		if (!force || mode == MIGRATE_ASYNC)
+		if (!force || mode == MIGRATE_ASYNC
+			   || mode == MIGRATE_SYNC_LIGHT)
 			goto out;
 
 		/*
-- 
2.21.1

