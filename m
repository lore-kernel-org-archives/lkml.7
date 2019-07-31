Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E50C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A74206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="D/xOlMhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbfGaPT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:19:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39569 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbfGaPTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:19:50 -0400
Received: by mail-ed1-f68.google.com with SMTP id m10so66045131edv.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dXgFqK9tRsaes8xbX8jlTX0gUbPqQYtilIkdLoU6CY4=;
        b=D/xOlMhrdU0ZyN8+we4kbni7hHuGIfv/4U4Ig0LX9ewfIEajz0z1lI9iS5QnH6yCat
         sfE6Wxgj7gCcNgGeO8sqZDkOENTjXyGaq0eGqLegmkmODaaLkPBU23YDdAqvq4s4OSxZ
         N0A8Q4QWYpmDkk2dAzVYUHeLTCw2YmNW5FYuyTsyMmseshWxSznRJue51TmL0r+h8LG/
         vb4cNBRmMjzUCNNogPHi3S31sph/SJ/M4uXMSstfF9OC/trKRR9pDG2nUWbNR9Ymsx50
         ScB2FK2fZENk5csdIp1g+R48LmIGH0MJ/LiEr5bfor9Gh3Un92wYv/649p99ZIJ8QAGO
         S6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dXgFqK9tRsaes8xbX8jlTX0gUbPqQYtilIkdLoU6CY4=;
        b=It787u3pxfm8e0YvvFz/M1H7HUgrh3ahJuUe/lGiz2arKWdtRkbWL+aCvdlKL21GcR
         8vjpmpnvEzsM3lYHfPDrW8VWh81DWCAoLFuoP+hKpW96qfzEGPUYczUUXi/8bwJUteov
         tb8rIGS4+PA/dPvuMxytF954LiwvXwglMw8xpVWBgH8h8j6hbRebFsozJViewUz4wfpL
         iUs91/YV2v+yipHgE/duJ+vtwcaModl/3utBnIuVtsWeHXRf4R31P/QBwsrwzpZefXVm
         t5ZBp+iE37bxVUwXH9Au+l/NOl4HemJ9jKqDT8kcChTXTi6FS9igd7sSR+XzpzWRdT9i
         IA/Q==
X-Gm-Message-State: APjAAAVwBo9Q+ErtuQryby+IVgfEjxFtzjVXb0kkcBOm9QSKxh3CVZ1/
        NuAWThMEDpl9znjUiC0lmM8=
X-Google-Smtp-Source: APXvYqyagj0pny7ZfrRGD/QMhFKklBkFWmGDfmQgFU5rbWlHF6yWjUkfAl5cJt9AcGs7WHAa7fbavg==
X-Received: by 2002:a50:a485:: with SMTP id w5mr108547875edb.277.1564586038641;
        Wed, 31 Jul 2019 08:13:58 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i8sm17219860edg.12.2019.07.31.08.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:13:57 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 3A5C3104604; Wed, 31 Jul 2019 18:08:17 +0300 (+03)
To:     Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        David Howells <dhowells@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 46/59] mm: Restrict MKTME memory encryption to anonymous VMAs
Date:   Wed, 31 Jul 2019 18:08:00 +0300
Message-Id: <20190731150813.26289-47-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Memory encryption is only supported for mappings that are ANONYMOUS.
Test the VMA's in an encrypt_mprotect() request to make sure they all
meet that requirement before encrypting any.

The encrypt_mprotect syscall will return -EINVAL and will not encrypt
any VMA's if this check fails.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/mprotect.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 518d75582e7b..4b079e1b2d6f 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -347,6 +347,24 @@ static int prot_none_walk(struct vm_area_struct *vma, unsigned long start,
 	return walk_page_range(start, end, &prot_none_walk);
 }
 
+/*
+ * Encrypted mprotect is only supported on anonymous mappings.
+ * If this test fails on any single VMA, the entire mprotect
+ * request fails.
+ */
+static bool mem_supports_encryption(struct vm_area_struct *vma, unsigned long end)
+{
+	struct vm_area_struct *test_vma = vma;
+
+	do {
+		if (!vma_is_anonymous(test_vma))
+			return false;
+
+		test_vma = test_vma->vm_next;
+	} while (test_vma && test_vma->vm_start < end);
+	return true;
+}
+
 int
 mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 	       unsigned long start, unsigned long end, unsigned long newflags,
@@ -533,6 +551,12 @@ static int do_mprotect_ext(unsigned long start, size_t len,
 				goto out;
 		}
 	}
+
+	if (keyid > 0 && !mem_supports_encryption(vma, end)) {
+		error = -EINVAL;
+		goto out;
+	}
+
 	if (start > vma->vm_start)
 		prev = vma;
 
-- 
2.21.0

