Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D51C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67ED92075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553715260;
	bh=vocEwnbZp/TrmugDuJcC5kb7NwJKwfyOUE3Qe/SKxwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MkY82S42yEzXB/GB8qC2w8e70pV7qniC7u7gKWuL2BM+BagDz0o69Q6srZezmygo0
	 YhN7DRsiVRBqoYa4t51o7obY4a+/Yh4VFrJrUeCg/G3OBDfZwsotnUj5HVYN4O0BkX
	 X4O8aFQ1hR6ovDUsx1CLEt+nOQXmcStLFG2eMigg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731989AbfC0TeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:34:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729234AbfC0SCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:02:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F94C2173C;
        Wed, 27 Mar 2019 18:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709730;
        bh=vocEwnbZp/TrmugDuJcC5kb7NwJKwfyOUE3Qe/SKxwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i3PBpV2FdYVUxmYSSvV4LfpwZtqS3Xp10w85i0XaNd0pGoJAXPL5lj1+/c7o+xBqh
         9IfOkMN72Gd/ANdm4KZJMTGFnZLlfz8PhclXiiYEthvIpEF/WWMo0BlFu07K01IHyc
         yBwMp5m/vur9yJZM58/9K3msqF45+PX86Xm0/FLg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>,
        Guo Ren <ren_guo@c-sky.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.0 008/262] swiotlb: add checks for the return value of memblock_alloc*()
Date:   Wed, 27 Mar 2019 13:57:43 -0400
Message-Id: <20190327180158.10245-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

[ Upstream commit a0bf842e89a3842162aa8514b9bf4611c86fee10 ]

Add panic() calls if memblock_alloc() returns NULL.

The panic() format duplicates the one used by memblock itself and in
order to avoid explosion with long parameters list replace open coded
allocation size calculations with a local variable.

Link: http://lkml.kernel.org/r/1548057848-15136-19-git-send-email-rppt@linux.ibm.com
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Christoph Hellwig <hch@lst.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guan Xuetao <gxt@pku.edu.cn>
Cc: Guo Ren <guoren@kernel.org>
Cc: Guo Ren <ren_guo@c-sky.com>				[c-sky]
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Juergen Gross <jgross@suse.com>			[Xen]
Cc: Mark Salter <msalter@redhat.com>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Rich Felker <dalias@libc.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/swiotlb.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c873f9cc2146..41224f0ec40e 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -191,6 +191,7 @@ void __init swiotlb_update_mem_attributes(void)
 int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 {
 	unsigned long i, bytes;
+	size_t alloc_size;
 
 	bytes = nslabs << IO_TLB_SHIFT;
 
@@ -203,12 +204,18 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 	 * to find contiguous free memory regions of size up to IO_TLB_SEGSIZE
 	 * between io_tlb_start and io_tlb_end.
 	 */
-	io_tlb_list = memblock_alloc(
-				PAGE_ALIGN(io_tlb_nslabs * sizeof(int)),
-				PAGE_SIZE);
-	io_tlb_orig_addr = memblock_alloc(
-				PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t)),
-				PAGE_SIZE);
+	alloc_size = PAGE_ALIGN(io_tlb_nslabs * sizeof(int));
+	io_tlb_list = memblock_alloc(alloc_size, PAGE_SIZE);
+	if (!io_tlb_list)
+		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
+		      __func__, alloc_size, PAGE_SIZE);
+
+	alloc_size = PAGE_ALIGN(io_tlb_nslabs * sizeof(phys_addr_t));
+	io_tlb_orig_addr = memblock_alloc(alloc_size, PAGE_SIZE);
+	if (!io_tlb_orig_addr)
+		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
+		      __func__, alloc_size, PAGE_SIZE);
+
 	for (i = 0; i < io_tlb_nslabs; i++) {
 		io_tlb_list[i] = IO_TLB_SEGSIZE - OFFSET(i, IO_TLB_SEGSIZE);
 		io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
-- 
2.19.1

