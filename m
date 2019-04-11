Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6785C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 04:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A412C217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 04:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfDKECd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 00:02:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfDKECd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 00:02:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C339E85546;
        Thu, 11 Apr 2019 04:02:32 +0000 (UTC)
Received: from treble (ovpn-120-231.rdu2.redhat.com [10.10.120.231])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 303CC608A4;
        Thu, 11 Apr 2019 04:02:24 +0000 (UTC)
Date:   Wed, 10 Apr 2019 23:02:22 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jon Masters <jcm@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC 3/5] powerpc/speculation: Add support for
 'cpu_spec_mitigations=' cmdline options
Message-ID: <20190411040222.p6yslvypbe6lq5cm@treble>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <91b92d8182d2f114d92c95689fcd4bb1a8dda1b0.1554396090.git.jpoimboe@redhat.com>
 <87pnpuwg05.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pnpuwg05.fsf@concordia.ellerman.id.au>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 11 Apr 2019 04:02:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 04:06:50PM +1000, Michael Ellerman wrote:
> Josh Poimboeuf <jpoimboe@redhat.com> writes:
> > Configure powerpc CPU runtime speculation bug mitigations in accordance
> > with the 'cpu_spec_mitigations=' cmdline options.  This affects
> > Meltdown, Spectre v1, Spectre v2, and Speculative Store Bypass.
> >
> > The default behavior is unchanged.
> >
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 9 +++++----
> >  arch/powerpc/kernel/security.c                  | 6 +++---
> >  arch/powerpc/kernel/setup_64.c                  | 2 +-
> >  3 files changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 29dc03971630..0e8eae1e8a25 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2552,10 +2552,11 @@
> >  
> >  			off
> >  				Disable all speculative CPU mitigations.
> > -				Equivalent to: nopti [x86]
> > +				Equivalent to: nopti [x86, powerpc]
> > +					       nospectre_v1 [powerpc]
> >  					       nospectre_v2 [x86]
> 
> Not sure if you meant to omit powerpc from nospectre_v2?
> 
> You have patched it in the code below.

Oops.  I'll update the documentation.

> >  					       spectre_v2_user=off [x86]
> > -					       spec_store_bypass_disable=off [x86]
> > +					       spec_store_bypass_disable=off [x86, powerpc]
> >  					       l1tf=off [x86]
> >  
> >  			auto (default)
> > @@ -2568,7 +2569,7 @@
> >  				Equivalent to: pti=auto [x86]
> >  					       spectre_v2=auto [x86]
> >  					       spectre_v2_user=auto [x86]
> > -					       spec_store_bypass_disable=auto [x86]
> > +					       spec_store_bypass_disable=auto [x86, powerpc]
> >  					       l1tf=flush [x86]
> >  
> >  			auto,nosmt
> > @@ -2579,7 +2580,7 @@
> >  				Equivalent to: pti=auto [x86]
> >  					       spectre_v2=auto [x86]
> >  					       spectre_v2_user=auto [x86]
> > -					       spec_store_bypass_disable=auto [x86]
> > +					       spec_store_bypass_disable=auto [x86, powerpc]
> >  					       l1tf=flush,nosmt [x86]
> >  
> >  	mminit_loglevel=
> > diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
> > index b33bafb8fcea..5aed4ad729ba 100644
> > --- a/arch/powerpc/kernel/security.c
> > +++ b/arch/powerpc/kernel/security.c
> > @@ -57,7 +57,7 @@ void setup_barrier_nospec(void)
> >  	enable = security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&
> >  		 security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR);
> >  
> > -	if (!no_nospec)
> > +	if (!no_nospec && cpu_spec_mitigations != CPU_SPEC_MITIGATIONS_OFF)
> >  		enable_barrier_nospec(enable);
> 
> Adding a wrapper func that checks for CPU_SPEC_MITIGATIONS_OFF would
> make these a little less verbose, eg:
> 
> 	if (!no_nospec && !cpu_spec_mitigations_off())
>   		enable_barrier_nospec(enable);
> 
> But that's a nitpick.

Yes, that would be much nicer.  I'll probably do something like that in
the next version.  Thanks.

-- 
Josh
