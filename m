Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A3EC74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532C82064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfGJUBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:01:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48522 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfGJUBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 16:01:09 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hlIlw-000213-DB; Wed, 10 Jul 2019 22:01:00 +0200
Date:   Wed, 10 Jul 2019 22:00:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kees Cook <keescook@chromium.org>
cc:     Xi Ruoyao <xry111@mengyan1223.wang>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
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
In-Reply-To: <201907101258.FE97AEC86@keescook>
Message-ID: <alpine.DEB.2.21.1907102200360.1758@nanos.tec.linutronix.de>
References: <cb6d381ed7cd0bf732ae9d8f30c806b849b0f94b.camel@mengyan1223.wang> <alpine.DEB.2.21.1907101404570.1758@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1907101425290.5899@cbobk.fhfr.pm> <768463eb26a2feb0fcc374fd7f9cc28b96976917.camel@mengyan1223.wang>
 <20190710134433.GN3402@hirez.programming.kicks-ass.net> <nycvar.YFH.7.76.1907101621050.5899@cbobk.fhfr.pm> <20190710142653.GJ3419@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1907101709340.1758@nanos.tec.linutronix.de>
 <a822cf447949582e2a11b7899f22b11da02f0ece.camel@mengyan1223.wang> <alpine.DEB.2.21.1907102140340.1758@nanos.tec.linutronix.de> <201907101258.FE97AEC86@keescook>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2019, Kees Cook wrote:

> On Wed, Jul 10, 2019 at 09:42:46PM +0200, Thomas Gleixner wrote:
> > The pinning of sensitive CR0 and CR4 bits caused a boot crash when loading
> > the kvm_intel module on a kernel compiled with CONFIG_PARAVIRT=n.
> > 
> > The reason is that the static key which controls the pinning is marked RO
> > after init. The kvm_intel module contains a CR4 write which requires to
> > update the static key entry list. That obviously does not work when the key
> > is in a RO section.
> > 
> > With CONFIG_PARAVIRT enabled this does not happen because the CR4 write
> > uses the paravirt indirection and the actual write function is built in.
> > 
> > As the key is intended to be immutable after init, move
> > native_write_cr0/3() out of line.
> > 
> > While at it consolidate the update of the cr4 shadow variable and store the
> > value right away when the pinning is initialized on a booting CPU. No point
> > in reading it back 20 instructions later. This allows to confine the static
> > key and the pinning variable to cpu/common and allows to mark them static.
> > 
> > Fixes: 8dbec27a242c ("x86/asm: Pin sensitive CR0 bits")
> > Fixes: 873d50d58f67 ("x86/asm: Pin sensitive CR4 bits")
> > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Reported-by: Xi Ruoyao <xry111@mengyan1223.wang>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Tested-by: Xi Ruoyao <xry111@mengyan1223.wang>
> 
> Thank you for tracking this down and solving it!
> 
> Nit: should be "cr0/4()" in Subject and in paragraph 4.

Yeah. My brain is not working today.
