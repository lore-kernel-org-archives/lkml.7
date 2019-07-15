Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5B4C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5F520868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbfGON0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:26:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730124AbfGON0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:26:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C465630B9305;
        Mon, 15 Jul 2019 13:26:00 +0000 (UTC)
Received: from treble (ovpn-120-170.rdu2.redhat.com [10.10.120.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9482E5D9C6;
        Mon, 15 Jul 2019 13:25:58 +0000 (UTC)
Date:   Mon, 15 Jul 2019 08:25:55 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH 04/22] x86/kvm: Don't call kvm_spurious_fault() from
 .fixup
Message-ID: <20190715132555.3tz4ciogkv3xlkta@treble>
References: <cover.1563150885.git.jpoimboe@redhat.com>
 <1f37a9e42732c224bc5299dbc827b4101c9deb22.1563150885.git.jpoimboe@redhat.com>
 <07b8513a-d8f7-f8cf-daf6-83a80ade987a@redhat.com>
 <20190715124025.prcetv24oyjnuvip@treble>
 <29d30d81-bcbe-5261-b34d-12bd62df9116@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <29d30d81-bcbe-5261-b34d-12bd62df9116@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 15 Jul 2019 13:26:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 03:05:33PM +0200, Paolo Bonzini wrote:
> On 15/07/19 14:40, Josh Poimboeuf wrote:
> >>>   * Hardware virtualization extension instructions may fault if a
> >>>   * reboot turns off virtualization while processes are running.
> >>> - * Trap the fault and ignore the instruction if that happens.
> >>> + * If that happens, trap the fault and panic (unless we're rebooting).
> >> Not sure the comment is better than before, but apar from that
> > The previous comment didn't seem to match the code, since we only ignore
> > the instruction if we're rebooting.
> > 
> 
> "If that happens" refers to "a reboot turns off virtualization while
> processes are running".

Ah, makes sense now.  I was reading "if that happens" to mean the fault.

>  * Usually after catching the fault we just panic; during reboot
>  * instead the instruction is ignored.

Yes, that's much clearer.  Assuming you meant to replace the entire
comment.  I also moved it to directly above the macro it's describing:


asmlinkage void __noreturn kvm_spurious_fault(void);

/*
 * Usually after catching the fault we just panic; during reboot
 * instead the instruction is ignored.
 */
#define ____kvm_handle_fault_on_reboot(insn, cleanup_insn)		\


-- 
Josh
