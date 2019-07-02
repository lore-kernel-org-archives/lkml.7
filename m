Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8880BC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE9E21848
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHjHjhpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfGBOQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:16:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36695 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfGBOQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:16:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so8326777pfl.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 07:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G8O9YGTZsZSZcNV2syt7QHGA27EpzoxaGp70ElDSGVs=;
        b=gHjHjhpuTNFRjW6geiXwx4SxHlaljBV0ZdtUgREKxzgVNiTbp3EFo3iTPJceIBR4It
         oUKt3V6ZSBWZLf5SRxftMNzHmzysU0SJG2vfqsXjHyT0kXBZISdHDSEysQFqSH6OTYJC
         rrhp4F4yUa06njImZ8H/cA0nC8QpnQi31mjRGbQ7zADeoC6KHG8p4y9jc6obk46hKGrQ
         RaWVl199RMIUZKuE3QIBIWbdMP9rmHlRrFp2/rDFUQClotk7ahVjmNy38rFo8Y9TyB7f
         kRpJa689c3ikpSC6QRhxv8C+SOPr+r81+L+4jkQ/PXpz8UvfvRFaVyU2+6TFMinUkrve
         7heA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G8O9YGTZsZSZcNV2syt7QHGA27EpzoxaGp70ElDSGVs=;
        b=XKuscXrNK258OXMVKlQ0dbZuxGZ4/S4OUElZa7xO+7jqjtbULOhTsxmeGVwbN6pPFn
         1Wkc6/Ago9XwDPYYtGIBslt17an7O1B+TjpnQsB3GB6EZHkNhtcMROUd4/eMtGj+GHW0
         SBh77rE2QqD7FSX5qzR+jFCkv6kVCBHvt7xg3CJbFg/IWgm/58I/OmMuHuYzL+IVHvPE
         p6MkNkx+wQz4/SHyjGUK3T95/tb0ygYwvoGo+sjGWOsKZ6EEi3iuQhfbvMejo/c9mfyl
         HGdFkw7vND4Mj4kRSMxUIFygYlgZGHYKJB0AWpc3ja/XrSE/RhKeVImm2U6y0qPpf3Hq
         rA6Q==
X-Gm-Message-State: APjAAAVQ4EYBeDwXaAk3IDsZB5e0BCVbUt51RMpg+vYT9tYilfvuNlCD
        auYmhN1EFBat0Z+0ERrPqS4=
X-Google-Smtp-Source: APXvYqySwVE9Fh+614x2kyb57wZjPWabmz8Qpui29yVSRTKwoZaH6ufwyye8S/75FbHZEacWu15FjQ==
X-Received: by 2002:a17:90a:e38f:: with SMTP id b15mr5996459pjz.85.1562076989286;
        Tue, 02 Jul 2019 07:16:29 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:648:b8c3:8577:bf2f:2])
        by smtp.gmail.com with ESMTPSA id a5sm744617pjv.21.2019.07.02.07.16.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 07:16:28 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org, peterz@infradead.org, urezki@gmail.com
Cc:     rpenyaev@suse.de, mhocko@suse.com, guro@fb.com,
        aryabinin@virtuozzo.com, rppt@linux.ibm.com, mingo@kernel.org,
        rick.p.edgecombe@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v2 3/5] mm/vmalloc.c: Rename function __find_vmap_area() for readability
Date:   Tue,  2 Jul 2019 22:15:39 +0800
Message-Id: <20190702141541.12635-4-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702141541.12635-1-lpf.vector@gmail.com>
References: <20190702141541.12635-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function __find_vmap_area to __search_va_in_busy_tree to
indicate that it is searching in the *BUSY* tree.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 mm/vmalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a5065fcb74d3..b6ea52d6e8f9 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -399,7 +399,7 @@ static void purge_vmap_area_lazy(void);
 static BLOCKING_NOTIFIER_HEAD(vmap_notify_list);
 static unsigned long lazy_max_pages(void);
 
-static struct vmap_area *__find_vmap_area(unsigned long addr)
+static struct vmap_area *__search_va_in_busy_tree(unsigned long addr)
 {
 	struct rb_node *n = vmap_area_root.rb_node;
 
@@ -1313,7 +1313,7 @@ static struct vmap_area *find_vmap_area(unsigned long addr)
 	struct vmap_area *va;
 
 	spin_lock(&vmap_area_lock);
-	va = __find_vmap_area(addr);
+	va = __search_va_in_busy_tree(addr);
 	spin_unlock(&vmap_area_lock);
 
 	return va;
-- 
2.21.0

