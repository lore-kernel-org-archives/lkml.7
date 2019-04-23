Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A904C10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 01:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C99D2077C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 01:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbfDWBaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 21:30:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729120AbfDWBaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 21:30:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 124144E908;
        Tue, 23 Apr 2019 01:30:23 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9965E60142;
        Tue, 23 Apr 2019 01:30:11 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com
Subject: [PATCH 0/3 v11] add reserved e820 ranges to the kdump kernel e820 table
Date:   Tue, 23 Apr 2019 09:30:04 +0800
Message-Id: <20190423013007.17838-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 23 Apr 2019 01:30:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset did three things:

a). x86/e820, resource: add a new I/O resource descriptor 'IORES_DESC_
    RESERVED'

b). x86/mm: change the check condition in SEV because a new descriptor is
    introduced

c). x86/kexec_file: add reserved e820 ranges to kdump kernel e820 table

Changes since v1:
1. Modified the value of flags to "0", when walking through the whole
tree for e820 reserved ranges.

Changes since v2:
1. Modified the value of flags to "0", when walking through the whole
tree for e820 reserved ranges.
2. Modified the invalid SOB chain issue.

Changes since v3:
1. Dropped [PATCH 1/3 v3] resource: fix an error which walks through iomem
   resources. Please refer to this commit <010a93bf97c7> "resource: Fix
   find_next_iomem_res() iteration issue"

Changes since v4:
1. Improve the patch log, and add kernel log.

Changes since v5:
1. Rewrite these patches log.

Changes since v6:
1. Modify the [PATCH 1/2], and add the new I/O resource descriptor
   'IORES_DESC_RESERVED' for the iomem resources search interfaces,
   and also updates these codes relates to 'IORES_DESC_NONE'.
2. Modify the [PATCH 2/2], and walk through io resource based on the
   new descriptor 'IORES_DESC_RESERVED'.
3. Update patch log.

Changes since v7:
1. Improve patch log.
2. Improve this function __ioremap_check_desc_other().
3. Modify code comment in the __ioremap_check_desc_other()

Changes since v8:
1. Get rid of all changes about ia64.(Borislav's suggestion)
2. Change the examination condition to the 'IORES_DESC_ACPI_*'.
3. Modify the signature. This patch(add the new I/O resource
   descriptor 'IORES_DESC_RESERVED') was suggested by Boris.

Changes since v9:
1. Improve patch log.
2. No need to modify the kernel/resource.c, so correct them.
3. Change the name of the __ioremap_check_desc_other() to
   __ioremap_check_desc_none_and_reserved(), and modify the
   check condition, add comment above it.

Changes since v10:
1. Split them into three patches, the second patch is currently added.
2. Change struct ioremap_mem_flags to struct ioremap_desc and redefine
it.
3. Change the name of the __ioremap_check_desc_other() to
__ioremap_check_desc().
4. Change the check condition in SEV and also improve them.
5. Modify the return value for some functions.

Lianbo Jiang (3):
  x86/e820, resource: add a new I/O resource descriptor
    'IORES_DESC_RESERVED'
  x86/mm: change the check condition in SEV because a new descriptor is
    introduced
  x86/kexec_file: add reserved e820 ranges to kdump kernel e820 table

 arch/x86/kernel/crash.c |  6 +++++
 arch/x86/kernel/e820.c  |  2 +-
 arch/x86/mm/ioremap.c   | 59 ++++++++++++++++++++++++++---------------
 include/linux/ioport.h  | 10 +++++++
 4 files changed, 54 insertions(+), 23 deletions(-)

-- 
2.17.1

