Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB051C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98452087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocuyImxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfCKVRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:17:15 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41159 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfCKVRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:17:14 -0400
Received: by mail-qt1-f193.google.com with SMTP id v10so234576qtp.8;
        Mon, 11 Mar 2019 14:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4j3HEZankYO3iOM/HOBbb61LY4IRt7eDPG/d2XGJVbc=;
        b=ocuyImxA0hdc0yW3lgCiJyiGCBQlX5YbBWrHa+Lg3+ewHS1dY8UqJ5ke6uQexvkhVC
         bPyiGl5YwB95LIe+p3ERnSVFJggCVoFDC94uuXtwsIoap6cfDlFBACkN3UGkdWkFApAl
         oX/IEQlu08/NVJOkvzElfBcODOSffTFqu1BoQP+B2KXgCA8omNFEWvy74aAzO9TC8Zbt
         6YepTGRGqi8pspfiv5AOOin9r/KoBOf3kapADUWa9TmvfYyhdrGnJL2lAYbpOyVLGMsE
         E9fF1mE7QfkI/Y2ZSTybJb6IAF+ytOWaxrgGkOg+OzwVzd5EX5ubsIjJBrgSDUA2j6xH
         +Piw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4j3HEZankYO3iOM/HOBbb61LY4IRt7eDPG/d2XGJVbc=;
        b=PjE2swpreOTxBJ2Y6apvdhrsnctPuFpmCrgnehoigo2QLWuWUmU8LKp5hGqfOjO5hK
         5gA3QpxGopWxEDmHhv6Jzsa7cmD8rcknBX68l4lHNtmEhvj9vuzRdRtjk4qaDv20O/vK
         GTjJGGWuvgUnweeBqRlrJEElsYyRTo8LDWRk1B7ZbiwGXIBla/ENYu7PtbHJ7l6uVwWP
         dfPazRlCWizKnIOi9QJAP8Mg1xUmd71WRmWPsHkzQ27HBiQwzyasGOuyIOY50O7jGjsw
         b0Cdh+1i2i/ri7gfuGAfwybnc7lUMjukBIV9Dpw7/wcjTNxTOtQyoKw/s+kl4cIF2iuk
         9Q5A==
X-Gm-Message-State: APjAAAV12VP6aL6zLvC4D7xXJnnIe3k5KaqzKXIk3TarolcGFGzkpCnl
        VjaVe2TVWjA2j9hiQysPCkI=
X-Google-Smtp-Source: APXvYqy8nlqCkmLopjB1BVj13xKbw8TawtY3sF28FHw3tcCsK2UcOTkJkra/nMFamU6V6TQ73SuE6g==
X-Received: by 2002:a0c:b6d1:: with SMTP id h17mr27887693qve.135.1552339033087;
        Mon, 11 Mar 2019 14:17:13 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id m52sm4702054qtc.23.2019.03.11.14.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 14:17:12 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7FC204039C; Mon, 11 Mar 2019 18:17:09 -0300 (-03)
Date:   Mon, 11 Mar 2019 18:17:09 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "sdf@fomichev.me" <sdf@fomichev.me>
Subject: Re: [PATCH v8 perf,bpf 10/15] perf-top: add option --no-bpf-event
Message-ID: <20190311211709.GA4939@kernel.org>
References: <20190311195555.889995-1-songliubraving@fb.com>
 <20190311195555.889995-11-songliubraving@fb.com>
 <B1C5BA9A-20FB-46BA-A4D8-759CBA1C9ABD@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B1C5BA9A-20FB-46BA-A4D8-759CBA1C9ABD@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 09:07:20PM +0000, Song Liu escreveu:
> 
> 
> > On Mar 11, 2019, at 12:55 PM, Song Liu <songliubraving@fb.com> wrote:
> > 
> > bpf events should be tracked by default for perf-top. This patch makes it
> > on by default, and adds option to disable bpf events.
> > 
> > Signed-off-by: Song Liu <songliubraving@fb.com>
> > ---
> > tools/perf/builtin-top.c | 3 +++
> > tools/perf/util/top.h    | 1 +
> > 2 files changed, 4 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index 27d8d42e0a4d..ccdf5689452f 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -1492,6 +1492,7 @@ int cmd_top(int argc, const char **argv)
> > 		    "Display raw encoding of assembly instructions (default)"),
> > 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
> > 		    "Enable kernel symbol demangling"),
> > +	OPT_BOOLEAN(0, "no-bpf-event", &top.no_bpf_event, "do not record bpf events"),
> > 	OPT_STRING(0, "objdump", &top.annotation_opts.objdump_path, "path",
> > 		    "objdump binary to use for disassembly and annotations"),
> > 	OPT_STRING('M', "disassembler-style", &top.annotation_opts.disassembler_style, "disassembler style",
> > @@ -1651,6 +1652,8 @@ int cmd_top(int argc, const char **argv)
> > 		signal(SIGWINCH, winch_sig);
> > 	}
> > 
> > +	top.record_opts.bpf_event = !top.no_bpf_event;
> > +
> > 	status = __cmd_top(&top);
> > 
> > out_delete_evlist:
> > diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
> > index 19f95eaf75c8..862a37bd27ea 100644
> > --- a/tools/perf/util/top.h
> > +++ b/tools/perf/util/top.h
> > @@ -32,6 +32,7 @@ struct perf_top {
> > 	bool		   use_tui, use_stdio;
> > 	bool		   vmlinux_warned;
> > 	bool		   dump_symtab;
> > +	bool		   no_bpf_event;
> > 	struct hist_entry  *sym_filter_entry;
> > 	struct perf_evsel  *sym_evsel;
> > 	struct perf_session *session;
> > -- 
> > 2.17.1
> > 
> 
> Hi Arnaldo, 
> 
> Currently, we have bpf-event default OFF for perf-record, with option to 
> turn it ON; while bpf-event is default ON for perf-top, with option to 
> turn if OFF. I think this is a little confusing. 
> 
> How about we set them both to default ON, and add option to turn it OFF?

Agreed.

> I think we still have time to make the change. 
> 
> Thanks,
> Song
> 
> 

-- 

- Arnaldo
