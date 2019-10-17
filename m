Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1EFFA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A3321D80
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="kPLzGqgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406914AbfJQBZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 21:25:39 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36988 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394713AbfJQBZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 21:25:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id u20so295272plq.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 18:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OYfGHq7Ua8XlIFWVnYrWlfnb+Qaiu3AuIcv4KZ3ENBU=;
        b=kPLzGqggNUsPFDxV/H8ftNKVOlHtZarUZ2uO5M1Cl+hwXsMbW/vTrWwIjhfQ+3DWYJ
         BAJOSuNbGvc+wZSDF5mXHgUtEzM/UBmDJTY+ncpQRCjrnopVjD47CaQs12J79yMzbmaJ
         2HoVzjwx6/PntMBB3luM9yU1+3Xh96sr83vp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OYfGHq7Ua8XlIFWVnYrWlfnb+Qaiu3AuIcv4KZ3ENBU=;
        b=UD4suJEqKZfRGPt/1W4gpN97HXqeQG0hgkxWDbNFbsQVJavfO/gr0P3kYjs3YJwFfG
         I/GrSZIPNGzsbhnASnIpkI/DPqQOVGkC/KxiIzTmYO0wdgsvTB81B5NzaVtA/290wA7O
         cAJ4qhPBLPGRNiSvukfbb2RVGjUB3NYubkuwIrWksKa5wmdTZvGfNARLajHC5cIVLKqP
         /RAef+UBAc7fw1ISw1NYXBHq+nXunD5/4B8dpO2atPNsZizOpWUDe/TT67LByEHQNFGF
         RXDWvaInWfK8Q107UILVXP7tsCGp5cGLxA2aoF1WUTfgTUlpSePFIM704MMayakqFIS5
         roXA==
X-Gm-Message-State: APjAAAWf+QKbv4S0ERp6YQgKPMQL1oi2huO8TTAqXvhpX9EMWSLVsE3u
        z5WnanY8jWAI2+X6YB+PoR1qfA==
X-Google-Smtp-Source: APXvYqwQlBhRRBicY30cw6VPEISaJYd+4/odDPgj5HED+MoQwNbayPMmtq4wGs1t8T3sUU1Hp+309g==
X-Received: by 2002:a17:902:8ec1:: with SMTP id x1mr1189452plo.314.1571275537371;
        Wed, 16 Oct 2019 18:25:37 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id d4sm381964pjs.9.2019.10.16.18.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 18:25:36 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v9 5/5] kasan debug: track pages allocated for vmalloc shadow
Date:   Thu, 17 Oct 2019 12:25:06 +1100
Message-Id: <20191017012506.28503-6-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017012506.28503-1-dja@axtens.net>
References: <20191017012506.28503-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the current number of vmalloc shadow pages in
/sys/kernel/debug/kasan/vmalloc_shadow_pages.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

v8: rename kasan_vmalloc/shadow_pages -> kasan/vmalloc_shadow_pages

On v4 (no dynamic freeing), I saw the following approximate figures
on my test VM:

 - fresh boot: 720
 - after test_vmalloc: ~14000

With v5 (lazy dynamic freeing):

 - boot: ~490-500
 - running modprobe test_vmalloc pushes the figures up to sometimes
    as high as ~14000, but they drop down to ~560 after the test ends.
    I'm not sure where the extra sixty pages are from, but running the
    test repeately doesn't cause the number to keep growing, so I don't
    think we're leaking.
 - with vmap_stack, spawning tasks pushes the figure up to ~4200, then
    some clearing kicks in and drops it down to previous levels again.
---
 mm/kasan/common.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git mm/kasan/common.c mm/kasan/common.c
index 81521d180bec..ac05038afa5a 100644
--- mm/kasan/common.c
+++ mm/kasan/common.c
@@ -35,6 +35,7 @@
 #include <linux/vmalloc.h>
 #include <linux/bug.h>
 #include <linux/uaccess.h>
+#include <linux/debugfs.h>
 
 #include <asm/tlbflush.h>
 
@@ -750,6 +751,8 @@ core_initcall(kasan_memhotplug_init);
 #endif
 
 #ifdef CONFIG_KASAN_VMALLOC
+static u64 vmalloc_shadow_pages;
+
 static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
 				      void *unused)
 {
@@ -782,6 +785,7 @@ static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
 	if (likely(pte_none(*ptep))) {
 		set_pte_at(&init_mm, addr, ptep, pte);
 		page = 0;
+		vmalloc_shadow_pages++;
 	}
 	spin_unlock(&init_mm.page_table_lock);
 	if (page)
@@ -836,6 +840,7 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
 		pte_clear(&init_mm, addr, ptep);
 		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 		free_page(page);
+		vmalloc_shadow_pages--;
 	}
 	spin_unlock(&init_mm.page_table_lock);
 
@@ -954,4 +959,25 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 				       (unsigned long)shadow_end);
 	}
 }
+
+static __init int kasan_init_debugfs(void)
+{
+	struct dentry *root, *count;
+
+	root = debugfs_create_dir("kasan", NULL);
+	if (IS_ERR(root)) {
+		if (PTR_ERR(root) == -ENODEV)
+			return 0;
+		return PTR_ERR(root);
+	}
+
+	count = debugfs_create_u64("vmalloc_shadow_pages", 0444, root,
+				   &vmalloc_shadow_pages);
+
+	if (IS_ERR(count))
+		return PTR_ERR(root);
+
+	return 0;
+}
+late_initcall(kasan_init_debugfs);
 #endif
-- 
2.20.1

