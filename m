Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FA4C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D28D222C3
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642306;
	bh=iTZR3SpRq2wY9Ep4gpB+c/ynW1BnyIfbSusvbnoKGPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ugMFKja78JzHMn2zYgXnu0FSmkVO494dEYQbLXaOqe4VYXB8SBzidGbGyyJOryZ5O
	 uBpMdxIJJadW4rX+gkIjQkJURfVqo+pEGIbR94Hm28SoYYjQ60SHkx9m83ZxuoqHbO
	 z3gIUXuDM3zZTPw4cG2p1RtUmdDpIQZVRUqWe05E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387520AbfL2R6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:58:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:49310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387469AbfL2R6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:58:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0B89206DB;
        Sun, 29 Dec 2019 17:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642297;
        bh=iTZR3SpRq2wY9Ep4gpB+c/ynW1BnyIfbSusvbnoKGPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ztsiq1lgPa7ZFHVp+HbSAzu7X0ZMTW/839Wv0Djd+HC6rHihkNvjlwjmaWdZqR5uV
         O28UnbAMeXeqvNXhT3ChcLyvFfj3nxaKXUL+jcy06EFqcq39QOYwoSwFEW8Ylv9ZxM
         Buu3IPLUdBx1m90cZnrLicwDcdRSGw+2Oed8TIOM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Jacob Xu <jacobhxu@google.com>,
        Peter Shier <pshier@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 5.4 417/434] kvm: x86: Host feature SSBD doesnt imply guest feature AMD_SSBD
Date:   Sun, 29 Dec 2019 18:27:50 +0100
Message-Id: <20191229172730.635509330@linuxfoundation.org>
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

commit 8715f05269bfbc6453e25e80825d781a82902f8e upstream.

The host reports support for the synthetic feature X86_FEATURE_SSBD
when any of the three following hardware features are set:
  CPUID.(EAX=7,ECX=0):EDX.SSBD[bit 31]
  CPUID.80000008H:EBX.AMD_SSBD[bit 24]
  CPUID.80000008H:EBX.VIRT_SSBD[bit 25]

Either of the first two hardware features implies the existence of the
IA32_SPEC_CTRL MSR, but CPUID.80000008H:EBX.VIRT_SSBD[bit 25] does
not. Therefore, CPUID.80000008H:EBX.AMD_SSBD[bit 24] should only be
set in the guest if CPUID.(EAX=7,ECX=0):EDX.SSBD[bit 31] or
CPUID.80000008H:EBX.AMD_SSBD[bit 24] is set on the host.

Fixes: 4c6903a0f9d76 ("KVM: x86: fix reporting of AMD speculation bug CPUID leaf")
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
@@ -760,7 +760,8 @@ static inline int __do_cpuid_func(struct
 			entry->ebx |= F(AMD_IBRS);
 		if (boot_cpu_has(X86_FEATURE_STIBP))
 			entry->ebx |= F(AMD_STIBP);
-		if (boot_cpu_has(X86_FEATURE_SSBD))
+		if (boot_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) ||
+		    boot_cpu_has(X86_FEATURE_AMD_SSBD))
 			entry->ebx |= F(AMD_SSBD);
 		if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
 			entry->ebx |= F(AMD_SSB_NO);


