Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1524FC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE84521775
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518991;
	bh=twlSvSLJpbpIjcmSMCIchDBYbKZAHazciYiLj5xREQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gWUSUdsuHbtQ8BZTJHOQ8aH7wcwd+nXfdBZzQZgYnzPb3bDeR8xJ5eoq5usTHIypz
	 /BSvwyskKpb0QM2Rcl3oY13uvVWrltfwdN6WfxaedZ5FsWQPCTaWL/3AXluwuOYCXZ
	 BldOinW4U/E0hpUlRBD6b3K1u1jjw1iIOESKtnTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfLPR4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:56:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728221AbfLPR43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:56:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DA4521739;
        Mon, 16 Dec 2019 17:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518988;
        bh=twlSvSLJpbpIjcmSMCIchDBYbKZAHazciYiLj5xREQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FcwBvpn2q1RNvSzdsjD/phqzwOoMsf3jC51z1iPymfyY0ncot3fCR8T8gvqyiI7cN
         SnClW8pUm+N7+DPv3rDRT25/VsWPiuMmbyquXixeIuWHUyyZAU+e/79KHB4I6wGrOs
         GYzAo4Uo89fTnjkfTE85D/7/u+Kj1qbJgg/Wdkrg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.14 142/267] KVM: x86: fix presentation of TSX feature in ARCH_CAPABILITIES
Date:   Mon, 16 Dec 2019 18:47:48 +0100
Message-Id: <20191216174910.260734464@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

commit cbbaa2727aa3ae9e0a844803da7cef7fd3b94f2b upstream.

KVM does not implement MSR_IA32_TSX_CTRL, so it must not be presented
to the guests.  It is also confusing to have !ARCH_CAP_TSX_CTRL_MSR &&
!RTM && ARCH_CAP_TAA_NO: lack of MSR_IA32_TSX_CTRL suggests TSX was not
hidden (it actually was), yet the value says that TSX is not vulnerable
to microarchitectural data sampling.  Fix both.

Cc: stable@vger.kernel.org
Tested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1113,10 +1113,15 @@ u64 kvm_get_arch_capabilities(void)
 	 * If TSX is disabled on the system, guests are also mitigated against
 	 * TAA and clear CPU buffer mitigation is not required for guests.
 	 */
-	if (boot_cpu_has_bug(X86_BUG_TAA) && boot_cpu_has(X86_FEATURE_RTM) &&
-	    (data & ARCH_CAP_TSX_CTRL_MSR))
+	if (!boot_cpu_has(X86_FEATURE_RTM))
+		data &= ~ARCH_CAP_TAA_NO;
+	else if (!boot_cpu_has_bug(X86_BUG_TAA))
+		data |= ARCH_CAP_TAA_NO;
+	else if (data & ARCH_CAP_TSX_CTRL_MSR)
 		data &= ~ARCH_CAP_MDS_NO;
 
+	/* KVM does not emulate MSR_IA32_TSX_CTRL.  */
+	data &= ~ARCH_CAP_TSX_CTRL_MSR;
 	return data;
 }
 


