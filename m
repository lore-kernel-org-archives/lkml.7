Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D746C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB8122BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebzZdKnq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfGYSn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:43:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34444 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfGYSn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:43:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so23762797plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 11:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AtweZa/Z6F63u6BGDtxfZL6SRwzo4lD4iM0Os9b2INA=;
        b=ebzZdKnqccWwtZwsMRzf5dLs66cvT47cvTOupG9sQ1axgMouSlzYHllw4szdTYKBLZ
         g1ZdTZFw13XszJ8qE73aGeFFYM9pYIQp0NuxgO9EsQRc3FzxGTfLaEsE4okN2DEJ/qPp
         EkDOEF4pFgN3/5zsqMjEbEEPGEC0m2PX8a34iW8qlMgG7H6agaEA6RhAZCNH6g1bykps
         spfRDwLfZ+HmDgav54rp1H6iQtsTLsasHxY8gAzelL0nEZVqJKai88jeAcPoipuzNpSX
         RkKnjcl/A8ILOT+tgjQRkDU3dMJP35QLW0U6+NNwyOEHJZIyo9bIhlH2buli4LdQrTMI
         9IXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AtweZa/Z6F63u6BGDtxfZL6SRwzo4lD4iM0Os9b2INA=;
        b=eoF7bc/uHKqPxB+ZRwf36nU6vbShC65pTot3b2rVXvdrg51nkW3nmobbxWjpUzCx5J
         +WVgRd1tbcNDn5red3EAfITWvCdQbsaiohF276wWmNg3MF33S5f8jasb9AgPcWy+1x0s
         U/jj0yFR8c39ZPnxUIHAdnkEYGV+sXV8twVeKu8s3upS6K8jkTuj69vqqe9Wrw4cUfs/
         nXLRRXN5BFFxYZci8M3om1bmhJgXARfO7KL+q5/0P5cQ4E1jdEb3oHR4biw4T6Wobtx4
         3oD/XThXndqb2JZjgslQ+mCBeVH6mzoBhfPZuamT98aO0AEwr0P9ayHKzbed1iM473dy
         QsNA==
X-Gm-Message-State: APjAAAVWf3LGRGwDl02BWSGQG5I/jcBw9TbdIYuMQLiC3IvhPZY6v+oQ
        4F0WoWt0J0Yp3IKTSaeoEaU=
X-Google-Smtp-Source: APXvYqzc9P14nGXtvX/LEuC0l4T+N/irxzGOcvtRr7MZQhPIkaH8tJw5GEjVuz0DSjvlv5/7QxHJ7g==
X-Received: by 2002:a17:902:8a87:: with SMTP id p7mr91805919plo.124.1564080235858;
        Thu, 25 Jul 2019 11:43:55 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:624:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id w3sm43818257pgl.31.2019.07.25.11.43.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 11:43:55 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@suse.com, vbabka@suse.cz,
        cai@lca.pw, aryabinin@virtuozzo.com, osalvador@suse.de,
        rostedt@goodmis.org, mingo@redhat.com,
        pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH 03/10] mm/page_alloc: use unsigned int for "order" in should_compact_retry()
Date:   Fri, 26 Jul 2019 02:42:46 +0800
Message-Id: <20190725184253.21160-4-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725184253.21160-1-lpf.vector@gmail.com>
References: <20190725184253.21160-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because "order" will never be negative in should_compact_retry(),
so just make "order" unsigned int.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1432cbcd87cd..7d47af09461f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -839,7 +839,7 @@ static inline struct capture_control *task_capc(struct zone *zone)
 
 static inline bool
 compaction_capture(struct capture_control *capc, struct page *page,
-		   int order, int migratetype)
+		   unsigned int order, int migratetype)
 {
 	if (!capc || order != capc->cc->order)
 		return false;
@@ -870,7 +870,7 @@ static inline struct capture_control *task_capc(struct zone *zone)
 
 static inline bool
 compaction_capture(struct capture_control *capc, struct page *page,
-		   int order, int migratetype)
+		   unsigned int order, int migratetype)
 {
 	return false;
 }
-- 
2.21.0

