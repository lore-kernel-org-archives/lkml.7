Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2FDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BB320685
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257476;
	bh=5MVnA7CHGmUTFN8iQw6p49DZflFClmoihRffN3MyVAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cHK5NpfiigttgEYGlrvoV5hO5SNfjSNJYB3DFvPLhNnVRDOy+Cm7dwum1K7maGocv
	 Gnxd+Li97x7VmOHEzhoiz/W3/iDMl86zyr5DbJAjrx9e6irGetlYKmOtEV/XwZ5qaP
	 cRaNylbn9bn6u8pBQgqt9fBjm3jpx+kPMbOIpSJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391257AbfCVMYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:24:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403792AbfCVMY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:24:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD4862054F;
        Fri, 22 Mar 2019 12:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257469;
        bh=5MVnA7CHGmUTFN8iQw6p49DZflFClmoihRffN3MyVAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jieHLzMzOhLBM/HfRDMhyiceqLiOanOaBclh4r1pXpD1Y/2hATTR75YatdaPR1wSB
         6t8yd0Peb5U0VcaEFeJjFLWKQnLgc6pOBQv3QILiLc6T+IvVGyii59Zsdcg9D4lMuD
         EOWUctla+4g9NKSNGDNwOJKhXfGd/aLXJYLJ3McY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.0 232/238] KVM: nVMX: Check a single byte for VMCS "launched" in nested early checks
Date:   Fri, 22 Mar 2019 12:17:31 +0100
Message-Id: <20190322111312.070930068@linuxfoundation.org>
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

commit 1ce072cbfd8dba46f117804850398e0b3040a541 upstream.

Nested early checks does a manual comparison of a VMCS' launched status
in its asm blob to execute the correct VM-Enter instruction, i.e.
VMLAUNCH vs. VMRESUME.  The launched flag is a bool, which is a typedef
of _Bool.  C99 does not define an exact size for _Bool, stating only
that is must be large enough to hold '0' and '1'.  Most, if not all,
compilers use a single byte for _Bool, including gcc[1].

The use of 'cmpl' instead of 'cmpb' was not deliberate, but rather the
result of a copy-paste as the asm blob was directly derived from the asm
blob for vCPU-run.

This has not caused any known problems, likely due to compilers aligning
variables to 4-byte or 8-byte boundaries and KVM zeroing out struct
vcpu_vmx during allocation.  I.e. vCPU-run accesses "junk" data, it just
happens to always be zero and so doesn't affect the result.

[1] https://gcc.gnu.org/ml/gcc-patches/2000-10/msg01127.html

Fixes: 52017608da33 ("KVM: nVMX: add option to perform early consistency checks via H/W")
Cc: <stable@vger.kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx/nested.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2765,7 +2765,7 @@ static int nested_vmx_check_vmentry_hw(s
 		"add $%c[wordsize], %%" _ASM_SP "\n\t" /* un-adjust RSP */
 
 		/* Check if vmlaunch or vmresume is needed */
-		"cmpl $0, %c[launched](%% " _ASM_CX")\n\t"
+		"cmpb $0, %c[launched](%% " _ASM_CX")\n\t"
 
 		"call vmx_vmenter\n\t"
 


