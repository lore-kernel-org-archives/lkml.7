Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFFFC06508
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 07:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5713D208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 07:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffjKb1Hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfF3H5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 03:57:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34438 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfF3H5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 03:57:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id c85so5035017pfc.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 00:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B8cz0p1U2cEXshPnnN86RK5M/poNnk6a+Vr9fHBKncc=;
        b=ffjKb1HrgKUUctGTqK85NRnFp565HiDUpfM/Ri3+MUMkO2+p3U7fWXgil9oYaSsq7+
         R35g5lkpuQa56AWLCtqStNh0+CWkoieCbOcwjqHB+shzdZ14Dh7p+x2K9eiF0vRwQ7/0
         e+2Iah+RphOiCdvZW3mRXYNkcSPWu/GM9e4Li3JycDq2H9mFZyeD0spZ4bFDQhhrbwUu
         gbOQM6AdzjbT5Z0WOLG3lw2aLjNdsCgQTWhi3AS2ddpIooGHuX1bCzdpb2/dAbcfSva7
         nwpLe4mkdhUUzellr9Da72OZFTdBq/aQtmFTBINd1L8BFuPZrxNh8T8sjmx1X0zHFmTb
         LqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B8cz0p1U2cEXshPnnN86RK5M/poNnk6a+Vr9fHBKncc=;
        b=ZumIBeEQliUWOpc0cvcNXKcEdD0GzcAPJ4CZoJFXWhwCw3mYEciw8KE+UmDyL0xoe7
         SOWj8m8OL0sGS8nv1h3NKmyXn8Zc+CrwR/WcMuUfYYpS0nOPoLxrvYr2AP6wW8Q9R6nP
         9FIlF5+i4NdWrOe5TilOfzZEIC8QZsyEAjEddQhfOjssAylWv4o+1+JZZxfOxKXWclqp
         uJoJ/ocKfh/BNDbTd82EoJaItARhPMCQWYu42X6EivLEFCWtA5bHTAY9vOu9wWATF/+0
         oWHy3FjM6ga7tLHsIoivXi9hFv3yQ8vPlf07GPZJ8Yp/fmc3CF0F+of3tf8d6asZPeUc
         TBsw==
X-Gm-Message-State: APjAAAV2s7yuhfry7gqK7VlL0Iqa2AtjnPLGZRzYJwRjakBYCSMFBiOq
        AiRit6ess6rgT0ZY4rkVYBg=
X-Google-Smtp-Source: APXvYqxyXVNFtPTqFEC9kbmUTJGkH5SitL5qzTDfmRtyc0PTQLnSfVVEVDv2LlFkGqWo4kQoKHUCGg==
X-Received: by 2002:a17:90a:35e5:: with SMTP id r92mr24134932pjb.34.1561881464652;
        Sun, 30 Jun 2019 00:57:44 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:648:b8c3:8577:bf2f:2])
        by smtp.gmail.com with ESMTPSA id w10sm5989637pgs.32.2019.06.30.00.57.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 00:57:44 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org, peterz@infradead.org, urezki@gmail.com
Cc:     rpenyaev@suse.de, mhocko@suse.com, guro@fb.com,
        aryabinin@virtuozzo.com, rppt@linux.ibm.com, mingo@kernel.org,
        rick.p.edgecombe@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH 3/5] mm/vmalloc.c: Rename function __find_vmap_area() for readability
Date:   Sun, 30 Jun 2019 15:56:48 +0800
Message-Id: <20190630075650.8516-4-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630075650.8516-1-lpf.vector@gmail.com>
References: <20190630075650.8516-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function __find_vmap_area to __search_va_from_busy_tree to
indicate that it is searching in the *BUSY* tree.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 mm/vmalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a5065fcb74d3..1beb5bcfb450 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -399,7 +399,7 @@ static void purge_vmap_area_lazy(void);
 static BLOCKING_NOTIFIER_HEAD(vmap_notify_list);
 static unsigned long lazy_max_pages(void);
 
-static struct vmap_area *__find_vmap_area(unsigned long addr)
+static struct vmap_area *__search_va_from_busy_tree(unsigned long addr)
 {
 	struct rb_node *n = vmap_area_root.rb_node;
 
@@ -1313,7 +1313,7 @@ static struct vmap_area *find_vmap_area(unsigned long addr)
 	struct vmap_area *va;
 
 	spin_lock(&vmap_area_lock);
-	va = __find_vmap_area(addr);
+	va = __search_va_from_busy_tree(addr);
 	spin_unlock(&vmap_area_lock);
 
 	return va;
-- 
2.21.0

