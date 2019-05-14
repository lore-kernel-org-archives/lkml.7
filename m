Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DA5C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5762086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCRDczIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfENTe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 15:34:57 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41779 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfENTe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 15:34:56 -0400
Received: by mail-qt1-f193.google.com with SMTP id y22so419510qtn.8;
        Tue, 14 May 2019 12:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RBYOvxiWmO3bQL8vugMK4oxEBk4q/77DwSeYMrIR7sM=;
        b=CCRDczIjXsd3Ym5A7uoH1pOzcknd1ilZw42UBtqnTSGIX0CtFt4uxO9kCsawBqZiwW
         oc/9trz2tw3t2undUUtMGrl3lKYaAxbIn5Ra+1DcRpUGeznQw4BzF3SziSzZM5aq4Phw
         xgNObaWTKiAM4nWbfkDiNaSh8w8PQlMhUCaIW8xlVB3aD1zv6tdQjdlsRCMS7+yjJQqu
         A81eUvTFklbl2awvScOKIMmnExokyACo11YldQ1BRHNg95vlw7YLdhMGtvyd3274PxiA
         g7Xy1gMMmypep4MslpMl0qS5tGJFQ8GviRVO8YBKLiKjhWnT3epQNbOPTGnPIinrijPL
         l/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RBYOvxiWmO3bQL8vugMK4oxEBk4q/77DwSeYMrIR7sM=;
        b=ZkzhU1TMqo+YYeyLMBDNnTkxKVXPqaz0zVN1p9hZnePjw8ta0mAg0o3u3YkcywZzgp
         7/LKBAk35yF+5gAFOhfbnBvKiAd3BPlL5xRVoswo3Oh1hU4bXwqI7aKEAEbRdqmBdvG9
         FMo8Pjl13WntMA2CxURYiIZbD9Jo411KtvUsTpnbrcVehw2PBSmPlNY5nMvwYAmnw379
         cUhear69mG08ys8Y7VOlnhCuD1eeRkEFdAoIg/xdgSvUrVcP7gjY5a8QCSBBy3kAOu6g
         ot0H2Ezg0NOpijRhBNuU/Ie3BbUNmlBNERFXlL/sO5rVIBNDYqzGtuSIEAByEFwY2SoZ
         2MsQ==
X-Gm-Message-State: APjAAAXOLCgw8RUhDNK1udrKWgLpj9E8Mi/3yEHS4IGofKf/Li5XqmE6
        hyWoDkm5vAgvur5BV2Zjqdo=
X-Google-Smtp-Source: APXvYqxZmWam7B95dIXeaMIQ4UZ37RuknBm9llEAqMQLP387twPJ3C9/pK23VkTjH3AntpKDS13+hQ==
X-Received: by 2002:ac8:2cbc:: with SMTP id 57mr9119426qtw.222.1557862495398;
        Tue, 14 May 2019 12:34:55 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-182-78.3g.claro.net.br. [179.240.182.78])
        by smtp.gmail.com with ESMTPSA id e8sm8343784qtm.34.2019.05.14.12.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 12:34:54 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B0FF2403AD; Tue, 14 May 2019 16:34:50 -0300 (-03)
Date:   Tue, 14 May 2019 16:34:50 -0300
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/3] perf parse-regs: Add generic support for non-gprs
Message-ID: <20190514193450.GA21157@kernel.org>
References: <1557844753-58223-1-git-send-email-kan.liang@linux.intel.com>
 <1557844753-58223-2-git-send-email-kan.liang@linux.intel.com>
 <20190514181902.GB1756@kernel.org>
 <4b2b6e69-4e39-0946-4010-1bc3a2a60696@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b2b6e69-4e39-0946-4010-1bc3a2a60696@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 14, 2019 at 03:25:51PM -0400, Liang, Kan escreveu:
> 
> 
> On 5/14/2019 2:19 PM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, May 14, 2019 at 07:39:12AM -0700, kan.liang@linux.intel.com escreveu:
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > > 
> > > Some non general purpose registers, e.g. XMM, can be collected on some
> > > platforms, e.g. X86 Icelake.
> > > 
> > > Add a weak function has_non_gprs_support() to check if the
> > > kernel/hardware support non-gprs collection.
> > > Add a weak function non_gprs_mask() to return non-gprs mask.
> > > 
> > > By default, the non-gprs collection is not support. Specific platforms
> > > should implement their own non-gprs functions if they can collect
> > > non-gprs.
> > > 
> > > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > > ---
> > >   tools/perf/util/parse-regs-options.c | 10 +++++++++-
> > >   tools/perf/util/perf_regs.c          | 10 ++++++++++
> > >   tools/perf/util/perf_regs.h          |  2 ++
> > >   3 files changed, 21 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
> > > index b21617f..2f90f31 100644
> > > --- a/tools/perf/util/parse-regs-options.c
> > > +++ b/tools/perf/util/parse-regs-options.c
> > > @@ -12,6 +12,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
> > >   	const struct sample_reg *r;
> > >   	char *s, *os = NULL, *p;
> > >   	int ret = -1;
> > > +	bool has_non_gprs = has_non_gprs_support(intr);
> > 
> > This is generic code, what does "non gprs" means for !Intel? Can we come
> > up with a better, not architecture specific jargon? Or you mean "general
> > purpose registers"?
> 
> I mean "general purpose registers".

Ok
 
> > 
> > Perhaps we can ask for a register mask for use with intr? I.e.:
> > 
> > For the -I/--intr-regs
> > 
> >          uint64_t mask = arch__intr_reg_mask();
> > 
> > And for --user-regs
> > 
> >          uint64_t mask = arch__user_reg_mask();
> > 
> > And then on that loop do:
> > 
> >    	for (r = sample_reg_masks; r->name; r++) {
> > 		if (r->mask & mask))
> >    			fprintf(stderr, "%s ", r->name);
> >    	}
> > 
> > ?
> 
> Yes, it looks like a little bit simpler than my implementation.
> I will send out V2.

Thanks!
 
> Thanks,
> Kan
> 
> > >   	if (unset)
> > >   		return 0;
> > > @@ -37,6 +38,8 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
> > >   			if (!strcmp(s, "?")) {
> > >   				fprintf(stderr, "available registers: ");
> > >   				for (r = sample_reg_masks; r->name; r++) {
> > > +					if (!has_non_gprs && (r->mask & ~PERF_REGS_MASK))
> > > +						break;
> > >   					fprintf(stderr, "%s ", r->name);
> > >   				}
> > >   				fputc('\n', stderr);
> > > @@ -44,6 +47,8 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
> > >   				return -1;
> > >   			}
> > >   			for (r = sample_reg_masks; r->name; r++) {
> > > +				if (!has_non_gprs && (r->mask & ~PERF_REGS_MASK))
> > > +					continue;
> > >   				if (!strcasecmp(s, r->name))
> > >   					break;
> > >   			}
> > > @@ -64,8 +69,11 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
> > >   	ret = 0;
> > >   	/* default to all possible regs */
> > > -	if (*mode == 0)
> > > +	if (*mode == 0) {
> > >   		*mode = PERF_REGS_MASK;
> > > +		if (has_non_gprs)
> > > +			*mode |= non_gprs_mask(intr);
> > > +	}
> > >   error:
> > >   	free(os);
> > >   	return ret;
> > > diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> > > index 2acfcc5..0d278b6 100644
> > > --- a/tools/perf/util/perf_regs.c
> > > +++ b/tools/perf/util/perf_regs.c
> > > @@ -13,6 +13,16 @@ int __weak arch_sdt_arg_parse_op(char *old_op __maybe_unused,
> > >   	return SDT_ARG_SKIP;
> > >   }
> > > +bool __weak has_non_gprs_support(bool intr __maybe_unused)
> > > +{
> > > +	return false;
> > > +}
> > > +
> > > +u64 __weak non_gprs_mask(bool intr __maybe_unused)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > >   #ifdef HAVE_PERF_REGS_SUPPORT
> > >   int perf_reg_value(u64 *valp, struct regs_dump *regs, int id)
> > >   {
> > > diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> > > index 1a15a4b..983b4e6 100644
> > > --- a/tools/perf/util/perf_regs.h
> > > +++ b/tools/perf/util/perf_regs.h
> > > @@ -23,6 +23,8 @@ enum {
> > >   };
> > >   int arch_sdt_arg_parse_op(char *old_op, char **new_op);
> > > +bool has_non_gprs_support(bool intr);
> > > +u64 non_gprs_mask(bool intr);
> > >   #ifdef HAVE_PERF_REGS_SUPPORT
> > >   #include <perf_regs.h>
> > > -- 
> > > 2.7.4
> > 

-- 

- Arnaldo
