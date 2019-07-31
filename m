Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFCAC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0170208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="kKXhGbR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfGaPKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:10:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35712 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388453AbfGaPIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:08:21 -0400
Received: by mail-ed1-f65.google.com with SMTP id w20so65995150edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AJU4EYtP5Ndll/OqHeAitrNwzvbF49Nst5sv0orja/w=;
        b=kKXhGbR2JDGE9bSyvxgjKsfR1EooQVCxUWsDBiB/ov2JhR22a80ZVWH6hsoT5t60hW
         ReQlX2VuPnyHZm+ht43QCRrwOTR4FXEx8N9KLDx8PA4ydWKsR2BIUMxIijk5qFFyJWJR
         2f083LoqCGdskXIuleu/ah0wA10Rm17n5y2ig4+kPBzijtTL3lkIw8/27JLPaHybuORM
         pzMd9bI4PnPnmBKajAUKL8D2paFeEh9jjqZZbZStBfag1gDyfG8bBCKhuARqXP5nW2Pq
         L1ZhDiLr0HWi2NeMxbyWk+wgHvu/5r9izvPURcblDhh/5L3ApkkaOd6gdu9AGvFSIsuM
         bwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJU4EYtP5Ndll/OqHeAitrNwzvbF49Nst5sv0orja/w=;
        b=tncZ7NQY0EJnonHKzJ8kDJ+tFGp30L3BnMleGafj6hAvRyjgDjh8beUmtTVZWyWaRM
         WrJPPyja2w9XjFZS5RiKv0E9knXjYTEIfO1PBlLxyLevQfZzgEccuz68xUxcTuF2C8dl
         w6s9tz990Vtg8qc9dvJSFFu90jrpEZUjfUjYEk5+MYcLvrhNZe731FJLCFHpSd93nFYR
         y8fFEygTzAEExekc1n7MxjcDr8vhtNJqtMr82KqAq5DC1cLpPivLbDLkSjtwa2POvPJD
         JUW/o/iIPEYweOWisOtcJ0PWrGy3mWXrU90ue5rsgRD2AZ7+nrU3KQZH6GwpkzIKTwHz
         FXlg==
X-Gm-Message-State: APjAAAUp1AWAB6C39zn7jp/NUc1cUtSbhMgP/qhBYdXrIGK10kXert1W
        CNMfKi4jPN0gYmaDsRyTDSY=
X-Google-Smtp-Source: APXvYqwybSsBXdcn4hH+cdquBQ7naCJOKUH1HBc36wrC3gr3IAtOhb7lLrFtZj0CqBrWNvtjPSNrNw==
X-Received: by 2002:aa7:da14:: with SMTP id r20mr107154184eds.65.1564585699886;
        Wed, 31 Jul 2019 08:08:19 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o22sm17282787edc.37.2019.07.31.08.08.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:08:19 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 17B6310131D; Wed, 31 Jul 2019 18:08:16 +0300 (+03)
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
Subject: [PATCHv2 06/59] mm/khugepaged: Handle encrypted pages
Date:   Wed, 31 Jul 2019 18:07:20 +0300
Message-Id: <20190731150813.26289-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For !NUMA khugepaged allocates page in advance, before we found a VMA
for collapse. We don't yet know which KeyID to use for the allocation.

The page is allocated with KeyID-0. Once we know that the VMA is
suitable for collapsing, we prepare the page for KeyID we need, based on
vma_keyid().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/khugepaged.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index eaaa21b23215..ae9bd3b18aa1 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1059,6 +1059,16 @@ static void collapse_huge_page(struct mm_struct *mm,
 	 */
 	anon_vma_unlock_write(vma->anon_vma);
 
+	/*
+	 * At this point new_page is allocated as non-encrypted.
+	 * If VMA's KeyID is non-zero, we need to prepare it to be encrypted
+	 * before coping data.
+	 */
+	if (vma_keyid(vma)) {
+		prep_encrypted_page(new_page, HPAGE_PMD_ORDER,
+				vma_keyid(vma), false);
+	}
+
 	__collapse_huge_page_copy(pte, new_page, vma, address, pte_ptl);
 	pte_unmap(pte);
 	__SetPageUptodate(new_page);
-- 
2.21.0

