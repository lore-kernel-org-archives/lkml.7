Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4919CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA3B2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257542;
	bh=+1PYINcUFQ56bOHgp+tVwe2tJ9XzuE/XqUX17EGUyL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PMdjNP+2W1T7K7iXncMgxvb3M8a/f97Xyjx841C/LZaFmVS8PV/Jzf6sVmsfAZiG6
	 94G12op2xNrJe+XXRrTI67ipzWaxDMVP6v9Dtg2tT6vsf3KuVSLI47pDMiOfhRTsZZ
	 qJCcEwrsGAqtdfCuI/a8ewVRIePR/xvUfYh2ouc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391160AbfCVMXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:23:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390655AbfCVMXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:23:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95479218A1;
        Fri, 22 Mar 2019 12:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257419;
        bh=+1PYINcUFQ56bOHgp+tVwe2tJ9XzuE/XqUX17EGUyL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tq5O+YLj3ro8258MaOwQIPEZqcg2wRR5LzTI0p1+FV/bxHUAKOjUadQNA8IHkLb8Z
         N59PDEyvv2+GogK3Zj90q5tPnphO1GlcuGKp2kc7YUbmFF6KSWCQsDoXEvnqM9KuWg
         ZxO11FKMCmu2Pu40P5bUIa4dnDqlG5a2qY4JkcBk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.0 225/238] KVM: VMX: Compare only a single byte for VMCS "launched" in vCPU-run
Date:   Fri, 22 Mar 2019 12:17:24 +0100
Message-Id: <20190322111311.621105920@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 61c08aa9606d4e48a8a50639c956448a720174c3 upstream.

The vCPU-run asm blob does a manual comparison of a VMCS' launched
status to execute the correct VM-Enter instruction, i.e. VMLAUNCH vs.
VMRESUME.  The launched flag is a bool, which is a typedef of _Bool.
C99 does not define an exact size for _Bool, stating only that is must
be large enough to hold '0' and '1'.  Most, if not all, compilers use
a single byte for _Bool, including gcc[1].

Originally, 'launched' was of type 'int' and so the asm blob used 'cmpl'
to check the launch status.  When 'launched' was moved to be stored on a
per-VMCS basis, struct vcpu_vmx's "temporary" __launched flag was added
in order to avoid having to pass the current VMCS into the asm blob.
The new  '__launched' was defined as a 'bool' and not an 'int', but the
'cmp' instruction was not updated.

This has not caused any known problems, likely due to compilers aligning
variables to 4-byte or 8-byte boundaries and KVM zeroing out struct
vcpu_vmx during allocation.  I.e. vCPU-run accesses "junk" data, it just
happens to always be zero and so doesn't affect the result.

[1] https://gcc.gnu.org/ml/gcc-patches/2000-10/msg01127.html

Fixes: d462b8192368 ("KVM: VMX: Keep list of loaded VMCSs, instead of vcpus")
Cc: <stable@vger.kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx/vmx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6399,7 +6399,7 @@ static void __vmx_vcpu_run(struct kvm_vc
 		"mov %%" _ASM_AX", %%cr2 \n\t"
 		"3: \n\t"
 		/* Check if vmlaunch or vmresume is needed */
-		"cmpl $0, %c[launched](%%" _ASM_CX ") \n\t"
+		"cmpb $0, %c[launched](%%" _ASM_CX ") \n\t"
 		/* Load guest registers.  Don't clobber flags. */
 		"mov %c[rax](%%" _ASM_CX "), %%" _ASM_AX " \n\t"
 		"mov %c[rbx](%%" _ASM_CX "), %%" _ASM_BX " \n\t"


