Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27185C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11B92332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbfHURCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 13:02:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32916 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfHURCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:02:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id go14so1657148plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 10:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U6z5UAUGFghdvzjH4C6pX/4JXep5tUCHLfsHPzlx9LA=;
        b=KEQQ2/DsUObRZ8/fV32XqKYLJGaF0Vc130lqJoI5kHt5ghbBQmgCXB/GWDPsmHG+er
         /xUR58MM/+MX5iRaxobqtJrhGAos9CUOUXDyjUs9ezngXx62Ne146O1dofynLvtWHmGp
         tHHwgztW/+CsDy+yQjSCd9TvXu/S8hVX/kBs61Jw6dZrkLC29JCpRU3KEGW//s9316EF
         tGLT+m9lqMyQyeKacT5IF0UIfrBTlDWvpeDQOps2CkBVI1fwDUZ0Ob+lXidPNvKAS63h
         GrsHZ5x5yztOUNrcwhHX3mNGnfiEwf+mmJ/PIHuf2S73zgIk5RratlqbzBiHWaiLhWXW
         ANDg==
X-Gm-Message-State: APjAAAVCZCFWxMQhwuTDn6RUGupKBY82+inZfNzFtHqn7/IElNMKCEDo
        WsXqNnVX1DQacSCRWdeeKGg=
X-Google-Smtp-Source: APXvYqwSHmzMs89oPrC2mo0cPIKVAkb2F9Ln2a5cPO2U0/JORRLOHxSXJwFKQGFE12cP6dDufj9BgA==
X-Received: by 2002:a17:902:e407:: with SMTP id ci7mr20821703plb.326.1566406971488;
        Wed, 21 Aug 2019 10:02:51 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id b18sm15151398pfi.128.2019.08.21.10.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 10:02:50 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2] mm/balloon_compaction: Informative allocation warnings
Date:   Wed, 21 Aug 2019 02:41:59 -0700
Message-Id: <20190821094159.40795-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to print generic warnings when balloon memory
allocation fails, as failures are expected and can be handled
gracefully. Since VMware balloon now uses balloon-compaction
infrastructure, and suppressed these warnings before, it is also
beneficial to suppress these warnings to keep the same behavior that the
balloon had before.

Since such warnings can still be useful to indicate that the balloon is
over-inflated, print more informative and less frightening warning if
allocation fails instead.

Cc: David Hildenbrand <david@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Nadav Amit <namit@vmware.com>

---

v1->v2:
  * Print informative warnings instead suppressing [David]
---
 mm/balloon_compaction.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 798275a51887..0c1d1f7689f0 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -124,7 +124,12 @@ EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
 struct page *balloon_page_alloc(void)
 {
 	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
-				       __GFP_NOMEMALLOC | __GFP_NORETRY);
+				       __GFP_NOMEMALLOC | __GFP_NORETRY |
+				       __GFP_NOWARN);
+
+	if (!page)
+		pr_warn_ratelimited("memory balloon: memory allocation failed");
+
 	return page;
 }
 EXPORT_SYMBOL_GPL(balloon_page_alloc);
-- 
2.17.1

