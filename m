Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E393C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D578A208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LYkVwRYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387431AbfIMIPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 04:15:05 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43743 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfIMIPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 04:15:04 -0400
Received: by mail-io1-f66.google.com with SMTP id r8so36228821iol.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 01:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qq1awCjpRMPOyf0C8LW7d8/EPKDjpRBoDaDLFoNd7hY=;
        b=LYkVwRYBlEvPXQ94YvGoj045oggYRmmxZeLUp1AKO9lQhbZLTVUnQmEkJ7yc5RPQrC
         5k2bWW8f8iPzjEnsZxhkUwOKlNB9v2jFtT+HRerN13Ismyadf+Lx8+zxK6EMomL4aX9n
         xaGADX6ipyvktDBVFveiE2IXHYQwXd9BWXhotxQB+aozgAFCe0cHUhWoTo+yCla/2uku
         yTujpTFE+w4oQFSACKUBnSg+tH1OSfbiKcxmmNSNTfSXmmcfZho1v644D1adL1LzB1mq
         bIB+CPX5VN97pG6XNZeizGn/9DdZglMEQFxPjjBvdM6v0VD+3WCeJ1GPjUsGeHi758qD
         qGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qq1awCjpRMPOyf0C8LW7d8/EPKDjpRBoDaDLFoNd7hY=;
        b=aL8fFKkvXmwVqjo/hM20cihOO7lA1hcunVZHkjvU7INa9HwBy1Ud/yJcLl4LOQLbBH
         FX/dIYY4k/4kQk1i5JAAQOOvwiFPk8i6Y+udFsGSR35cE3DX8ha/1qGXuFE7zBU0h6da
         t0zFaJN9+GTJlo+v12r5KcGIvN7WGIzyeAsrFJAka9k0Jl9MIRop09/xFKw0LR8ryB3Z
         q5eTjGNsJe01LzhCds5fBX7DA1Edc8fynwtVCL1V7ARQMZqxak8WGbF8n3IUyaI4EDUi
         p7MxHUhhx0mEXDembouml5k3AJGiccM8UkNtZOszJgiEhf08YJqtnesvph4UmAdWqAmt
         KwYg==
X-Gm-Message-State: APjAAAW2Hhd165drAyU13A7+pHelDIdOLRzYg9Vz4D1HjQ1lWejZcr/T
        3SxPjSXlKD441mM9reFHmcR+j3GAieHWqfRuWm7JsF17/QBJ5g==
X-Google-Smtp-Source: APXvYqw23utF2hL/E3pJoAfSh+SgqMUkYLhcnFoXBNSYqbSL2PkCJ8ANCSRtA4UsKV0L9FrjihVvSDNcVUQrj9FUGtI=
X-Received: by 2002:a6b:6013:: with SMTP id r19mr9576721iog.94.1568362501133;
 Fri, 13 Sep 2019 01:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190904062603.90165-1-eranian@google.com>
In-Reply-To: <20190904062603.90165-1-eranian@google.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 13 Sep 2019 01:14:50 -0700
Message-ID: <CABPqkBRBSxp92KVkrBbk_kFZEfSPg6WHkW4tn6fR9jVHWxo6jw@mail.gmail.com>
Subject: Re: [PATCH] perf record: fix priv level with branch sampling for paranoid=2
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 11:26 PM Stephane Eranian <eranian@google.com> wrote:
>
> Now that the default perf_events paranoid level is set to 2, a regular user
> cannot monitor kernel level activity anymore. As such, with the following
> cmdline:
>
> $ perf record -e cycles date
>
> The perf tool first tries cycles:uk but then falls back to cycles:u
> as can be seen in the perf report --header-only output:
>
>   cmdline : /export/hda3/tmp/perf.tip record -e cycles ls
>   event : name = cycles:u, , id = { 436186, ... }
>
> This is okay as long as there is way to learn the priv level was changed
> internally by the tool.
>
> But consider a similar example:
>
> $ perf record -b -e cycles date
> Error:
> You may not have permission to collect stats.
>
> Consider tweaking /proc/sys/kernel/perf_event_paranoid,
> which controls use of the performance events system by
> unprivileged users (without CAP_SYS_ADMIN).
> ...
>
> Why is that treated differently given that the branch sampling inherits the
> priv level of the first event in this case, i.e., cycles:u? It turns out
> that the branch sampling code is more picky and also checks exclude_hv.
>
> In the fallback path, perf record is setting exclude_kernel = 1, but it
> does not change exclude_hv. This does not seem to match the restriction
> imposed by paranoid = 2.
>
> This patch fixes the problem by forcing exclude_hv = 1 in the fallback
> for paranoid=2. With this in place:
>
> $ perf record -b -e cycles date
>   cmdline : /export/hda3/tmp/perf.tip record -b -e cycles ls
>   event : name = cycles:u, , id = { 436847, ... }
>
> And the command succeeds as expected.
>
Any comment on this patch?

> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  tools/perf/util/evsel.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 85825384f9e8..3cbe06fdf7f7 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2811,9 +2811,11 @@ bool perf_evsel__fallback(struct evsel *evsel, int err,
>                 if (evsel->name)
>                         free(evsel->name);
>                 evsel->name = new_name;
> -               scnprintf(msg, msgsize,
> -"kernel.perf_event_paranoid=%d, trying to fall back to excluding kernel samples", paranoid);
> +               scnprintf(msg, msgsize, "kernel.perf_event_paranoid=%d, trying "
> +                         "to fall back to excluding kernel and hypervisor "
> +                         " samples", paranoid);
>                 evsel->core.attr.exclude_kernel = 1;
> +               evsel->core.attr.exclude_hv     = 1;
>
>                 return true;
>         }
> --
> 2.23.0.187.g17f5b7556c-goog
>
