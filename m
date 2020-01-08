Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD8BC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC2D20673
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="AgXhiwF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgAHP2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:28:20 -0500
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:3495 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgAHP2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:28:19 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jan 2020 10:28:18 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1578497299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=u+HZe/IB7NWuju/ekZtvFNhhexGEz06n0VVXB1U9a4M=;
  b=AgXhiwF2PTwG93UagGXq27V0GBqDlamh/teZvCTcjbNuZU6ZWTWMlrdq
   koFUa400l4sjjHr/iqIdFEdLvxRfNIZbvq5tdyasMLwLKFCUZubGR5WZy
   T/fWdayMkfZuYqVs98q5oN1XmVRBVnUH+ANPxAxcXpdUELc2a8GSU6etp
   8=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=sergey.dyasli@citrix.com; spf=Pass smtp.mailfrom=sergey.dyasli@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  sergey.dyasli@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
  sergey.dyasli@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: NbrdZNDy/8773XZvZO8zNVSrjuBIlAMLf4M6CL+ejqbSJOqIN86OXwZR2Ps3f9MnAat1eXt5rL
 I5/hb4LebArVQjJXBOXfAtGECD78VXz6jBVCYi8lUug0bg+ZZEhfDnvYsb8fP9uyUSmZDg0AFT
 jKOSB2BDBcfGoWQV7vQbwBSL5PachzEw22NTcMg9xW7eIs2jH1J+/mNaxrn7xe2G3nVPLqdX7z
 xjzRnNNqF5pxf+YhbmBJeCEuBX4Hv89CfiDNTkbDZc3hXN5yEmJGTM/EOf8PjvYbiT2GYU9wZ6
 6Qo=
X-SBRS: 2.7
X-MesageID: 11004135
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,410,1571716800"; 
   d="scan'208";a="11004135"
From:   Sergey Dyasli <sergey.dyasli@citrix.com>
To:     <xen-devel@lists.xen.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        George Dunlap <george.dunlap@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Dyasli <sergey.dyasli@citrix.com>
Subject: [PATCH v1 1/4] kasan: introduce set_pmd_early_shadow()
Date:   Wed, 8 Jan 2020 15:20:57 +0000
Message-ID: <20200108152100.7630-2-sergey.dyasli@citrix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108152100.7630-1-sergey.dyasli@citrix.com>
References: <20200108152100.7630-1-sergey.dyasli@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is incorrect to call pmd_populate_kernel() multiple times for the
same page table. Xen notices it during kasan_populate_early_shadow():

    (XEN) mm.c:3222:d155v0 mfn 3704b already pinned

This happens for kasan_early_shadow_pte when USE_SPLIT_PTE_PTLOCKS is
enabled. Fix this by introducing set_pmd_early_shadow() which calls
pmd_populate_kernel() only once and uses set_pmd() afterwards.

Signed-off-by: Sergey Dyasli <sergey.dyasli@citrix.com>
---
RFC --> v1:
- New patch
---
 mm/kasan/init.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index ce45c491ebcd..a4077320777f 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -81,6 +81,19 @@ static inline bool kasan_early_shadow_page_entry(pte_t pte)
 	return pte_page(pte) == virt_to_page(lm_alias(kasan_early_shadow_page));
 }
 
+static inline void set_pmd_early_shadow(pmd_t *pmd)
+{
+	static bool pmd_populated = false;
+	pte_t *early_shadow = lm_alias(kasan_early_shadow_pte);
+
+	if (likely(pmd_populated)) {
+		set_pmd(pmd, __pmd(__pa(early_shadow) | _PAGE_TABLE));
+	} else {
+		pmd_populate_kernel(&init_mm, pmd, early_shadow);
+		pmd_populated = true;
+	}
+}
+
 static __init void *early_alloc(size_t size, int node)
 {
 	void *ptr = memblock_alloc_try_nid(size, size, __pa(MAX_DMA_ADDRESS),
@@ -120,8 +133,7 @@ static int __ref zero_pmd_populate(pud_t *pud, unsigned long addr,
 		next = pmd_addr_end(addr, end);
 
 		if (IS_ALIGNED(addr, PMD_SIZE) && end - addr >= PMD_SIZE) {
-			pmd_populate_kernel(&init_mm, pmd,
-					lm_alias(kasan_early_shadow_pte));
+			set_pmd_early_shadow(pmd);
 			continue;
 		}
 
@@ -157,8 +169,7 @@ static int __ref zero_pud_populate(p4d_t *p4d, unsigned long addr,
 			pud_populate(&init_mm, pud,
 					lm_alias(kasan_early_shadow_pmd));
 			pmd = pmd_offset(pud, addr);
-			pmd_populate_kernel(&init_mm, pmd,
-					lm_alias(kasan_early_shadow_pte));
+			set_pmd_early_shadow(pmd);
 			continue;
 		}
 
@@ -198,8 +209,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			pud_populate(&init_mm, pud,
 					lm_alias(kasan_early_shadow_pmd));
 			pmd = pmd_offset(pud, addr);
-			pmd_populate_kernel(&init_mm, pmd,
-					lm_alias(kasan_early_shadow_pte));
+			set_pmd_early_shadow(pmd);
 			continue;
 		}
 
@@ -271,8 +281,7 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 			pud_populate(&init_mm, pud,
 					lm_alias(kasan_early_shadow_pmd));
 			pmd = pmd_offset(pud, addr);
-			pmd_populate_kernel(&init_mm, pmd,
-					lm_alias(kasan_early_shadow_pte));
+			set_pmd_early_shadow(pmd);
 			continue;
 		}
 
-- 
2.17.1

