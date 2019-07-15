Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4ECC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCD8206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbfGOMhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:37:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbfGOMhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:37:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5FEB9C057F2B;
        Mon, 15 Jul 2019 12:37:07 +0000 (UTC)
Received: from treble (ovpn-120-170.rdu2.redhat.com [10.10.120.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2104960C4C;
        Mon, 15 Jul 2019 12:37:06 +0000 (UTC)
Date:   Mon, 15 Jul 2019 07:37:04 -0500
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
Message-ID: <20190715123704.oke4pd4wguj5a7i3@treble>
References: <cover.1563150885.git.jpoimboe@redhat.com>
 <299fe4adb78cff0a182f8376c23a445b94d7c782.1563150885.git.jpoimboe@redhat.com>
 <0b37031b-1043-8274-a086-2b5d0b02b5ef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0b37031b-1043-8274-a086-2b5d0b02b5ef@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 15 Jul 2019 12:37:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 11:04:03AM +0200, Paolo Bonzini wrote:
> On 15/07/19 02:36, Josh Poimboeuf wrote:
> > With CONFIG_FRAME_POINTER, vmx_vmenter() needs to do frame pointer setup
> > before calling kvm_spurious_fault().
> > 
> > Fixes the following warning:
> > 
> >   arch/x86/kvm/vmx/vmenter.o: warning: objtool: vmx_vmenter()+0x14: call without frame pointer save/setup
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> This is not enough, because the RSP value must match what is computed at
> this place:
> 
>         /* Adjust RSP to account for the CALL to vmx_vmenter(). */
>         lea -WORD_SIZE(%_ASM_SP), %_ASM_ARG2
>         call vmx_update_host_rsp

Ah, that is surprising :-)

And then there's this, which overwrites the frame pointer anyway:

	mov VCPU_RBP(%_ASM_AX), %_ASM_BP

Would it make sense to remove the call to vmx_vmenter() altogether, and
just either embed it in __vmx_vcpu_run(), or jmp back and forth to it
from __vmx_vcpu_run()?

Then you could get rid of the RSP adjustment hack, and the
vmx_update_host_rsp() function altogether.

> Is this important since kvm_spurious_fault is just BUG()?

It's probably only important if you care about the stack trace for the
BUG() case.  But BP is clobbered anyway so I guess it doesn't matter.

> There is no macro currently to support CONFIG_DEBUG_BUGVERBOSE in
> assembly code, but it's also fine if you just change the call to ud2.

That would be one way to make objtool happy.

-- 
Josh
