Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4020C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61D12186A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567765709;
	bh=LckxxhN33QI7hBosz2hOt44i8WFcrDpnBzPka+P6J1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wC3E9ZaCUkgnC+qbeFLvHRz8L7qd+NF3n6K2wOVOM8v+9t70SU/5UvjWD4MMAHXs3
	 zpwMV0YgLNDPuWBmzy7OrmeOJ3H3CvPvkuJHc6hTqUxyk9i8ZVK948txJlIHWOXUZN
	 MibuegtyX+KJDx7RpHTokaWpjJlA7s2gpdySnlgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391205AbfIFK22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 06:28:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387772AbfIFK22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:28:28 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B2CC20693;
        Fri,  6 Sep 2019 10:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567765708;
        bh=LckxxhN33QI7hBosz2hOt44i8WFcrDpnBzPka+P6J1I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OVpHyutzcEHG86HaLs+WIIPoe586pIAkDgL5B4RVmqFHZRrupJnVY5eXgVtfwj61M
         0syzuaWYZVFQJG3Je/48SiMTzubCIfCeRIaqKy9sx56ioL77GyutKSw3zgPoC9jq4z
         M5F1AK426s/Q6f2phTZKMS7tJ3a2ewqVMICm7kTE=
Date:   Fri, 6 Sep 2019 19:28:22 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH -tip v3 1/2] x86: xen: insn: Decode Xen and KVM
 emulate-prefix signature
Message-Id: <20190906192822.21afa68b557463fdc7b1cc81@kernel.org>
In-Reply-To: <20190906073436.GS2349@hirez.programming.kicks-ass.net>
References: <156773433821.31441.2905951246664148487.stgit@devnote2>
        <156773434815.31441.12739136439382289412.stgit@devnote2>
        <20190906073436.GS2349@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2019 09:34:36 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Sep 06, 2019 at 10:45:48AM +0900, Masami Hiramatsu wrote:
> 
> > diff --git a/arch/x86/include/asm/xen/interface.h b/arch/x86/include/asm/xen/interface.h
> > index 62ca03ef5c65..fe33a9798708 100644
> > --- a/arch/x86/include/asm/xen/interface.h
> > +++ b/arch/x86/include/asm/xen/interface.h
> > @@ -379,12 +379,15 @@ struct xen_pmu_arch {
> >   * Prefix forces emulation of some non-trapping instructions.
> >   * Currently only CPUID.
> >   */
> > +#include <asm/xen/prefix.h>
> > +
> >  #ifdef __ASSEMBLY__
> > -#define XEN_EMULATE_PREFIX .byte 0x0f,0x0b,0x78,0x65,0x6e ;
> > +#define XEN_EMULATE_PREFIX .byte __XEN_EMULATE_PREFIX ;
> >  #define XEN_CPUID          XEN_EMULATE_PREFIX cpuid
> >  #else
> > -#define XEN_EMULATE_PREFIX ".byte 0x0f,0x0b,0x78,0x65,0x6e ; "
> > +#define XEN_EMULATE_PREFIX ".byte " __XEN_EMULATE_PREFIX_STR " ; "
> >  #define XEN_CPUID          XEN_EMULATE_PREFIX "cpuid"
> > +
> >  #endif
> 
> Possibly you can do something like:
> 
> #define XEN_EMULATE_PREFIX	__ASM_FORM(.byte __XEN_EMULATE_PREFIX ;)
> #define XEN_CPUID		XEN_EMULATE_PREFIX __ASM_FORM(cpuid)

Oops, this doesn't work, since __ASM_FORM(x) uses #x directly

# define __ASM_FORM(x)  " " #x " "

which doesn't expand "x" if x is a macro. We have to use __stringify
like 

# include <linux/stringify.h>
# define __ASM_FORM(x)  " " __stringify(x) " "

So this needs aonther patch in the series :)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
