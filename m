Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532BFC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272B92064B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ79Hkh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfGBNyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:54:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45906 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfGBNyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:54:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id r1so8276492pfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 06:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=w2BNPQwh7S/nFGeH+ms7w19rWgUYaTkEZzHk2Qdx8+0=;
        b=gQ79Hkh/BFF778AYW0KVlVtHqMRepoo0B1ji+zXqPLbUaZWpmlnMucSvl6y+CN4+3k
         qYx78jLBkZO0JEaaMprEJ34ZMs4EsSKBKI0AMbO7wL7lyagjvRK9q8Py0s2/VagR4jFG
         uTfQ/JTl53KoIzXhnrMcRtOqFVGvd+oyiw2+Ii02zSLeI3H7b8kOom3hSc0SrxA4GsYz
         PZHa2a2uoByUvW/qj5NCw9eO73gC4/kxbxHOvbbkxi9XCqJdpikpXPyQVEl82YRQtVhv
         hDfA4Psa1uJkyAB1VDTPN1+nJD9qT8AkDxucUvAuNQo1ggHgYxR21vKbDpHIPNhbP5Gp
         gZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w2BNPQwh7S/nFGeH+ms7w19rWgUYaTkEZzHk2Qdx8+0=;
        b=UE4YEzIMipetTTAMTOQPalu6kdJgPhiGjvai3Y1IzbyNr4IKZG2IFMfsB0MXaP4j+H
         wVXYX4esx3G/v4VD4scb6MJ9cyqyqju2TpnJTdsytTUAjPV1F6CZPja4zF6N5rYLY9MB
         wZAngfH5RZ3YyzVhxLQry/rLJl7qoTRxvKUvGOMq28emFprEDhQMK0B78gbsf3bKyrka
         Zv3NGCrG/OllOVfw3kv6IR7gmfw2LXqsyiIKeZ5Az/ejuWOzt1p/F/DE5F4ROHDdhhAH
         C6ao0oTXrr7YsFNnPmSnmIv5JSDIvtE8yaFFWpWP3YWkJu2gYZGJ+j2/hrAuKw4J39tg
         FtJQ==
X-Gm-Message-State: APjAAAUxFx4GERrdIrLMOcJ29DKG/EdTTXmUSUciL2jlnPYjHH26AbIG
        tslAtdCSHunUsdP7glnoQA==
X-Google-Smtp-Source: APXvYqxthi/Anqcspql3AIVjs7d8XDbWIPItCvqC6SzOFphrFA9bEN6ceq5EwcqWj1z9QjuO5vVWZQ==
X-Received: by 2002:a17:90a:a489:: with SMTP id z9mr5598087pjp.24.1562075640093;
        Tue, 02 Jul 2019 06:54:00 -0700 (PDT)
Received: from mylaptop.redhat.com ([2408:8207:782e:f8f0:635f:8a20:82ca:fda3])
        by smtp.gmail.com with ESMTPSA id g66sm7955419pfb.44.2019.07.02.06.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 06:53:59 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Qian Cai <cai@lca.pw>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_isolate: change the prototype of undo_isolate_page_range()
Date:   Tue,  2 Jul 2019 21:53:24 +0800
Message-Id: <1562075604-8979-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

undo_isolate_page_range() never fails, so no need to return value.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Qian Cai <cai@lca.pw>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/page-isolation.h | 2 +-
 mm/page_isolation.c            | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 280ae96..1099c2f 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -50,7 +50,7 @@ start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
  * Changes MIGRATE_ISOLATE to MIGRATE_MOVABLE.
  * target range is [start_pfn, end_pfn)
  */
-int
+void
 undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 			unsigned migratetype);
 
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index e3638a5..89c19c0 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -230,7 +230,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 /*
  * Make isolated pages available again.
  */
-int undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
+void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 			    unsigned migratetype)
 {
 	unsigned long pfn;
@@ -247,7 +247,6 @@ int undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 			continue;
 		unset_migratetype_isolate(page, migratetype);
 	}
-	return 0;
 }
 /*
  * Test all pages in the range is free(means isolated) or not.
-- 
2.7.5

