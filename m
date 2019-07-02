Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCD2C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7983208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pw4CVxvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfGBNCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:02:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46476 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfGBNCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:02:07 -0400
Received: by mail-pl1-f195.google.com with SMTP id e5so334868pls.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 06:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=khyDU3y3brXaa9hnvY2oQK5kO8QsNPfjkHRRye2R9w0=;
        b=pw4CVxvBDMiI9DQXD67VcLNExsOKGO6Zdy5ZP+qlcS8miUB1MOr0/i+v96aAF6xyFM
         CmT33pBdJkWArwAqk/lsrdmlxAgq9gjOm3ExOQRf3ezYc4KwEC75XoeC3uZL9uMEzzFK
         sw4fO/94cXLyEkjHpEBHeDH9tuW4eSzm567+gvBGpnzwTUlEXuAjjnh48qq/00SgIozW
         9P8TLdZgqvNMB9VodK6G0wU0A0n15/BCL3jEqCgyOD/QmI5xUfPdwA4G4evZQC+pfFxH
         kBX1ye9eVireEvfCwY7gTyNgH94dU2KrCFoXlxQJeePUOaUkFp5fWhyXz6mIUxtB+bkn
         rUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=khyDU3y3brXaa9hnvY2oQK5kO8QsNPfjkHRRye2R9w0=;
        b=Gq7E3JlgcS06mfKXpmDBNtaXZek6tu8OIiNp5rb72NzfbIFvKRqf1fZ4ANXgytRbfL
         S809ftiVSDQB7qQmK7q8zMf+FjDHFUXLdNI1iPYpEBXuIsknMefUzZnAnRZoFOL+6oSN
         gJWnhOu0dmCS0Wmn9fzk29972P2jkeOnyJ26qO/j8lTusqCrpimB0r5c8nDJmah0Swp2
         Itg9SgZ4m1/RunnfL3x0I0Ey/dlf6dq84gx5WS9AoLfuBR7mB+YdyEQoTYIF/2tVcxYl
         DXIV09WmdT1e6OzZQyED29X7U2gMiAgeXdXz3GYZmsCNjPigpQ3Hn2D3V5cK/VbY1aE2
         j5/Q==
X-Gm-Message-State: APjAAAX5d9IPcWetvTW0DMLyE43caVMA4+y5mi/YWVOoxIXzmzKzKfkm
        S69DjgZDS7gEKVJFJhZHKrZ+gfeH
X-Google-Smtp-Source: APXvYqzB1pF/qUqyAlCHdAxDN/p/CNLQWGgTzgY98AvJhwovS+uWV6NhSEOB0TQnHROUBBMuc/ZzeA==
X-Received: by 2002:a17:902:2868:: with SMTP id e95mr32933747plb.319.1562072526735;
        Tue, 02 Jul 2019 06:02:06 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z22sm10855267pgu.28.2019.07.02.06.02.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 06:02:05 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH -next] mm: Mark undo_dev_pagemap as __maybe_unused
Date:   Tue,  2 Jul 2019 06:02:03 -0700
Message-Id: <1562072523-22311-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several mips builds generate the following build warning.

mm/gup.c:1788:13: warning: 'undo_dev_pagemap' defined but not used

The function is declared unconditionally but only called from behind
various ifdefs. Mark it __maybe_unused.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 mm/gup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 7dde2e3a1963..95a373bd8f21 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1785,7 +1785,8 @@ static inline pte_t gup_get_pte(pte_t *ptep)
 }
 #endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
 
-static void undo_dev_pagemap(int *nr, int nr_start, struct page **pages)
+static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
+					    struct page **pages)
 {
 	while ((*nr) - nr_start) {
 		struct page *page = pages[--(*nr)];
-- 
2.7.4

