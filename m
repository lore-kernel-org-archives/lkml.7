Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB40C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D2C206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381480;
	bh=VKeBhnU2OZGxUtOFmDwiH/+gnCKfaZhuTAMfn4Ruuwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RR1Pe6CDsXRRKPXLobYNgH4roAKHpDwIba/YG6EHqnlHmCtl6g8ue/09PPMqqdoVE
	 RN74eCRvVdN62qlcCCkp/TirXlxnwr1pGYJNP+1Ni6BWgDN9KMvGCoJysQ9D+3HiIq
	 yIyVIn4nvmLkcx+GEuguPffAr8l2oVFfbn/oHL+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391713AbfIMNbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:31:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388270AbfIMNPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:15:09 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEB0B206BB;
        Fri, 13 Sep 2019 13:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380507;
        bh=VKeBhnU2OZGxUtOFmDwiH/+gnCKfaZhuTAMfn4Ruuwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=axUsc4X+i9SYojsR9AKEpARj5OLIoaerTTcUQSWXh6y1HKA4yjqTJL7m7PiLVZl4j
         vw0AInNk/c+lbZ/ZqECGpzc7DykZK8p2iTmQGzWnJebNsPIAUzixNWQALTQscqP1i4
         /dEB5eE0tywRuCjzcujfTDn20QPby1dlccungX+U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 087/190] KVM: VMX: Compare only a single byte for VMCS "launched" in vCPU-run
Date:   Fri, 13 Sep 2019 14:05:42 +0100
Message-Id: <20190913130606.517354432@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 61c08aa9606d4e48a8a50639c956448a720174c3 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 2e310ea62d609..562f5dc4645b6 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10808,7 +10808,7 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		"mov %%" _ASM_AX", %%cr2 \n\t"
 		"3: \n\t"
 		/* Check if vmlaunch of vmresume is needed */
-		"cmpl $0, %c[launched](%0) \n\t"
+		"cmpb $0, %c[launched](%0) \n\t"
 		/* Load guest registers.  Don't clobber flags. */
 		"mov %c[rax](%0), %%" _ASM_AX " \n\t"
 		"mov %c[rbx](%0), %%" _ASM_BX " \n\t"
-- 
2.20.1



