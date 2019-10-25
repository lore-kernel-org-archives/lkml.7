Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53B1CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF37B21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDPFHIw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440048AbfJYOjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:39:16 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40661 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440001AbfJYOjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:39:16 -0400
Received: by mail-qt1-f194.google.com with SMTP id o49so3546349qta.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 07:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=slfEvGT57OxIu3hX85oZQaDrJpmEdiqRD6KlxrAV7aQ=;
        b=vDPFHIw23VXT1K87qQNIYWSLV8YkofOSlB9fDCEHicyXkAy08DbZp0GhqWm+9iAPAr
         fLPI1Pxq/EAuNpiUQY2U6tuTEp5G4qXp1IF6mfDSC81rlR5DxfcB6A98G7Q4kV0yOCoR
         SKYgt1IFrwURKElP0Fnsl9iad5j9+IaGVmn8Q+Y2uH61Fo+WxkgvpeyU5o1QdnFhXzjS
         54ZRt5xW69LE8F6RGP16YYg53hX7SRHWraWPRbOxIem76r0oMaZ983/vo7ZBRYvi+uXr
         1SzOz2hipaJN76BG3FP++IZ5l0w1ZVct0AvXl6x9YqroOeZqv+12eOI5mssXwqDdWfc3
         XB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=slfEvGT57OxIu3hX85oZQaDrJpmEdiqRD6KlxrAV7aQ=;
        b=rif0ddzKEXsIrXO2ZvZE8j0YQm+8Z+b67CrXK83Q+i6UXDfSHZJaiIa/YgJLtFnRTE
         y1VGzRwSZdHoStXRFGZEPN2Y1Jo4BiaZlkArZm514eJdU3C577uK0dwsPuHDtDxnUTHQ
         /LS71nKn/7Nh/xZZ7+XflfvUZZW7khSujUN62AP6qBabdXP+rMnv67fYDvPAYhBUT0dS
         BmEckU5QVufNjUGwfryDQlgzQo17qxPaHfXWqEgsbmfj830H6zfltfBjqf/t9nwKh6dr
         OjF+BOOqHavq5U6opZUuYqqZwmSQdbnf53L2zpG+d2RN4h2DXGEInD9OqqwJiNCpici3
         IGdQ==
X-Gm-Message-State: APjAAAVns5ZmAIGZj2fcOGaGRRvnV5IRurebFmnRDqTOhUhAeu7C3W+o
        Say4CD8PiOFPKG2HkaMDLCw=
X-Google-Smtp-Source: APXvYqyPI4wuOct1wJbBgzl8PbW7g3PBp2o6LEacmWROsLX5BKzTuan6Rx50fWUu6ft3NiEEOAsHHg==
X-Received: by 2002:aed:2986:: with SMTP id o6mr3204630qtd.320.1572014353350;
        Fri, 25 Oct 2019 07:39:13 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id z12sm1355387qkg.97.2019.10.25.07.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 07:39:12 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AECB941199; Fri, 25 Oct 2019 11:39:10 -0300 (-03)
Date:   Fri, 25 Oct 2019 11:39:10 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH 3/6] perf/probe: Fix to probe an inline function
 which has no entry pc
Message-ID: <20191025143910.GC15617@kernel.org>
References: <157199317547.8075.1010940983970397945.stgit@devnote2>
 <157199320336.8075.16189530425277588587.stgit@devnote2>
 <20191025143513.GB15617@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025143513.GB15617@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 25, 2019 at 11:35:13AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Oct 25, 2019 at 05:46:43PM +0900, Masami Hiramatsu escreveu:
> > Fix perf probe to probe an inlne function which has no entry pc
> > or low pc but only has ranges attribute.
> > 
> > This seems very rare case, but I could find a few examples, as
> > same as probe_point_search_cb(), use die_entrypc() to get the
> > entry address in probe_point_inline_cb() too.
> > 
> > Without this patch,
> >   # tools/perf/perf probe -D __amd_put_nb_event_constraints
> >   Failed to get entry address of __amd_put_nb_event_constraints.
> >   Probe point '__amd_put_nb_event_constraints' not found.
> >     Error: Failed to add events.
> > 
> > With this patch,
> >   # tools/perf/perf probe -D __amd_put_nb_event_constraints
> >   p:probe/__amd_put_nb_event_constraints amd_put_event_constraints+43
> 
> Here I got it slightly different:
> 
> Before:
> 
>   [root@quaco ~]# perf probe -D __amd_put_nb_event_constraints
>   Failed to get entry address of __amd_put_nb_event_constraints.
>   Probe point '__amd_put_nb_event_constraints' not found.
>     Error: Failed to add events.
>   [root@quaco ~]#
> 
> After:
> 
>   [root@quaco ~]# perf probe -D __amd_put_nb_event_constraints
>   p:probe/__amd_put_nb_event_constraints _text+33789
>   [root@quaco ~]#
> 
> 
> ----
> 
> I'm now checking if this is because I applied patch 4/6 before 3/6

Nope, even then:

[root@quaco ~]# perf probe -D __amd_put_nb_event_constraints
p:probe/__amd_put_nb_event_constraints _text+33789
[root@quaco ~]# grep __amd_put_nb_event_constraints /proc/kallsyms
[root@quaco ~]#

Ok, maybe this may help:

[root@quaco ~]# perf probe -v -D __amd_put_nb_event_constraints |& grep vmlinux
Looking at the vmlinux_path (8 entries long)
Using /usr/lib/debug/lib/modules/5.2.18-200.fc30.x86_64/vmlinux for symbols
Open Debuginfo file: /usr/lib/debug/lib/modules/5.2.18-200.fc30.x86_64/vmlinux
[root@quaco ~]#

[root@quaco ~]# readelf -wi /usr/lib/debug/lib/modules/5.2.18-200.fc30.x86_64/vmlinux | grep __amd_put_nb_event_constraints -B1 -A7
 <1><192640>: Abbrev Number: 123 (DW_TAG_subprogram)
    <192641>   DW_AT_name        : (indirect string, offset: 0x299576): __amd_put_nb_event_constraints
    <192645>   DW_AT_decl_file   : 1
    <192646>   DW_AT_decl_line   : 361
    <192648>   DW_AT_decl_column : 13
    <192649>   DW_AT_prototyped  : 1
    <192649>   DW_AT_inline      : 1	(inlined)
    <19264a>   DW_AT_sibling     : <0x192700>
 <2><19264e>: Abbrev Number: 38 (DW_TAG_formal_parameter)
^C
[root@quaco ~]#

Continuing to process the other patches...

- Arnaldo
  
> > Fixes: 4ea42b181434 ("perf: Add perf probe subcommand, a kprobe-event setup helper")
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  tools/perf/util/probe-finder.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> > index 71633f55f045..2fa932bcf960 100644
> > --- a/tools/perf/util/probe-finder.c
> > +++ b/tools/perf/util/probe-finder.c
> > @@ -930,7 +930,7 @@ static int probe_point_inline_cb(Dwarf_Die *in_die, void *data)
> >  		ret = find_probe_point_lazy(in_die, pf);
> >  	else {
> >  		/* Get probe address */
> > -		if (dwarf_entrypc(in_die, &addr) != 0) {
> > +		if (die_entrypc(in_die, &addr) != 0) {
> >  			pr_warning("Failed to get entry address of %s.\n",
> >  				   dwarf_diename(in_die));
> >  			return -ENOENT;
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
