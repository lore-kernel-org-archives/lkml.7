Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AC4C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E99921670
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="nD1A5jPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfH3AkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 20:40:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39305 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfH3AkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 20:40:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id a67so40779pfa.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 17:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=82Q/JFIZnRXp0gOKtGutBaFqGjeRYEXgiO+lMUV240Y=;
        b=nD1A5jPvsIP89nHBMvBHrNI1GqT/PDiCf4jxHaCbxxEnlAXlcBW7mkvaA6ZVlmKfzS
         NkBfs1H94Zz4smL76mncvLsIszMvMwN8JXpr2ZJU31OBYDVyPNcshJZWBWPg9+gdAgSF
         w4aZZ3y1NslYt7ctZc5tXH2Vuybo+Jx53VCXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=82Q/JFIZnRXp0gOKtGutBaFqGjeRYEXgiO+lMUV240Y=;
        b=SQ6mISxDr+1VuZX8YUn1jLmrm/pGoJ1xfzTRBPSdzeLebTG9m6TO7rLrrNLH5zkz4e
         6cSUlxXLzufherxIicz4Z62YplnROFd8VNh9+PH7HZP2RiMsxuuN15tyk6oIWzU/WluY
         hmqXYOrKAILcNus4WMUVq67WQ9UvvrinfQCxP8uoJFK1wdvjO1cXpx6kOkkvg3xfgvUA
         vZ/aDhQplQmBMA9X4feSIYmAmi57grQYF2kZJgt6Y4TuCXckzLeXMTk/Xo4RkPPvAEVT
         YxPg4C2spUXxGFYewn0W9frfcQMZKxvXjvEcNLtxv5CuXTRKAZrGNMNquud1Nxks0YCW
         T/HA==
X-Gm-Message-State: APjAAAXtvt2qDyR1akociz39fH0F1f8/b5jYkDbZ1MrIBazbB63uj3Vd
        fK1ZMDGpMmFZwpUW5aTJ3Ki7xQ==
X-Google-Smtp-Source: APXvYqzNoJGYFrsnYDroRSYoteG3iJDXlHgkj88MSgz63Rrn0+nV1EyQWSk/4Z2CmdbFPGnpPD4GHg==
X-Received: by 2002:a63:1908:: with SMTP id z8mr10423041pgl.433.1567125606413;
        Thu, 29 Aug 2019 17:40:06 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id b19sm3452810pgs.10.2019.08.29.17.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 17:40:05 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v5 5/5] kasan debug: track pages allocated for vmalloc shadow
Date:   Fri, 30 Aug 2019 10:38:21 +1000
Message-Id: <20190830003821.10737-6-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190830003821.10737-1-dja@axtens.net>
References: <20190830003821.10737-1-dja@axtens.net>
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
index c12a2e6ecff5..69f32f2857b0 100644
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
@@ -833,6 +837,7 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
 
 	pte_clear(&init_mm, addr, ptep);
 	free_page(page);
+	vmalloc_shadow_pages--;
 	spin_unlock(&init_mm.page_table_lock);
 
 	return 0;
@@ -887,4 +892,25 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
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

