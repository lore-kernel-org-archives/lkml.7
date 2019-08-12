Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86961C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8F1206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCSyHIgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfHLRqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 13:46:22 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45323 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHLRqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:46:22 -0400
Received: by mail-qt1-f196.google.com with SMTP id k13so6381605qtm.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LVxEDKrf04Xopgme4UW2pTYkpgrPm8vtbBKdwKPRb9c=;
        b=KCSyHIgGOsuO8VlJboapGrv3uhEopskXPDsFu7H1p9LYYyS2CGX6Vrw/1AhAqUASy7
         S3MODho1pvt3/WGIDnCuXZR+zweI0QhhmUL3NhHq/nPbNc9BJ4M4XBZShrlMpGWBor0G
         veS6Z92NKz/8JQUXJryAP553TL7cfe+X6Fc3fjbgP3YmZsfw/pdY2jvA5ogkpvPaWpCg
         ulxbnezJQUw8xPfIPYQ5T+aOp88nk4ELGkDN9FUiHX2pPeiPaf7m0jwbCDqQ8kEcaqXj
         9I4nSuC0vDo6Zlo0e93FMP4xeuhnZIxWGkWL4YdgmLpNfD8oUuz8Hq3LrQkjaGUvBGL5
         CxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LVxEDKrf04Xopgme4UW2pTYkpgrPm8vtbBKdwKPRb9c=;
        b=gG+PdMF77qXx2pDl45yWodrOBFlU/cKO4AsTLPGXzGP1us/6t3cmlOayjJjjgZ57YW
         UtTofzJePRw6vMZceIGCxY6Q+v/oj05/M4L7ADR0cAF9XYxd5MBsD8oDgNNlTZ9H/3iY
         EMzrF2dfBsVOdARsoZpqff0XvSOlI80dVulCsjQiiC5QF0kTGEB0ksP6XCqKzWq91OER
         8/4dAg/gtdVFjDGOjWw7SL2xKzGe5QlM/HS60bbjbmyB5sct5LGmYJFr5IIHRWuZX6vk
         4C/VwGOv4R+44FcHKm7cBx7Thle7Ehq9RzxUPvLa6n/KlA+7Y612T2npspqWsHOyDaji
         nYLA==
X-Gm-Message-State: APjAAAX7U5thTwNhuFV6Ih1LqAGIq16L8XKljAyFJzRG/rvQdm6l8n9B
        g53pEX3xA32PFGkeTPMOgVjTwKJIsFUACl/gJwU=
X-Google-Smtp-Source: APXvYqy+Jmbzf7jTZ24TOrSSq9r08v/LQV+Makklb/THjSKpsq6jEo20OqmNUNgrzG2PWnH9KYA42WeZlWvVFrzuXsY=
X-Received: by 2002:ac8:1e9b:: with SMTP id c27mr24683751qtm.171.1565631980750;
 Mon, 12 Aug 2019 10:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190809214642.12078-1-dxu@dxuuu.xyz> <20190809214642.12078-5-dxu@dxuuu.xyz>
In-Reply-To: <20190809214642.12078-5-dxu@dxuuu.xyz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 12 Aug 2019 10:46:09 -0700
Message-ID: <CAEf4Bza3tz+3N6UyL2e9xM9yyf6=C+s0qa46bYyptuAioFtWuQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/4] tracing/probe: Add self test for PERF_EVENT_IOC_QUERY_PROBE
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, peterz@infraded.org,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        alexander.shishkin@linux.intel.com, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 2:49 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---

Getting verbose, we might want to rethink this test checks at some
point, but I think it's fine for now.

Please fix typos below, but overall:

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  .../selftests/bpf/prog_tests/attach_probe.c   | 102 ++++++++++++++++++
>  1 file changed, 102 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> index 5ecc267d98b0..bb53103ddb66 100644
> --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> @@ -27,17 +27,27 @@ void test_attach_probe(void)
>         const char *kretprobe_name = "kretprobe/sys_nanosleep";
>         const char *uprobe_name = "uprobe/trigger_func";
>         const char *uretprobe_name = "uretprobe/trigger_func";
> +       struct perf_event_query_probe kprobe_query = {};
> +       struct perf_event_query_probe kretprobe_query = {};
> +       struct perf_event_query_probe uprobe_query = {};
> +       struct perf_event_query_probe uretprobe_query = {};
>         const int kprobe_idx = 0, kretprobe_idx = 1;
>         const int uprobe_idx = 2, uretprobe_idx = 3;
>         const char *file = "./test_attach_probe.o";
>         struct bpf_program *kprobe_prog, *kretprobe_prog;
>         struct bpf_program *uprobe_prog, *uretprobe_prog;
>         struct bpf_object *obj;
> +       const struct bpf_link_fd *kprobe_fd_link;
> +       const struct bpf_link_fd *kretprobe_fd_link;
> +       const struct bpf_link_fd *uprobe_fd_link;
> +       const struct bpf_link_fd *uretprobe_fd_link;
>         int err, prog_fd, duration = 0, res;
>         struct bpf_link *kprobe_link = NULL;
>         struct bpf_link *kretprobe_link = NULL;
>         struct bpf_link *uprobe_link = NULL;
>         struct bpf_link *uretprobe_link = NULL;
> +       int kprobe_fd, kretprobe_fd;
> +       int uprobe_fd, uretprobe_fd;
>         int results_map_fd;
>         size_t uprobe_offset;
>         ssize_t base_addr;
> @@ -116,6 +126,52 @@ void test_attach_probe(void)
>         /* trigger & validate kprobe && kretprobe */
>         usleep(1);
>
> +       kprobe_fd_link = bpf_link__as_fd(kprobe_link);
> +       if (CHECK(!kprobe_fd_link, "kprobe_link_as_fd",
> +                 "failed to cast link to fd link\n"))
> +               goto cleanup;
> +
> +       kprobe_fd = bpf_link_fd__fd(kprobe_fd_link);
> +       if (CHECK(kprobe_fd < 0, "kprobe_get_perf_fd",
> +           "failed to get perf fd from kprobe link\n"))
> +               goto cleanup;
> +
> +       kretprobe_fd_link = bpf_link__as_fd(kretprobe_link);
> +       if (CHECK(!kretprobe_fd_link, "kretprobe_link_as_fd",
> +                 "failed to cast link to fd link\n"))
> +               goto cleanup;
> +
> +       kretprobe_fd = bpf_link_fd__fd(kretprobe_fd_link);
> +       if (CHECK(kretprobe_fd < 0, "kretprobe_get_perf_fd",
> +           "failed to get perf fd from kretprobe link\n"))
> +               goto cleanup;
> +
> +       err = ioctl(kprobe_fd, PERF_EVENT_IOC_QUERY_PROBE, &kprobe_query);
> +       if (CHECK(err, "get_kprobe_ioctl",
> +                 "failed to issue kprobe query ioctl\n"))
> +               goto cleanup;
> +       if (CHECK(kprobe_query.nmissed > 0, "get_kprobe_ioctl",
> +                 "read incorect nmissed from kprobe_ioctl: %llu\n",

typo: incorrect

> +                 kprobe_query.nmissed))
> +               goto cleanup;
> +       if (CHECK(kprobe_query.nhit == 0, "get_kprobe_ioctl",
> +                 "read incorect nhit from kprobe_ioctl: %llu\n",

typo: incorrect

> +                 kprobe_query.nhit))
> +               goto cleanup;
> +
> +       err = ioctl(kretprobe_fd, PERF_EVENT_IOC_QUERY_PROBE, &kretprobe_query);
> +       if (CHECK(err, "get_kretprobe_ioctl",
> +                 "failed to issue kretprobe query ioctl\n"))
> +               goto cleanup;
> +       if (CHECK(kretprobe_query.nmissed > 0, "get_kretprobe_ioctl",
> +                 "read incorect nmissed from kretprobe_ioctl: %llu\n",

same typo :)

> +                 kretprobe_query.nmissed))
> +               goto cleanup;
> +       if (CHECK(kretprobe_query.nhit <= 0, "get_kretprobe_ioctl",
> +                 "read incorect nhit from kretprobe_ioctl: %llu\n",

the power of copy/paste! :)

> +                 kretprobe_query.nhit))
> +               goto cleanup;
> +
>         err = bpf_map_lookup_elem(results_map_fd, &kprobe_idx, &res);
>         if (CHECK(err, "get_kprobe_res",
>                   "failed to get kprobe res: %d\n", err))
> @@ -135,6 +191,52 @@ void test_attach_probe(void)
>         /* trigger & validate uprobe & uretprobe */
>         get_base_addr();
>
> +       uprobe_fd_link = bpf_link__as_fd(uprobe_link);
> +       if (CHECK(!uprobe_fd_link, "uprobe_link_as_fd",
> +                 "failed to cast link to fd link\n"))
> +               goto cleanup;
> +
> +       uprobe_fd = bpf_link_fd__fd(uprobe_fd_link);
> +       if (CHECK(uprobe_fd < 0, "uprobe_get_perf_fd",
> +           "failed to get perf fd from uprobe link\n"))
> +               goto cleanup;
> +
> +       uretprobe_fd_link = bpf_link__as_fd(uretprobe_link);
> +       if (CHECK(!uretprobe_fd_link, "uretprobe_link_as_fd",
> +                 "failed to cast link to fd link\n"))
> +               goto cleanup;
> +
> +       uretprobe_fd = bpf_link_fd__fd(uretprobe_fd_link);
> +       if (CHECK(uretprobe_fd < 0, "uretprobe_get_perf_fd",
> +           "failed to get perf fd from uretprobe link\n"))
> +               goto cleanup;
> +
> +       err = ioctl(uprobe_fd, PERF_EVENT_IOC_QUERY_PROBE, &uprobe_query);
> +       if (CHECK(err, "get_uprobe_ioctl",
> +                 "failed to issue uprobe query ioctl\n"))
> +               goto cleanup;
> +       if (CHECK(uprobe_query.nmissed > 0, "get_uprobe_ioctl",
> +                 "read incorect nmissed from uprobe_ioctl: %llu\n",
> +                 uprobe_query.nmissed))
> +               goto cleanup;
> +       if (CHECK(uprobe_query.nhit == 0, "get_uprobe_ioctl",
> +                 "read incorect nhit from uprobe_ioctl: %llu\n",
> +                 uprobe_query.nhit))
> +               goto cleanup;
> +
> +       err = ioctl(uretprobe_fd, PERF_EVENT_IOC_QUERY_PROBE, &uretprobe_query);
> +       if (CHECK(err, "get_uretprobe_ioctl",
> +                 "failed to issue uretprobe query ioctl\n"))
> +               goto cleanup;
> +       if (CHECK(uretprobe_query.nmissed > 0, "get_uretprobe_ioctl",
> +                 "read incorect nmissed from uretprobe_ioctl: %llu\n",
> +                 uretprobe_query.nmissed))
> +               goto cleanup;
> +       if (CHECK(uretprobe_query.nhit <= 0, "get_uretprobe_ioctl",
> +                 "read incorect nhit from uretprobe_ioctl: %llu\n",
> +                 uretprobe_query.nhit))
> +               goto cleanup;
> +

same typos

>         err = bpf_map_lookup_elem(results_map_fd, &uprobe_idx, &res);
>         if (CHECK(err, "get_uprobe_res",
>                   "failed to get uprobe res: %d\n", err))
> --
> 2.20.1
>
