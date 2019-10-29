Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9866ECA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 04:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4472087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 04:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="q37hvvFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731616AbfJ2EVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 00:21:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46439 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731591AbfJ2EV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 00:21:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id f19so8565205pgn.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 21:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E6G/cbdwI55VRIDPH2MzPtSSwLNnlVDKj+xUqyB9XvU=;
        b=q37hvvFEaBAuDhdw8f9RGZPAKbEe6zMTpH1vieG+zpL2j/QDs8RghoIx9JE+q4QWze
         TAruY1QMB+c1d5affF47SiBVcB02uLSf31ZZ6pl18sMLuLqjyMUqrZhipq3ZGdu16JlP
         nJAdQq+06ElZPTzvTwKeK7V2Y0q4KaKOeZi5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E6G/cbdwI55VRIDPH2MzPtSSwLNnlVDKj+xUqyB9XvU=;
        b=mVDj97l6GQkvqnqfzm27WuYG8zksnQRj51hq+RnsjbSfgegSGh9Vf7Iyv4bqTtAutO
         jGMJ5Tg6JrlnKVb9iS/oVcDxY/LF0f8oAayASDz/JGobuqSJsN82FxG11ydg1BrrsitN
         tEnTRAaBPOXSTTvJ2zQjR/Ik5Kn8GzUp62HX+IVY3bGKH2EBtvWoqLXpvBK1Xpl7XzYG
         XsjubDBVYwajQX7sT6aG5plp309TR7wxPOF9FihscFS1usWsmB544Q14EDRjqZQHFxAs
         eHQSPkXEK01IuELfTagCe15TV+lHpFpRjzmdggPsWrCkpV6hG2L/wHv1FJdhF2zyEo6Y
         mF0Q==
X-Gm-Message-State: APjAAAV+XjEn6bUYesrfnt3iJMlkuUaOfC9ruxAPH3iTMTmFZxOFLPz4
        RyMz9ZHAPG32BqtGYujV3jgHog==
X-Google-Smtp-Source: APXvYqxNDS1dIEPkNBGrfTraoXwMKGGsjqxNiWzOEOkJlq5Mx5SitV2hc6VnXEFqIfQN/nkn2AOfVQ==
X-Received: by 2002:a63:e60b:: with SMTP id g11mr23118732pgh.119.1572322888371;
        Mon, 28 Oct 2019 21:21:28 -0700 (PDT)
Received: from localhost ([2001:44b8:802:1120:783a:2bb9:f7cb:7c3c])
        by smtp.gmail.com with ESMTPSA id z4sm957607pjt.20.2019.10.28.21.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 21:21:27 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v10 5/5] kasan debug: track pages allocated for vmalloc shadow
Date:   Tue, 29 Oct 2019 15:20:59 +1100
Message-Id: <20191029042059.28541-6-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191029042059.28541-1-dja@axtens.net>
References: <20191029042059.28541-1-dja@axtens.net>
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

v10: rebase on linux-next/master.

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
 mm/kasan/common.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 6e7bc5d3fa83..a4b5c64da16f 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
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
@@ -770,6 +773,7 @@ static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
 	if (likely(pte_none(*ptep))) {
 		set_pte_at(&init_mm, addr, ptep, pte);
 		page = 0;
+		vmalloc_shadow_pages++;
 	}
 	spin_unlock(&init_mm.page_table_lock);
 	if (page)
@@ -858,6 +862,7 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
 	if (likely(!pte_none(*ptep))) {
 		pte_clear(&init_mm, addr, ptep);
 		free_page(page);
+		vmalloc_shadow_pages--;
 	}
 	spin_unlock(&init_mm.page_table_lock);
 
@@ -974,4 +979,22 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 				       (unsigned long)shadow_end);
 	}
 }
+
+static __init int kasan_init_debugfs(void)
+{
+	struct dentry *root;
+
+	root = debugfs_create_dir("kasan", NULL);
+	if (IS_ERR(root)) {
+		if (PTR_ERR(root) == -ENODEV)
+			return 0;
+		return PTR_ERR(root);
+	}
+
+	debugfs_create_u64("vmalloc_shadow_pages", 0444, root,
+			   &vmalloc_shadow_pages);
+
+	return 0;
+}
+late_initcall(kasan_init_debugfs);
 #endif
-- 
2.20.1

