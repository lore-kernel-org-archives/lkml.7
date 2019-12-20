Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753FBC2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417F22467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="PckJPvOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfLTO0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:26:05 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40985 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfLTO0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:26:02 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so10189911ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 06:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1aqJaMPhZ/LdjH/pzYf9S/QghCRA9LSMRsvTbXKKDeI=;
        b=PckJPvOugvXBXBrEBUqMIwlz8UBJbGbd2J43VDNcLAolBMRZ4byslRdYeWQaVz7Obx
         4R0B6iJrB+Bcc73zIRff+qQ7uUsqdgp1GaoBiVcszCYtEptuvAqElel306DaUnKO+NXk
         0JIuCY3jRAmkbGOLfedKYnbbKTOYXA6T+oKrdIWSXph/zZwskDO8ekzaHUbBnEIGlRmm
         1/Sd5mCU5lobONzW7fTpTuvo9m9T2+FvaOSRiwjhdQ5+NW8A6CX7O6wsovBibyN31Tci
         92EAdKncazj099YD/eoptvL8C0m50EHtVdf6a7jD/Bvq0VJbkt+T5sHWroDYqz1XRwsQ
         h2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1aqJaMPhZ/LdjH/pzYf9S/QghCRA9LSMRsvTbXKKDeI=;
        b=YB23jEj9ioS10JHFpur5MaiA/UsSfyIGZM8ppCUidq0EJecve4U9E8LnokVhPBoe0l
         cRjAVc68LisM5yoW8NSfZNSPGa/4pohzCmCl40m22Sntnc5QYKDUYO5uogJ2e/2xORuf
         MhdGowCPti+jc/mwiqZFXJ6rBhU6hLjwm89OGQcSoNi0fh+5Q3dv3XytfCsF5w4PskbR
         zomjJWCsHJrn66Duqy6mNYLYurd7+BxfCFbAyLw6SOs8Z/VDfIiDxUNDbS9uPiDc0e7F
         Ob4d4JVDHmwYOsFxifHr7ZVv0nX06+/lGuSiu+Kg2hxwQ02P6untKKZ/CVo1BbU6sV61
         Udng==
X-Gm-Message-State: APjAAAWvZcIVPgcGMzYsrwlGvj8ewvGtp+1knOqby9p7yZHCPS7kdxlw
        ELb5n/7EP6Clh7KmLUbxRQ6xRw==
X-Google-Smtp-Source: APXvYqwgRZair3v7dcpcAV9A4xU5RH+vM2FKRLJfLSIhHs9JOyWmUyRsV2oGsT0Cbiqqk0ZHhQQkuQ==
X-Received: by 2002:a2e:9806:: with SMTP id a6mr9736008ljj.178.1576851958332;
        Fri, 20 Dec 2019 06:25:58 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h10sm4310863ljc.39.2019.12.20.06.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 06:25:56 -0800 (PST)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 373B01006EA; Fri, 20 Dec 2019 17:25:59 +0300 (+03)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Willhalm, Thomas" <thomas.willhalm@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Bruggeman, Otto G" <otto.g.bruggeman@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 1/2] thp: Fix conflict of above-47bit hint address and PMD alignment
Date:   Fri, 20 Dec 2019 17:25:47 +0300
Message-Id: <20191220142548.7118-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220142548.7118-1-kirill.shutemov@linux.intel.com>
References: <20191220142548.7118-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Filesystems use thp_get_unmapped_area() to provide THP-friendly
mappings. For DAX in particular.

Normally, the kernel doesn't create userspace mappings above 47-bit,
even if the machine allows this (such as with 5-level paging on x86-64).
Not all user space is ready to handle wide addresses. It's known that
at least some JIT compilers use higher bits in pointers to encode their
information.

Userspace can ask for allocation from full address space by specifying
hint address (with or without MAP_FIXED) above 47-bits. If the
application doesn't need a particular address, but wants to allocate
from whole address space it can specify -1 as a hint address.

Unfortunately, this trick breaks thp_get_unmapped_area(): the function
would not try to allocate PMD-aligned area if *any* hint address
specified.

Modify the routine to handle it correctly:

 - Try to allocate the space at the specified hint address with length
   padding required for PMD alignment.
 - If failed, retry without length padding (but with the same hint
   address);
 - If the returned address matches the hint address return it.
 - Otherwise, align the address as required for THP and return.

The user specified hint address is passed down to get_unmapped_area() so
above-47bit hint address will be taken into account without breaking
alignment requirements.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: b569bab78d8d ("x86/mm: Prepare to expose larger address space to userspace")
Reported-by: Thomas Willhalm <thomas.willhalm@intel.com>
Tested-by: Dan Williams <dan.j.williams@intel.com>
---
 mm/huge_memory.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 969653530c8f..dccadfbc9994 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -527,13 +527,13 @@ void prep_transhuge_page(struct page *page)
 	set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
 }
 
-static unsigned long __thp_get_unmapped_area(struct file *filp, unsigned long len,
+static unsigned long __thp_get_unmapped_area(struct file *filp,
+		unsigned long addr, unsigned long len,
 		loff_t off, unsigned long flags, unsigned long size)
 {
-	unsigned long addr;
 	loff_t off_end = off + len;
 	loff_t off_align = round_up(off, size);
-	unsigned long len_pad;
+	unsigned long len_pad, ret;
 
 	if (off_end <= off_align || (off_end - off_align) < size)
 		return 0;
@@ -542,30 +542,40 @@ static unsigned long __thp_get_unmapped_area(struct file *filp, unsigned long le
 	if (len_pad < len || (off + len_pad) < off)
 		return 0;
 
-	addr = current->mm->get_unmapped_area(filp, 0, len_pad,
+	ret = current->mm->get_unmapped_area(filp, addr, len_pad,
 					      off >> PAGE_SHIFT, flags);
-	if (IS_ERR_VALUE(addr))
+
+	/*
+	 * The failure might be due to length padding. The caller will retry
+	 * without the padding.
+	 */
+	if (IS_ERR_VALUE(ret))
 		return 0;
 
-	addr += (off - addr) & (size - 1);
-	return addr;
+	/*
+	 * Do not try to align to THP boundary if allocation at the address
+	 * hint succeeds.
+	 */
+	if (ret == addr)
+		return addr;
+
+	ret += (off - ret) & (size - 1);
+	return ret;
 }
 
 unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
+	unsigned long ret;
 	loff_t off = (loff_t)pgoff << PAGE_SHIFT;
 
-	if (addr)
-		goto out;
 	if (!IS_DAX(filp->f_mapping->host) || !IS_ENABLED(CONFIG_FS_DAX_PMD))
 		goto out;
 
-	addr = __thp_get_unmapped_area(filp, len, off, flags, PMD_SIZE);
-	if (addr)
-		return addr;
-
- out:
+	ret = __thp_get_unmapped_area(filp, addr, len, off, flags, PMD_SIZE);
+	if (ret)
+		return ret;
+out:
 	return current->mm->get_unmapped_area(filp, addr, len, pgoff, flags);
 }
 EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
-- 
2.24.1

