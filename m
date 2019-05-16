Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1CDC04E87
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1622082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfEPJmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 05:42:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42031 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfEPJml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:42:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id l2so2581083wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 02:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YN77z8gKHSuM2XjFecvZy0A0ECsUV7zC1Q0pr8QKOlY=;
        b=LWXVQ4+rw2+WsSxSQ0vLiMGKboRCkPzcSkIqBRPGiRKYra/knfmMR5Q+vaVUPSn6Iy
         xp/Y4ZKQelsS7F8wHkDMhd/aCI4Y4LpFRX5vqG3OZd3fPP1DdFBswNVmG4CrO6bVb8lN
         FkFpN/nmCH7CMFfjeSyLZ9SAXW2QHMN69FmN2ZoOrRj2NiOyoJmzYCkv2mrlJSEAVaMw
         /ECL9GTeydLcDn2v+Gy+BshHEOereDCOkCfxJLJlhvO1UVE7a17hbLS6eSSaGIMXVgxd
         BtopE18tR9t69vZN5btKKktVSAsGYrR8I9GUTbHzVvMi7NbaJwsbzH3PXxZQtnCYWPzo
         MwzQ==
X-Gm-Message-State: APjAAAUAcqZJNJBnFFpy3zbPYqQSmpiVV0kKbhyhEbqkoW0hiEkPSGOf
        czTgV9cUxQkHs8zJMihNQaWrIY0TqBCukA==
X-Google-Smtp-Source: APXvYqys469LpVWfYxPlfxZW3I0nW/iuorQWcrS5tP7pLu+XZ/hJioroCE9kOeMmFNuO1N+8Ds8oZA==
X-Received: by 2002:adf:f9c3:: with SMTP id w3mr20196436wrr.271.1557999759998;
        Thu, 16 May 2019 02:42:39 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s3sm7204729wre.97.2019.05.16.02.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 02:42:39 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Greg KH <greg@kroah.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: [PATCH RFC 2/5] mm/ksm: introduce ksm_madvise_merge() helper
Date:   Thu, 16 May 2019 11:42:31 +0200
Message-Id: <20190516094234.9116-3-oleksandr@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190516094234.9116-1-oleksandr@redhat.com>
References: <20190516094234.9116-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move MADV_MERGEABLE part of ksm_madvise() into a dedicated helper since
it will be further used for marking VMAs to be merged forcibly.

This does not bring any functional changes.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 include/linux/ksm.h |  2 ++
 mm/ksm.c            | 60 +++++++++++++++++++++++++++------------------
 2 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index e48b1e453ff5..e824b3141677 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -19,6 +19,8 @@ struct stable_node;
 struct mem_cgroup;
 
 #ifdef CONFIG_KSM
+int ksm_madvise_merge(struct mm_struct *mm, struct vm_area_struct *vma,
+		unsigned long *vm_flags);
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags);
 int __ksm_enter(struct mm_struct *mm);
diff --git a/mm/ksm.c b/mm/ksm.c
index fc64874dc6f4..1fdcf2fbd58d 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2442,41 +2442,53 @@ static int ksm_scan_thread(void *nothing)
 	return 0;
 }
 
-int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
-		unsigned long end, int advice, unsigned long *vm_flags)
+int ksm_madvise_merge(struct mm_struct *mm, struct vm_area_struct *vma,
+		unsigned long *vm_flags)
 {
-	struct mm_struct *mm = vma->vm_mm;
 	int err;
 
-	switch (advice) {
-	case MADV_MERGEABLE:
-		/*
-		 * Be somewhat over-protective for now!
-		 */
-		if (*vm_flags & (VM_MERGEABLE | VM_SHARED  | VM_MAYSHARE   |
-				 VM_PFNMAP    | VM_IO      | VM_DONTEXPAND |
-				 VM_HUGETLB | VM_MIXEDMAP))
-			return 0;		/* just ignore the advice */
+	/*
+	 * Be somewhat over-protective for now!
+	 */
+	if (*vm_flags & (VM_MERGEABLE | VM_SHARED  | VM_MAYSHARE   |
+			 VM_PFNMAP    | VM_IO      | VM_DONTEXPAND |
+			 VM_HUGETLB | VM_MIXEDMAP))
+		return 0;		/* just ignore the advice */
 
-		if (vma_is_dax(vma))
-			return 0;
+	if (vma_is_dax(vma))
+		return 0;
 
 #ifdef VM_SAO
-		if (*vm_flags & VM_SAO)
-			return 0;
+	if (*vm_flags & VM_SAO)
+		return 0;
 #endif
 #ifdef VM_SPARC_ADI
-		if (*vm_flags & VM_SPARC_ADI)
-			return 0;
+	if (*vm_flags & VM_SPARC_ADI)
+		return 0;
 #endif
 
-		if (!test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
-			err = __ksm_enter(mm);
-			if (err)
-				return err;
-		}
+	if (!test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
+		err = __ksm_enter(mm);
+		if (err)
+			return err;
+	}
+
+	*vm_flags |= VM_MERGEABLE;
+
+	return 0;
+}
 
-		*vm_flags |= VM_MERGEABLE;
+int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
+		unsigned long end, int advice, unsigned long *vm_flags)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	int err;
+
+	switch (advice) {
+	case MADV_MERGEABLE:
+		err = ksm_madvise_merge(mm, vma, vm_flags);
+		if (err)
+			return err;
 		break;
 
 	case MADV_UNMERGEABLE:
-- 
2.21.0

