Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8576BC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D7A2177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="WetTng58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfCMVZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:25:23 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45753 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfCMVZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:25:23 -0400
Received: by mail-qk1-f195.google.com with SMTP id z76so2064251qkb.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 14:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OucWAD8gEwp6r0i7GUXnLfUiVl1FutMHKz9ApiJmhnw=;
        b=WetTng58/5AC8vNv7/Q3M7nMkYg6b7Xsn5STk7j1JUnYBxffHHSCDVlDJOBWYGi8W2
         Bs2Sx0XNuM/Tv+AQwEluhvZ+98gWrnkF3wphGlR0XIw0x9UawlMn/qiQ9CSIi5OBL7wR
         gm6ACtvpjid/oYG0TWvRdwHijRAmeCupHl4HeAKaSVk+IF6IHNlkyZgkOJgx0DCAIq4s
         gh4ypLihL9IpgaZKg8tzQM0ROrWEG9CJ2nK6T9OcGAY/tdUhAy02hMyxP43yLrVJtAh2
         /jceOF1yKKAlvDE5PICIZtSfMGSkGTnr9NV0zn3366hFRlNFCpRQi1trDDh7ABZNT8lW
         8CAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OucWAD8gEwp6r0i7GUXnLfUiVl1FutMHKz9ApiJmhnw=;
        b=FO5LfKFMhOLje+H3tVIos6Ux7XBTTxhpUSZkL6lHifl3Jj68KswTh4/QGltsLsxsma
         Qq9p6uzn5aAYYvVsgGQtZ1WRx6KIKHgNVWDoDM7HT9X+KXuQj2Is7bXiuXieZ5XFNbxy
         9GBcJJQPY0PrGJqDrtqxjMk6O9mGohyXB4kr455MtcVIsFj+scrEiJZA6PA0C6pMvdq+
         I23+/CSkFoJ0uTnizfFo5uIG7WTgyCgda9SnNWzk3rSd3NcuauRF0Z8/0m31Gmgx9+sn
         C58siUyFHZti428Rr00aLgVGn5ZOQyihvtoEBqZO26IlN0hWWRhLXHOFpcM8JNKOICo+
         t79g==
X-Gm-Message-State: APjAAAVNGdn4JWtul5KalVc6qlS1RW8dYWf36DQMPJc/i2R209sf52co
        tFMluxAH99SSGfBleUWFoT9E/g==
X-Google-Smtp-Source: APXvYqxsLXlrKPQvRjHH3e/SsrDAGZnPjfdFb0me0wrVY9xzhbgomiMmLcdlIM9CjGnc3IwmpOBVdg==
X-Received: by 2002:a05:620a:35e:: with SMTP id t30mr35097254qkm.15.1552512322586;
        Wed, 13 Mar 2019 14:25:22 -0700 (PDT)
Received: from ovpn-121-103.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m128sm7470350qkf.53.2019.03.13.14.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 14:25:21 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] mm: fix a wrong flag in set_migratetype_isolate()
Date:   Wed, 13 Mar 2019 17:25:07 -0400
Message-Id: <20190313212507.49852-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to has_unmovable_pages() takes an incorrect irqsave flag instead of
the isolation flag in set_migratetype_isolate(), it causes issues with
HWPOSION and error reporting where dump_page() is not called when there
is an unmoveable page.

Fixes: d381c54760dc ("mm: only report isolation failures when offlining memory")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/page_isolation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index bf67b63227ca..0f5c92fdc7f1 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -59,7 +59,8 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
 	 * We just check MOVABLE pages.
 	 */
-	if (!has_unmovable_pages(zone, page, arg.pages_found, migratetype, flags))
+	if (!has_unmovable_pages(zone, page, arg.pages_found, migratetype,
+				 isol_flags))
 		ret = 0;
 
 	/*
-- 
2.17.2 (Apple Git-113)

