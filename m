Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2EECA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 14:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51CB21726
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 14:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbqkBZru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfKBOSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 10:18:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42313 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfKBOSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 10:18:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id s23so4866346pgo.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 07:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a8nPsYzLVucjtzOFwmv8LXp67bFoiAmOgB6QFAs0bng=;
        b=qbqkBZruX8HZvNfpETOZhWhtFPZ+VhfXgFGq6FyblnNDlsxOM+41fczYXB/YbSFkIS
         QlJzl5FTMdGMAqr1vsIH5T06fPmyOJn8LrXtIV7OpsXPYognMKM5bGbp5EaBMttjxTQ6
         J/rYNZ4JE/KVP9zXS+z9a/GXhqrjyLbeBbF4dfYgkbIH8OiisNmP/M7PkeoPGa20i2UL
         RE/iKdi7mvJtaanGImu34OCwinO9aRpy13MVNY7vEmvi9+F0ALtorv9X/DMeUr1s4qJu
         y9TBkle10bQk7ZEmGrsRsBq022a40dOp28QV9oy4/qcbprqFwoofEgOHbP0iaUU1c0QE
         X/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a8nPsYzLVucjtzOFwmv8LXp67bFoiAmOgB6QFAs0bng=;
        b=M0rO8iMbwf9aaLVxh/ybFDBK/GlgLdnJNZT2wxU+JGrDny8h5Gkjr7NErjVXWWI+I9
         FPt2o5t+E3B2WDXDLzObigC0rjLW7ZGFiTrW96U/iZfzO+8mAxFs2JuxAi9LDRhUFZdF
         pC/xHiIBLZ8S1xlJG9X+Sp+qHNSmveMM5/lO/6KJahI6b2GPPkPr7Z2SzV4Z8tSFQfRF
         3/bpA1dkpf8rsST3Xy44O2dWnYBTX8XNLiB2vqYQ1WFYkT5XjrOhD8+D3q2MbHcT0+TS
         23dz/ydn3rF5p/RUU6PQOcXlXfSEWBe2d9OfwvQ9hsIfiFw6YsrpoKhLiA5IngkIk4Ef
         fIdw==
X-Gm-Message-State: APjAAAUNYucypffeN2m7AZVPz+3XTfwBkNEEqKniGONi8EoMNYFLeeNA
        iKTrEwvDrkedGuJN6G9UpOE=
X-Google-Smtp-Source: APXvYqwDAC1rJSscJSIHVSnxRwA8DQLNEHV+K7FSNAXLFmdrsTL5HR36OFH3XqJsu0CWAT2oI4YMTg==
X-Received: by 2002:a63:e750:: with SMTP id j16mr20531847pgk.30.1572704296770;
        Sat, 02 Nov 2019 07:18:16 -0700 (PDT)
Received: from ubuntu.localdomain ([118.193.245.26])
        by smtp.gmail.com with ESMTPSA id k9sm9999203pfk.72.2019.11.02.07.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Nov 2019 07:18:16 -0700 (PDT)
From:   hui yang <yanghui.def@gmail.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, yanghui.def@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: There should have an unit (kB)
Date:   Sat,  2 Nov 2019 22:18:07 +0800
Message-Id: <1572704287-4444-1-git-send-email-yanghui.def@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YangHui <yanghui.def@gmail.com>

-    printk(KERN_CONT " %ld", zone->lowmem_reserve[i]);
+    printk(KERN_CONT " %ldkB", zone->lowmem_reserve[i]);
Make it look more perfect

Signed-off-by: YangHui <yanghui.def@gmail.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ecc3dba..ee5043a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5389,7 +5389,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(zone_page_state(zone, NR_FREE_CMA_PAGES)));
 		printk("lowmem_reserve[]:");
 		for (i = 0; i < MAX_NR_ZONES; i++)
-			printk(KERN_CONT " %ld", zone->lowmem_reserve[i]);
+			printk(KERN_CONT " %ldkB", zone->lowmem_reserve[i]);
 		printk(KERN_CONT "\n");
 	}
 
-- 
2.7.4

