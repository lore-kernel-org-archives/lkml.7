Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EC0C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 21:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560312081B
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 21:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfI2VFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 17:05:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfI2VFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 17:05:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ABEF1859FF;
        Sun, 29 Sep 2019 21:05:19 +0000 (UTC)
Received: from krava (ovpn-204-49.brq.redhat.com [10.40.204.49])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5240360C4B;
        Sun, 29 Sep 2019 21:05:15 +0000 (UTC)
Date:   Sun, 29 Sep 2019 23:05:14 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf tools: avoid sample_reg_masks being const + weak
Message-ID: <20190929210514.GC602@krava>
References: <20190927211005.147176-1-irogers@google.com>
 <20190927214341.170683-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927214341.170683-1-irogers@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sun, 29 Sep 2019 21:05:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 02:43:41PM -0700, Ian Rogers wrote:
> Being const + weak breaks with some compilers that constant-propagate
> from the weak symbol. This behavior is outside of the specification, but
> in LLVM is chosen to match GCC's behavior.
> 
> LLVM's implementation was set in this patch:
> https://github.com/llvm/llvm-project/commit/f49573d1eedcf1e44893d5a062ac1b72c8419646
> A const + weak symbol is set to be weak_odr:
> https://llvm.org/docs/LangRef.html
> ODR is one definition rule, and given there is one constant definition
> constant-propagation is possible. It is possible to get this code to
> miscompile with LLVM when applying link time optimization. As compilers
> become more aggressive, this is likely to break in more instances.
> 
> Move the definition of sample_reg_masks to the conditional part of
> perf_regs.h and guard usage with HAVE_PERF_REGS_SUPPORT. This avoids the
> weak symbol.
> 
> Fix an issue when HAVE_PERF_REGS_SUPPORT isn't defined from patch v1.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/parse-regs-options.c | 8 ++++++--
>  tools/perf/util/perf_regs.c          | 4 ----
>  tools/perf/util/perf_regs.h          | 4 ++--
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
> index ef46c2848808..e687497b3aac 100644
> --- a/tools/perf/util/parse-regs-options.c
> +++ b/tools/perf/util/parse-regs-options.c
> @@ -13,7 +13,7 @@ static int
>  __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>  {
>  	uint64_t *mode = (uint64_t *)opt->value;
> -	const struct sample_reg *r;
> +	const struct sample_reg *r = NULL;
>  	char *s, *os = NULL, *p;
>  	int ret = -1;
>  	uint64_t mask;
> @@ -46,19 +46,23 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
>  
>  			if (!strcmp(s, "?")) {
>  				fprintf(stderr, "available registers: ");
> +#ifdef HAVE_PERF_REGS_SUPPORT
>  				for (r = sample_reg_masks; r->name; r++) {
>  					if (r->mask & mask)
>  						fprintf(stderr, "%s ", r->name);
>  				}
> +#endif
>  				fputc('\n', stderr);
>  				/* just printing available regs */
>  				return -1;
>  			}
> +#ifdef HAVE_PERF_REGS_SUPPORT
>  			for (r = sample_reg_masks; r->name; r++) {
>  				if ((r->mask & mask) && !strcasecmp(s, r->name))
>  					break;
>  			}
> -			if (!r->name) {
> +#endif
> +			if (!r || !r->name) {
>  				ui__warning("Unknown register \"%s\", check man page or run \"perf record %s?\"\n",
>  					    s, intr ? "-I" : "--user-regs=");
>  				goto error;
> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> index 2774cec1f15f..5ee47ae1509c 100644
> --- a/tools/perf/util/perf_regs.c
> +++ b/tools/perf/util/perf_regs.c
> @@ -3,10 +3,6 @@
>  #include "perf_regs.h"
>  #include "event.h"
>  
> -const struct sample_reg __weak sample_reg_masks[] = {
> -	SMPL_REG_END
> -};
> -
>  int __weak arch_sdt_arg_parse_op(char *old_op __maybe_unused,
>  				 char **new_op __maybe_unused)
>  {
> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> index 47fe34e5f7d5..e014c2c038f4 100644
> --- a/tools/perf/util/perf_regs.h
> +++ b/tools/perf/util/perf_regs.h
> @@ -15,8 +15,6 @@ struct sample_reg {
>  #define SMPL_REG2(n, b) { .name = #n, .mask = 3ULL << (b) }
>  #define SMPL_REG_END { .name = NULL }
>  
> -extern const struct sample_reg sample_reg_masks[];
> -
>  enum {
>  	SDT_ARG_VALID = 0,
>  	SDT_ARG_SKIP,
> @@ -27,6 +25,8 @@ uint64_t arch__intr_reg_mask(void);
>  uint64_t arch__user_reg_mask(void);
>  
>  #ifdef HAVE_PERF_REGS_SUPPORT
> +extern const struct sample_reg sample_reg_masks[];
> +
>  #include <perf_regs.h>
>  
>  #define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
> -- 
> 2.23.0.444.g18eeb5a265-goog
> 
