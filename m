Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A585EC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7621B206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642345;
	bh=gXczSCKfbm7Y32nkafn2lyCz6yLvKuk/egGe9LBwxvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1bmTVkD9/7YBZP8Lm9z0Pxd4gdJs0V+OzhOtW4Qf3aGlbRyWUwMZgrZGrqTFBVG/a
	 KiIUC2jOpX9Z/mo36FOvKHn/rfDW761as2IZAzzMcd5U9F7Vdo0ByWrCFhJ0ENahuG
	 ZpBkurkOvI+6Kajey9ivjC7NJF0Kw1/TSGKTFhds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387664AbfL2R7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:59:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:50472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732690AbfL2R7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:59:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69430206DB;
        Sun, 29 Dec 2019 17:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642339;
        bh=gXczSCKfbm7Y32nkafn2lyCz6yLvKuk/egGe9LBwxvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SyDBp+1/7eXeqioE3C6oDp28mmNipJbCY3k4Q/pR6eBl/3i/pvrFbe5mvl7FfsijB
         CCY+giss7f/nh+hMo3+gHn0PkpbcJitChx0Fmhu7Y3VyYl5ahv5/KWXxphQ+w+Vn2n
         du7mRxZM7kfM+4jYYORCcTfCIVpNOQR6aWzELQRQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Jacob Xu <jacobhxu@google.com>,
        Peter Shier <pshier@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 5.4 416/434] kvm: x86: Host feature SSBD doesnt imply guest feature SPEC_CTRL_SSBD
Date:   Sun, 29 Dec 2019 18:27:49 +0100
Message-Id: <20191229172730.516907684@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Mattson <jmattson@google.com>

commit 396d2e878f92ec108e4293f1c77ea3bc90b414ff upstream.

The host reports support for the synthetic feature X86_FEATURE_SSBD
when any of the three following hardware features are set:
  CPUID.(EAX=7,ECX=0):EDX.SSBD[bit 31]
  CPUID.80000008H:EBX.AMD_SSBD[bit 24]
  CPUID.80000008H:EBX.VIRT_SSBD[bit 25]

Either of the first two hardware features implies the existence of the
IA32_SPEC_CTRL MSR, but CPUID.80000008H:EBX.VIRT_SSBD[bit 25] does
not. Therefore, CPUID.(EAX=7,ECX=0):EDX.SSBD[bit 31] should only be
set in the guest if CPUID.(EAX=7,ECX=0):EDX.SSBD[bit 31] or
CPUID.80000008H:EBX.AMD_SSBD[bit 24] is set on the host.

Fixes: 0c54914d0c52a ("KVM: x86: use Intel speculation bugs and features as derived in generic x86 code")
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Jacob Xu <jacobhxu@google.com>
Reviewed-by: Peter Shier <pshier@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: stable@vger.kernel.org
Reported-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/cpuid.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -402,7 +402,8 @@ static inline void do_cpuid_7_mask(struc
 			entry->edx |= F(SPEC_CTRL);
 		if (boot_cpu_has(X86_FEATURE_STIBP))
 			entry->edx |= F(INTEL_STIBP);
-		if (boot_cpu_has(X86_FEATURE_SSBD))
+		if (boot_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) ||
+		    boot_cpu_has(X86_FEATURE_AMD_SSBD))
 			entry->edx |= F(SPEC_CTRL_SSBD);
 		/*
 		 * We emulate ARCH_CAPABILITIES in software even


