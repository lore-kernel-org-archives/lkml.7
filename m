Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209C5CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 08:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C0220867
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 08:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572077085;
	bh=0Ybg33h4Z4BRHS95I27jriTXQZvjzY59pizQbW6iyEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YkKnv3LVl83SpDV5UHuNWRi7WyaCxPlhojHr52wR/k52RWFRK43MPVMGrCeT0NeXV
	 jlhyT8xLM3cakK12t86yiftTf8ySfINy9zqZ4Vrw9chZ9fKWHt6v9XKf9c65Td6lcd
	 /5nnDXYxg8jDX3RItf8YTcPIv9vtb07lI7T9FUiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfJZIEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 04:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfJZIEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 04:04:42 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B4A5214DA;
        Sat, 26 Oct 2019 08:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572077081;
        bh=0Ybg33h4Z4BRHS95I27jriTXQZvjzY59pizQbW6iyEA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vsZypVoptBxz6HEvwI6kexxRnSuXt9/2bsRHs8mj7s4nwmAhG4kdPGU2NAIk5vtnh
         5EEaRLl5LufsbGWQqxcAdi0dHhIvahZjbwjQnWepvzrBnAKbFPuUaB9umg1Qfm+k46
         pZxEapoo12arAQ/4u6QquHmnH0BuTMZuSldhKO3c=
Date:   Sat, 26 Oct 2019 17:04:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH 3/6] perf/probe: Fix to probe an inline function
 which has no entry pc
Message-Id: <20191026170437.22719a025f59111c4213b701@kernel.org>
In-Reply-To: <20191025143910.GC15617@kernel.org>
References: <157199317547.8075.1010940983970397945.stgit@devnote2>
        <157199320336.8075.16189530425277588587.stgit@devnote2>
        <20191025143513.GB15617@kernel.org>
        <20191025143910.GC15617@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo 

On Fri, 25 Oct 2019 11:39:10 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Fri, Oct 25, 2019 at 11:35:13AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Oct 25, 2019 at 05:46:43PM +0900, Masami Hiramatsu escreveu:
> > > Fix perf probe to probe an inlne function which has no entry pc
> > > or low pc but only has ranges attribute.
> > > 
> > > This seems very rare case, but I could find a few examples, as
> > > same as probe_point_search_cb(), use die_entrypc() to get the
> > > entry address in probe_point_inline_cb() too.
> > > 
> > > Without this patch,
> > >   # tools/perf/perf probe -D __amd_put_nb_event_constraints
> > >   Failed to get entry address of __amd_put_nb_event_constraints.
> > >   Probe point '__amd_put_nb_event_constraints' not found.
> > >     Error: Failed to add events.
> > > 
> > > With this patch,
> > >   # tools/perf/perf probe -D __amd_put_nb_event_constraints
> > >   p:probe/__amd_put_nb_event_constraints amd_put_event_constraints+43
> > 
> > Here I got it slightly different:
> > 
> > Before:
> > 
> >   [root@quaco ~]# perf probe -D __amd_put_nb_event_constraints
> >   Failed to get entry address of __amd_put_nb_event_constraints.
> >   Probe point '__amd_put_nb_event_constraints' not found.
> >     Error: Failed to add events.
> >   [root@quaco ~]#
> > 
> > After:
> > 
> >   [root@quaco ~]# perf probe -D __amd_put_nb_event_constraints
> >   p:probe/__amd_put_nb_event_constraints _text+33789
> >   [root@quaco ~]#

Ah, sorry, it was my mistake, when I copy the command, I lacked -k option,
which means using offline kernel image. I'll update the patch description
and resend it.

With online kernel (same buildid), perf-probe modifies the address with
_text based offset for avoiding mixed up with same-name symbols. Even if
there are several same-name symbols (like local functions),  the
"_text + offset" expression can identify one of them.
However, if the buildid of the given kernel image (specified by -k option)
doesn't match, it generates event definition based on the symbol name.
Hmm, I think we can use _text even with off-line kernel, I'll check it.

> > 
> > 
> > ----
> > 
> > I'm now checking if this is because I applied patch 4/6 before 3/6
> 
> Nope, even then:
> 
> [root@quaco ~]# perf probe -D __amd_put_nb_event_constraints
> p:probe/__amd_put_nb_event_constraints _text+33789
> [root@quaco ~]# grep __amd_put_nb_event_constraints /proc/kallsyms
> [root@quaco ~]#

So, _text + offset is normal behavior. I'll try to renew the example
with actual options. Sorry for confusing.

Thank you,


> 
> Ok, maybe this may help:
> 
> [root@quaco ~]# perf probe -v -D __amd_put_nb_event_constraints |& grep vmlinux
> Looking at the vmlinux_path (8 entries long)
> Using /usr/lib/debug/lib/modules/5.2.18-200.fc30.x86_64/vmlinux for symbols
> Open Debuginfo file: /usr/lib/debug/lib/modules/5.2.18-200.fc30.x86_64/vmlinux
> [root@quaco ~]#
> 
> [root@quaco ~]# readelf -wi /usr/lib/debug/lib/modules/5.2.18-200.fc30.x86_64/vmlinux | grep __amd_put_nb_event_constraints -B1 -A7
>  <1><192640>: Abbrev Number: 123 (DW_TAG_subprogram)
>     <192641>   DW_AT_name        : (indirect string, offset: 0x299576): __amd_put_nb_event_constraints
>     <192645>   DW_AT_decl_file   : 1
>     <192646>   DW_AT_decl_line   : 361
>     <192648>   DW_AT_decl_column : 13
>     <192649>   DW_AT_prototyped  : 1
>     <192649>   DW_AT_inline      : 1	(inlined)
>     <19264a>   DW_AT_sibling     : <0x192700>
>  <2><19264e>: Abbrev Number: 38 (DW_TAG_formal_parameter)
> ^C
> [root@quaco ~]#
> 
> Continuing to process the other patches...
> 
> - Arnaldo
>   
> > > Fixes: 4ea42b181434 ("perf: Add perf probe subcommand, a kprobe-event setup helper")
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > ---
> > >  tools/perf/util/probe-finder.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> > > index 71633f55f045..2fa932bcf960 100644
> > > --- a/tools/perf/util/probe-finder.c
> > > +++ b/tools/perf/util/probe-finder.c
> > > @@ -930,7 +930,7 @@ static int probe_point_inline_cb(Dwarf_Die *in_die, void *data)
> > >  		ret = find_probe_point_lazy(in_die, pf);
> > >  	else {
> > >  		/* Get probe address */
> > > -		if (dwarf_entrypc(in_die, &addr) != 0) {
> > > +		if (die_entrypc(in_die, &addr) != 0) {
> > >  			pr_warning("Failed to get entry address of %s.\n",
> > >  				   dwarf_diename(in_die));
> > >  			return -ENOENT;
> > 
> > -- 
> > 
> > - Arnaldo
> 
> -- 
> 
> - Arnaldo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
