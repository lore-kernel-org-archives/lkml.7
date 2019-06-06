Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9600AC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 06:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6951020673
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 06:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnKTI+h9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfFFGF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 02:05:59 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36857 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFGF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 02:05:58 -0400
Received: by mail-lf1-f66.google.com with SMTP id q26so638476lfc.3;
        Wed, 05 Jun 2019 23:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=85f35iBYdrRzdhtgaXQmKcZ+bfEqFgQ2odNEDImkUGc=;
        b=XnKTI+h9AkOsttr0eUcm4Rr1i/K8ovEEi8XNOT7tigv9RPWCTXpcL9LQiOh7yy07hS
         ldGc7SArE2V4pw0laEgS2NuFlZ29zHds4bc/4I1LDl2uTAomGdWOxk6K67DhKeLa+0TS
         xUuLz3mY2RF9jLyYUK2JdWYvR7d4uP//B/jRkIJ+EnIoXNUzgIXta6ONQut3GwX/QVFY
         a90aAniQuruO3Lo9qXlwcMSLRNj1i8NcqfgWFdXEzgCRHSORJljBkTq8S1qJiX1JpRmc
         uiJqbB9rWGrT1JXxQ8T5wVSXRMyUWdhg/6GLEMkoWJYeYlilBIKCKOYYTG004YLogRxB
         02UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=85f35iBYdrRzdhtgaXQmKcZ+bfEqFgQ2odNEDImkUGc=;
        b=e2ncLTHwXLc2p0godvJt1wXLQ8H85oCii0Z2d+2yhokqkc4j1Lz5Am3tAuY0pyVHFj
         NQEwLIzvKwG8d2eclGzFQ2Xa2CWIqVP2a/bhsolBrdlNdhk1rOPSoc5kg39ueu+lKD3n
         7YZseb3C5DMWdo8xixqOLwQvSt8An0UcWKPAMYcl4yTuafy1xJxqrZw7EojAkt//zY0W
         Y4iVfGjyXe0u3IbbyHu2ZKBKa4P5+j3m0BMiEmAwQ+pfS8fr565pR7lK8MH0vtrse2oY
         VroTy8sK2ztbZxT8gGldnF+mKQiD+xm8a8Qoi5cEv19bv88iU5s71GRlf5Q5vq/3R3Zg
         nlBw==
X-Gm-Message-State: APjAAAVG2sDJEuPn3eNA/q+tH51QLiFOrU/EhewdIk+TVpQSq3So2/Al
        pu+oSptKV4IaPLvO7bFLfNSCDWPNEd3N6hr5vHg=
X-Google-Smtp-Source: APXvYqxVuoLELu4NIyqv2RFkEk1WKA4yA6FFIiNlXHUffHUfwvCBEZco2qwzhA/Wd/d1rMbPo9neSIFag2TGIs0R69c=
X-Received: by 2002:ac2:528e:: with SMTP id q14mr4484430lfm.17.1559801156056;
 Wed, 05 Jun 2019 23:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <1559222962-22891-1-git-send-email-ufo19890607@gmail.com>
In-Reply-To: <1559222962-22891-1-git-send-email-ufo19890607@gmail.com>
From:   =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date:   Thu, 6 Jun 2019 14:05:44 +0800
Message-ID: <CAHCio2gFbPn_m4AkMzLXuathtk8sW-cqtXAB6nkTwpbFmMf-aw@mail.gmail.com>
Subject: Re: [PATCH] perf record: Add support to collect callchains from
 kernel or user space only.
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Wind Yu <yuzhoujian@didichuxing.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wang Nan <wangnan0@huawei.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING


ufo19890607 <ufo19890607@gmail.com> =E4=BA=8E2019=E5=B9=B45=E6=9C=8830=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=889:29=E5=86=99=E9=81=93=EF=BC=9A
>
> From: yuzhoujian <yuzhoujian@didichuxing.com>
>
> One can just record callchains in the kernel or user space with
> this new options. We can use it together with "--all-kernel" options.
> This two options is used just like print_stack(sys) or print_ustack(usr)
> for systemtap.
>
> Show below is the usage of this new option combined with "--all-kernel"
> options.
>         1. Configure all used events to run in kernel space and just
> collect kernel callchains.
>         $ perf record -a -g --all-kernel --kernel-callchains
>         2. Configure all used events to run in kernel space and just
> collect user callchains.
>         $ perf record -a -g --all-kernel --user-callchains
>
> Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
> ---
>  tools/perf/Documentation/perf-record.txt | 6 ++++++
>  tools/perf/builtin-record.c              | 4 ++++
>  tools/perf/perf.h                        | 2 ++
>  tools/perf/util/evsel.c                  | 4 ++++
>  4 files changed, 16 insertions(+)
>
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Docume=
ntation/perf-record.txt
> index de269430720a..b647eb3db0c6 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -490,6 +490,12 @@ Configure all used events to run in kernel space.
>  --all-user::
>  Configure all used events to run in user space.
>
> +--kernel-callchains::
> +Collect callchains from kernel space.
> +
> +--user-callchains::
> +Collect callchains from user space.
> +
>  --timestamp-filename
>  Append timestamp to output file name.
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index e2c3a585a61e..dca55997934e 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2191,6 +2191,10 @@ static struct option __record_options[] =3D {
>         OPT_BOOLEAN_FLAG(0, "all-user", &record.opts.all_user,
>                          "Configure all used events to run in user space.=
",
>                          PARSE_OPT_EXCLUSIVE),
> +       OPT_BOOLEAN(0, "kernel-callchains", &record.opts.kernel_callchain=
s,
> +                   "collect kernel callchains"),
> +       OPT_BOOLEAN(0, "user-callchains", &record.opts.user_callchains,
> +                   "collect user callchains"),
>         OPT_STRING(0, "clang-path", &llvm_param.clang_path, "clang path",
>                    "clang binary to use for compiling BPF scriptlets"),
>         OPT_STRING(0, "clang-opt", &llvm_param.clang_opt, "clang options"=
,
> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> index d59dee61b64d..711e009381ec 100644
> --- a/tools/perf/perf.h
> +++ b/tools/perf/perf.h
> @@ -61,6 +61,8 @@ struct record_opts {
>         bool         record_switch_events;
>         bool         all_kernel;
>         bool         all_user;
> +       bool         kernel_callchains;
> +       bool         user_callchains;
>         bool         tail_synthesize;
>         bool         overwrite;
>         bool         ignore_missing_thread;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a6f572a40deb..a606b2833e27 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -680,6 +680,10 @@ static void __perf_evsel__config_callchain(struct pe=
rf_evsel *evsel,
>
>         attr->sample_max_stack =3D param->max_stack;
>
> +       if (opts->kernel_callchains)
> +               attr->exclude_callchain_user =3D 1;
> +       if (opts->user_callchains)
> +               attr->exclude_callchain_kernel =3D 1;
>         if (param->record_mode =3D=3D CALLCHAIN_LBR) {
>                 if (!opts->branch_stack) {
>                         if (attr->exclude_user) {
> --
> 2.14.1
>
