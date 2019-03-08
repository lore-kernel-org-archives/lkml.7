Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F7BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E850120643
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfCHVyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:54:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfCHVyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:54:54 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03171307B967;
        Fri,  8 Mar 2019 21:54:54 +0000 (UTC)
Received: from treble (ovpn-123-151.rdu2.redhat.com [10.10.123.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A193258B2;
        Fri,  8 Mar 2019 21:54:51 +0000 (UTC)
Date:   Fri, 8 Mar 2019 15:54:49 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 18/20] objtool: Add UACCESS validation
Message-ID: <20190308215449.47xk64pt7svk4pef@treble>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.697533978@infradead.org>
 <20190308210209.usq2rpedccz25va5@treble>
 <20190308213155.GD2482@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190308213155.GD2482@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 08 Mar 2019 21:54:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 10:31:56PM +0100, Peter Zijlstra wrote:
> On Fri, Mar 08, 2019 at 03:02:09PM -0600, Josh Poimboeuf wrote:
> > > +static const char *uaccess_safe_builtin[] = {
> > > +	/* KASAN */
> > 
> > A short comment would be good here, something describing why a function
> > might be added to the list.
> 
> There is; but I'm thinking it might be too short?

I actually just meant a comment above uaccess_safe_builtin describing
what the purpose of the list is and what the expectations are for the
listed functions.  i.e. these are functions which are allowed to be
called with the AC flag on, and they should not clear it unless they're
saving/restoring.

> > > +++ b/tools/objtool/special.c
> > > @@ -42,6 +42,7 @@
> > >  #define ALT_NEW_LEN_OFFSET	11
> > >  
> > >  #define X86_FEATURE_POPCNT (4*32+23)
> > > +#define X86_FEATURE_SMAP   (9*32+20)
> > >  
> > >  struct special_entry {
> > >  	const char *sec;
> > > @@ -107,8 +108,15 @@ static int get_alt_entry(struct elf *elf
> > >  		 * It has been requested that we don't validate the !POPCNT
> > >  		 * feature path which is a "very very small percentage of
> > >  		 * machines".
> > > +		 *
> > > +		 * Also, unconditionally enable SMAP; this avoids seeing paths
> > > +		 * that pass through the STAC alternative and through the CLAC
> > > +		 * NOPs.
> > 
> > Why is this a problem?
> 
> 'obvious' violation?
> 
> STAC; .... RET; # an AC=1 leak
> 
> .... CLAC; # spurious CLAC
> 
> If we do the STAC we must also do the CLAC. If we don't do the STAC we
> must also not do the CLAC.

Makes sense now, can you add that last sentence to the paragraph?

> > > +		 *
> > > +		 * XXX: We could do this for all binary NOP/single-INSN
> > > +		 * alternatives.
> > 
> > Same question here.
> 
> In general, validating NOPs isn't too interesting, so all NOP/INSN
> binary alternatives could be forced on.

Right, but it doesn't sound like there's any real benefit to adding
extra logic.

> > >  		 */
> > > -		if (feature == X86_FEATURE_POPCNT)
> > > +		if (feature == X86_FEATURE_POPCNT || feature == X86_FEATURE_SMAP)
> > >  			alt->skip_orig = true;
> > >  	}
> 
> I've actually changed this to depend on --uaccess, when set we force on
> FEATURE_SMAP, otherwise we force off.

Ok.

-- 
Josh
