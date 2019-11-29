Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2046C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 15:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FA921736
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 15:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0zaQXg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfK2PRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 10:17:39 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43690 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfK2PRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 10:17:38 -0500
Received: by mail-qk1-f193.google.com with SMTP id q28so6859878qkn.10;
        Fri, 29 Nov 2019 07:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U1LwTXtTJwMx/Gf3bAA/rzMwkaawHZhe6MpIRKU1ETs=;
        b=p0zaQXg/QH1tViOwvoFBuFxpcYjAVLYFuFsY6eGC06Zev4iIvs4xWstyELAG6XVbYX
         3FFmumMAbLTjuJX1g1RTolJx3LtIOuISlDLBcCD2kFlzekivV6S9GFnQrXklOvWpBZ1I
         6ViPU9K7hcPkxiLbm5QWaIg18pfsSah98RtwTTGWjnPhaYkYQM8GBaX2LuC/exFLUdG+
         kFKsW4XviraxsTlMTqTKELMFsHJnDYx8+dSaAGKQF6HCRCYLqPrcz0EfBsUgQOYvYD8u
         5HIFKS1MLw3aAzPJNYzI/qsSbdDCrnoc/JDCUot+2HFpoIUrtHIZVgSrriyz/2tfef6Y
         MyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U1LwTXtTJwMx/Gf3bAA/rzMwkaawHZhe6MpIRKU1ETs=;
        b=o3G+L+3KclU2KUUIhcfsmtMdMraz5XaGDDrtIlDErczL1o0f8Yk0ENGU9U4CIQVdUq
         JMWKa1ZfqWLnEEHX9okJ/qQIFSCH5kbyVb15OHyOd2t+EdqsXjpFss2Rfx92IEH/52Sc
         qBKQz2HHQNm1OhjY/nlmZl9IjCImDHlZinMpyV0sfxeel9OXPn4GEJZomReWz7/ArTqU
         E6ajuTP7PKSl9fzSj7u8fT+DZVzqnKvSwoKRjm/HbsA5Bl63ZAzF9Ja4HuMcZN5MmjOl
         nZAC8aHtamWnp9m0SR0jrWHuxsuZ0J+Dg7P/xQC9DUQunv6F8fsvQ7hRwGHLP9B6NfKi
         iNYw==
X-Gm-Message-State: APjAAAU0uoERtCuYaKGA3QYTsq05X+K/4qHlLfUVQysd2TPM8BXLBCZL
        GaPxP+46MAwYhI83+9KGRCE=
X-Google-Smtp-Source: APXvYqwCkzOCf7m9eLmcpJCrljKxYKRw1sPitU6OrvYXjVgFVw6bLg4Q2YsTGt1SVitBbMZ6jtcHAw==
X-Received: by 2002:a05:620a:1209:: with SMTP id u9mr4820532qkj.248.1575040656295;
        Fri, 29 Nov 2019 07:17:36 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id w76sm5465878qkb.8.2019.11.29.07.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 07:17:35 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 682A1405B6; Fri, 29 Nov 2019 12:17:33 -0300 (-03)
Date:   Fri, 29 Nov 2019 12:17:33 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 04/15] perf tools: Add map_groups to 'struct
 addr_location'
Message-ID: <20191129151733.GC26963@kernel.org>
References: <20191112183757.28660-1-acme@kernel.org>
 <20191112183757.28660-5-acme@kernel.org>
 <20191129134056.GE14169@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129134056.GE14169@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 29, 2019 at 02:40:56PM +0100, Jiri Olsa escreveu:
> On Tue, Nov 12, 2019 at 03:37:46PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > From there we can get al->mg->machine, so replace that field with the
> > more useful 'struct map_groups' that for now we're obtaining from
> > al->map->groups, and that is one thing getting into the way of maps
> > being fully shareable.
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Link: https://lkml.kernel.org/n/tip-4qdducrm32tgrjupcp0kjh1e@git.kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/callchain.c                          |  6 +++---
> >  tools/perf/util/db-export.c                          | 12 ++++++------
> >  tools/perf/util/event.c                              |  6 +++---
> >  .../perf/util/scripting-engines/trace-event-python.c |  2 +-
> >  tools/perf/util/symbol.h                             |  2 +-
> >  5 files changed, 14 insertions(+), 14 deletions(-)
> > 
> > diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> > index 9a9b56ed3f0a..89faa644b0bc 100644
> > --- a/tools/perf/util/callchain.c
> > +++ b/tools/perf/util/callchain.c
> > @@ -1119,8 +1119,8 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
> >  			goto out;
> >  	}
> >  
> > -	if (al->map->groups == &al->machine->kmaps) {
> > -		if (machine__is_host(al->machine)) {
> > +	if (al->mg == &al->mg->machine->kmaps) {
> 
> heya, I'm getting segfault because of this change
> 
> perf record --call-graph dwarf ./ex
> 
> 	(gdb) r report --stdio
> 	Program received signal SIGSEGV, Segmentation fault.
> 	fill_callchain_info (al=0x7fffffffa1b0, node=0xcd2bd0, hide_unresolved=false) at util/callchain.c:1122
> 	1122            if (al->maps == &al->maps->machine->kmaps) {
> 	(gdb) p al->maps
> 	$1 = (struct maps *) 0x0
> 
> I wish all those map changes would go through some review,
> I have no idea how the code works now ;-)

ouch, I did tons of tests, obviously some more, and reviewing, would
catch these, my bad, will try and fix this...

And yeah, I reproduced the problem, working on a fix.

- Arnaldo
