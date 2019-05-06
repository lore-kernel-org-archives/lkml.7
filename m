Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124CEC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE28214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153492;
	bh=BaH+cTG8MNxmf2G1evFZX/hJl0oSG6msQP0eoWe5B9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EE4CQ+UCdMYHp290hj+C60QQJJ/UIl+ccMVjFCgOI/WR9f2bXYfcWIPUIGS3d1PYR
	 oRoitTWE8joibfs8oSOYIdJuFTxBUC0+m9sTMIJUMB1Q58Kfzw7+mJqgRFrZGeJi5M
	 HtLc7UszNwAeqsYNR/VqPHRY46Br4U4Yb0GReQS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfEFOiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbfEFOiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:38:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B1EE214C6;
        Mon,  6 May 2019 14:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153487;
        bh=BaH+cTG8MNxmf2G1evFZX/hJl0oSG6msQP0eoWe5B9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S9kZIG5APcdx2bczeVxadHxAvm5D9hbXvw/CKTZTjKfuYpBkrrMjON16RG53cDvrq
         UK3moMNGA+zVinrWeOSzMQPF0HWaHR/m3PKrAWGlFbLFbV/SwITY5zR4jkxNcdipT6
         G1pvvi4dYtu+sWaRlBywYGBb1bbvU5EGp/ARowds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.0 100/122] KVM: VMX: Save RSI to an unused output in the vCPU-run asm blob
Date:   Mon,  6 May 2019 16:32:38 +0200
Message-Id: <20190506143103.757242468@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit f3689e3f17f064fd4cd5f0cb01ae2395c94f39d9 upstream.

RSI is clobbered by the vCPU-run asm blob, but it's not marked as such,
probably because GCC doesn't let you mark inputs as clobbered.  "Save"
RSI to a dummy output so that GCC recognizes it as being clobbered.

Fixes: 773e8a0425c9 ("x86/kvm: use Enlightened VMCS when running on Hyper-V")
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx/vmx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6465,7 +6465,7 @@ static void __vmx_vcpu_run(struct kvm_vc
 		"xor %%edi, %%edi \n\t"
 		"xor %%ebp, %%ebp \n\t"
 		"pop  %%" _ASM_BP "; pop  %%" _ASM_DX " \n\t"
-	      : ASM_CALL_CONSTRAINT
+	      : ASM_CALL_CONSTRAINT, "=S"((int){0})
 	      : "c"(vmx), "d"((unsigned long)HOST_RSP), "S"(evmcs_rsp),
 		[launched]"i"(offsetof(struct vcpu_vmx, __launched)),
 		[fail]"i"(offsetof(struct vcpu_vmx, fail)),


