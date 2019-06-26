Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4EDC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD8D2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gmoxh7Lk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfFZOng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:43:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44661 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfFZOnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:43:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5QEh2jm4146759
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 26 Jun 2019 07:43:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5QEh2jm4146759
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561560183;
        bh=SqvD6PO80P7lVqvvX1dp+MzC/918X1RgXuNNpMNGRVg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gmoxh7LkQlAE9DitxSQlXT+6Ew4unElbG7UZMUcIifRt3LfW58+ydcedPAZ9bzAmJ
         IIlNwlmYjcAYK9UJ2aewgCGcV5uOuVvFBbBSh2iABsWMS6OwOdrVCIFWHCJAesQiDT
         fPczaL9so6E7mBDydXTu7tVQuhMThT4wZhEYcxs9s4xMkLMJZJYSMsvTMz01sCUpr5
         0N2ByeN9+Bt8Og3NET8TLJKa3k4iFu284a2MZiFB9rncYtpn8WlOixgljEFJd6xbDd
         IZcWn8h4qr8Drf4oSITE9+q+6lG3KYbivFvizhEroBrMeYp0gLDDbGqHwgEQwwHRl7
         16u06rMPrA7Fw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5QEh2Kc4146756;
        Wed, 26 Jun 2019 07:43:02 -0700
Date:   Wed, 26 Jun 2019 07:43:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alejandro Jimenez <tipbot@zytor.com>
Message-ID: <tip-c1f7fec1eb6a2c86d01bc22afce772c743451d88@git.kernel.org>
Cc:     hpa@zytor.com, pbonzini@redhat.com, mark.kanda@oracle.com,
        tglx@linutronix.de, mingo@kernel.org,
        alejandro.j.jimenez@oracle.com, liam.merwick@oracle.com,
        linux-kernel@vger.kernel.org
Reply-To: pbonzini@redhat.com, hpa@zytor.com, tglx@linutronix.de,
          mingo@kernel.org, mark.kanda@oracle.com,
          alejandro.j.jimenez@oracle.com, linux-kernel@vger.kernel.org,
          liam.merwick@oracle.com
In-Reply-To: <1560187210-11054-1-git-send-email-alejandro.j.jimenez@oracle.com>
References: <1560187210-11054-1-git-send-email-alejandro.j.jimenez@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/speculation: Allow guests to use SSBD even if
 host does not
Git-Commit-ID: c1f7fec1eb6a2c86d01bc22afce772c743451d88
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c1f7fec1eb6a2c86d01bc22afce772c743451d88
Gitweb:     https://git.kernel.org/tip/c1f7fec1eb6a2c86d01bc22afce772c743451d88
Author:     Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
AuthorDate: Mon, 10 Jun 2019 13:20:10 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 26 Jun 2019 16:38:36 +0200

x86/speculation: Allow guests to use SSBD even if host does not

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

---
 arch/x86/kernel/cpu/bugs.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 03b4cc0ec3a7..66ca906aa790 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -835,6 +835,16 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
 		break;
 	}
 
+	/*
+	 * If SSBD is controlled by the SPEC_CTRL MSR, then set the proper
+	 * bit in the mask to allow guests to use the mitigation even in the
+	 * case where the host does not enable it.
+	 */
+	if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) ||
+	    static_cpu_has(X86_FEATURE_AMD_SSBD)) {
+		x86_spec_ctrl_mask |= SPEC_CTRL_SSBD;
+	}
+
 	/*
 	 * We have three CPU feature flags that are in play here:
 	 *  - X86_BUG_SPEC_STORE_BYPASS - CPU is susceptible.
@@ -852,7 +862,6 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
 			x86_amd_ssb_disable();
 		} else {
 			x86_spec_ctrl_base |= SPEC_CTRL_SSBD;
-			x86_spec_ctrl_mask |= SPEC_CTRL_SSBD;
 			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
 		}
 	}
