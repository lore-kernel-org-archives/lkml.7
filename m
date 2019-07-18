Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24880C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F279521019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nPt7a8/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391210AbfGRTJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:09:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49007 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRTJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:09:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJ8ukV2123756
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:08:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJ8ukV2123756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563476937;
        bh=GcovEUfk//4KrFFre87CBIZf3wyaATwToKKe+uiUpLk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=nPt7a8/uggJi+aj2x6lCb7a7wETRT+o1Gmn7yyoM+reUkbiy/Qnp4MunZ5+UJwYot
         Pmr/zfj7cqn0zJ5VanlGFu6WZzmZ53pFn6mWpGMnCyAEP3CLS4wWVtx9IoZsAaZ8mF
         J/r102Q5NJ0VwxWUurLIpFdYMcVc8vvT9lxawKNTuxGiSIItvozdXSPfQ//4UuMX9t
         22nDPFlPZBePF1Cf3TnXE82eCnN3Uqh6W31h30VxPwVqQU0AmM7Iq+3cVRf3HXysUt
         ywYrpOBBm5xhD6MwmtE09tIsPdVxD1vow7lcypsYULr5wz8j8lSnbQaNOYH0U30jmo
         p3yuWAzGM/l6w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJ8ueC2123753;
        Thu, 18 Jul 2019 12:08:56 -0700
Date:   Thu, 18 Jul 2019 12:08:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-19f2d8fa98644c7b78845b1d66abeae4e3d9dfa8@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, pbonzini@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, peterz@infradead.org
Reply-To: peterz@infradead.org, jpoimboe@redhat.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          pbonzini@redhat.com, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <9fc2216c9dc972f95bb65ce2966a682c6bda1cb0.1563413318.git.jpoimboe@redhat.com>
References: <9fc2216c9dc972f95bb65ce2966a682c6bda1cb0.1563413318.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] x86/kvm: Replace vmx_vmenter()'s call to
 kvm_spurious_fault() with UD2
Git-Commit-ID: 19f2d8fa98644c7b78845b1d66abeae4e3d9dfa8
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

Commit-ID:  19f2d8fa98644c7b78845b1d66abeae4e3d9dfa8
Gitweb:     https://git.kernel.org/tip/19f2d8fa98644c7b78845b1d66abeae4e3d9dfa8
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:36:38 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:01:03 +0200

x86/kvm: Replace vmx_vmenter()'s call to kvm_spurious_fault() with UD2

Objtool reports the following:

  arch/x86/kvm/vmx/vmenter.o: warning: objtool: vmx_vmenter()+0x14: call without frame pointer save/setup

But frame pointers are necessarily broken anyway, because
__vmx_vcpu_run() clobbers RBP with the guest's value before calling
vmx_vmenter().  So calling without a frame pointer doesn't make things
any worse.

Make objtool happy by changing the call to a UD2.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lkml.kernel.org/r/9fc2216c9dc972f95bb65ce2966a682c6bda1cb0.1563413318.git.jpoimboe@redhat.com

---
 arch/x86/kvm/vmx/vmenter.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index d4cb1945b2e3..4010d519eb8c 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -54,9 +54,9 @@ ENTRY(vmx_vmenter)
 	ret
 
 3:	cmpb $0, kvm_rebooting
-	jne 4f
-	call kvm_spurious_fault
-4:	ret
+	je 4f
+	ret
+4:	ud2
 
 	.pushsection .fixup, "ax"
 5:	jmp 3b
