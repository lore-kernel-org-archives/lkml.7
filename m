Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8541EC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F76621855
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562054810;
	bh=JzhaEiPOMzUPEDdCttlNaZQHACR4FpyS+c4Ey6GXKhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LW6BKQWwfaE4YD94JMl+Whke9/QTLWTQgyZbN3+0D2Fzqv+aaZL743frO5QPM3CYC
	 n7ZtHmukhYNsOtQwWdZcOB+Xnmv7C3pyxc2pfUVpiLVFQmKBVo2B+DgrVR6Cb97Y2H
	 mdEKWGGSGXicaeUaCxropOSRZfLBD3KUh1mL01L0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfGBIGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:06:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbfGBIGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:06:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A18DC21851;
        Tue,  2 Jul 2019 08:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054806;
        bh=JzhaEiPOMzUPEDdCttlNaZQHACR4FpyS+c4Ey6GXKhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SqyRqtOx3do88SYZcz1QFU78yy7LtsAgEUo0nROWbRvMTd8FIXF5UgDKp3JflsGBi
         XYqg4Zm0nFab9o0mg8UF0xatl0bht5vMzmS0l2umo2xyuKo0fMQmcQV412HumzipKl
         1PK8udkDULzhXpNXiP/1kykXpPizfJSCX058cOVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Liam Merwick <liam.merwick@oracle.com>,
        Mark Kanda <mark.kanda@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>, bp@alien8.de,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Subject: [PATCH 4.19 41/72] x86/speculation: Allow guests to use SSBD even if host does not
Date:   Tue,  2 Jul 2019 10:01:42 +0200
Message-Id: <20190702080126.783958835@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080124.564652899@linuxfoundation.org>
References: <20190702080124.564652899@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

commit c1f7fec1eb6a2c86d01bc22afce772c743451d88 upstream.

The bits set in x86_spec_ctrl_mask are used to calculate the guest's value
of SPEC_CTRL that is written to the MSR before VMENTRY, and control which
mitigations the guest can enable.  In the case of SSBD, unless the host has
enabled SSBD always on mode (by passing "spec_store_bypass_disable=on" in
the kernel parameters), the SSBD bit is not set in the mask and the guest
can not properly enable the SSBD always on mitigation mode.

This has been confirmed by running the SSBD PoC on a guest using the SSBD
always on mitigation mode (booted with kernel parameter
"spec_store_bypass_disable=on"), and verifying that the guest is vulnerable
unless the host is also using SSBD always on mode. In addition, the guest
OS incorrectly reports the SSB vulnerability as mitigated.

Always set the SSBD bit in x86_spec_ctrl_mask when the host CPU supports
it, allowing the guest to use SSBD whether or not the host has chosen to
enable the mitigation in any of its modes.

Fixes: be6fcb5478e9 ("x86/bugs: Rework spec_ctrl base and mask logic")
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: bp@alien8.de
Cc: rkrcmar@redhat.com
Cc: kvm@vger.kernel.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1560187210-11054-1-git-send-email-alejandro.j.jimenez@oracle.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/bugs.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -821,6 +821,16 @@ static enum ssb_mitigation __init __ssb_
 	}
 
 	/*
+	 * If SSBD is controlled by the SPEC_CTRL MSR, then set the proper
+	 * bit in the mask to allow guests to use the mitigation even in the
+	 * case where the host does not enable it.
+	 */
+	if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) ||
+	    static_cpu_has(X86_FEATURE_AMD_SSBD)) {
+		x86_spec_ctrl_mask |= SPEC_CTRL_SSBD;
+	}
+
+	/*
 	 * We have three CPU feature flags that are in play here:
 	 *  - X86_BUG_SPEC_STORE_BYPASS - CPU is susceptible.
 	 *  - X86_FEATURE_SSBD - CPU is able to turn off speculative store bypass
@@ -837,7 +847,6 @@ static enum ssb_mitigation __init __ssb_
 			x86_amd_ssb_disable();
 		} else {
 			x86_spec_ctrl_base |= SPEC_CTRL_SSBD;
-			x86_spec_ctrl_mask |= SPEC_CTRL_SSBD;
 			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
 		}
 	}


