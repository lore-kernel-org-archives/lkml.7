Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D33C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAFE21928
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpbaPRx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388000AbfIIDtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 23:49:55 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46869 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730739AbfIIDtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 23:49:55 -0400
Received: by mail-lf1-f68.google.com with SMTP id t8so9267107lfc.13;
        Sun, 08 Sep 2019 20:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kq/0HLiUK8W2h+dk2WJMskncJuE+4YLYDYO2ZzK45o0=;
        b=ZpbaPRx2lmat2fGxjZLS177OO+d0emKhB2IrUfsdUvpKm0l+d8XfgsYdtJHPfzyh28
         pTiCG91F7OLR4FYbABHI3d2ON6UYGx98DQ6T/Gny2XyWFLxSqniMJ6Qm2O/hOeu3U7jF
         Pz6nr7u/WqSUBJCk99i2LNIRlSmsZ6xfPg5HuLmHPmWDNvyDjIJGZYfyhqfQ/G4D1HG5
         gwBJs/wLJGqvpPFH+M8tu3Wi6IPEXdhdxUYliRWp4UR85gqYi9ZDckRuyhMX0mrEJjM3
         M57TMRqmriKes8DXJQUjoQjBGpLkKBqMODF3wKe2+yvcBXtW6DfRnAgvkMKb9JJngHk7
         0vSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kq/0HLiUK8W2h+dk2WJMskncJuE+4YLYDYO2ZzK45o0=;
        b=G6frux3xbvcs7nwLGVWh6MBXPANCQT9eOCO4YUg7O6vRKGkgc8+P2UTQYJtwSuELSy
         XhZPaNMrA3tsuqomFkGJmdms8KjP0N0R8DCGvy6f8hyEsqNoXuo1oQSvSEyp8e7FgHn7
         OcB8CjJb+OMrl039T9eNlSKoJ33cVxpoYrwJYHIb/0t+0Tw7Ue5i7D/d5pUyjqE05TQy
         Xgf4tmpIs46UXAusaPK9D8C3DsACGMlQdHpv2l6PmH7mh+vNMY9pnBcQme9whElaPhWh
         pbxr+qWXM9Nv+4yB9h1Fa86Y6M6lSWdqZH4wdVMWxC9DsefIWOel5/6z+mj4LKwFoywM
         cXZA==
X-Gm-Message-State: APjAAAW7TQyDKEiPf7kuLGEl5vm4mFi3IQzAPFJvWxh3CE/SbI2PsDZE
        x5VtLsDK3SlSJ1dCjqgbQ6FDlftExX2Kq083X6E=
X-Google-Smtp-Source: APXvYqxQj86TjeTxr0/xpyiy4ZWLOU2z5VlWw4H2N3G0Z/inYDZjPb1C9XiFndN7u/3/v+XBFdAmhW0qJ88qNqS+EVs=
X-Received: by 2002:a19:f604:: with SMTP id x4mr13837563lfe.17.1568000993249;
 Sun, 08 Sep 2019 20:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190903085535.23913-1-ufo19890607@gmail.com>
In-Reply-To: <20190903085535.23913-1-ufo19890607@gmail.com>
From:   =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date:   Mon, 9 Sep 2019 11:49:42 +0800
Message-ID: <CAHCio2iLvOSDEJ8JSnBx6w_65yekWNWu0B8wTAWbLDjy65J9JQ@mail.gmail.com>
Subject: Re: [PATCH] Add input file_name support for perf sched {map|latency|replay|timehist}
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        windyu@tencent.com, Adrian Hunter <adrian.hunter@intel.com>,
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


yuzhoujian <ufo19890607@gmail.com> =E4=BA=8E2019=E5=B9=B49=E6=9C=883=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=884:56=E5=86=99=E9=81=93=EF=BC=9A
>
> From: YuZhoujian <windyu@tencent.com>
>
> Just add '-i' option for perf sched {map|latency|replay|timehist}
>
> Signed-off-by: YuZhoujian <windyu@tencent.com>
> ---
>  tools/perf/Documentation/perf-sched.txt | 7 +++++++
>  tools/perf/builtin-sched.c              | 4 ++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documen=
tation/perf-sched.txt
> index 63f938b887dd..182c223d3d9b 100644
> --- a/tools/perf/Documentation/perf-sched.txt
> +++ b/tools/perf/Documentation/perf-sched.txt
> @@ -80,6 +80,9 @@ OPTIONS
>
>  OPTIONS for 'perf sched map'
>  ----------------------------
> +-i::
> +--input=3D<file>::
> +        Input file name. (default: perf.data unless stdin is a fifo)
>
>  --compact::
>         Show only CPUs with activity. Helps visualizing on high core
> @@ -96,6 +99,10 @@ OPTIONS for 'perf sched map'
>
>  OPTIONS for 'perf sched timehist'
>  ---------------------------------
> +-i::
> +--input=3D<file>::
> +        Input file name. (default: perf.data unless stdin is a fifo)
> +
>  -k::
>  --vmlinux=3D<file>::
>      vmlinux pathname
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 025151dcb651..8e51fbb88549 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3374,6 +3374,7 @@ int cmd_sched(int argc, const char **argv)
>         const struct option latency_options[] =3D {
>         OPT_STRING('s', "sort", &sched.sort_order, "key[,key2...]",
>                    "sort by key(s): runtime, switch, avg, max"),
> +       OPT_STRING('i', "input", &input_name, "file", "input file name"),
>         OPT_INTEGER('C', "CPU", &sched.profile_cpu,
>                     "CPU to profile on"),
>         OPT_BOOLEAN('p', "pids", &sched.skip_merge,
> @@ -3381,11 +3382,13 @@ int cmd_sched(int argc, const char **argv)
>         OPT_PARENT(sched_options)
>         };
>         const struct option replay_options[] =3D {
> +       OPT_STRING('i', "input", &input_name, "file", "input file name"),
>         OPT_UINTEGER('r', "repeat", &sched.replay_repeat,
>                      "repeat the workload replay N times (-1: infinite)")=
,
>         OPT_PARENT(sched_options)
>         };
>         const struct option map_options[] =3D {
> +       OPT_STRING('i', "input", &input_name, "file", "input file name"),
>         OPT_BOOLEAN(0, "compact", &sched.map.comp,
>                     "map output in compact mode"),
>         OPT_STRING(0, "color-pids", &sched.map.color_pids_str, "pids",
> @@ -3397,6 +3400,7 @@ int cmd_sched(int argc, const char **argv)
>         OPT_PARENT(sched_options)
>         };
>         const struct option timehist_options[] =3D {
> +       OPT_STRING('i', "input", &input_name, "file", "input file name"),
>         OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
>                    "file", "vmlinux pathname"),
>         OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
> --
> 2.23.0.37.g745f681
>
