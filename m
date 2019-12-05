Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E93C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7B022525
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="TdxvDXVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfLEOEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:04:23 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45470 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbfLEOEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:04:22 -0500
Received: by mail-pl1-f196.google.com with SMTP id w7so1286427plz.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 06:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U+rYuarcFGCelyfsuzmoID8VbDpvPXs1LM8fcwC/sPE=;
        b=TdxvDXVFzR+61ypb+pkDPPMEjQCXeQyzL1jbq0HfNnf8R45+X/Tq1+GrRUfToFVMhr
         Zk+sUDBIx4cA3P46G2dqpvqsZdm7TNnQh1XTTXYyolmD+fjA6wViiPUD72sS0R4Xqa1e
         UG9/MvphoVnmZ8fE5uTs25ux3qgptunBk+NLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U+rYuarcFGCelyfsuzmoID8VbDpvPXs1LM8fcwC/sPE=;
        b=MSW67EmtFWyxJtIrj3iI3NGZGByUBszTe5WenexSyYDKi/xXnrJqiOJEX8Bpgj8vfM
         xxhbrekPm3e0XzWt7cT6pp9oKAeUuaivD4aE8VdxWd3s/vNDkogc6IElquEcCZqcr3oH
         ngynwDT0CaHLF1q3I0DOyHNKC6DoNrWx0Qv3Quu12aNCl/CZTTonsenpRVuAHvoP64O+
         l9/6WoQAtorT1WcoNL10h1LsC/jJ9jhjleYwu0JJxULn45e6m9OXfCFAroRBTkgDeANw
         I24HRV1BR13Pi7wA/WfVSIpdz7o2dmXAwIXnU5EEKKJKtyaKlg1QO2V8TN5hW9iLFrGD
         LttQ==
X-Gm-Message-State: APjAAAUPS0/5iRXDNmv+nI6v1EqieteKfzm4M8zm25Xp6LoIgoZB6sBL
        b4U8+hE6iJdZMpcwJlMAoJOsOA==
X-Google-Smtp-Source: APXvYqxVDhF8ueI6xXs6y+EV68T16oJerbdtvwULNuHUTWfYDLhkt+8b64AvbBxFH7IT4ww5pVig1w==
X-Received: by 2002:a17:902:904b:: with SMTP id w11mr5268735plz.204.1575554661870;
        Thu, 05 Dec 2019 06:04:21 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-61b9-031c-bed1-3502.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:61b9:31c:bed1:3502])
        by smtp.gmail.com with ESMTPSA id q67sm5745928pjb.4.2019.12.05.06.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 06:04:21 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        aryabinin@virtuozzo.com, glider@google.com,
        linux-kernel@vger.kernel.org, dvyukov@google.com
Cc:     daniel@iogearbox.net, cai@lca.pw, Daniel Axtens <dja@axtens.net>,
        syzbot+82e323920b78d54aaed5@syzkaller.appspotmail.com,
        syzbot+59b7daa4315e07a994f1@syzkaller.appspotmail.com
Subject: [PATCH 3/3] kasan: don't assume percpu shadow allocations will succeed
Date:   Fri,  6 Dec 2019 01:04:07 +1100
Message-Id: <20191205140407.1874-3-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191205140407.1874-1-dja@axtens.net>
References: <20191205140407.1874-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzkaller and the fault injector showed that I was wrong to assume
that we could ignore percpu shadow allocation failures.

Handle failures properly. Merge all the allocated areas back into the free
list and release the shadow, then clean up and return NULL. The shadow
is released unconditionally, which relies upon the fact that the release
function is able to tolerate pages not being present.

Also clean up shadows in the recovery path - currently they are not
released, which leaks a bit of memory.

Fixes: 3c5c3cfb9ef4 ("kasan: support backing vmalloc space with real shadow memory")
Reported-by: syzbot+82e323920b78d54aaed5@syzkaller.appspotmail.com
Reported-by: syzbot+59b7daa4315e07a994f1@syzkaller.appspotmail.com
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 mm/vmalloc.c | 48 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 37af94b6cf30..fa5688093a88 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3291,7 +3291,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 	struct vmap_area **vas, *va;
 	struct vm_struct **vms;
 	int area, area2, last_area, term_area;
-	unsigned long base, start, size, end, last_end;
+	unsigned long base, start, size, end, last_end, orig_start, orig_end;
 	bool purged = false;
 	enum fit_type type;
 
@@ -3421,6 +3421,15 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 
 	spin_unlock(&free_vmap_area_lock);
 
+	/* populate the kasan shadow space */
+	for (area = 0; area < nr_vms; area++) {
+		if (kasan_populate_vmalloc(vas[area]->va_start, sizes[area]))
+			goto err_free_shadow;
+
+		kasan_unpoison_vmalloc((void *)vas[area]->va_start,
+				       sizes[area]);
+	}
+
 	/* insert all vm's */
 	spin_lock(&vmap_area_lock);
 	for (area = 0; area < nr_vms; area++) {
@@ -3431,13 +3440,6 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 	}
 	spin_unlock(&vmap_area_lock);
 
-	/* populate the shadow space outside of the lock */
-	for (area = 0; area < nr_vms; area++) {
-		/* assume success here */
-		kasan_populate_vmalloc(vas[area]->va_start, sizes[area]);
-		kasan_unpoison_vmalloc((void *)vms[area]->addr, sizes[area]);
-	}
-
 	kfree(vas);
 	return vms;
 
@@ -3449,8 +3451,12 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 	 * and when pcpu_get_vm_areas() is success.
 	 */
 	while (area--) {
-		merge_or_add_vmap_area(vas[area], &free_vmap_area_root,
-				       &free_vmap_area_list);
+		orig_start = vas[area]->va_start;
+		orig_end = vas[area]->va_end;
+		va = merge_or_add_vmap_area(vas[area], &free_vmap_area_root,
+					    &free_vmap_area_list);
+		kasan_release_vmalloc(orig_start, orig_end,
+				      va->va_start, va->va_end);
 		vas[area] = NULL;
 	}
 
@@ -3485,6 +3491,28 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 	kfree(vas);
 	kfree(vms);
 	return NULL;
+
+err_free_shadow:
+	spin_lock(&free_vmap_area_lock);
+	/*
+	 * We release all the vmalloc shadows, even the ones for regions that
+	 * hadn't been successfully added. This relies on kasan_release_vmalloc
+	 * being able to tolerate this case.
+	 */
+	for (area = 0; area < nr_vms; area++) {
+		orig_start = vas[area]->va_start;
+		orig_end = vas[area]->va_end;
+		va = merge_or_add_vmap_area(vas[area], &free_vmap_area_root,
+					    &free_vmap_area_list);
+		kasan_release_vmalloc(orig_start, orig_end,
+				      va->va_start, va->va_end);
+		vas[area] = NULL;
+		kfree(vms[area]);
+	}
+	spin_unlock(&free_vmap_area_lock);
+	kfree(vas);
+	kfree(vms);
+	return NULL;
 }
 
 /**
-- 
2.20.1

