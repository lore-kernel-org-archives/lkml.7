Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD10C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06BC208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="bZcGmOHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfGaPTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:19:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33038 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbfGaPTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:19:04 -0400
Received: by mail-ed1-f68.google.com with SMTP id i11so2556934edq.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EvEqqoCYvSiaJViGsfZgvE8wYjGeg4BQWYRIZAIdYOQ=;
        b=bZcGmOHwm0gi6j5t/BbUGsKtOCIZr4doGxyXBg+bAsntyv91YXoAwS8iK8gYH/2Rhd
         EZoLChmRluivD3XLirlmMT5W1vFicn0Th6yRJbjlvSCthP29u5r3kvQbgKOL0NnWdm5O
         z6WKnsGxsng9YOVJ6s+hk1x3ysUEVhPOmeDyo07xX324wqjHjFQ9yfcsBJPs6sEkZfG/
         j1P95OYBR2KAtJYWJH/9fdcbulUD7i7ZdBv1U7AlRZ5qi7KMU65oMM+umaihE2hREq1N
         HFgl1iVKn4xa5Uwqe5PFQO1apPGzMbp3tx+aOQoTXOpVFI0CqNnOhoaQyl+Z3LmysdM7
         SIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EvEqqoCYvSiaJViGsfZgvE8wYjGeg4BQWYRIZAIdYOQ=;
        b=UkCg8d7ZijlSYT667GRMK0qD+bBn3GKhAIzoPmcsd3hm5GlWP/h1aCjPam0NH+2i1S
         9Pv4Q0FJLINVTKEYQC1heWv05mtxwTAtTpiuW7MEMMUuCsKrRU34h2+fjmWH40stHm4w
         WmOWBd9TgODNR49s+McV8w6CiD+VtKHJJ0V9Iov+yqBc40ExooMAKdeAXGtfM8KinV+Z
         5TmXj8gDYw+MvVfF490fvd0GNj1USyTXhuOX/Z7W9GwqInOchHrHWffht7qOMQVkS7Kp
         mbrlnWxgowQuJXzu7g/Rfx20b8Dffwra86ByQ/32a7iw16PHfR9Ghyfn0XTgeXm/6WaI
         1fRQ==
X-Gm-Message-State: APjAAAVLa8YvMLj7JWEOld3Rjo4wa+7qQCYKUOG2Mbgppglx6cUcAwZi
        xQDu4CH+93NZsDm7fs1Qlzo=
X-Google-Smtp-Source: APXvYqze/zmPMD1Bsfoldl9kgWqcWF2ltGwH8c0r7lo9vR1AXcu6XddkT5YuYdRgsgxlZcifb+OJkw==
X-Received: by 2002:a17:906:4d19:: with SMTP id r25mr94272907eju.125.1564586035045;
        Wed, 31 Jul 2019 08:13:55 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g7sm16945101eda.52.2019.07.31.08.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:13:53 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 874211030BD; Wed, 31 Jul 2019 18:08:16 +0300 (+03)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 22/59] mm/rmap: Clear vma->anon_vma on unlink_anon_vmas()
Date:   Wed, 31 Jul 2019 18:07:36 +0300
Message-Id: <20190731150813.26289-23-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If all pages in the VMA got unmapped there's no reason to link it into
original anon VMA hierarchy: it cannot possibly share any pages with
other VMA.

Set vma->anon_vma to NULL on unlink_anon_vmas(). With the change VMA
can be reused. The new anon VMA will be allocated on the first fault.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/rmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index e5dfe2ae6b0d..911367b5fb40 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -400,8 +400,10 @@ void unlink_anon_vmas(struct vm_area_struct *vma)
 		list_del(&avc->same_vma);
 		anon_vma_chain_free(avc);
 	}
-	if (vma->anon_vma)
+	if (vma->anon_vma) {
 		vma->anon_vma->degree--;
+		vma->anon_vma = NULL;
+	}
 	unlock_anon_vma_root(root);
 
 	/*
-- 
2.21.0

