Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF70C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 21:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA4A20872
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 21:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbfIYVhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 17:37:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38549 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbfIYVhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 17:37:34 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iDEyX-0002Dx-3W; Wed, 25 Sep 2019 23:37:29 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] KVM: x86: svm: Pass XSAVES to guest if available on host
Date:   Wed, 25 Sep 2019 23:37:20 +0200
Message-Id: <20190925213721.21245-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925213721.21245-1-bigeasy@linutronix.de>
References: <20190925213721.21245-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit
   55412b2eda2b7 ("kvm: x86: Add kvm_x86_ops hook that enables XSAVES for g=
uest")

XSAVES was enabled on VMX with a few additional tweaks and was always
disabled on SVM. Before ZEN XSAVES was not available so it made no
difference. With Zen it is possible to expose it to the guest if it is
available on the host.
I didn't find anything close to VMX's "VM-Execution Controls" and
exposing this flag based on the CPUID flags cause no harm so far.

Expose the XSAVES flag to the guest if the host supports it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kvm/svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index e0368076a1ef9..3878eb766fa39 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5992,7 +5992,7 @@ static bool svm_mpx_supported(void)
=20
 static bool svm_xsaves_supported(void)
 {
-	return false;
+	return boot_cpu_has(X86_FEATURE_XSAVES);
 }
=20
 static bool svm_umip_emulated(void)
--=20
2.23.0

