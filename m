Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDD0C74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 21:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86CA2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 21:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MlbQLz+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfGJVct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 17:32:49 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:35355 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfGJVct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 17:32:49 -0400
Received: by mail-pl1-f202.google.com with SMTP id s21so1969008plr.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 14:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=D4vxIycjAa/oRBETN9HeGCijuet8TadWyyhq7cpzL/s=;
        b=MlbQLz+2fkGnqHycT99BCVEXFcIhY0NwQnphKHCTU8Gz9tipQo+9WHu51grPurjhXe
         a2mJ8ImxNmgAbiTIYRG/nSGwe2kz43z1U4ZFd89xe0Qe96E9FIxdd44b8vQ+Qtm9V9b5
         HXkWdEoy/bQqkyx07h4E6LUexLwmJCyUDimPcIRIL4qOhQYwmfLIrt3mAISYUmIFbA4S
         uN7O6+RFujww9gENEH3kpQJwwTNEUg7kBMszggQSnFpNEPgoXxJgqD+B8MPrcpHgxie9
         owYX9XCkjhjvjOD8la1tz+HhhRIty/YyOGFWGKeYu2TZ7aDtu9hj+njqVG0AF4Gd16+w
         Tt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=D4vxIycjAa/oRBETN9HeGCijuet8TadWyyhq7cpzL/s=;
        b=IjmKPkinF4/v/nuKBa3cgfIxgQhERCdCwM3zKepyNMMMz7aeWW2+zeQHLbZGllPu6C
         Enl32bM3vzkH3Wx56+PIXb6tMQe+zGrfdcyL46axpxjBf1JH8dzWg5OQGKhWi6FL62LN
         wFo1W8DUg22xcALMj/nDHsejrsTSBVdL31udGdqUh9xTI0EUYcTMyugxOFZixI4zSyFU
         E265eTHsKRlpKPwlPfw42SRNv5CwLz/OV1HbsMAZTQon4a9Gsk+GdAMKe/TWNazFs6T3
         J269E40V05RyAQoyK1UBvnLDy3LGcxH528atuUwcZ7hebHlpQnNNRHSGkD1k46dtyJAJ
         eJBw==
X-Gm-Message-State: APjAAAVUR9iRE2h/opVmRU9lU1U4srkWAt117s99P37AcsSzcMF0Xa2K
        yi1NWCsjClAvjTGikoltMKKQvlyTWL1RkOcS
X-Google-Smtp-Source: APXvYqxkWs1ql8glIONr4J4jL2IwaFcEo5teu2KgnAVys+7+MAYwgY/fHlQzByp8VzJ9+OIkKY/Au1eLlsXi9afg
X-Received: by 2002:a65:65c5:: with SMTP id y5mr407700pgv.342.1562794368035;
 Wed, 10 Jul 2019 14:32:48 -0700 (PDT)
Date:   Wed, 10 Jul 2019 14:32:38 -0700
Message-Id: <20190710213238.91835-1-henryburns@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] mm/z3fold.c: remove z3fold_migration trylock
From:   Henry Burns <henryburns@google.com>
To:     Vitaly Wool <vitalywool@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vitaly Vul <vitaly.vul@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Snild Dolkow <snild@sony.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Henry Burns <henryburns@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

z3fold_page_migrate() will never succeed because it attempts to acquire a
lock that has already been taken by migrate.c in __unmap_and_move().

__unmap_and_move() migrate.c
  trylock_page(oldpage)
  move_to_new_page(oldpage_newpage)
    a_ops->migrate_page(oldpage, newpage)
      z3fold_page_migrate(oldpage, newpage)
        trylock_page(oldpage)


Signed-off-by: Henry Burns <henryburns@google.com>
---
 mm/z3fold.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 985732c8b025..9fe9330ab8ae 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1335,16 +1335,11 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
 	zhdr = page_address(page);
 	pool = zhdr_to_pool(zhdr);
 
-	if (!trylock_page(page))
-		return -EAGAIN;
-
 	if (!z3fold_page_trylock(zhdr)) {
-		unlock_page(page);
 		return -EAGAIN;
 	}
 	if (zhdr->mapped_count != 0) {
 		z3fold_page_unlock(zhdr);
-		unlock_page(page);
 		return -EBUSY;
 	}
 	new_zhdr = page_address(newpage);
@@ -1376,7 +1371,6 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
 	queue_work_on(new_zhdr->cpu, pool->compact_wq, &new_zhdr->work);
 
 	page_mapcount_reset(page);
-	unlock_page(page);
 	put_page(page);
 	return 0;
 }
-- 
2.22.0.410.gd8fdbe21b5-goog

