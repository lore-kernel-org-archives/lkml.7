Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50871CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1916D20856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="arp4N/Fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439536AbfJXMCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 08:02:31 -0400
Received: from mout.gmx.net ([212.227.15.19]:42985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfJXMCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 08:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571918532;
        bh=BtPN5byu76jvQFbrBcOcxvBymOTJxo5DdTxvJCjqupU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=arp4N/FbyrbbrWU2bD10SeR2AHU/OtThpy/vmPEoLp4mB3hmt6/tLqAjj9MLN4FME
         ZJg28B8TRDhkXFzuy/9wvgf33CaVYEmHYHbzyvCrkb0i3EIteFJYqzfToSFaYMCCKN
         kAFJV20xpM53FPOnRslQhkGZSALUVtoyN+494HMw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.166.174]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPGRz-1idtks3oVh-00PdKv; Thu, 24
 Oct 2019 14:02:11 +0200
Date:   Thu, 24 Oct 2019 14:02:08 +0200
From:   Helge Deller <deller@gmx.de>
To:     Mike Rapoport <rppt@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 08/12] parisc: use pgtable-nopXd instead of 4level-fixup
Message-ID: <20191024120208.GA17545@ls3530.fritz.box>
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
 <1571822941-29776-9-git-send-email-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571822941-29776-9-git-send-email-rppt@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Provags-ID: V03:K1:r1gv/v0lqEe+bOB9wfxWZhIMST35qEY+LNwPO498vtsnue1RXl2
 lWQDLVWd80Z6a4Lj04aLo5FkmTg3OVUbn4v8jLwYceC1cgAZYOhiEAmkfk0R2eWIIxUv9gA
 cbubaamfTzFraEZ3mzmS2EFn24YRuV495qnagXRfvZoqh4K9b3N6jXYf5O3VWfod+/MTcmQ
 CN76kMYrHU87gXf/G1QHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iFOcPc+fCqA=:5hjzE9MtPU6n/6E7zSmXXU
 vJmjNuJ/0EYDqaUyH3HGtsNlpH2mXkPbwvmlQ/LFEeqrTQSy2gH7lTHRbwLirGOvXSU6IpWfR
 GcgI/eUOsdbtk2G2xIwPCY2SxPcFVIh1HNmpxqzBAPug89a0mNEsepSDEM7GFKhfdGtI2bltZ
 dPO9/usBAc4ROUDTvAHnWWWcuEu2TfV2Z8WMgaPtIjTN9qc78oZaoaEfEKzcB5j0GVrPLpDm9
 vzxGDbCHguHfr4FfBvl1Zy7kyr6Q5GZG8rg3edQmKQWDtFTvo4F3rjoqiyNzhII+XR8x6w6pk
 +94THkXKOVwumBi7Cu06zOiJEaNHnhqaERR6yduGtadCSxtUdT/TRrilO+JLRq/npk8PZ4N4/
 pXtCpT8/KkJxOKXRwZfdMNLqPHsIO/+2lRexjES0xnRxTZOpZZupplQGoNe2mxfxfHze/vxdL
 wW2zFmJsU0WWKxED5IOgZnkt9g0K7urfcqCCYtIrDGlCMc+4kxVNCdux0w4RGN6HGRtaP0ugo
 NWjE06Nkj+M3XWf8u4//ZXABix1FEnyvFrhDL3+IWmSoz0PpC439uEkks/RSEQFz3nSCM8nZ0
 bKDTtptootL7Ivacj6vh3lnCdjgfiX9ri59UfUu8nyAxVtWeC87EIyz4EHpxKbD4rpBA6T3O2
 /9sG0pYVSVoF037pbGXgZ+Sf9JxCVQ76ejH9vb2AnD5g01YfQG5mstre90Uj+Iatfj0FqnGBL
 6XTfyj/54bhXh5HNAlyqjiwyPCCZgCZboVw3UrKQzDfx2X7JM9tqUtJme8Yse0NjT8mz+msY1
 /OQP+JDsrDfz3AtxOtk2LbkF81bYt9Qx9VjswluvAudCxy746DoM+hkXqbUZzk4e/QZog1Do4
 99TIsrrTZbKZmuup4qGj9LV6Xq5T7EbkrayAKfA2RhepIRLTY6y71d1srK++gVTY8gXKNFF5J
 sXUNH0UNpNa8u91Vf4Vi225DOl0ImcQRAKC2I2Q/pC/3BaplwliJmRXLKkhjD9T5yzQPnRAJU
 8hhtbAyFiFTvLCVzGhyeW5MBrwD5S/fHQwIxeo+EAS/8lIGh2y1+zz9B6yWpHPKFSZSknipza
 WjXDZ1g292htA5hXnYrC01xRvRNxbaucQvWvcTXaBgPP5VFmmWRzSEI41jssIWVNaajaN4Gr0
 AVmO9BbOR9bEqpJ2yFFjuiaRVm35NNM15DcuyvVFi/ZuHa2GFUEzco6ahuaamUyU3EMSxPy3i
 CDPXCle0+T3MuFUtNsbbdAOd7DvUtNynrNcAMRw==
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mike Rapoport <rppt@kernel.org>:
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> parisc has two or three levels of page tables and can use appropriate
> pgtable-nopXd and folding of the upper layers.
>
> Replace usage of include/asm-generic/4level-fixup.h and explicit
> definitions of __PAGETABLE_PxD_FOLDED in parisc with
> include/asm-generic/pgtable-nopmd.h for two-level configurations and wit=
h
> include/asm-generic/pgtable-nopmd.h for three-lelve configurations and
> adjust page table manipulation macros and functions accordingly.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/parisc/include/asm/page.h    | 30 +++++++++++++---------
>  arch/parisc/include/asm/pgalloc.h | 41 +++++++++++-------------------
>  arch/parisc/include/asm/pgtable.h | 52 +++++++++++++++++++-------------=
-------
>  arch/parisc/include/asm/tlb.h     |  2 ++
>  arch/parisc/kernel/cache.c        | 13 ++++++----
>  arch/parisc/kernel/pci-dma.c      |  9 +++++--
>  arch/parisc/mm/fixmap.c           | 10 +++++---
>  7 files changed, 81 insertions(+), 76 deletions(-)

Mike, thanks for this clean-up!

Your patch is functional OK. I successfully tested it with a 32-bit
kernel in qemu, and with a 64-bit kernel on a physical box.
For 64-bit you missed to adapt the parisc hugetlb code, so maybe you
can add the patch below to your series?

Other than that (and the lexical corrections which other already mentioned=
):
Acked-by: Helge Deller <deller@gmx.de>

Thanks!
Helge

=2D---------------
parisc/hugetlb: use pgtable-nopXd instead of 4level-fixup

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/arch/parisc/mm/hugetlbpage.c b/arch/parisc/mm/hugetlbpage.c
index d578809e55cf..0e1e212f1c96 100644
=2D-- a/arch/parisc/mm/hugetlbpage.c
+++ b/arch/parisc/mm/hugetlbpage.c
@@ -49,6 +49,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 			unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte =3D NULL;
@@ -61,7 +62,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 	addr &=3D HPAGE_MASK;

 	pgd =3D pgd_offset(mm, addr);
-	pud =3D pud_alloc(mm, pgd, addr);
+	p4d =3D p4d_offset(pgd, addr);
+	pud =3D pud_alloc(mm, p4d, addr);
 	if (pud) {
 		pmd =3D pmd_alloc(mm, pud, addr);
 		if (pmd)
@@ -74,6 +76,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz)
 {
 	pgd_t *pgd;
+	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte =3D NULL;
@@ -82,11 +85,14 @@ pte_t *huge_pte_offset(struct mm_struct *mm,

 	pgd =3D pgd_offset(mm, addr);
 	if (!pgd_none(*pgd)) {
-		pud =3D pud_offset(pgd, addr);
-		if (!pud_none(*pud)) {
-			pmd =3D pmd_offset(pud, addr);
-			if (!pmd_none(*pmd))
-				pte =3D pte_offset_map(pmd, addr);
+		p4d =3D p4d_offset(pgd, addr);
+		if (!p4d_none(*p4d)) {
+			pud =3D pud_offset(p4d, addr);
+			if (!pud_none(*pud)) {
+				pmd =3D pmd_offset(pud, addr);
+				if (!pmd_none(*pmd))
+					pte =3D pte_offset_map(pmd, addr);
+			}
 		}
 	}
 	return pte;





