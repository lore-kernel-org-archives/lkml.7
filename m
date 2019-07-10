Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DE6C74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB49A20651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SF+ZWihV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfGJUDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:03:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50338 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbfGJUDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 16:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z/YeB5rzfyGHi9UbIOSe9nW28qqyKZ2+XgjqKHbWPpY=; b=SF+ZWihV7gVH3A8wgb59tzPkK
        jzf3LT2Tiv6jNZUbLxrNatKS9a/JTDlU3E6OzcfCmYQK+dGCNMBx14xeV59LDOtifpXygvaGWKzoh
        Gn8YeaLJJZLxvo12FFzmchU8cG48jo1fV9XybH5X3Iiq09TNmQphb17eLZRGbmA7o5mzbBt9RZ4Gk
        NJ5xC3fMAhKspzVhAqarnhysP1ygPJxZR0XYtZB2hxSRjG2wJNzBCOZZ7TsobI4iTzQ1oarqdlTSO
        DgxNGgAWUatz5Zq7h6Yk0yMPQU6vV9euCWX/GofR91dqBDerZZzufxkwgOhKqABrhFi6FITE6FQ2h
        LxExBW2OA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlInb-0007ff-1X; Wed, 10 Jul 2019 20:02:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E3E52012354A; Wed, 10 Jul 2019 22:02:40 +0200 (CEST)
Date:   Wed, 10 Jul 2019 22:02:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Xi Ruoyao <xry111@mengyan1223.wang>,
        Jiri Kosina <jikos@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86/asm: Move native_write_cr0/3() out of line
Message-ID: <20190710200240.GR3402@hirez.programming.kicks-ass.net>
References: <cb6d381ed7cd0bf732ae9d8f30c806b849b0f94b.camel@mengyan1223.wang>
 <alpine.DEB.2.21.1907101404570.1758@nanos.tec.linutronix.de>
 <nycvar.YFH.7.76.1907101425290.5899@cbobk.fhfr.pm>
 <768463eb26a2feb0fcc374fd7f9cc28b96976917.camel@mengyan1223.wang>
 <20190710134433.GN3402@hirez.programming.kicks-ass.net>
 <nycvar.YFH.7.76.1907101621050.5899@cbobk.fhfr.pm>
 <20190710142653.GJ3419@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907101709340.1758@nanos.tec.linutronix.de>
 <a822cf447949582e2a11b7899f22b11da02f0ece.camel@mengyan1223.wang>
 <alpine.DEB.2.21.1907102140340.1758@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907102140340.1758@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 09:42:46PM +0200, Thomas Gleixner wrote:
> The pinning of sensitive CR0 and CR4 bits caused a boot crash when loading
> the kvm_intel module on a kernel compiled with CONFIG_PARAVIRT=n.
> 
> The reason is that the static key which controls the pinning is marked RO
> after init. The kvm_intel module contains a CR4 write which requires to
> update the static key entry list. That obviously does not work when the key
> is in a RO section.
> 
> With CONFIG_PARAVIRT enabled this does not happen because the CR4 write
> uses the paravirt indirection and the actual write function is built in.
> 
> As the key is intended to be immutable after init, move
> native_write_cr0/3() out of line.
> 
> While at it consolidate the update of the cr4 shadow variable and store the
> value right away when the pinning is initialized on a booting CPU. No point
> in reading it back 20 instructions later. This allows to confine the static
> key and the pinning variable to cpu/common and allows to mark them static.
> 
> Fixes: 8dbec27a242c ("x86/asm: Pin sensitive CR0 bits")
> Fixes: 873d50d58f67 ("x86/asm: Pin sensitive CR4 bits")
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Reported-by: Xi Ruoyao <xry111@mengyan1223.wang>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Xi Ruoyao <xry111@mengyan1223.wang>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
