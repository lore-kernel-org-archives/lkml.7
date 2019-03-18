Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919BBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE792085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FOD+vlL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfCRWrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 18:47:24 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4548 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfCRWrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 18:47:23 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c901ffc0000>; Mon, 18 Mar 2019 15:47:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 18 Mar 2019 15:47:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 18 Mar 2019 15:47:22 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Mar
 2019 22:47:22 +0000
From:   <rcampbell@nvidia.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Ralph Campbell <rcampbell@nvidia.com>,
        Craig Bergstrom <craigb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sander Eikelenboom <linux@eikelenboom.it>,
        Sean Young <sean@mess.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 1/1] x86/mm: Fix limit mmap() of /dev/mem to valid physical addresses
Date:   Mon, 18 Mar 2019 15:46:53 -0700
Message-ID: <20190318224653.26549-2-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318224653.26549-1-rcampbell@nvidia.com>
References: <20190318224653.26549-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552949244; bh=B8TqZYzUiNm2o9lJaKdlFCUI9JnPax1W6w227rOcK0M=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         X-Originating-IP:X-ClientProxiedBy:Content-Transfer-Encoding:
         Content-Type;
        b=FOD+vlL0/kNAqVsy0VnxCTwyhQH3A0Yp80kuqNlKXrjuIUOQAjMZn44k4q//Yj5tV
         qOsdAw0saz4drD/KpmrX2EocDSj7cBVz4n8pTKt13UZrDpq+kTyzneDr2ouLR2u9tu
         ljTOUKiU/cYXS2fKHYUmf9tXDE+hfVnTJ2dGG2jmAXfT6ZSu4Hxq9VLPIDKw0Z/aBx
         +C5rtB0W6ooWwHNCzZosW7jLdF2YKgeGHQeDz1UeBBnwBgvKdWWKiIZcc7gr8r1oYk
         qBcvzaxygM94P3lNeXxkraBOm1KFzy6Bs4qt2FraJzR8J0ugyX7dBGPwCKpD8dmhCi
         jjqY8kJrPAaCA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Campbell <rcampbell@nvidia.com>

If CONFIG_DEBUG_VIRTUAL is enabled, a read or write to /dev/mem can
trigger a VIRTUAL_BUG_ON() depending on the value of high_memory.
For example:

read_mem()
  valid_phys_addr_range(p=3D401f1550, count=3D8)
    __pa(high_memory)
      __phys_addr(x=3Dffffc88000000000)
        // __START_KERNEL_map =3D ffffffff80000000
        // y =3D ffffc88000000000 - ffffffff80000000
        VIRTUAL_BUG_ON(phys_addr_valid(400000000000))
          // boot_cpu_data.x86_phys_bits=3D46

Since by design high_memory is outside the range of valid physical
addresses, use the non-error checking version __pa_nodebug(high_memory).

Fixes: be62a32044061cb4a3b70a10598e093f1319102e ("x86/mm: Limit mmap() of
/dev/mem to valid physical addresses")

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: Craig Bergstrom <craigb@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sander Eikelenboom <linux@eikelenboom.it>
Cc: Sean Young <sean@mess.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index db3165714521..196bed43d5e6 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -230,7 +230,7 @@ bool mmap_address_hint_valid(unsigned long addr, unsign=
ed long len)
 /* Can we access it for direct reading/writing? Must be RAM: */
 int valid_phys_addr_range(phys_addr_t addr, size_t count)
 {
-	return addr + count <=3D __pa(high_memory);
+	return addr + count <=3D __pa_nodebug(high_memory);
 }
=20
 /* Can we access it through mmap? Must be a valid physical address: */
--=20
2.20.1

