Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A812EC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8464F20879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfENNRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 09:17:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40379 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfENNRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:17:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so19198806wre.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 06:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ljDEI5wRVFawwIewIlFmLcuWyWda410CfkNvL+gmA1U=;
        b=gTR2zBXB1x3vvp49XaQGMIob9dDKyeZx8ZAWTyXu1HUIXMZRJDl9+zmYzjgfFo4TZz
         alkzLqmO55MOLi9n9HQyr7uHHu2ntOBwpKvsTChh9c7dodOCcxPe5X0HCLpuXXzXAL13
         /idV8j/R5CbV9Hfa7VlnmctOkSX5Lc+fCCJp/vbXP4opDb/4QQWP6wk5wVBw5okXjrqQ
         129qBFQZiATzj5oHYi4iTtH6aZAAT6Tg7MNk6Znz67PhiF4TJz87mIscCr/AiPuDxf5S
         9PIGFUuzplU5PPKXfgS0uYV8wYxYM6VRsI7vpmW4Rx0Xp3PL+BZxJdlmjv79JN405nT2
         B8Rg==
X-Gm-Message-State: APjAAAV4QpT3n9+JtNiIiRQC2IROEs+34nBom/V+HtmBTOhzPI6A4m9r
        1fM0w0d6WbaZConm4Ao4zzoOZZX4eyrmPw==
X-Google-Smtp-Source: APXvYqyoalSThS0pSE7N8sUVpxlOVAILQIDieoXie4XGja4UBj+IPrLGODtVhuz+nrtZqWL+oyjzXQ==
X-Received: by 2002:adf:b35e:: with SMTP id k30mr2739640wrd.178.1557839819722;
        Tue, 14 May 2019 06:16:59 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id u125sm7196076wme.15.2019.05.14.06.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 06:16:59 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org
Subject: [PATCH RFC v2 2/4] mm/ksm: introduce ksm_leave() helper
Date:   Tue, 14 May 2019 15:16:52 +0200
Message-Id: <20190514131654.25463-3-oleksandr@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514131654.25463-1-oleksandr@redhat.com>
References: <20190514131654.25463-1-oleksandr@redhat.com>
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
 mm/ksm.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 02fdbee394cc..e9f3901168bb 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2478,6 +2478,25 @@ static int ksm_enter(struct mm_struct *mm, struct vm_area_struct *vma,
 	return 0;
 }
 
+static int ksm_leave(struct vm_area_struct *vma, unsigned long start,
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
+		err = ksm_leave(vma, start, end, vm_flags);
+		if (err)
+			return err;
 		break;
 	}
 
-- 
2.21.0

