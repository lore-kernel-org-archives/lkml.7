Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9077C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DF8217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfEJHVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 03:21:32 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35804 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfEJHVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 03:21:30 -0400
Received: by mail-qk1-f196.google.com with SMTP id c15so3092133qkl.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 00:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qzOAoH/TNvXjcpwg8Oz/fc8MXlS07T4EqVnD2ZBjw6A=;
        b=A0KYrft1OCnl5OcsAOo9h1AxVu+oBfn/0hSqwsIjP05X/D35h8rl5F24hweAQl9X6L
         +PMvq6MqWjYapj8iGqmCrpmi92o7hTWGV73YL935T1jw+IPQLawXBduXaEtXeEt89ZV+
         E2XIn5ycOiOr/GSFgudPExOKT1UJWttikvjKibfeXkqQtdWYLhiqsPDuxXpLOEY5yr1Y
         AVIsYYQ6iP0GZQrT+GnDMvLrIbihhBk53Imnz93SWJIjGb/4p42Pw0lGX65FXbLConCd
         /m/f0Oq2B2JycUOIEcylqWKRRq++YY+AR8aHAg2Zz/ekzzIcCJaeuJqXS60rqZre/U5Q
         NGXg==
X-Gm-Message-State: APjAAAXYiBKZjw53mgUpQGDTLA0cCRybRWiVJ5O/CZhcym/ZPxi9wqlW
        APzUQXXKejbkb5FSwcequ0Od+p0tjTg5hw==
X-Google-Smtp-Source: APXvYqwKpqIkvTy6CiBwHKtkH71OJTdUzb+Ov2Uf7B01EGgr+mZM24+4w2juFKcB1sGHGd3S+eq7hw==
X-Received: by 2002:a37:648d:: with SMTP id y135mr7656118qkb.237.1557472889756;
        Fri, 10 May 2019 00:21:29 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i92sm2579667qtb.44.2019.05.10.00.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 00:21:29 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>, linux-mm@kvack.org
Subject: [PATCH RFC 1/4] mm/ksm: introduce ksm_enter() helper
Date:   Fri, 10 May 2019 09:21:22 +0200
Message-Id: <20190510072125.18059-2-oleksandr@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190510072125.18059-1-oleksandr@redhat.com>
References: <20190510072125.18059-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move MADV_MERGEABLE part of ksm_madvise() into a dedicated helper since
it will be further used in do_anonymous_page().

This does not bring any functional changes.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 include/linux/ksm.h |  2 ++
 mm/ksm.c            | 66 ++++++++++++++++++++++++++-------------------
 2 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index e48b1e453ff5..bc13f228e2ed 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -21,6 +21,8 @@ struct mem_cgroup;
 #ifdef CONFIG_KSM
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags);
+int ksm_enter(struct mm_struct *mm, struct vm_area_struct *vma,
+		unsigned long *vm_flags);
 int __ksm_enter(struct mm_struct *mm);
 void __ksm_exit(struct mm_struct *mm);
 
diff --git a/mm/ksm.c b/mm/ksm.c
index fc64874dc6f4..a6b0788a3a22 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2450,33 +2450,9 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 
 	switch (advice) {
 	case MADV_MERGEABLE:
-		/*
-		 * Be somewhat over-protective for now!
-		 */
-		if (*vm_flags & (VM_MERGEABLE | VM_SHARED  | VM_MAYSHARE   |
-				 VM_PFNMAP    | VM_IO      | VM_DONTEXPAND |
-				 VM_HUGETLB | VM_MIXEDMAP))
-			return 0;		/* just ignore the advice */
-
-		if (vma_is_dax(vma))
-			return 0;
-
-#ifdef VM_SAO
-		if (*vm_flags & VM_SAO)
-			return 0;
-#endif
-#ifdef VM_SPARC_ADI
-		if (*vm_flags & VM_SPARC_ADI)
-			return 0;
-#endif
-
-		if (!test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
-			err = __ksm_enter(mm);
-			if (err)
-				return err;
-		}
-
-		*vm_flags |= VM_MERGEABLE;
+		err = ksm_enter(mm, vma, vm_flags);
+		if (err)
+			return err;
 		break;
 
 	case MADV_UNMERGEABLE:
@@ -2496,6 +2472,42 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 	return 0;
 }
 
+int ksm_enter(struct mm_struct *mm, struct vm_area_struct *vma,
+		unsigned long *vm_flags)
+{
+	int err;
+
+	/*
+	 * Be somewhat over-protective for now!
+	 */
+	if (*vm_flags & (VM_MERGEABLE | VM_SHARED  | VM_MAYSHARE   |
+			 VM_PFNMAP    | VM_IO      | VM_DONTEXPAND |
+			 VM_HUGETLB | VM_MIXEDMAP))
+		return 0;		/* just ignore the advice */
+
+	if (vma_is_dax(vma))
+		return 0;
+
+#ifdef VM_SAO
+	if (*vm_flags & VM_SAO)
+		return 0;
+#endif
+#ifdef VM_SPARC_ADI
+	if (*vm_flags & VM_SPARC_ADI)
+		return 0;
+#endif
+
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
+
 int __ksm_enter(struct mm_struct *mm)
 {
 	struct mm_slot *mm_slot;
-- 
2.21.0

