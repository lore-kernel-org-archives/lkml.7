Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F6EC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BE520868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbfGONfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:35:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22039 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730172AbfGONfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:35:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF02F85546;
        Mon, 15 Jul 2019 13:35:35 +0000 (UTC)
Received: from treble (ovpn-120-170.rdu2.redhat.com [10.10.120.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D28C47E23;
        Mon, 15 Jul 2019 13:35:32 +0000 (UTC)
Date:   Mon, 15 Jul 2019 08:35:25 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH 03/22] x86/kvm: Fix frame pointer usage in vmx_vmenter()
Message-ID: <20190715133525.gr4wvnd4kxwtv63o@treble>
References: <cover.1563150885.git.jpoimboe@redhat.com>
 <299fe4adb78cff0a182f8376c23a445b94d7c782.1563150885.git.jpoimboe@redhat.com>
 <0b37031b-1043-8274-a086-2b5d0b02b5ef@redhat.com>
 <20190715123704.oke4pd4wguj5a7i3@treble>
 <2172ac52-899b-a32a-cba7-c2e5f2bb784e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2172ac52-899b-a32a-cba7-c2e5f2bb784e@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 15 Jul 2019 13:35:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 03:03:23PM +0200, Paolo Bonzini wrote:
> On 15/07/19 14:37, Josh Poimboeuf wrote:
> > On Mon, Jul 15, 2019 at 11:04:03AM +0200, Paolo Bonzini wrote:
> >> On 15/07/19 02:36, Josh Poimboeuf wrote:
> >>> With CONFIG_FRAME_POINTER, vmx_vmenter() needs to do frame pointer setup
> >>> before calling kvm_spurious_fault().
> >>>
> >>> Fixes the following warning:
> >>>
> >>>   arch/x86/kvm/vmx/vmenter.o: warning: objtool: vmx_vmenter()+0x14: call without frame pointer save/setup
> >>>
> >>> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> >>
> >> This is not enough, because the RSP value must match what is computed at
> >> this place:
> >>
> >>         /* Adjust RSP to account for the CALL to vmx_vmenter(). */
> >>         lea -WORD_SIZE(%_ASM_SP), %_ASM_ARG2
> >>         call vmx_update_host_rsp
> > 
> > Ah, that is surprising :-)
> > 
> > And then there's this, which overwrites the frame pointer anyway:
> > 
> > 	mov VCPU_RBP(%_ASM_AX), %_ASM_BP
> > 
> > Would it make sense to remove the call to vmx_vmenter() altogether, and
> > just either embed it in __vmx_vcpu_run(), or jmp back and forth to it
> > from __vmx_vcpu_run()?
> 
> Unfortunately there's another use of it in nested_vmx_check_vmentry_hw.

Ah, I missed that too (failed by cscope).  Is this ok?

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
