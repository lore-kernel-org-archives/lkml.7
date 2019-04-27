Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3E0C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F7A208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfD0PYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:24:22 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33492 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727468AbfD0PP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:27 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2x-00014C-Rk; Sat, 27 Apr 2019 16:15:24 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-0004ac-GC; Sat, 27 Apr 2019 16:15:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jim Mattson" <jmattson@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        "Zdenek Kaspar" <zkaspar82@gmail.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.569842885@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 148/202] x86/kvm/nVMX: read from MSR_IA32_VMX_PROCBASED_CTLS2
 only when it is available
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Kuznetsov <vkuznets@redhat.com>

commit 6b1971c694975e49af302229202c0043568b1791 upstream.

SDM says MSR_IA32_VMX_PROCBASED_CTLS2 is only available "If
(CPUID.01H:ECX.[5] && IA32_VMX_PROCBASED_CTLS[63])". It was found that
some old cpus (namely "Intel(R) Core(TM)2 CPU 6600 @ 2.40GHz (family: 0x6,
model: 0xf, stepping: 0x6") don't have it. Add the missing check.

Reported-by: Zdenek Kaspar <zkaspar82@gmail.com>
Tested-by: Zdenek Kaspar <zkaspar82@gmail.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[bwh: Backported to 3.16:
 - The MSR values are stored in static variables
 - Adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2320,8 +2320,11 @@ static __init void nested_vmx_setup_ctls
 	nested_vmx_procbased_ctls_high |= CPU_BASED_USE_MSR_BITMAPS;
 
 	/* secondary cpu-based controls */
-	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,
-		nested_vmx_secondary_ctls_low, nested_vmx_secondary_ctls_high);
+	if (nested_vmx_procbased_ctls_high & CPU_BASED_ACTIVATE_SECONDARY_CONTROLS)
+		rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,
+		      nested_vmx_secondary_ctls_low,
+		      nested_vmx_secondary_ctls_high);
+
 	nested_vmx_secondary_ctls_low = 0;
 	nested_vmx_secondary_ctls_high &=
 		SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |

