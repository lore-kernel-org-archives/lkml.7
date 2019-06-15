Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677DCC31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 09:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454682084B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 09:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfFOJVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 05:21:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725927AbfFOJVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 05:21:51 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8C34F9152DDE68AF5ADA;
        Sat, 15 Jun 2019 17:21:48 +0800 (CST)
Received: from huawei.com (10.175.101.78) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Sat, 15 Jun 2019
 17:21:41 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>
CC:     <yangyingliang@huawei.com>
Subject: [RFC PATCH] doc: fix documentation about UIO_MEM_LOGICAL using
Date:   Sat, 15 Jun 2019 17:41:29 +0800
Message-ID: <1560591689-68051-1-git-send-email-yangyingliang@huawei.com>
X-Mailer: git-send-email 1.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.78]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit d4fc5069a394 ("mm: switch s_mem and slab_cache in struct page")
page->mapping will be re-used by slab allocations and page->mapping->host
will be used in balance_dirty_pages_ratelimited() as an inode member but
it's not an inode in fact and leads an oops.

[  159.906493] Unable to handle kernel paging request at virtual address ffff200012d90be8
[  159.908029] Mem abort info:
[  159.908552]   ESR = 0x96000007
[  159.909138]   Exception class = DABT (current EL), IL = 32 bits
[  159.910155]   SET = 0, FnV = 0
[  159.910690]   EA = 0, S1PTW = 0
[  159.911241] Data abort info:
[  159.911846]   ISV = 0, ISS = 0x00000007
[  159.912567]   CM = 0, WnR = 0
[  159.913105] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000042acd000
[  159.914269] [ffff200012d90be8] pgd=000000043ffff003, pud=000000043fffe003, pmd=000000043fffa003, pte=0000000000000000
[  159.916280] Internal error: Oops: 96000007 [#1] SMP
[  159.917195] Dumping ftrace buffer:
[  159.917845]    (ftrace buffer empty)
[  159.918521] Modules linked in: uio_dev(OE)
[  159.919276] CPU: 1 PID: 295 Comm: uio_test Tainted: G           OE     5.2.0-rc4+ #46
[  159.920859] Hardware name: linux,dummy-virt (DT)
[  159.921815] pstate: 60000005 (nZCv daif -PAN -UAO)
[  159.922809] pc : balance_dirty_pages_ratelimited+0x68/0xc38
[  159.923965] lr : fault_dirty_shared_page.isra.8+0xe4/0x100
[  159.925134] sp : ffff800368a77ae0
[  159.925824] x29: ffff800368a77ae0 x28: 1ffff0006d14ce1a
[  159.926906] x27: ffff800368a670d0 x26: ffff800368a67120
[  159.927985] x25: 1ffff0006d10f5fe x24: ffff200012d90be8
[  159.929089] x23: ffff200013732000 x22: ffff80036ec03200
[  159.930172] x21: ffff200012d90bc0 x20: 1fffe400025b217d
[  159.931253] x19: ffff80036ec03200 x18: 0000000000000000
[  159.932348] x17: 0000000000000000 x16: 0ffffe0000010208
[  159.933439] x15: 0000000000000000 x14: 0000000000000000
[  159.934518] x13: 0000000000000000 x12: 0000000000000000
[  159.935596] x11: 1fffefc001b452c0 x10: ffff0fc001b452c0
[  159.936697] x9 : dfff200000000000 x8 : dfff200000000001
[  159.937781] x7 : ffff7e000da29607 x6 : ffff0fc001b452c1
[  159.938859] x5 : ffff0fc001b452c1 x4 : ffff0fc001b452c1
[  159.939944] x3 : ffff200010523ad4 x2 : 1fffe400026e659b
[  159.941065] x1 : dfff200000000000 x0 : ffff200013732cd8
[  159.942205] Call trace:
[  159.942732]  balance_dirty_pages_ratelimited+0x68/0xc38
[  159.943797]  fault_dirty_shared_page.isra.8+0xe4/0x100
[  159.944867]  do_fault+0x608/0x1250
[  159.945571]  __handle_mm_fault+0x93c/0xfb8
[  159.946412]  handle_mm_fault+0x1c0/0x360
[  159.947224]  do_page_fault+0x358/0x8d0
[  159.947993]  do_translation_fault+0xf8/0x124
[  159.948884]  do_mem_abort+0x70/0x190
[  159.949624]  el0_da+0x24/0x28

According another commit 5e901d0b15c0 ("scsi: qedi: Fix bad pte call trace
when iscsiuio is stopped."), using kmalloc also cause other problem.

But the documentation about UIO_MEM_LOGICAL allows using kmalloc(), remove
and don't allow using kmalloc() in documentation.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 Documentation/driver-api/uio-howto.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/uio-howto.rst b/Documentation/driver-api/uio-howto.rst
index 25f50ea..8fecfa1 100644
--- a/Documentation/driver-api/uio-howto.rst
+++ b/Documentation/driver-api/uio-howto.rst
@@ -276,8 +276,8 @@ fields of ``struct uio_mem``:
 -  ``int memtype``: Required if the mapping is used. Set this to
    ``UIO_MEM_PHYS`` if you you have physical memory on your card to be
    mapped. Use ``UIO_MEM_LOGICAL`` for logical memory (e.g. allocated
-   with :c:func:`kmalloc()`). There's also ``UIO_MEM_VIRTUAL`` for
-   virtual memory.
+   with :c:func:`__get_free_pages()` but not kmalloc()). There's also
+   ``UIO_MEM_VIRTUAL`` for virtual memory.
 
 -  ``phys_addr_t addr``: Required if the mapping is used. Fill in the
    address of your memory block. This address is the one that appears in
-- 
1.8.3

