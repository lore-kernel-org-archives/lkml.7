Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7EFC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0F62073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eny3JXx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfLJQFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 11:05:11 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37797 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLJQFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 11:05:11 -0500
Received: by mail-pg1-f195.google.com with SMTP id q127so9116786pga.4;
        Tue, 10 Dec 2019 08:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=emGhzWuhNPjt1BJOm+vTsDQa4JuHnONtolq4L0YAYQ8=;
        b=eny3JXx2eahzZo3X31J0NB5EmLHKTOLzfIfOxR4z3ENiB1Iof+3JuFqpyvxRWvP4Pu
         fTylmtLSdoRXhWcJpw6qqXHQo3alRswnSIpp0AnOv6CzOgaxFODrXQWyIjvEwZEsrIB4
         WmCMT9eiUFYON+w7Ci5J22Zo5o+uMk5PDckFgxqAaEocNlmYdSm8fZHFeXRis1P+lrjQ
         DqGC8eVJXFytcZFNdUpWzOD/tLgWw6HWuFcaFbjO9acQjWg38quHgp5HUFwE8mHGKjGD
         RGaVQeqzNVgpLerJQ23QVALPzOL8cZStwWdXtH73Rnb56gTLJRufPy1w7SjKlZJuPiBb
         dXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=emGhzWuhNPjt1BJOm+vTsDQa4JuHnONtolq4L0YAYQ8=;
        b=X9gNtO1OFH3Z455DM3uIsL0WdlfAb/NO9XZ+BypTzXzpbm9Bo8Z4HivObeKI5e4kAl
         yn1CAz9zEF0Dyk/g8DQN300XnWzjj35TxywsaPEdQL/uC3bXdNQePygjLt4tt8HEip+V
         C9BQvQlRtHl428yfbrwdcIyZwLaihW0YybTCQhLauiSOWK/Mc15LanTsGdSDqJBw9lgE
         R1EOFZ/H8TWM+eJ3rFU829o4GtgdOb3ZhQxdrzwZVBR1q6NpNfwxykrAQfuIZLqTYmWi
         Hgl/46tIQMksXHFOt+d1lobiMulQVQz7oWxdHe+TMBXHZmiTwXC3xx2T08V1VpTHJHUK
         JThw==
X-Gm-Message-State: APjAAAVfQA55CfdVYc+DehLaJAxAxmaFZujCkvcbhyKfXjqLx45YV1as
        7Y/oMrKstzqyHUlIibG8FfxulxomRh0=
X-Google-Smtp-Source: APXvYqxqyq0LMYrV9nWAMsGfNdVghMRXYcYTjVV4noJRT3W6Qq8Yvutu7S2XNRZVC7YP4a6pWJ2vGw==
X-Received: by 2002:a63:d406:: with SMTP id a6mr25684793pgh.264.1575993910580;
        Tue, 10 Dec 2019 08:05:10 -0800 (PST)
Received: from localhost.localdomain ([2408:8025:ad:7e20:84d1:c490:3936:fab0])
        by smtp.gmail.com with ESMTPSA id c68sm4022729pfc.156.2019.12.10.08.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 08:05:10 -0800 (PST)
From:   chengkaitao <pilgrimtao@gmail.com>
To:     hannes@cmpxchg.org
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        smuchun@gmail.com, Kaitao Cheng <pilgrimtao@gmail.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2] mm: cleanup some useless code
Date:   Tue, 10 Dec 2019 08:04:50 -0800
Message-Id: <20191210160450.3395-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaitao Cheng <pilgrimtao@gmail.com>

Compound pages handling in mem_cgroup_migrate is more convoluted than
necessary. The state is duplicated in compound variable and the same
could be achieved by PageTransHuge check which is trivial and
hpage_nr_pages is already PageTransHuge aware.

It is much simpler to just use hpage_nr_pages for nr_pages and replace
the local variable by PageTransHuge check directly

Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
Change in v2:
	Update commit message

 mm/memcontrol.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bc01423277c5..870284d3ee9d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6678,7 +6678,6 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 {
 	struct mem_cgroup *memcg;
 	unsigned int nr_pages;
-	bool compound;
 	unsigned long flags;
 
 	VM_BUG_ON_PAGE(!PageLocked(oldpage), oldpage);
@@ -6700,8 +6699,7 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 		return;
 
 	/* Force-charge the new page. The old one will be freed soon */
-	compound = PageTransHuge(newpage);
-	nr_pages = compound ? hpage_nr_pages(newpage) : 1;
+	nr_pages = hpage_nr_pages(newpage);
 
 	page_counter_charge(&memcg->memory, nr_pages);
 	if (do_memsw_account())
@@ -6711,7 +6709,8 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	commit_charge(newpage, memcg, false);
 
 	local_irq_save(flags);
-	mem_cgroup_charge_statistics(memcg, newpage, compound, nr_pages);
+	mem_cgroup_charge_statistics(memcg, newpage, PageTransHuge(newpage),
+			nr_pages);
 	memcg_check_events(memcg, newpage);
 	local_irq_restore(flags);
 }
-- 
2.20.1

