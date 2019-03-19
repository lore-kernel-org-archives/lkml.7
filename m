Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82BFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5012147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJsw/+E5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfCSNiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:38:06 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39645 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbfCSNiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:38:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id c189so11830061qke.6;
        Tue, 19 Mar 2019 06:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rwwt3s+q6HGtM3YX8nR9UkkyxK36VH+pwvoQivb/Ou4=;
        b=EJsw/+E5dimb+TZ37EgyJJhvmPWYIt7itmkd1tkBxYEf0H0berfdcYLGeI5E06fLsc
         zSG1k1EBpsUc+9hHnqNKKsuInleW5K6655POElQDmqtw7EDUkNUx5gtvnwVdDrAkeUgv
         dAKdobTTiUTmQ2EBumErjetfxTDPwiQaraRIbRZc7EhkpWPK08S9t0wOJu0l9Jl8MbiP
         5XCYAwO3rOHuWp0xcKs9v2qHEYkHS47RPzpqy44gr0H9TW1L8S2FEwp9segn9VFjAwIu
         50EyT4TGnupPAmlwo9UIxr0rFSrbYvAxViVbmWaFREQzdwT6kEw3WHVCsBlztznfO9yV
         o30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rwwt3s+q6HGtM3YX8nR9UkkyxK36VH+pwvoQivb/Ou4=;
        b=gRV4xRWQkoW55H4JPPgd/KOK6Fkt5duexepND1Y1s1pO18u0PW/aN4RhZLb4sZ4/Wv
         Hg7LODx6JbLmEShCZ2SAP7v9gcfFZkjlxKGSy+p+1rNQnm2NbvDVunVda5OnYhC3BVhI
         S2aeGdEmL3x607exuGY/0QQD0OLnApHhGl+/GwcuFH+rsOQv6KSf2qeMniqRf2wsxLUK
         B2j2ve/w61CIeuEFReBkydSIE2URBHLPwqBJFmuEBGECa7eesRj4YTrz6WRWV0g/ofY/
         rl77AM9VMo3vXAAXqt2E9wurc4paQ0c0zmWMrhYOhWSF52j3yWrYYXeuEfwN6cCvWeKa
         0n/w==
X-Gm-Message-State: APjAAAUveK1b4bONAE4zRkV3QDAO8m5z15KsgTUGmOn70R04ZubtTSBX
        U25T0jl6KjOIaTVSMg/BbC8=
X-Google-Smtp-Source: APXvYqzcTR/OvP3Vqn2kDVq8Q8YiaQ/0GIhAeraODPfwePwPWJ033woaViTc7UGcwsO5bwd21xAhEQ==
X-Received: by 2002:a37:27d4:: with SMTP id n203mr1864237qkn.105.1553002682708;
        Tue, 19 Mar 2019 06:38:02 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id z41sm8786531qtz.5.2019.03.19.06.38.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 06:38:01 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EAF714039C; Tue, 19 Mar 2019 10:37:58 -0300 (-03)
Date:   Tue, 19 Mar 2019 10:37:58 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "sdf@fomichev.me" <sdf@fomichev.me>
Subject: Re: [PATCH v9 perf,bpf 12/15] perf, bpf: enable annotation of bpf
 program
Message-ID: <20190319133758.GB3029@kernel.org>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-13-songliubraving@fb.com>
 <20190318163848.GE22548@kernel.org>
 <20190318164358.GF22548@kernel.org>
 <0EBEB3A4-8C54-4486-AFE5-A058EBDC2117@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0EBEB3A4-8C54-4486-AFE5-A058EBDC2117@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 19, 2019 at 06:10:42AM +0000, Song Liu escreveu:
> 
> 
> > On Mar 18, 2019, at 9:43 AM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > 
> > Em Mon, Mar 18, 2019 at 01:38:48PM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Mon, Mar 11, 2019 at 10:30:48PM -0700, Song Liu escreveu:
> >>> This patch enables the annotation of bpf program.
> >>> 
> >>> A new dso type DSO_BINARY_TYPE__BPF_PROG_INFO is introduced to for BPF
> >>> programs. In symbol__disassemble(), DSO_BINARY_TYPE__BPF_PROG_INFO dso
> >>> calls into a new function symbol__disassemble_bpf(), where annotation
> >>> line information is filled based bpf_prog_info and btf saved in given
> >>> perf_env.
> >>> 
> >>> symbol__disassemble_bpf() uses libbfd to disassemble bpf programs.
> >>> 
> >>> Signed-off-by: Song Liu <songliubraving@fb.com>
> >>> ---
> >>> tools/build/Makefile.feature |   6 +-
> >>> tools/perf/Makefile.config   |   4 +
> >> 
> >> I see the changes to these two files, but I can't see the feature test
> >> that it triggers, forgot to do a git-add? Or is it in an upcoming patch
> >> in this series?
> >> 
> >> After applying this test it "works":
> >> 
> >>  make: Entering directory '/home/acme/git/perf/tools/perf'
> >>    BUILD:   Doing 'make -j8' parallel build
> >> 
> >>  Auto-detecting system features:
> >>  ...                         dwarf: [ on  ]
> >>  ...            dwarf_getlocations: [ on  ]
> >>  <SNIP>
> >>  ...                           bpf: [ on  ]
> >>  ...                        libaio: [ on  ]
> >>  ...        disassembler-four-args: [ on  ]
> >> 
> >> Because you added it to FEATURE_TESTS_BASIC, and this means that if
> >> tools/build/feature/test-all.c builds, then what is in
> >> FEATURE_TESTS_BASIC is set to 'on', but you didn't add anything to
> >> tools/build/feature/test-all.c, so it works because all the other
> >> features are present.
> >> 
> >> Take a look at:
> >> 
> >>  2a07d814747b ("tools build feature: Check if libaio is available")
> >> 
> >> To see what needs to be done.
> >> 
> >> Either way, its interesting to break this patch in two, one adding the
> >> feature test and another to use it, i.e. the second patch out of this
> >> should have the commit log message in this patch.
> >> 
> >> I've applied the patches up to before this one and will continue
> >> processing other patches while you address this.
> > 
> > Ok, to continue processing the other patches I chunked out the part
> > below into a 3rd patch from the above one and have it applied already.
> 
> Could you please push applied patches to the tmp.perf/bpf-annotation 
> branch? 

It is in my perf/core branch already.
 
> Thanks,
> Song
> 
> > 
> > commit f326de312abc3657b0397817c66cd7e1540655f7
> > Author: Song Liu <songliubraving@fb.com>
> > Date:   Mon Mar 11 22:30:48 2019 -0700
> > 
> >    perf symbols: Introduce DSO_BINARY_TYPE__BPF_PROG_INFO
> > 
> >    Introduce a new dso type DSO_BINARY_TYPE__BPF_PROG_INFO for BPF programs. In
> >    symbol__disassemble(), DSO_BINARY_TYPE__BPF_PROG_INFO dso will call into a new
> >    function symbol__disassemble_bpf() in an upcoming patch, where annotation line
> >    information is filled based bpf_prog_info and btf saved in given perf_env.
> > 
> >    Signed-off-by: Song Liu <songliubraving@fb.com>
> >    Reviewed-by: Jiri Olsa <jolsa@kernel.org>
> >    Cc: Alexei Starovoitov <ast@kernel.org>
> >    Cc: Daniel Borkmann <daniel@iogearbox.net>
> >    Cc: Namhyung Kim <namhyung@kernel.org>
> >    Cc: Peter Zijlstra <peterz@infradead.org>
> >    Cc: Stanislav Fomichev <sdf@google.com>
> >    Cc: kernel-team@fb.com
> >    Link: http://lkml.kernel.org/r/20190312053051.2690567-13-songliubraving@fb.com
> >    [ split from a larger patch ]
> >    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index ba58ba603b69..58547c468c65 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> > @@ -184,6 +184,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
> > 	case DSO_BINARY_TYPE__KALLSYMS:
> > 	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
> > 	case DSO_BINARY_TYPE__JAVA_JIT:
> > +	case DSO_BINARY_TYPE__BPF_PROG_INFO:
> > 	case DSO_BINARY_TYPE__NOT_FOUND:
> > 		ret = -1;
> > 		break;
> > diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> > index bb417c54c25a..c274b5aa839d 100644
> > --- a/tools/perf/util/dso.h
> > +++ b/tools/perf/util/dso.h
> > @@ -14,6 +14,7 @@
> > 
> > struct machine;
> > struct map;
> > +struct perf_env;
> > 
> > enum dso_binary_type {
> > 	DSO_BINARY_TYPE__KALLSYMS = 0,
> > @@ -35,6 +36,7 @@ enum dso_binary_type {
> > 	DSO_BINARY_TYPE__KCORE,
> > 	DSO_BINARY_TYPE__GUEST_KCORE,
> > 	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
> > +	DSO_BINARY_TYPE__BPF_PROG_INFO,
> > 	DSO_BINARY_TYPE__NOT_FOUND,
> > };
> > 
> > @@ -178,17 +180,25 @@ struct dso {
> > 	struct auxtrace_cache *auxtrace_cache;
> > 	int		 comp;
> > 
> > -	/* dso data file */
> > -	struct {
> > -		struct rb_root	 cache;
> > -		int		 fd;
> > -		int		 status;
> > -		u32		 status_seen;
> > -		size_t		 file_size;
> > -		struct list_head open_entry;
> > -		u64		 debug_frame_offset;
> > -		u64		 eh_frame_hdr_offset;
> > -	} data;
> > +	union {
> > +		/* dso data file */
> > +		struct {
> > +			struct rb_root	 cache;
> > +			int		 fd;
> > +			int		 status;
> > +			u32		 status_seen;
> > +			size_t		 file_size;
> > +			struct list_head open_entry;
> > +			u64		 debug_frame_offset;
> > +			u64		 eh_frame_hdr_offset;
> > +		} data;
> > +		/* bpf prog information */
> > +		struct {
> > +			u32		id;
> > +			u32		sub_id;
> > +			struct perf_env	*env;
> > +		} bpf_prog;
> > +	};
> > 
> > 	union { /* Tool specific area */
> > 		void	 *priv;
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 58442ca5e3c4..5cbad55cd99d 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -1455,6 +1455,7 @@ static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
> > 	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
> > 		return true;
> > 
> > +	case DSO_BINARY_TYPE__BPF_PROG_INFO:
> > 	case DSO_BINARY_TYPE__NOT_FOUND:
> > 	default:
> > 		return false;

-- 

- Arnaldo
