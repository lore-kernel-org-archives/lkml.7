Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DB0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C832A20855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zDPGxnhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfCHVcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:32:17 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37478 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfCHVcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T9W0N0LW1D35wu6wa1ptKy0t9BSrUQcLCieLxJkuDmY=; b=zDPGxnhcJydjZde1fNboAEWw2
        fU3fgN3bpsGlqPMwoWOh0r3pWQb0MGoz0t1ypQHjTV3HriiNNydgkPO6C/HKRSI+bD5mpnO8tq3kV
        6jXTgX8dSUHSTVqqLVl6JR1Fz1HTvD8hZEDX5niMcs02VFp/fxdr1+Q1hBdPQFFXr5LGapQjR2uEs
        Bss6LEJYG+oXVSMWwCn3A468c8sEn3jKIElAAt3tCDtu485uavk4sZfyPd2IFSIG61Sm0c3yyfdzo
        8W4jgAbI9jUSWvde/Ok5CB59A/MAUdiyQXA3liQLh9mZUkrsCZKFfRI25xtvXyWXgqLr41PI5xyu4
        50jTRDTlw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2N5y-00021n-6h; Fri, 08 Mar 2019 21:31:58 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0DB4F981BBE; Fri,  8 Mar 2019 22:31:56 +0100 (CET)
Date:   Fri, 8 Mar 2019 22:31:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 18/20] objtool: Add UACCESS validation
Message-ID: <20190308213155.GD2482@worktop.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.697533978@infradead.org>
 <20190308210209.usq2rpedccz25va5@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308210209.usq2rpedccz25va5@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 03:02:09PM -0600, Josh Poimboeuf wrote:
> > +static const char *uaccess_safe_builtin[] = {
> > +	/* KASAN */
> 
> A short comment would be good here, something describing why a function
> might be added to the list.

There is; but I'm thinking it might be too short?

> > +	"memset_orig", /* XXX why not memset_erms */
> > +	"__memset",
> > +	"kasan_poison_shadow",
> > +	"kasan_unpoison_shadow",
> > +	"__asan_poison_stack_memory",
> > +	"__asan_unpoison_stack_memory",

Those are gone.

> > +	"kasan_report",

That is the main kasan_report function, and is for, as the comment says:
kasan :-)

> > +	"check_memory_region",

for __asan_{load,store}N

> > +	/* KASAN out-of-line */
> > +	"__asan_loadN_noabort",
> > +	"__asan_load1_noabort",
> > +	"__asan_load2_noabort",
> > +	"__asan_load4_noabort",
> > +	"__asan_load8_noabort",
> > +	"__asan_load16_noabort",
> > +	"__asan_storeN_noabort",
> > +	"__asan_store1_noabort",
> > +	"__asan_store2_noabort",
> > +	"__asan_store4_noabort",
> > +	"__asan_store8_noabort",
> > +	"__asan_store16_noabort",

These, are, again as the comment suggests, the out-of-line KASAN ABI
calls.

> > +	/* KASAN in-line */
> > +	"__asan_report_load_n_noabort",
> > +	"__asan_report_load1_noabort",
> > +	"__asan_report_load2_noabort",
> > +	"__asan_report_load4_noabort",
> > +	"__asan_report_load8_noabort",
> > +	"__asan_report_load16_noabort",
> > +	"__asan_report_store_n_noabort",
> > +	"__asan_report_store1_noabort",
> > +	"__asan_report_store2_noabort",
> > +	"__asan_report_store4_noabort",
> > +	"__asan_report_store8_noabort",
> > +	"__asan_report_store16_noabort",

The in-line KASAN ABI

Also, can I just say that {load,store}N vs {load,store}_n bugs the
hell out of me?

> > +	/* KCOV */
> > +	"write_comp_data",

the logger function

> > +	"__sanitizer_cov_trace_pc",
> > +	"__sanitizer_cov_trace_const_cmp1",
> > +	"__sanitizer_cov_trace_const_cmp2",
> > +	"__sanitizer_cov_trace_const_cmp4",
> > +	"__sanitizer_cov_trace_const_cmp8",
> > +	"__sanitizer_cov_trace_cmp1",
> > +	"__sanitizer_cov_trace_cmp2",
> > +	"__sanitizer_cov_trace_cmp4",
> > +	"__sanitizer_cov_trace_cmp8",

KCOV ABI

> > +	/* UBSAN */
> > +	"ubsan_type_mismatch_common",

implementation

> > +	"__ubsan_handle_type_mismatch",
> > +	"__ubsan_handle_type_mismatch_v1",

UBSAN ABI

> > +	/* misc */
> > +	"csum_partial_copy_generic",
> > +	"__memcpy_mcsafe",
> > +	"ftrace_likely_update", /* CONFIG_TRACE_BRANCH_PROFILING */
> > +	NULL
> > +};

> > +		func = find_symbol_by_name(file->elf, *name);
> 
> This won't work if the function name changes due to IPA optimizations.
> I assume these are all global functions so maybe it's fine?

With one or two exceptions, yep.

> These gotos make my head spin.  Again I would much prefer a small amount
> of code duplication over this.

I didn't think the code was that bad once you see the end result, but
sure, I can try something else.

> > +++ b/tools/objtool/special.c
> > @@ -42,6 +42,7 @@
> >  #define ALT_NEW_LEN_OFFSET	11
> >  
> >  #define X86_FEATURE_POPCNT (4*32+23)
> > +#define X86_FEATURE_SMAP   (9*32+20)
> >  
> >  struct special_entry {
> >  	const char *sec;
> > @@ -107,8 +108,15 @@ static int get_alt_entry(struct elf *elf
> >  		 * It has been requested that we don't validate the !POPCNT
> >  		 * feature path which is a "very very small percentage of
> >  		 * machines".
> > +		 *
> > +		 * Also, unconditionally enable SMAP; this avoids seeing paths
> > +		 * that pass through the STAC alternative and through the CLAC
> > +		 * NOPs.
> 
> Why is this a problem?

'obvious' violation?

STAC; .... RET; # an AC=1 leak

.... CLAC; # spurious CLAC

If we do the STAC we must also do the CLAC. If we don't do the STAC we
must also not do the CLAC.


> > +		 *
> > +		 * XXX: We could do this for all binary NOP/single-INSN
> > +		 * alternatives.
> 
> Same question here.

In general, validating NOPs isn't too interesting, so all NOP/INSN
binary alternatives could be forced on.

> >  		 */
> > -		if (feature == X86_FEATURE_POPCNT)
> > +		if (feature == X86_FEATURE_POPCNT || feature == X86_FEATURE_SMAP)
> >  			alt->skip_orig = true;
> >  	}

I've actually changed this to depend on --uaccess, when set we force on
FEATURE_SMAP, otherwise we force off.
