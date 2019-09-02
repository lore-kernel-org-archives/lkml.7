Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FF9C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 11:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFF821883
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 11:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="lJn2ZoGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbfIBLWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 07:22:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44577 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730207AbfIBLWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 07:22:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so6487175plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 04:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rhvVAb+7J0RMzU60BoXrtVVNGscRpJk5bY5+hc+pgTs=;
        b=lJn2ZoGmqXvNOJ2GxqOHlg6gynw3icF854gnf2fdkeE0C1KypDYUziQiRDkZOFXzSt
         zK6v1cmSzkPiqdxZzYsmcE9mgSUk9zesoGV/S6xbSjxAnTZOWTpnmGigvZ+QfyuOa6ph
         ngh/RxBH/bEhzFLW53FQ4dmuIPmMmMb9Ti82U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rhvVAb+7J0RMzU60BoXrtVVNGscRpJk5bY5+hc+pgTs=;
        b=WOBPHVTl2OYpvsbZDfpGdPDhqQtAfMeA8nlYJPap+jTQYRuLP6ipBs/7IdpbqzuOOa
         UGqCgAYVUnelaWSx/i4UDxkZ3KX/0zq4ge2dQozMxwVKZLgP+o9YFeXN/BdnjguNOC1R
         ndj/0mxo5BZFS1MsD3BGHc2nU2/nnAz3kDEWC0v2FXTcBNfgySNo/9pN47VLtMFwd7uU
         vPJShQ1BxVZEAQUAxWO6uqoF062lOlCDIf8tmGwFnXRHYUGdoM8PLEvsVrPDqYBsNjTB
         CIbKQjnwtgXyclKP9Z03Ok/7nfL1Mxo8icyfZTe+tiezS+uwxGVx9e0XF5nr6ohsafiL
         effw==
X-Gm-Message-State: APjAAAV/z3WBHu+xvBFb/ZPNL/F/ZotCyf2h7rsqAzH6mvBPLAefqHx+
        1g4srOr0WVQN2kNqT2+tw5nfTg==
X-Google-Smtp-Source: APXvYqx8sWsJ0Dzj+XlOGkClIeselhraeNCbICc/NGLkgtHjuqQppEXsadh9Ra2gh550ahw6zC+osQ==
X-Received: by 2002:a17:902:74c7:: with SMTP id f7mr25317727plt.263.1567423328350;
        Mon, 02 Sep 2019 04:22:08 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id x10sm11662494pjo.4.2019.09.02.04.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 04:22:07 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v6 5/5] kasan debug: track pages allocated for vmalloc shadow
Date:   Mon,  2 Sep 2019 21:20:28 +1000
Message-Id: <20190902112028.23773-6-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902112028.23773-1-dja@axtens.net>
References: <20190902112028.23773-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the current number of vmalloc shadow pages in
/sys/kernel/debug/kasan_vmalloc/shadow_pages.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

Merging this is probably overkill, but I leave it to the discretion
of the broader community.

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

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 0b5141108cdc..fae3cf4ab23a 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -35,6 +35,7 @@
 #include <linux/vmalloc.h>
 #include <linux/bug.h>
 #include <linux/uaccess.h>
+#include <linux/debugfs.h>
 
 #include "kasan.h"
 #include "../slab.h"
@@ -748,6 +749,8 @@ core_initcall(kasan_memhotplug_init);
 #endif
 
 #ifdef CONFIG_KASAN_VMALLOC
+static u64 vmalloc_shadow_pages;
+
 static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
 				      void *unused)
 {
@@ -774,6 +777,7 @@ static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
 	if (likely(pte_none(*ptep))) {
 		set_pte_at(&init_mm, addr, ptep, pte);
 		page = 0;
+		vmalloc_shadow_pages++;
 	}
 	spin_unlock(&init_mm.page_table_lock);
 	if (page)
@@ -827,6 +831,7 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
 	if (likely(!pte_none(*ptep))) {
 		pte_clear(&init_mm, addr, ptep);
 		free_page(page);
+		vmalloc_shadow_pages--;
 	}
 	spin_unlock(&init_mm.page_table_lock);
 
@@ -882,4 +887,25 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 				    (unsigned long)(shadow_end - shadow_start),
 				    kasan_depopulate_vmalloc_pte, NULL);
 }
+
+static __init int kasan_init_vmalloc_debugfs(void)
+{
+	struct dentry *root, *count;
+
+	root = debugfs_create_dir("kasan_vmalloc", NULL);
+	if (IS_ERR(root)) {
+		if (PTR_ERR(root) == -ENODEV)
+			return 0;
+		return PTR_ERR(root);
+	}
+
+	count = debugfs_create_u64("shadow_pages", 0444, root,
+				   &vmalloc_shadow_pages);
+
+	if (IS_ERR(count))
+		return PTR_ERR(root);
+
+	return 0;
+}
+late_initcall(kasan_init_vmalloc_debugfs);
 #endif
-- 
2.20.1

