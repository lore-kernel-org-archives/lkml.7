Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E65C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A46F20704
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 23:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLy9Nkr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKVXKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:10:53 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:38875 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVXKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:10:53 -0500
Received: by mail-il1-f196.google.com with SMTP id u17so8573645ilq.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 15:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DEYv92j7IemrkT72odbISRuFdrsY92708cwl4dDgtHw=;
        b=rLy9Nkr9porBJAHLvO9SKbOVmuXwLIiyb49wh9rmNlgufky1Gr/O/KSuWV8Cm61hky
         uJCCChoiAgM+WF+urKe2Bo5HAbBHsutG96qZgeL1ynWsm3XrF/4qrFMIUOlOmApMvZsz
         qudfdPv03yF5gniw/8947gRwyeZMutHcprPCVuAKtY0f7ytTzQPf3F6sPf1TL+zjaape
         yKQlRnL7eDmLHnpAzGjn+fRS2DAAmIa1yYyBS+BBg+J0DE3arx/CRlbcQjXK2G5iJX1d
         YjwpPQ7j27/phkJmL+6BOe/9c3RRUVBOWN1XVQGGifz02IavG7oDLundKDwzrxYB52L4
         o8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DEYv92j7IemrkT72odbISRuFdrsY92708cwl4dDgtHw=;
        b=KZ4K5w/2gZC/EIyRCYGpyM3t446vRbrfDxP+CMU4uq5S/L1qeVNAiwzufAOKSC55Us
         mooavb4kUoDd4W6l1s/pTjMtPxxKmoYteCHJJmJUBqhbVphwqpOqTAJoLV44SYmnNCOt
         i/hVm4SBiDAKmomnZJKbj3SaUkBGvmHvuDHiCOXP3dp9xeJ6fZzQSC2D7zkAE2w1EIAb
         L+1ipSwB7wMXxR0/2/V/0wNzeZHcrdcbWarcJdHwXqbSM3rdYQMTVd82P8ckBYn6NErD
         MpYk+LU2UWWk5U4H0P4b9ytOEJ0XSDAcJwrGtRR1L1clPJLfzTsC6y5sxxw8LGQlSkCx
         6Ehg==
X-Gm-Message-State: APjAAAUMxkuX7aqjm2aSA3qd/XQWzC3R24am4WUyHfsj1D7U1K6PooUD
        ipXIilI9U+Dn6bvjWEsIJ7o=
X-Google-Smtp-Source: APXvYqxy4HsiYhun3maar2NcfeaqQIbkLoH0vMv1kZl7c94h7A0UODraIdyb32xMmBT1uAnO0Du7NA==
X-Received: by 2002:a92:8ccc:: with SMTP id s73mr19391625ill.86.1574464252041;
        Fri, 22 Nov 2019 15:10:52 -0800 (PST)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id a23sm2155846ill.83.2019.11.22.15.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 15:10:51 -0800 (PST)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] mm/gup: Fix memory leaks in __gup_benchmark_ioctl
Date:   Fri, 22 Nov 2019 16:41:15 -0600
Message-Id: <20191122224117.2372-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of __gup_benchmark_ioctl() memory is leaked if the
passed cmd is invalid. Release pages before returning -1.

Fixes: 714a3a1ebafe ("mm/gup_benchmark.c: add additional pinning methods")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 mm/gup_benchmark.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
index 7dd602d7f8db..33ede5727523 100644
--- a/mm/gup_benchmark.c
+++ b/mm/gup_benchmark.c
@@ -23,7 +23,7 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 		struct gup_benchmark *gup)
 {
 	ktime_t start_time, end_time;
-	unsigned long i, nr_pages, addr, next;
+	unsigned long i, j, nr_pages, addr, next;
 	int nr;
 	struct page **pages;
 
@@ -63,6 +63,12 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 					    NULL);
 			break;
 		default:
+			for (j = 0; j < i; j++) {
+				if (!pages[j])
+					break;
+				put_page(pages[j]);
+			}
+			kvfree(pages);
 			return -1;
 		}
 
-- 
2.17.1

