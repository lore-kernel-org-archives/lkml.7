Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B74C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B09B20740
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573798886;
	bh=qYyzXt7umkf9Q1uRUWIFOcGRA0/84gaxMKeaYozMFVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CTNBs3MLfnrlmg+0Vhum1F6+E4RXXztfpmMPmbfzq6tEaFa/4cu3B6QCsFPkSuqee
	 tD9Ogu+nAaXkQZ0AYdY/itoRczvRec/YOtfPnlis111XSJ3JlP8dOLwnNGb32ZmZvH
	 Zq1tYIqAhFtT40ncWmUz5Z6dydDPc4R7Z/qLboLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfKOGVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 01:21:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:50124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbfKOGVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 01:21:22 -0500
Received: from localhost (unknown [104.132.150.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49A022073A;
        Fri, 15 Nov 2019 06:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573798881;
        bh=qYyzXt7umkf9Q1uRUWIFOcGRA0/84gaxMKeaYozMFVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=enSfNf5O00CqqQQfAukEpUPhhLX8be30OhnsiNaZ11zuBE5uESVn9Zw5bFrEXRYTZ
         ogfTEu0Hsf4UcmCZohdk6ka2No/dTw3G5QDmUT45DfaHZCRk2gkMW8SpR6+xgQo0tJ
         tcWommAEqMQfcLCJOmqwHPc227Ony3klDClDCZJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Neelima Krishnan <neelima.krishnan@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.4 15/20] kvm/x86: Export MDS_NO=0 to guests when TSX is enabled
Date:   Fri, 15 Nov 2019 14:20:44 +0800
Message-Id: <20191115062013.337413821@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191115062006.854443935@linuxfoundation.org>
References: <20191115062006.854443935@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

commit e1d38b63acd843cfdd4222bf19a26700fd5c699e upstream.

Export the IA32_ARCH_CAPABILITIES MSR bit MDS_NO=0 to guests on TSX
Async Abort(TAA) affected hosts that have TSX enabled and updated
microcode. This is required so that the guests don't complain,

  "Vulnerable: Clear CPU buffers attempted, no microcode"

when the host has the updated microcode to clear CPU buffers.

Microcode update also adds support for MSR_IA32_TSX_CTRL which is
enumerated by the ARCH_CAP_TSX_CTRL bit in IA32_ARCH_CAPABILITIES MSR.
Guests can't do this check themselves when the ARCH_CAP_TSX_CTRL bit is
not exported to the guests.

In this case export MDS_NO=0 to the guests. When guests have
CPUID.MD_CLEAR=1, they deploy MDS mitigation which also mitigates TAA.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Neelima Krishnan <neelima.krishnan@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/x86.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1008,6 +1008,25 @@ u64 kvm_get_arch_capabilities(void)
 	if (!boot_cpu_has_bug(X86_BUG_MDS))
 		data |= ARCH_CAP_MDS_NO;
 
+	/*
+	 * On TAA affected systems, export MDS_NO=0 when:
+	 *	- TSX is enabled on the host, i.e. X86_FEATURE_RTM=1.
+	 *	- Updated microcode is present. This is detected by
+	 *	  the presence of ARCH_CAP_TSX_CTRL_MSR and ensures
+	 *	  that VERW clears CPU buffers.
+	 *
+	 * When MDS_NO=0 is exported, guests deploy clear CPU buffer
+	 * mitigation and don't complain:
+	 *
+	 *	"Vulnerable: Clear CPU buffers attempted, no microcode"
+	 *
+	 * If TSX is disabled on the system, guests are also mitigated against
+	 * TAA and clear CPU buffer mitigation is not required for guests.
+	 */
+	if (boot_cpu_has_bug(X86_BUG_TAA) && boot_cpu_has(X86_FEATURE_RTM) &&
+	    (data & ARCH_CAP_TSX_CTRL_MSR))
+		data &= ~ARCH_CAP_MDS_NO;
+
 	return data;
 }
 


