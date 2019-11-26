Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8804C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE2820866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="poRKj6I8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKZU1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 15:27:48 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:37737 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfKZU1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:27:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 575903F656;
        Tue, 26 Nov 2019 21:27:44 +0100 (CET)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=poRKj6I8;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZkFTzor5INdG; Tue, 26 Nov 2019 21:27:42 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id EEE623F382;
        Tue, 26 Nov 2019 21:27:39 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 24C7B36016C;
        Tue, 26 Nov 2019 21:27:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1574800059; bh=j/BRuQJcx6Py9MS5lniFvxHGWs39VGoBsA+SEpAzptQ=;
        h=From:To:Cc:Subject:Date:From;
        b=poRKj6I8rSz6ts04cSbe3jhLXal6GPoSPgtvmmNXwuJf5JfYbmwOJ77qnsuFoveH9
         52jmShLTdgE0errbv8A4+Ktso8VbF9t3F9WzoFLRO7PbwEQOyi9KvsWwgmwwnWsfjN
         aBkCbGa7AbEp+wADG8tfrP3aIuUYus8Xt8iQeCVQ=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-graphics-maintainer@vmware.com
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 1/2] mm: Add and export vmf_insert_mixed_prot()
Date:   Tue, 26 Nov 2019 21:27:16 +0100
Message-Id: <20191126202717.30762-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

The TTM module today uses a hack to be able to set a different page
protection than struct vm_area_struct::vm_page_prot. To be able to do
this properly, add and export vmf_insert_mixed_prot().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 15 +++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cc292273e6ba..29575d3c1e47 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2548,6 +2548,8 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot);
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 			pfn_t pfn);
+vm_fault_t vmf_insert_mixed_prot(struct vm_area_struct *vma, unsigned long addr,
+			pfn_t pfn, pgprot_t pgprot);
 vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
 		unsigned long addr, pfn_t pfn);
 int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long len);
diff --git a/mm/memory.c b/mm/memory.c
index b1ca51a079f2..28f162e28144 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1719,9 +1719,9 @@ static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn)
 }
 
 static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
-		unsigned long addr, pfn_t pfn, bool mkwrite)
+		unsigned long addr, pfn_t pfn, pgprot_t pgprot,
+		bool mkwrite)
 {
-	pgprot_t pgprot = vma->vm_page_prot;
 	int err;
 
 	BUG_ON(!vm_mixed_ok(vma, pfn));
@@ -1764,10 +1764,17 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	return VM_FAULT_NOPAGE;
 }
 
+vm_fault_t vmf_insert_mixed_prot(struct vm_area_struct *vma, unsigned long addr,
+				 pfn_t pfn, pgprot_t pgprot)
+{
+	return __vm_insert_mixed(vma, addr, pfn, pgprot, false);
+}
+EXPORT_SYMBOL(vmf_insert_mixed_prot);
+
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 		pfn_t pfn)
 {
-	return __vm_insert_mixed(vma, addr, pfn, false);
+	return __vm_insert_mixed(vma, addr, pfn, vma->vm_page_prot, false);
 }
 EXPORT_SYMBOL(vmf_insert_mixed);
 
@@ -1779,7 +1786,7 @@ EXPORT_SYMBOL(vmf_insert_mixed);
 vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
 		unsigned long addr, pfn_t pfn)
 {
-	return __vm_insert_mixed(vma, addr, pfn, true);
+	return __vm_insert_mixed(vma, addr, pfn, vma->vm_page_prot, true);
 }
 EXPORT_SYMBOL(vmf_insert_mixed_mkwrite);
 
-- 
2.21.0

