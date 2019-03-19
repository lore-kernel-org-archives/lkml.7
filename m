Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED11DC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D471213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8OcKAb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfCSNhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:37:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36731 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbfCSNhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:37:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id y36so12296161qtb.3;
        Tue, 19 Mar 2019 06:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hvdSlzZdWjd+fwQ4vEWHBfCMZteduG2JezEl+nVKZG4=;
        b=j8OcKAb/epI2Hr6hZ2vzX3Rl+aW4mqeFDF7fYzXrunNxb+vRkaFtcErI6Z31UkrEdf
         mFaE0/Lg1jrun+5QIq1agCNF8iZ83EzzbNwyZf8Z/7dRuVroTPCshNPMECYNHEqgI8Sf
         ZWyljhOy+t9x432tD3UygIosAzQTx7eRoqOINgGspGOvqh35hNbB2FYmeozRMdi6e8vR
         FMijR9wVdb5maI8vxDj9vqMN45IRtybrAFhDkHq3/lvNh54/kvOLK5iMk4sVOTmFAyBP
         FS7g3ofhRVSjR3A1dnuZRj+D1Azfc9rNLkQLuLYqLJ7pufdSWLhmHJGA4nLlYIDZOoQ9
         316w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hvdSlzZdWjd+fwQ4vEWHBfCMZteduG2JezEl+nVKZG4=;
        b=hG+7lNP4lBnpN9Cit9z6AjXgbPnaGLalhkXXgdJJ0EsPcx9pResArdKV3oWOBWcHb+
         ZNEJpG9GlQQrVgITzFlFzymTIeab3J4KFxVVz8mK2rsBlIErjZDURmwNrjAtUIaX3Vtn
         +M41Gmrwrocv/91KUiGKRyI7V0ezzeBK45ndSzt53f7cXdxezeqStCjnhgoczNHu15o3
         bkQmPnwb3kqKOsaZvJYu32yVsoqctdflKR1xT0Ska4gwXqfg82hiVpEoZNGWI/dch+ZR
         cEp9SrkzFiFiDGNREYTKnA5GdAopXNMOlG95GL7gtlYaDnAovsJ8yY1Ngtzswx++dHHa
         mISQ==
X-Gm-Message-State: APjAAAXmh0C32HmcEw0zLSu5s6ixXDCL2qZlAJUSIaZRX/o/M96qZOm6
        ul18Ri2GiMc3+uPvrh5eWcs=
X-Google-Smtp-Source: APXvYqxsPQWXlGfltumKDmbTMfD9iw2NXYNqMNzlcSXUZ4DLalKLupGsNfGar+8Oz8flPgRdqHKNjw==
X-Received: by 2002:ac8:3328:: with SMTP id t37mr2074570qta.246.1553002656389;
        Tue, 19 Mar 2019 06:37:36 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id y18sm4602562qtc.52.2019.03.19.06.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 06:37:35 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 935434039C; Tue, 19 Mar 2019 10:37:32 -0300 (-03)
Date:   Tue, 19 Mar 2019 10:37:32 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH v9 perf,bpf 12/15] perf, bpf: enable annotation of bpf
 program
Message-ID: <20190319133732.GA3029@kernel.org>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-13-songliubraving@fb.com>
 <20190318163848.GE22548@kernel.org>
 <9BC22A6D-B0A7-47B6-9526-E32924EF409D@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9BC22A6D-B0A7-47B6-9526-E32924EF409D@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 19, 2019 at 06:05:30AM +0000, Song Liu escreveu:
> Sorry for the late response. 
> 
> > On Mar 18, 2019, at 9:38 AM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > 
> > Em Mon, Mar 11, 2019 at 10:30:48PM -0700, Song Liu escreveu:
> >> This patch enables the annotation of bpf program.
> >> 
> >> A new dso type DSO_BINARY_TYPE__BPF_PROG_INFO is introduced to for BPF
> >> programs. In symbol__disassemble(), DSO_BINARY_TYPE__BPF_PROG_INFO dso
> >> calls into a new function symbol__disassemble_bpf(), where annotation
> >> line information is filled based bpf_prog_info and btf saved in given
> >> perf_env.
> >> 
> >> symbol__disassemble_bpf() uses libbfd to disassemble bpf programs.
> >> 
> >> Signed-off-by: Song Liu <songliubraving@fb.com>
> >> ---
> >> tools/build/Makefile.feature |   6 +-
> >> tools/perf/Makefile.config   |   4 +
> > 
> > I see the changes to these two files, but I can't see the feature test
> > that it triggers, forgot to do a git-add? Or is it in an upcoming patch
> > in this series?
> 
> test-disassembler-four-args.c is an existing test used by bpftool.
> It was added in fb982666e380c1632a74495b68b3c33a66e76430 .  

Ok, I'll add that to the commit log message, but see below
 
> > 
> > After applying this test it "works":
> > 
> >  make: Entering directory '/home/acme/git/perf/tools/perf'
> >    BUILD:   Doing 'make -j8' parallel build
> > 
> >  Auto-detecting system features:
> >  ...                         dwarf: [ on  ]
> >  ...            dwarf_getlocations: [ on  ]
> >  <SNIP>
> >  ...                           bpf: [ on  ]
> >  ...                        libaio: [ on  ]
> >  ...        disassembler-four-args: [ on  ]
> > 
> > Because you added it to FEATURE_TESTS_BASIC, and this means that if
> > tools/build/feature/test-all.c builds, then what is in
> > FEATURE_TESTS_BASIC is set to 'on', but you didn't add anything to
> > tools/build/feature/test-all.c, so it works because all the other
> > features are present.
> > 
> > Take a look at:
> > 
> >  2a07d814747b ("tools build feature: Check if libaio is available")
> > 
> > To see what needs to be done.
> 
> I used different versions of gcc to verify that current version of the 
> patch works for both test-succeed and test-fail cases. I guess something 
> like the following is needed? But the test does work without it. 

The following is definetely needed, otherwise if all the other tests in
test-all.c works, this disassembler-four-args feature test will never be
performed.

- Arnaldo
 
> diff --git i/tools/build/feature/test-all.c w/tools/build/feature/test-all.c
> index e903b86b742f..7853e6d91090 100644
> --- i/tools/build/feature/test-all.c
> +++ w/tools/build/feature/test-all.c
> @@ -178,6 +178,10 @@
>  # include "test-reallocarray.c"
>  #undef main
> 
> +#define main main_test_disassembler_four_args
> +# include "test-disassembler-four-args.c"
> +#undef main
> +
>  int main(int argc, char *argv[])
>  {
>         main_test_libpython();
> @@ -219,6 +223,7 @@ int main(int argc, char *argv[])
>         main_test_setns();
>         main_test_libaio();
>         main_test_reallocarray();
> +       main_test_disassembler_four_args();
> 
>         return 0;
>  }
> 
> 
> > 
> > Either way, its interesting to break this patch in two, one adding the
> > feature test and another to use it, i.e. the second patch out of this
> > should have the commit log message in this patch.
> > 
> > I've applied the patches up to before this one and will continue
> > processing other patches while you address this.
> > 
> > Thanks,
> > 
> > - Arnaldo
> > 
> >> tools/perf/util/annotate.c   | 150 ++++++++++++++++++++++++++++++++++-
> >> tools/perf/util/dso.c        |   1 +
> >> tools/perf/util/dso.h        |  32 +++++---
> >> tools/perf/util/symbol.c     |   1 +
> >> 6 files changed, 180 insertions(+), 14 deletions(-)
> >> 
> >> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> >> index 61e46d54a67c..8d3864b061f3 100644
> >> --- a/tools/build/Makefile.feature
> >> +++ b/tools/build/Makefile.feature
> >> @@ -66,7 +66,8 @@ FEATURE_TESTS_BASIC :=                  \
> >>         sched_getcpu			\
> >>         sdt				\
> >>         setns				\
> >> -        libaio
> >> +        libaio				\
> >> +        disassembler-four-args
> >> 
> >> # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
> >> # of all feature tests
> >> @@ -118,7 +119,8 @@ FEATURE_DISPLAY ?=              \
> >>          lzma                   \
> >>          get_cpuid              \
> >>          bpf			\
> >> -         libaio
> >> +         libaio			\
> >> +         disassembler-four-args
> >> 
> >> # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
> >> # If in the future we need per-feature checks/flags for features not
> >> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> >> index df4ad45599ca..c51b59e43dcc 100644
> >> --- a/tools/perf/Makefile.config
> >> +++ b/tools/perf/Makefile.config
> >> @@ -808,6 +808,10 @@ ifdef HAVE_KVM_STAT_SUPPORT
> >>     CFLAGS += -DHAVE_KVM_STAT_SUPPORT
> >> endif
> >> 
> >> +ifeq ($(feature-disassembler-four-args), 1)
> >> +    CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
> >> +endif
> >> +
> >> ifeq (${IS_64_BIT}, 1)
> >>   ifndef NO_PERF_READ_VDSO32
> >>     $(call feature_check,compile-32)
> >> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> >> index 5f6dbbf5d749..e492b19a157c 100644
> >> --- a/tools/perf/util/annotate.c
> >> +++ b/tools/perf/util/annotate.c
> >> @@ -10,6 +10,10 @@
> >> #include <errno.h>
> >> #include <inttypes.h>
> >> #include <libgen.h>
> >> +#include <bpf/bpf.h>
> >> +#include <bpf/btf.h>
> >> +#include <bpf/libbpf.h>
> >> +#include <linux/btf.h>
> >> #include "util.h"
> >> #include "ui/ui.h"
> >> #include "sort.h"
> >> @@ -24,6 +28,7 @@
> >> #include "annotate.h"
> >> #include "evsel.h"
> >> #include "evlist.h"
> >> +#include "bpf-event.h"
> >> #include "block-range.h"
> >> #include "string2.h"
> >> #include "arch/common.h"
> >> @@ -31,6 +36,9 @@
> >> #include <pthread.h>
> >> #include <linux/bitops.h>
> >> #include <linux/kernel.h>
> >> +#include <bfd.h>
> >> +#include <dis-asm.h>
> >> +#include <bpf/libbpf.h>
> >> 
> >> /* FIXME: For the HE_COLORSET */
> >> #include "ui/browser.h"
> >> @@ -1674,6 +1682,144 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
> >> 	return 0;
> >> }
> >> 
> >> +static int symbol__disassemble_bpf(struct symbol *sym,
> >> +				   struct annotate_args *args)
> >> +{
> >> +	struct annotation *notes = symbol__annotation(sym);
> >> +	struct annotation_options *opts = args->options;
> >> +	struct bpf_prog_info_linear *info_linear;
> >> +	struct bpf_prog_linfo *prog_linfo = NULL;
> >> +	struct bpf_prog_info_node *info_node;
> >> +	int len = sym->end - sym->start;
> >> +	disassembler_ftype disassemble;
> >> +	struct map *map = args->ms.map;
> >> +	struct disassemble_info info;
> >> +	struct dso *dso = map->dso;
> >> +	int pc = 0, count, sub_id;
> >> +	struct btf *btf = NULL;
> >> +	char tpath[PATH_MAX];
> >> +	size_t buf_size;
> >> +	int nr_skip = 0;
> >> +	int ret = -1;
> >> +	char *buf;
> >> +	bfd *bfdf;
> >> +	FILE *s;
> >> +
> >> +	if (dso->binary_type != DSO_BINARY_TYPE__BPF_PROG_INFO)
> >> +		return -1;
> >> +
> >> +	pr_debug("%s: handling sym %s addr %lx len %lx\n", __func__,
> >> +		 sym->name, sym->start, sym->end - sym->start);
> >> +
> >> +	memset(tpath, 0, sizeof(tpath));
> >> +	perf_exe(tpath, sizeof(tpath));
> >> +
> >> +	bfdf = bfd_openr(tpath, NULL);
> >> +	assert(bfdf);
> >> +	assert(bfd_check_format(bfdf, bfd_object));
> >> +
> >> +	s = open_memstream(&buf, &buf_size);
> >> +	if (!s)
> >> +		goto out;
> >> +	init_disassemble_info(&info, s,
> >> +			      (fprintf_ftype) fprintf);
> >> +
> >> +	info.arch = bfd_get_arch(bfdf);
> >> +	info.mach = bfd_get_mach(bfdf);
> >> +
> >> +	info_node = perf_env__find_bpf_prog_info(dso->bpf_prog.env,
> >> +						 dso->bpf_prog.id);
> >> +	if (!info_node)
> >> +		goto out;
> >> +	info_linear = info_node->info_linear;
> >> +	sub_id = dso->bpf_prog.sub_id;
> >> +
> >> +	info.buffer = (void *)(info_linear->info.jited_prog_insns);
> >> +	info.buffer_length = info_linear->info.jited_prog_len;
> >> +
> >> +	if (info_linear->info.nr_line_info)
> >> +		prog_linfo = bpf_prog_linfo__new(&info_linear->info);
> >> +
> >> +	if (info_linear->info.btf_id) {
> >> +		struct btf_node *node;
> >> +
> >> +		node = perf_env__find_btf(dso->bpf_prog.env,
> >> +					  info_linear->info.btf_id);
> >> +		if (node)
> >> +			btf = btf__new((__u8 *)(node->data),
> >> +				       node->data_size);
> >> +	}
> >> +
> >> +	disassemble_init_for_target(&info);
> >> +
> >> +#ifdef DISASM_FOUR_ARGS_SIGNATURE
> >> +	disassemble = disassembler(info.arch,
> >> +				   bfd_big_endian(bfdf),
> >> +				   info.mach,
> >> +				   bfdf);
> >> +#else
> >> +	disassemble = disassembler(bfdf);
> >> +#endif
> >> +	assert(disassemble);
> >> +
> >> +	fflush(s);
> >> +	do {
> >> +		const struct bpf_line_info *linfo = NULL;
> >> +		struct disasm_line *dl;
> >> +		size_t prev_buf_size;
> >> +		const char *srcline;
> >> +		u64 addr;
> >> +
> >> +		addr = pc + ((u64 *)(info_linear->info.jited_ksyms))[sub_id];
> >> +		count = disassemble(pc, &info);
> >> +
> >> +		if (prog_linfo)
> >> +			linfo = bpf_prog_linfo__lfind_addr_func(prog_linfo,
> >> +								addr, sub_id,
> >> +								nr_skip);
> >> +
> >> +		if (linfo && btf) {
> >> +			srcline = btf__name_by_offset(btf, linfo->line_off);
> >> +			nr_skip++;
> >> +		} else
> >> +			srcline = NULL;
> >> +
> >> +		fprintf(s, "\n");
> >> +		prev_buf_size = buf_size;
> >> +		fflush(s);
> >> +
> >> +		if (!opts->hide_src_code && srcline) {
> >> +			args->offset = -1;
> >> +			args->line = strdup(srcline);
> >> +			args->line_nr = 0;
> >> +			args->ms.sym  = sym;
> >> +			dl = disasm_line__new(args);
> >> +			if (dl) {
> >> +				annotation_line__add(&dl->al,
> >> +						     &notes->src->source);
> >> +			}
> >> +		}
> >> +
> >> +		args->offset = pc;
> >> +		args->line = buf + prev_buf_size;
> >> +		args->line_nr = 0;
> >> +		args->ms.sym  = sym;
> >> +		dl = disasm_line__new(args);
> >> +		if (dl)
> >> +			annotation_line__add(&dl->al, &notes->src->source);
> >> +
> >> +		pc += count;
> >> +	} while (count > 0 && pc < len);
> >> +
> >> +	ret = 0;
> >> +out:
> >> +	free(prog_linfo);
> >> +	free(btf);
> >> +	fclose(s);
> >> +	bfd_close(bfdf);
> >> +	return ret;
> >> +}
> >> +
> >> static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
> >> {
> >> 	struct annotation_options *opts = args->options;
> >> @@ -1701,7 +1847,9 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
> >> 	pr_debug("annotating [%p] %30s : [%p] %30s\n",
> >> 		 dso, dso->long_name, sym, sym->name);
> >> 
> >> -	if (dso__is_kcore(dso)) {
> >> +	if (dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO) {
> >> +		return symbol__disassemble_bpf(sym, args);
> >> +	} else if (dso__is_kcore(dso)) {
> >> 		kce.kcore_filename = symfs_filename;
> >> 		kce.addr = map__rip_2objdump(map, sym->start);
> >> 		kce.offs = sym->start;
> >> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> >> index ba58ba603b69..58547c468c65 100644
> >> --- a/tools/perf/util/dso.c
> >> +++ b/tools/perf/util/dso.c
> >> @@ -184,6 +184,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
> >> 	case DSO_BINARY_TYPE__KALLSYMS:
> >> 	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
> >> 	case DSO_BINARY_TYPE__JAVA_JIT:
> >> +	case DSO_BINARY_TYPE__BPF_PROG_INFO:
> >> 	case DSO_BINARY_TYPE__NOT_FOUND:
> >> 		ret = -1;
> >> 		break;
> >> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> >> index bb417c54c25a..c274b5aa839d 100644
> >> --- a/tools/perf/util/dso.h
> >> +++ b/tools/perf/util/dso.h
> >> @@ -14,6 +14,7 @@
> >> 
> >> struct machine;
> >> struct map;
> >> +struct perf_env;
> >> 
> >> enum dso_binary_type {
> >> 	DSO_BINARY_TYPE__KALLSYMS = 0,
> >> @@ -35,6 +36,7 @@ enum dso_binary_type {
> >> 	DSO_BINARY_TYPE__KCORE,
> >> 	DSO_BINARY_TYPE__GUEST_KCORE,
> >> 	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
> >> +	DSO_BINARY_TYPE__BPF_PROG_INFO,
> >> 	DSO_BINARY_TYPE__NOT_FOUND,
> >> };
> >> 
> >> @@ -178,17 +180,25 @@ struct dso {
> >> 	struct auxtrace_cache *auxtrace_cache;
> >> 	int		 comp;
> >> 
> >> -	/* dso data file */
> >> -	struct {
> >> -		struct rb_root	 cache;
> >> -		int		 fd;
> >> -		int		 status;
> >> -		u32		 status_seen;
> >> -		size_t		 file_size;
> >> -		struct list_head open_entry;
> >> -		u64		 debug_frame_offset;
> >> -		u64		 eh_frame_hdr_offset;
> >> -	} data;
> >> +	union {
> >> +		/* dso data file */
> >> +		struct {
> >> +			struct rb_root	 cache;
> >> +			int		 fd;
> >> +			int		 status;
> >> +			u32		 status_seen;
> >> +			size_t		 file_size;
> >> +			struct list_head open_entry;
> >> +			u64		 debug_frame_offset;
> >> +			u64		 eh_frame_hdr_offset;
> >> +		} data;
> >> +		/* bpf prog information */
> >> +		struct {
> >> +			u32		id;
> >> +			u32		sub_id;
> >> +			struct perf_env	*env;
> >> +		} bpf_prog;
> >> +	};
> >> 
> >> 	union { /* Tool specific area */
> >> 		void	 *priv;
> >> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> >> index 758bf5f74e6e..4e2e304d4037 100644
> >> --- a/tools/perf/util/symbol.c
> >> +++ b/tools/perf/util/symbol.c
> >> @@ -1451,6 +1451,7 @@ static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
> >> 	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
> >> 		return true;
> >> 
> >> +	case DSO_BINARY_TYPE__BPF_PROG_INFO:
> >> 	case DSO_BINARY_TYPE__NOT_FOUND:
> >> 	default:
> >> 		return false;
> >> -- 
> >> 2.17.1
> > 
> > -- 
> > 
> > - Arnaldo

-- 

- Arnaldo
