Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F2DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D1D2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WmdCERaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbfJOOL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:11:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731977AbfJOOL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=u3AIL5Yut/d4CJmU5Dy8pm81xE/du7Qm4bFCGyoGlWQ=; b=WmdCERaAPalLY+SN9/TiCZoEO
        ibdhiLkjYDqIIZMAN2C5Gr9DJHd0t6I3MPg5p+sndTcJcpHbwnVFbK8jb+DPunf0JqC71S+Bda3Jg
        yftHujgMwq99qM0apSFBPE2woj+EdeWHxXEK+8hrehyZIQlbK4bhS0YvnjoTV563crPzFM7uDuger
        Gh6p28BGAeQqHv2H8oOJWh32EEGZ/+r0/UWwsY8/jAjzLOKmZ0qZNPfn82wFlRhArLM+vH519yNjD
        5kNa3JAHKUu/h5mEI5z445BUMigYj8MroXu64Bn1S0y08tEZzHFr9n5p+PAKRGyM+yXG8f4xTcO2T
        5NgaGupig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKNXe-0001Pb-4v; Tue, 15 Oct 2019 14:11:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5B56B303DDD;
        Tue, 15 Oct 2019 16:10:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 903B029A873D5; Tue, 15 Oct 2019 16:11:11 +0200 (CEST)
Date:   Tue, 15 Oct 2019 16:11:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, mbenes@suse.cz
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
Message-ID: <20191015141111.GP2359@hirez.programming.kicks-ass.net>
References: <20191008104335.6fcd78c9@gandalf.local.home>
 <20191009224135.2dcf7767@oasis.local.home>
 <20191010092054.GR2311@hirez.programming.kicks-ass.net>
 <20191010091956.48fbcf42@gandalf.local.home>
 <20191010140513.GT2311@hirez.programming.kicks-ass.net>
 <20191010115449.22044b53@gandalf.local.home>
 <20191010172819.GS2328@hirez.programming.kicks-ass.net>
 <20191011125903.GN2359@hirez.programming.kicks-ass.net>
 <20191015130739.GA23565@linux-8ccs>
 <20191015135634.GK2328@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015135634.GK2328@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 03:56:34PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 15, 2019 at 03:07:40PM +0200, Jessica Yu wrote:

> > > Once this ftrace thing is sorted, we'll change x86 to _refuse_ to make
> > > executable (kernel) memory writable.
> > 
> > Not sure if relevant, but just thought I'd clarify: IIRC,
> > klp_module_coming() is not poking the coming module, but it calls
> > module_enable_ro() on itself (the livepatch module) so it can apply
> > relocations and such on the new code, which lives inside the livepatch
> > module, and it needs to possibly do this numerous times over the
> > lifetime of the patch module for any coming module it is responsible
> > for patching (i.e., call module_enable_ro() on the patch module, not
> > necessarily the coming module). So I am not be sure why
> > klp_module_coming() should be moved before complete_formation(). I
> > hope I'm remembering the details correctly, livepatch folks feel free
> > to chime in if I'm incorrect here.
> 
> You mean it does module_disable_ro() ? That would be broken and it needs
> to be fixed. Can some livepatch person explain what it does and why?

mbenes confirmed; what would be needed is for the live-patch module to
have all module dependent parts to be in their own section and have the
sections be page-aligned. Then we can do the protection on sections
instead of on the whole module.

Damn, and I thought I was so close to getting W^X sorted :/
