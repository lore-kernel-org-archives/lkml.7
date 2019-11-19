Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B34DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5113A2240C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="stlsn3Wv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKSTAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 14:00:14 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36060 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfKSTAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 14:00:13 -0500
Received: by mail-io1-f65.google.com with SMTP id s3so24492058ioe.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 11:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IH8fCwSBDHnTBJAn+DM+MrcmtjvxWR929IoiwqW2EuI=;
        b=stlsn3WvzXLeFCpbDKSg/nWj/alwcHclp6NtU6nMcfLi1Xz1IgFfM/ZY23NzZTNGhO
         7QoAJqOywe8kyDXP4RLfkXvl0sH8v0Koy5+ufBLdKxRfQaqnV4vKJ7vkBUg7eXXK6Q1m
         Nk/Ml9Hn65lc7UPpGgVphYsdVKjNaXbNGxgEomH5oCHlH2XAVVWKMbcUNVzzvo08lhv7
         Ue+HAmhQhpf0KnjkrQPmOCa5bI39YSv3E37VtYdoL9RfaH0rTAqINcTbw+OSgsVPs1in
         0jEdFnTRH4rNyY1eK8xJXiOrK422lyIJOhXsCIpQp9TRHtdodUzYKPifE95B79eCBVyA
         EoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IH8fCwSBDHnTBJAn+DM+MrcmtjvxWR929IoiwqW2EuI=;
        b=OOe3CT5VoM4aaDnryl8697FuZlmSn8gJoEPIIskt3CWBh2qRYd9EiTB7fUrRVPVEDh
         KfH3gI4QphOjAobrMiZl9HlwNE5enXZL24UGiywv6TErExrdkyeSNdbO4Q1Ek9GJ++NP
         jheX6fk2XhG+t6CBluGjFzRwecWCEQXinZ0Sn9WCqB9OY4ZmFDcrhlcgdwO17Q1viTeI
         qZoS63eqCKuH+9u7nYzG/Pfyw3pmQd9iA92pft8J+f221M1PF4cXI7JQTtI4EE4cTAC5
         skHMQvQmCIZ3p3qlx0+QGmifkfpGw9HDbsuVMuYZ6jarEOI4v/aVOERlZw6avSYpnj/z
         HEBw==
X-Gm-Message-State: APjAAAXUzRQqdMP/cK+fo0D3HmK1QraNWGEsgCtJY/utf4/3urx1Uel6
        m1QYNNjLDucp4tYolyvuOoM7SZV9E4fC1y/Ug4S2bQ==
X-Google-Smtp-Source: APXvYqzTL0f9N2ouTtvcOXCA7M6/SjoLQSHRwFn5FjaCMTdyZnVxq4os30nNG70TkAPWy0vzTs+dYjPI72MXK83kYe8=
X-Received: by 2002:a02:a995:: with SMTP id q21mr20845036jam.27.1574190011787;
 Tue, 19 Nov 2019 11:00:11 -0800 (PST)
MIME-Version: 1.0
References: <20191119143411.3482-1-kan.liang@linux.intel.com> <20191119143411.3482-4-kan.liang@linux.intel.com>
In-Reply-To: <20191119143411.3482-4-kan.liang@linux.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 19 Nov 2019 11:00:00 -0800
Message-ID: <CABPqkBSkTgvbz0S_iv-F5DkUKdqA49k_dLtoh0wbE49ePQ6V=A@mail.gmail.com>
Subject: Re: [PATCH V4 03/13] perf tools: Support new branch sample type for
 LBR TOS
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        Andi Kleen <ak@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 6:35 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Support new branch sample type for LBR TOS.
>
> Enable LBR_TOS by default in LBR call stack mode.
> If kernel doesn't support the sample type, switching it off.
>
> Add a new branch options "tos" for the new branch sample type.
> The branch sample type is 64 bits. Change int to u64 for mode in
> struct branch_mode and bit in struct bit_names.
>
> Set tos to -1ULL if the LBR TOS information is unavailable.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/include/uapi/linux/perf_event.h     | 16 ++++++++++++++--
>  tools/perf/util/event.h                   |  1 +
>  tools/perf/util/evsel.c                   | 20 +++++++++++++++++---
>  tools/perf/util/evsel.h                   |  6 ++++++
>  tools/perf/util/parse-branch-options.c    |  3 ++-
>  tools/perf/util/perf_event_attr_fprintf.c |  3 ++-
>  6 files changed, 42 insertions(+), 7 deletions(-)
>
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index bb7b271397a6..c2da61c9ace7 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -180,7 +180,10 @@ enum perf_branch_sample_type_shift {
>
>         PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT      = 16, /* save branch type */
>
> -       PERF_SAMPLE_BRANCH_MAX_SHIFT            /* non-ABI */
> +       PERF_SAMPLE_BRANCH_MAX_SHIFT            = 17, /* non-ABI */
> +
> +       /* PMU specific */

No! You must abstract this.

> +       PERF_SAMPLE_BRANCH_LBR_TOS_SHIFT        = 63, /* save LBR TOS */
>  };
>
I don't like this because this is too Intel specific.
What is the meaning of this field? You need a clear definition so it can be used
with other PERF_SAMPLE_BRANCH_* implementations.


>
>  enum perf_branch_sample_type {
> @@ -208,8 +211,13 @@ enum perf_branch_sample_type {
>                 1U << PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT,
>
>         PERF_SAMPLE_BRANCH_MAX          = 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
> +
> +       PERF_SAMPLE_BRANCH_LBR_TOS      = 1ULL << PERF_SAMPLE_BRANCH_LBR_TOS_SHIFT,
>  };
>
> +#define PERF_SAMPLE_BRANCH_MASK                ((PERF_SAMPLE_BRANCH_MAX - 1) |\
> +                                        PERF_SAMPLE_BRANCH_LBR_TOS)
> +
>  /*
>   * Common flow change classification
>   */
> @@ -849,7 +857,11 @@ enum perf_event_type {
>          *        char                  data[size];}&& PERF_SAMPLE_RAW
>          *
>          *      { u64                   nr;
> -        *        { u64 from, to, flags } lbr[nr];} && PERF_SAMPLE_BRANCH_STACK
> +        *        { u64 from, to, flags } lbr[nr];
> +        *
> +        *        # only available if PERF_SAMPLE_BRANCH_LBR_TOS is set
> +        *        u64                   tos;
> +        *      } && PERF_SAMPLE_BRANCH_STACK
>          *
>          *      { u64                   abi; # enum perf_sample_regs_abi
>          *        u64                   regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index a0a0c91cde4a..98794758546b 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -130,6 +130,7 @@ struct perf_sample {
>         u32 raw_size;
>         u64 data_src;
>         u64 phys_addr;
> +       u64 lbr_tos;
>         u32 flags;
>         u16 insn_len;
>         u8  cpumode;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 1bf60f325608..b19669eb4437 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -712,7 +712,8 @@ static void __perf_evsel__config_callchain(struct evsel *evsel,
>                                 attr->branch_sample_type = PERF_SAMPLE_BRANCH_USER |
>                                                         PERF_SAMPLE_BRANCH_CALL_STACK |
>                                                         PERF_SAMPLE_BRANCH_NO_CYCLES |
> -                                                       PERF_SAMPLE_BRANCH_NO_FLAGS;
> +                                                       PERF_SAMPLE_BRANCH_NO_FLAGS |
> +                                                       PERF_SAMPLE_BRANCH_LBR_TOS;
>                         }
>                 } else
>                          pr_warning("Cannot use LBR callstack with branch stack. "
> @@ -763,7 +764,8 @@ perf_evsel__reset_callgraph(struct evsel *evsel,
>         if (param->record_mode == CALLCHAIN_LBR) {
>                 perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
>                 attr->branch_sample_type &= ~(PERF_SAMPLE_BRANCH_USER |
> -                                             PERF_SAMPLE_BRANCH_CALL_STACK);
> +                                             PERF_SAMPLE_BRANCH_CALL_STACK |
> +                                             PERF_SAMPLE_BRANCH_LBR_TOS);
>         }
>         if (param->record_mode == CALLCHAIN_DWARF) {
>                 perf_evsel__reset_sample_bit(evsel, REGS_USER);
> @@ -1641,6 +1643,8 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
>                 evsel->core.attr.ksymbol = 0;
>         if (perf_missing_features.bpf)
>                 evsel->core.attr.bpf_event = 0;
> +       if (perf_missing_features.lbr_tos)
> +               evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_LBR_TOS;
>  retry_sample_id:
>         if (perf_missing_features.sample_id_all)
>                 evsel->core.attr.sample_id_all = 0;
> @@ -1752,7 +1756,12 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
>          * Must probe features in the order they were added to the
>          * perf_event_attr interface.
>          */
> -       if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
> +       if (!perf_missing_features.lbr_tos &&
> +           (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_LBR_TOS)) {
> +               perf_missing_features.lbr_tos = true;
> +               pr_debug2("switching off LBR TOS support\n");
> +               goto fallback_missing_features;
> +       } else if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
>                 perf_missing_features.aux_output = true;
>                 pr_debug2_peo("Kernel has no attr.aux_output support, bailing out\n");
>                 goto out_close;
> @@ -2129,6 +2138,11 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>                 sz = data->branch_stack->nr * sizeof(struct branch_entry);
>                 OVERFLOW_CHECK(array, sz, max_size);
>                 array = (void *)array + sz;
> +
> +               if (perf_evsel__has_lbr_tos(evsel))
> +                       data->lbr_tos = *array++;
> +               else
> +                       data->lbr_tos = -1ULL;
>         }
>
>         if (type & PERF_SAMPLE_REGS_USER) {
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index ddc5ee6f6592..43a9fd83f791 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -115,6 +115,7 @@ struct perf_missing_features {
>         bool ksymbol;
>         bool bpf;
>         bool aux_output;
> +       bool lbr_tos;
>  };
>
>  extern struct perf_missing_features perf_missing_features;
> @@ -377,6 +378,11 @@ for ((_evsel) = _leader;                                                   \
>       (_evsel) && (_evsel)->leader == (_leader);                                        \
>       (_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
>
> +static inline bool perf_evsel__has_lbr_tos(const struct evsel *evsel)
> +{
> +       return evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_LBR_TOS;
> +}
> +
>  static inline bool perf_evsel__has_branch_callstack(const struct evsel *evsel)
>  {
>         return evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK;
> diff --git a/tools/perf/util/parse-branch-options.c b/tools/perf/util/parse-branch-options.c
> index bb4aa88c50a8..ce8b9ffc0663 100644
> --- a/tools/perf/util/parse-branch-options.c
> +++ b/tools/perf/util/parse-branch-options.c
> @@ -13,7 +13,7 @@
>
>  struct branch_mode {
>         const char *name;
> -       int mode;
> +       u64 mode;
>  };
>
>  static const struct branch_mode branch_modes[] = {
> @@ -32,6 +32,7 @@ static const struct branch_mode branch_modes[] = {
>         BRANCH_OPT("call", PERF_SAMPLE_BRANCH_CALL),
>         BRANCH_OPT("save_type", PERF_SAMPLE_BRANCH_TYPE_SAVE),
>         BRANCH_OPT("stack", PERF_SAMPLE_BRANCH_CALL_STACK),
> +       BRANCH_OPT("tos", PERF_SAMPLE_BRANCH_LBR_TOS),
>         BRANCH_END
>  };
>
> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
> index d4ad3f04923a..3411b67ea92a 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -8,7 +8,7 @@
>  #include "util/evsel_fprintf.h"
>
>  struct bit_names {
> -       int bit;
> +       u64 bit;
>         const char *name;
>  };
>
> @@ -50,6 +50,7 @@ static void __p_branch_sample_type(char *buf, size_t size, u64 value)
>                 bit_name(ABORT_TX), bit_name(IN_TX), bit_name(NO_TX),
>                 bit_name(COND), bit_name(CALL_STACK), bit_name(IND_JUMP),
>                 bit_name(CALL), bit_name(NO_FLAGS), bit_name(NO_CYCLES),
> +               bit_name(LBR_TOS),
>                 { .name = NULL, }
>         };
>  #undef bit_name
> --
> 2.17.1
>
