Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1137EC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91BC20665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997145;
	bh=ORC6eTDK2VYgx5goqOcD4F+nOhoZY/xvzPSzuNIr0xQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T+paftZ1K//e02/H0hTuBiFtYvmUWsU5unY+fzu2/zZM2RgWtv5FHc0PM6B560RDI
	 pnObGEGVkBrLsBn9XF751x0OInKiQlLvmMY3FAqQEYXvWBmg+gHEAu75Hf7UaTIqVF
	 EcK/8zZu8wdMdbSbJBkvaxbfhSkCZJRtf5fzXygs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389852AbfGXTjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:39:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389063AbfGXTjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:39:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D25822ADA;
        Wed, 24 Jul 2019 19:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997142;
        bh=ORC6eTDK2VYgx5goqOcD4F+nOhoZY/xvzPSzuNIr0xQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dMP5qTl3ZjK3iefyVDvo9qYqWyf020UriZPHavkiPoQ3vu+Bty23XORtbRer7cnBA
         HyZPzy13YQPxitRrge1Nzg1UuFGEFTqKSeEq6cb43q1uLtkrPmFj0GR5onZ6X7ULmA
         v9Q80f4OkI8BB8BId3MMc9uQz7upjZ3sotOCs1Ec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.2 334/413] KVM: PPC: Book3S HV: Fix CR0 setting in TM emulation
Date:   Wed, 24 Jul 2019 21:20:25 +0200
Message-Id: <20190724191759.719826993@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Neuling <mikey@neuling.org>

commit 3fefd1cd95df04da67c83c1cb93b663f04b3324f upstream.

When emulating tsr, treclaim and trechkpt, we incorrectly set CR0. The
code currently sets:
    CR0 <- 00 || MSR[TS]
but according to the ISA it should be:
    CR0 <-  0 || MSR[TS] || 0

This fixes the bit shift to put the bits in the correct location.

This is a data integrity issue as CR0 is corrupted.

Fixes: 4bb3c7a0208f ("KVM: PPC: Book3S HV: Work around transactional memory bugs in POWER9")
Cc: stable@vger.kernel.org # v4.17+
Tested-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kvm/book3s_hv_tm.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/powerpc/kvm/book3s_hv_tm.c
+++ b/arch/powerpc/kvm/book3s_hv_tm.c
@@ -128,7 +128,7 @@ int kvmhv_p9_tm_emulation(struct kvm_vcp
 		}
 		/* Set CR0 to indicate previous transactional state */
 		vcpu->arch.regs.ccr = (vcpu->arch.regs.ccr & 0x0fffffff) |
-			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 28);
+			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 29);
 		/* L=1 => tresume, L=0 => tsuspend */
 		if (instr & (1 << 21)) {
 			if (MSR_TM_SUSPENDED(msr))
@@ -172,7 +172,7 @@ int kvmhv_p9_tm_emulation(struct kvm_vcp
 
 		/* Set CR0 to indicate previous transactional state */
 		vcpu->arch.regs.ccr = (vcpu->arch.regs.ccr & 0x0fffffff) |
-			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 28);
+			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 29);
 		vcpu->arch.shregs.msr &= ~MSR_TS_MASK;
 		return RESUME_GUEST;
 
@@ -202,7 +202,7 @@ int kvmhv_p9_tm_emulation(struct kvm_vcp
 
 		/* Set CR0 to indicate previous transactional state */
 		vcpu->arch.regs.ccr = (vcpu->arch.regs.ccr & 0x0fffffff) |
-			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 28);
+			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 29);
 		vcpu->arch.shregs.msr = msr | MSR_TS_S;
 		return RESUME_GUEST;
 	}


