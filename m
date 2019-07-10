Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA2DC74A23
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF9120651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PdeAjWx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfGJO1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:27:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41440 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfGJO1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RlXhAkaMUAdGOUFAYrqz8nfH2erzY8x7rCdtY4iPiGs=; b=PdeAjWx0z/Z2HRIX9fIQXsgSp
        0FfZL97fOFsyolzkLrlxkK7Hxm9I8/Z1HSpUzXgjpAs8V8w75sCFYrQ1/Y0tqjoYfe7YAKeQRkjT+
        dT+CCglesn8W5g8qdGMO7mIAnQXhOjFVB1iJgM5lcfe7HME0xGegljFhFUIl6Xtxq8Dr/HFGubLiM
        Qng0pLVJNE0Q/3ojwNvwNecgCzz7xqfdWiEt8E8gsGSJy/e7KQRN5XdsVYanqtdAs3D7P5suYUZxi
        Lw4fV3U4FNSLzMB+97/QTFtVh5TL1qniaKDKzDrAOWg0ECTGP4CBKG+53ZPXsiWlkMr1QgFR8Lll0
        lskCi+l+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlDYd-0006FG-0I; Wed, 10 Jul 2019 14:26:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 47DA220977440; Wed, 10 Jul 2019 16:26:53 +0200 (CEST)
Date:   Wed, 10 Jul 2019 16:26:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Xi Ruoyao <xry111@mengyan1223.wang>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Nadav Amit <namit@vmware.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
Message-ID: <20190710142653.GJ3419@hirez.programming.kicks-ass.net>
References: <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907100115220.1758@nanos.tec.linutronix.de>
 <201907091727.91CC6C72D8@keescook>
 <1ad2de95e694a29909801d022fe2d556df9a4bd5.camel@mengyan1223.wang>
 <cb6d381ed7cd0bf732ae9d8f30c806b849b0f94b.camel@mengyan1223.wang>
 <alpine.DEB.2.21.1907101404570.1758@nanos.tec.linutronix.de>
 <nycvar.YFH.7.76.1907101425290.5899@cbobk.fhfr.pm>
 <768463eb26a2feb0fcc374fd7f9cc28b96976917.camel@mengyan1223.wang>
 <20190710134433.GN3402@hirez.programming.kicks-ass.net>
 <nycvar.YFH.7.76.1907101621050.5899@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1907101621050.5899@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 04:22:51PM +0200, Jiri Kosina wrote:
> On Wed, 10 Jul 2019, Peter Zijlstra wrote:
> 
> > If we mark the key as RO after init, and then try and modify the key to
> > link module usage sites, things might go bang as described.
> > 
> > Thanks!
> > 
> > 
> > diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> > index 27d7864e7252..5bf7a8354da2 100644
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -366,7 +366,7 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
> >  	cr4_clear_bits(X86_CR4_UMIP);
> >  }
> >  
> > -DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
> > +DEFINE_STATIC_KEY_FALSE(cr_pinning);
> 
> Good catch, I guess that is going to fix it.
> 
> At the same time though, it sort of destroys the original intent of Kees' 
> patch, right? The exploits will just have to call static_key_disable() 
> prior to calling native_write_cr4() again, and the protection is gone.

This is fixable by moving native_write_cr*() out-of-line, such that they
never end up in a module.

