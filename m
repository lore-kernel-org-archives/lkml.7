Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA9FC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DD92077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgAGUrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:47:17 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:53747 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgAGUrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:47:17 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MnIxu-1jVeUY1YPM-00jHl9; Tue, 07 Jan 2020 21:46:18 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        James Morse <james.morse@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: pagewalk: fix unused variable warning
Date:   Tue,  7 Jan 2020 21:45:50 +0100
Message-Id: <20200107204607.1533842-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nfd2MhnazBDFbdhEbkuXobt5dOcHmOdZavAoRTNw1E/Z0ByklA8
 ZmWSk/F6KnOGn+N4FPoIgKcLx8FLOUTv72ZAiXvIOewWpM43sKdNXtJUfe7cNYhWL4gc5Qa
 2OkGOKvYcZwKVRdUF0i504kVQWa1ePbs3WdoFcF18Lh36syCkac5LmTbH4mbSOtJGio4r5m
 lYhztIt8HyDSfKlf/oFoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SyFizkNhuwU=:SLvDzln1XdpostFeosJEMt
 noepWZS0FnRd5tMZNJk2BopLW9JAQSZs9viOuUd+Oaf4Xs2jaVH5zIqAbNLanFL85+898FW8f
 cSeFpuqZ1eroCE0ZIS14qS+/+13IS/zTrTU7lAI/ZipZRWHl9AniDLBDJeaY82SGMWBjnuYQG
 lYfQiVwVXq/dsFNc2WlrDbnpS1Zz6zBaeL10s4YYGrCUXxbdN9OQpM/FAs4/1eb/S00s6g5tn
 tHYp8yG152CrT34dxjslcpIWcu/kNnR093ZZ2Sd+5+oPYOT2aHov7PYc4iabHbAlEkY9b3bFY
 9XXsN6URmOBX0ubC+5CVUGZFiZJ8xngl41SuIu1QxpexPRsNyztKYHrXHkW8SnUs/OCdp0YSH
 C83ZsiQd/jqQk5Yfiro7mbsb5fiVyFXgLrY5uJEbJGP1r5FIxRsjWRpteqKu2npW+D8pCoqZ+
 vpf4H9hmz6AYZnl9LbWW3Hij5iydTz9DFHJqw4D89E4eNyxzcmpt5UQ29XyFIeiqMhBOyvopA
 thEN3MWT02eDhHReOmw4X7czemFnju3O81XiAtpOdLCNPKVwPCzzesZYMiJzzXZyH3/ABPs9t
 9We+gk7fKg3GXkfVlJjJQV3IR0rZpMd1l85fzYvVAxKqvmcpDQdZNMMU7EehxAcW8Fbrptcni
 CuQIg9SKt1zicXc/CPuC0C/Ic68sOXSI6A5Hw4GHpXmSCuTF29PfJPLBZzp5Swq7iJC/U1PBe
 V3N3hQAoci/maTKmK78iHYb3FL747Bt12GYuEEiHJNtWgWjRnMjnw/zqS++mxjh2BIL+7gGoH
 FrMc3sHF+mrhO8KjflI2JseeaFFmSERUIBGmnBD2zuTfjbr2WonosYxGEv4gmwM+THfyA/chw
 ukFpbpuDo4o3IoTaMbfA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the pagewalk patches introduced a harmless warning:

mm/hmm.c: In function 'hmm_vma_walk_pud':
mm/hmm.c:478:9: error: unused variable 'pmdp' [-Werror=unused-variable]
  pmd_t *pmdp;
         ^~~~
mm/hmm.c:477:30: error: unused variable 'next' [-Werror=unused-variable]
  unsigned long addr = start, next;
                              ^~~~

Remove both of the now-unused variables.

Fixes: cb4d03d5fb4c ("mm: pagewalk: add p4d_entry() and pgd_entry()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/hmm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index a71295e99968..72e5a6d9a417 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -474,8 +474,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 {
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
-	unsigned long addr = start, next;
-	pmd_t *pmdp;
+	unsigned long addr = start;
 	pud_t pud;
 	int ret = 0;
 	spinlock_t *ptl = pud_trans_huge_lock(pudp, walk->vma);
-- 
2.20.0

