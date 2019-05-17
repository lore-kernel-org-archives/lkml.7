Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11774C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D342087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfEQKij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 06:38:39 -0400
Received: from foss.arm.com ([217.140.101.70]:41790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbfEQKii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 06:38:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CE1880D;
        Fri, 17 May 2019 03:38:38 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0E5573F575;
        Fri, 17 May 2019 03:38:33 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        jglisse@redhat.com, ldufour@linux.vnet.ibm.com
Subject: [PATCH] mm/dev_pfn: Exclude MEMORY_DEVICE_PRIVATE while computing virtual address
Date:   Fri, 17 May 2019 16:08:34 +0530
Message-Id: <1558089514-25067-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The presence of struct page does not guarantee linear mapping for the pfn
physical range. Device private memory which is non-coherent is excluded
from linear mapping during devm_memremap_pages() though they will still
have struct page coverage. Just check for device private memory before
giving out virtual address for a given pfn.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
All these helper functions are all pfn_t related but could not figure out
another way of determining a private pfn without looking into it's struct
page. pfn_t_to_virt() is not getting used any where in mainline kernel.Is
it used by out of tree drivers ? Should we then drop it completely ?

 include/linux/pfn_t.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
index 7bb7785..3c202a1 100644
--- a/include/linux/pfn_t.h
+++ b/include/linux/pfn_t.h
@@ -68,7 +68,7 @@ static inline phys_addr_t pfn_t_to_phys(pfn_t pfn)
 
 static inline void *pfn_t_to_virt(pfn_t pfn)
 {
-	if (pfn_t_has_page(pfn))
+	if (pfn_t_has_page(pfn) && !is_device_private_page(pfn_t_to_page(pfn)))
 		return __va(pfn_t_to_phys(pfn));
 	return NULL;
 }
-- 
2.7.4

