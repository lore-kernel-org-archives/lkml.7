Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CC4C282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 00:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A3C20857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 00:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bP2uTrkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfDHAgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 20:36:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44667 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfDHAgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 20:36:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id g12so6258141pll.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 17:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mUF7FisCWPJBcyY+1uY0DR4+j9qrIcKSbRWtjK3YtW8=;
        b=bP2uTrkh739fzSEIqWmyX/sG6NKbgLlBEcO5pUqvbm5z+aN6K3VaMPnW/2QA9Wz44b
         l3N6uPAeWeFSP1TMOIGsmwa8qjrs6+GJA8hSsrvshaJ6UsZYJuQ2QpJSMj2vGcJ9Uoay
         s/srx7huOPqF0Za9+Wb0oLU1a9Yrn7RSEZ9pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mUF7FisCWPJBcyY+1uY0DR4+j9qrIcKSbRWtjK3YtW8=;
        b=iGJvsHfz/X05TBFlBIjePVyAU+AX06CyMytN4pknAih6a8S3Z3shk3fkCBnD1EOnR5
         zrxKrraA3X9AXSxZOLib6/QeZFcSeCFy9gyXLbKOTCHtHopuerBsTn8vogZ5+dq+U1N9
         SLf6Ab3SjwbbZrUhHwq++z7a9s3J+jBe9JuKHE0NEGirTAy0gZzJR3K1789DjXgwcf2e
         fjRHGN+upBUpbcXOI0mtJkjJ7GUGi0AjuP8kgSSPKPmHoAza0CkEY/aWg/zAnn9xgvza
         I+iZkXDKHfbcp+bOUUfsfH+LtSgvYiSpk6uCH+NP86SCXCZidK+YNOiUeOa4G80RwejD
         H52Q==
X-Gm-Message-State: APjAAAV7F4ogWHmoGe0TlrmHUzqBuLsJHGCs3r8ChimrXPX1NfAqD9m+
        r8nCo4mYMoInxw2z1xHLTyeIlA==
X-Google-Smtp-Source: APXvYqyEcxluh0LRXUByCtbfcaG1gVCzjI9vRF+orWx6aBtjmYnzxp/Thsz0QHzd2rPbi2TCPhYnXA==
X-Received: by 2002:a17:902:b7cc:: with SMTP id v12mr19536417plz.166.1554683808261;
        Sun, 07 Apr 2019 17:36:48 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 6sm5669455pft.64.2019.04.07.17.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 17:36:47 -0700 (PDT)
Date:   Sun, 7 Apr 2019 20:36:46 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH RFC tip/core/rcu 0/4] Forbid static SRCU use in modules
Message-ID: <20190408003646.GA135726@google.com>
References: <161156422.1435.1554219247444.JavaMail.zimbra@efficios.com>
 <20190403133243.GE4102@linux.ibm.com>
 <1028306587.504.1554301662374.JavaMail.zimbra@efficios.com>
 <20190403162039.GA14111@linux.ibm.com>
 <20190405232835.GA24702@linux.ibm.com>
 <20190406230613.GA187766@google.com>
 <20190407133941.GC14111@linux.ibm.com>
 <20190407135937.GA30053@linux.ibm.com>
 <20190407154613.GA2770@localhost>
 <20190407170514.GE14111@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190407170514.GE14111@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2019 at 10:05:14AM -0700, Paul E. McKenney wrote:
> On Sun, Apr 07, 2019 at 03:46:13PM +0000, Joel Fernandes wrote:
> > On Sun, Apr 07, 2019 at 06:59:37AM -0700, Paul E. McKenney wrote:
> > > On Sun, Apr 07, 2019 at 06:39:41AM -0700, Paul E. McKenney wrote:
> > > > On Sat, Apr 06, 2019 at 07:06:13PM -0400, Joel Fernandes wrote:
> > > 
> > > [ . . . ]
> > > 
> > > > > > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > > > > > index f8f6f04c4453..c2d919a1566e 100644
> > > > > > --- a/include/asm-generic/vmlinux.lds.h
> > > > > > +++ b/include/asm-generic/vmlinux.lds.h
> > > > > > @@ -338,6 +338,10 @@
> > > > > >  		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
> > > > > >  		__stop___tracepoints_ptrs = .;				\
> > > > > >  		*(__tracepoints_strings)/* Tracepoints: strings */	\
> > > > > > +		. = ALIGN(8);						\
> > > > > > +		__start___srcu_struct = .;				\
> > > > > > +		*(___srcu_struct_ptrs)					\
> > > > > > +		__end___srcu_struct = .;				\
> > > > > >  	}								\
> > > > > 
> > > > > This vmlinux linker modification is not needed. I tested without it and srcu
> > > > > torture works fine with rcutorture built as a module. Putting further prints
> > > > > in kernel/module.c verified that the kernel is able to find the srcu structs
> > > > > just fine. You could squash the below patch into this one or apply it on top
> > > > > of the dev branch.
> > > > 
> > > > Good point, given that otherwise FORTRAN named common blocks would not
> > > > work.
> > > > 
> > > > But isn't one advantage of leaving that stuff in the RO_DATA_SECTION()
> > > > macro that it can be mapped read-only?  Or am I suffering from excessive
> > > > optimism?
> > > 
> > > And to answer the other question, in the case where I am suffering from
> > > excessive optimism, it should be a separate commit.  Please see below
> > > for the updated original commit thus far.
> > 
> > Actually the vmlinux.lds.h file is unused for module building. For ex, if you
> > delete include/asm-generic/vmlinux.lds.h , then you can still build
> > rcutorture.ko. Did I miss something obvious? In that case the vmlinux.lds.h
> > are not needed since the __section annotations automatically place the srcu
> > structs in a separate section.
> 
> Hard to argue given that I just deleted include/asm-generic/vmlinux.lds.h,
> touched kernel/rcu/rcutorture.c, and rebuilt the corresponding .ko
> without errors.  ;-)
> 
> Hmmm...  Is there some way to place a section into a read-only page,
> for example, tagged onto the text section for that module?  That would
> get rid of a class of bugs, if nothing else.

Strictly speaking, the array of pointers in the new srcu section are fixed up
at runtime because the srcu_struct(s) they point to can be loaded at a
dynamic location in memory. The srcu_struct(s) are themselves in the .bss
section of the module and their locations depend on where the .bss section of
the module is loaded in memory at load time.

I agree that after such relocation fixups are done, there is no reason to keep
the array-of-pointers section readable but unfortunately I couldn't figure a
way out to make them read-only post the relocations.

I copied Jessica Yu who maintains module loading for any input. Jessica, as a
summary, we are trying to create a custom ELF section of srcu_struct pointers
in kernels modules, and then make the module loader do SRCU initialization
from structs pointed to by this section.  The srcu_struct themselves are defined
on the .bss section. Is there any way we can make this pointer array section
read-only *after* the relocation fixups of the array are completed?

> > Let me know if you would like me to send a patch separately, or if the
> > appended patch for the same in my previous email suffices.
> 
> Please do resend as a formal patch with the above in the commit log.
> I doubt that I am the only one needing a bit of module-build education!
> And thank you for providing that education, by the way!

Sounds great, I will go ahead and send out a patch in the morning for this
part.

> > > And may I have your Tested-by?
> > 
> > Absolutely, please do and thanks!
> 
> Done, and thank you for giving it a go!

You're very welcome. thanks,

 - Joel

