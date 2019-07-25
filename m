Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FBCC76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E21622CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJM1DtC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfGYSoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:44:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33048 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfGYSoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:44:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so23195268pfq.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bPDs9aZTbcVy9P5At/6nzEj0xAhZgvBWq0iu1KF/hyM=;
        b=eJM1DtC5tc7N+x3bUDdfU3a6aCPNIKs5Ea/Z/fUOdrJjaLs5VmctkQkOfWa5ycQmWy
         T5eFh5Pv2d56b42dZkAQcWzM/FzmI6m7UaLTTYpXxUJOE1+rTja/64NwSq+YXHDtkVhj
         UoDfaFAKiw0bjo8MjuKksMwuHF6M1UgGh6b4OyJFpU/RGI7iV6615GCVMwt+fzzREu+q
         F0x/mjJzP3lhCGVKSOcsUzuZMTn3ZbHwy9xR6IjoO9VTr2CUPe9CEu3D+nWk8iwRAWbP
         43C4KdlQ8/ROPCjSjhtS41Jp0XOnZKjzAHMrAVWtaOzkiLvj7kzrci0zbLlYjWwWycJJ
         wfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bPDs9aZTbcVy9P5At/6nzEj0xAhZgvBWq0iu1KF/hyM=;
        b=FkrF/QAha587nG1K50Q1Et9ffyTxjH319Fk1K/Tk+bVQsUScCtzHGT7giFY3kMmAaV
         wfhQNNv85PfYgwuV0p/P9JeY/t5C8UVtPCjB1qbhzgmn7dZHsP6bsC6lBMQlTN2+IDuI
         RuZRMmw8Kfg+KaPjwe/OZdt9HTI9gAqevjdRe8TZxFY3mHFIssEvQe9hsf/rRTVGYK9b
         J5WcLej8eW0T3t/EAAVUqoH0Rui3mW/aitOmg1QLHYk9bHYapiVBe6KloVCVF/xN3OJO
         l4ObojkScQQyJq/aUjbxm9EaQqR9C4MHP9BMU2XiPHYIqZWsp0vSCyW+l7xTQH6JJxnp
         mlhw==
X-Gm-Message-State: APjAAAV9fGxDp+WXBOViD/3fbXGeMbQiJHsig5HzG05/N8XMMkpII5YG
        Mv5TP+VpEcgDkak7WlliRjY=
X-Google-Smtp-Source: APXvYqxBv96pUxmfgMQrftaFG4psDx0UQ6pg+dJPW4c2ZWiusVnPoWSeEsuxPW2mk3fqgO0+1KFlLg==
X-Received: by 2002:a63:4522:: with SMTP id s34mr86869675pga.362.1564080243954;
        Thu, 25 Jul 2019 11:44:03 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:624:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id w3sm43818257pgl.31.2019.07.25.11.43.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 11:44:03 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@suse.com, vbabka@suse.cz,
        cai@lca.pw, aryabinin@virtuozzo.com, osalvador@suse.de,
        rostedt@goodmis.org, mingo@redhat.com,
        pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH 04/10] mm/page_alloc: remove never used "order" in alloc_contig_range()
Date:   Fri, 26 Jul 2019 02:42:47 +0800
Message-Id: <20190725184253.21160-5-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725184253.21160-1-lpf.vector@gmail.com>
References: <20190725184253.21160-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "order" will never be used in alloc_contig_range(), and "order"
is a negative number is very strange. So just remove it.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 mm/page_alloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7d47af09461f..6208ebfac980 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8347,7 +8347,6 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 
 	struct compact_control cc = {
 		.nr_migratepages = 0,
-		.order = -1,
 		.zone = page_zone(pfn_to_page(start)),
 		.mode = MIGRATE_SYNC,
 		.ignore_skip_hint = true,
-- 
2.21.0

