Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA26AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B45021939
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255616;
	bh=fbr/VLvl0bOhO7APOPaWOuqFggCN/Q9LcDmy3Riq/uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XE/LS5deynES+gabKzoUhFB3drOwfCioQ6mDWn89uOtD83hU1YABJNxehCOjVaigU
	 MHImrFD9h4go33+Ypfeh+AnTEnM+SEl48eTsU6R4Rj2fe5Io5y6WKARPcef6I8giLB
	 lxrG7tkjNx7Q6vVUeFiZl95RvaMe7jguGiCSOtrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733062AbfCVLxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:53:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733052AbfCVLxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:53:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BA7B21939;
        Fri, 22 Mar 2019 11:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255611;
        bh=fbr/VLvl0bOhO7APOPaWOuqFggCN/Q9LcDmy3Riq/uY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LCvwTwbgm6HbdbSP4p1RMzwtnM8MHJDhyiXciRSjA0pBjumNYrzH+z0i1m7jCrLUW
         bgvUrMJvyuvMNGwB4LV+q6Bap9UEpim0Hgh1wkflNiHGqDDwzwR+mppHa+Wy78O0i9
         PXoWiUJDzlaOAxG4uaJhPPqOhieAdqty9nJlKxJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 144/183] powerpc/hugetlb: Dont do runtime allocation of 16G pages in LPAR configuration
Date:   Fri, 22 Mar 2019 12:16:12 +0100
Message-Id: <20190322111252.220017507@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

commit 35f2806b481f5b9207f25e1886cba5d1c4d12cc7 upstream.

We added runtime allocation of 16G pages in commit 4ae279c2c96a
("powerpc/mm/hugetlb: Allow runtime allocation of 16G.") That was done
to enable 16G allocation on PowerNV and KVM config. In case of KVM
config, we mostly would have the entire guest RAM backed by 16G
hugetlb pages for this to work. PAPR do support partial backing of
guest RAM with hugepages via ibm,expected#pages node of memory node in
the device tree. This means rest of the guest RAM won't be backed by
16G contiguous pages in the host and hence a hash page table insertion
can fail in such case.

An example error message will look like

  hash-mmu: mm: Hashing failure ! EA=0x7efc00000000 access=0x8000000000000006 current=readback
  hash-mmu:     trap=0x300 vsid=0x67af789 ssize=1 base psize=14 psize 14 pte=0xc000000400000386
  readback[12260]: unhandled signal 7 at 00007efc00000000 nip 00000000100012d0 lr 000000001000127c code 2

This patch address that by preventing runtime allocation of 16G
hugepages in LPAR config. To allocate 16G hugetlb one need to kernel
command line hugepagesz=16G hugepages=<number of 16G pages>

With radix translation mode we don't run into this issue.

This change will prevent runtime allocation of 16G hugetlb pages on
kvm with hash translation mode. However, with the current upstream it
was observed that 16G hugetlbfs backed guest doesn't boot at all.

We observe boot failure with the below message:
  [131354.647546] KVM: map_vrma at 0 failed, ret=-4

That means this patch is not resulting in an observable regression.
Once we fix the boot issue with 16G hugetlb backed memory, we need to
use ibm,expected#pages memory node attribute to indicate 16G page
reservation to the guest. This will also enable partial backing of
guest RAM with 16G pages.

Fixes: 4ae279c2c96a ("powerpc/mm/hugetlb: Allow runtime allocation of 16G.")
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/book3s/64/hugetlb.h |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -55,6 +55,14 @@ static inline pte_t arch_make_huge_pte(p
 #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
 static inline bool gigantic_page_supported(void)
 {
+	/*
+	 * We used gigantic page reservation with hypervisor assist in some case.
+	 * We cannot use runtime allocation of gigantic pages in those platforms
+	 * This is hash translation mode LPARs.
+	 */
+	if (firmware_has_feature(FW_FEATURE_LPAR) && !radix_enabled())
+		return false;
+
 	return true;
 }
 #endif


