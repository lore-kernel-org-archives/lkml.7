Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F32C072A4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62702087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfEPJmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 05:42:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38316 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfEPJmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:42:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id d18so2605153wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 02:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QVnbcHKCSN58gborHO3ol7EK02u5KFHxun0EUOWl0vk=;
        b=Fnxz87KoHSn24RCU1fjJfNgmYejiofnawWjLrb6ChDclnBS7vKx5s7V6LWhtX30VzL
         vfTotDUKm7kTD022RebfwymzA9OYmAOoB27McudDqFFAarrQdC9iUVIqCQvhmNbrtSon
         tCp2STDUEvwTEifFKOlLvTKK5Zfhb0JYPjHECFd3jiOGLI3/8JI5q7DaPSy+72fSby6R
         0MhzdpSnsgFOLKqathNy8mfSpt4M+lHUssCs2owsttjBqRVBu9StSOf+WCu+pDlAAWTg
         sATIREaEuqX+FCnDFo3AIV1ayWjSv/YGV9L1wQFKN4mrNQv2OVYB3UyDd7MgQf6HUQjl
         fTOg==
X-Gm-Message-State: APjAAAUvje7cfQLALsUeBSLyag8+TS2L8KYfTiCSw78z0s34Ae8z243q
        6xvSDWDC39k9IgRsDs48TEH5dlVh42r57w==
X-Google-Smtp-Source: APXvYqwl58jVVB/evRftpSSgIkEdQu3pDWBXBnUiYvoeLvTMFHBb+KM6NeJY7cXdaHqSSVbMh3vTNg==
X-Received: by 2002:a5d:6982:: with SMTP id g2mr13708219wru.223.1557999761707;
        Thu, 16 May 2019 02:42:41 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n63sm4614805wmn.38.2019.05.16.02.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 02:42:40 -0700 (PDT)
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
Subject: [PATCH RFC 3/5] mm/ksm: introduce ksm_madvise_unmerge() helper
Date:   Thu, 16 May 2019 11:42:32 +0200
Message-Id: <20190516094234.9116-4-oleksandr@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190516094234.9116-1-oleksandr@redhat.com>
References: <20190516094234.9116-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move MADV_UNMERGEABLE part of ksm_madvise() into a dedicated helper
since it will be further used for unmerging VMAs forcibly.

This does not bring any functional changes.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 include/linux/ksm.h |  2 ++
 mm/ksm.c            | 32 ++++++++++++++++++++++----------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index e824b3141677..a91a7cfc87a1 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -21,6 +21,8 @@ struct mem_cgroup;
 #ifdef CONFIG_KSM
 int ksm_madvise_merge(struct mm_struct *mm, struct vm_area_struct *vma,
 		unsigned long *vm_flags);
+int ksm_madvise_unmerge(struct vm_area_struct *vma, unsigned long start,
+		unsigned long end, unsigned long *vm_flags);
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags);
 int __ksm_enter(struct mm_struct *mm);
diff --git a/mm/ksm.c b/mm/ksm.c
index 1fdcf2fbd58d..e0357e25e09f 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2478,6 +2478,25 @@ int ksm_madvise_merge(struct mm_struct *mm, struct vm_area_struct *vma,
 	return 0;
 }
 
+int ksm_madvise_unmerge(struct vm_area_struct *vma, unsigned long start,
+		unsigned long end, unsigned long *vm_flags)
+{
+	int err;
+
+	if (!(*vm_flags & VM_MERGEABLE))
+		return 0;		/* just ignore the advice */
+
+	if (vma->anon_vma) {
+		err = unmerge_ksm_pages(vma, start, end);
+		if (err)
+			return err;
+	}
+
+	*vm_flags &= ~VM_MERGEABLE;
+
+	return 0;
+}
+
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags)
 {
@@ -2492,16 +2511,9 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		break;
 
 	case MADV_UNMERGEABLE:
-		if (!(*vm_flags & VM_MERGEABLE))
-			return 0;		/* just ignore the advice */
-
-		if (vma->anon_vma) {
-			err = unmerge_ksm_pages(vma, start, end);
-			if (err)
-				return err;
-		}
-
-		*vm_flags &= ~VM_MERGEABLE;
+		err = ksm_madvise_unmerge(vma, start, end, vm_flags);
+		if (err)
+			return err;
 		break;
 	}
 
-- 
2.21.0

