Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0F6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BD52183E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfC2G5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:57:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728651AbfC2G5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:57:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E343581F13;
        Fri, 29 Mar 2019 06:57:06 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-53.pek2.redhat.com [10.72.12.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 156D5D1D8;
        Fri, 29 Mar 2019 06:56:54 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com
Subject: [PATCH 0/2 v10] add reserved e820 ranges to the kdump kernel e820 table
Date:   Fri, 29 Mar 2019 14:56:47 +0800
Message-Id: <20190329065649.12468-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 29 Mar 2019 06:57:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset did two things:

a). add a new I/O resource descriptor 'IORES_DESC_RESERVED'
When doing kexec_file_load(), the first kernel needs to pass the e820
reserved ranges to the second kernel, because some devices may use it
in kdump kernel, such as PCI devices.

But, the kernel can not exactly match the e820 reserved ranges when
walking through the iomem resources via the 'IORES_DESC_NONE', because
there are several types of e820 that are described as the 'IORES_DESC_NONE'
type. Please refer to the e820_type_to_iores_desc().

Therefore, add a new I/O resource descriptor 'IORES_DESC_RESERVED' for
the iomem resources search interfaces. It is helpful to exactly match
the reserved resource ranges when walking through iomem resources.

In addition, since the new descriptor 'IORES_DESC_RESERVED' has been
created for the reserved areas, the code originally related to the
descriptor 'IORES_DESC_NONE' also need to be updated.

b). add the e820 reserved ranges to kdump kernel e820 table
At present, when using the kexec_file_load() syscall to load the kernel
image and initramfs(for example: kexec -s -p xxx), the kernel does not
pass the e820 reserved ranges to the second kernel, which might cause
two problems:

The first one is the MMCONFIG issue. The basic problem is that this
device is in PCI segment 1 and the kernel PCI probing can not find it
without all the e820 I/O reservations being present in the e820 table.
And the kdump kernel does not have those reservations because the kexec
command does not pass the I/O reservation via the "memmap=xxx" command
line option. (This problem does not show up for other vendors, as SGI
is apparently the actually fails for everyone, but devices in segment 0
are then found by some legacy lookup method.) The workaround for this
is to pass the I/O reserved regions to the kdump kernel.

MMCONFIG(aka ECAM) space is described in the ACPI MCFG table. If you don't
have ECAM: (a) PCI devices won't work at all on non-x86 systems that use
only ECAM for config access, (b) you won't be albe to access devices on
non-0 segments, (c) you won't be able to access extended config space(
address 0x100-0xffff), which means none of the Extended Capabilities will
be available(AER, ACS, ATS, etc). [Bjorn's comment]

The second issue is that the SME kdump kernel doesn't work without the
e820 reserved ranges. When SME is active in kdump kernel, actually, those
reserved regions are still decrypted, but because those reserved ranges are
not present at all in kdump kernel e820 table, those reserved regions are
considered as encrypted, it goes wrong.

The e820 reserved range is useful in kdump kernel, so it is necessary to
pass the e820 reserved ranges to the kdump kernel.

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

Lianbo Jiang (2):
  x86/mm, resource: add a new I/O resource descriptor
    'IORES_DESC_RESERVED'
  x86/kexec_file: add reserved e820 ranges to kdump kernel e820 table

 arch/x86/kernel/crash.c |  6 ++++++
 arch/x86/kernel/e820.c  |  2 +-
 arch/x86/mm/ioremap.c   | 16 ++++++++++++++--
 include/linux/ioport.h  |  1 +
 4 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.17.1

