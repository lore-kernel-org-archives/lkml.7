Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE272C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF09206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIrJa7O3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfHMVrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:47:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46350 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfHMVrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:47:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id j15so14401549qtl.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 14:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S9dA/GdI5tmEIRRtpA3TOEAi+50PTMGECKOeEqJEGQ8=;
        b=rIrJa7O3sl+7svW2q/Lf7oNp+GNn7v+Rw6uSyvyF2VPOmPF+nRVFgjyFOmqqTs79tZ
         ka5t2oVJjFP8cIURcRCZix756S7tobGUniGigrIrBEx9sB/GPq0oSqWRj9mNTC+n2fOW
         Ixv2Crv+e0upytWnk3dBIMvNJN2HCRJ452f+B/g1sHOP3RwNfD6rTPYLl4fGfpjTYKvg
         lij4mT0PxBXSV2CWXVjPQ5g8uZSO4vsVXHNGUaB7/BQYECLh0hmxTJgMfjHCvaaSB0sI
         7Fx9u8JIZSqILw91IWSw1kY2T3sp2+8a8wW1NwUXwy/vliEDC8CwzuKhzK34QX9zZcQe
         vfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S9dA/GdI5tmEIRRtpA3TOEAi+50PTMGECKOeEqJEGQ8=;
        b=ZFNcxH/Lbg8LwEdGxng0k/F5VzjiUm7wkY1aS8vpyNlYmQSOPEb7MbBTXT3tkQeVpL
         5E2Wf6eLb+H4j57Hefi+QkVcPKU/4HIFn/tge0F8lty4n0GEwrIJiOVOpduI3bnijVAR
         fKtdd7uHb5ZGbovOKp/zfD2JSSA9BixMOlWB1A0zYMtrSRs2UNLmyXQUAwkgW3K8VTGy
         BHM+f0lBhri6GkgZVl0kR3jylGq6H7mCFpGv8b0eCHklLXqEDRNiIC+GgWU/QT2oUVlL
         zo5CN4WmtcN9cuEp2ggBbOGBlDSV2KvwZYo0Edfm71dJxATfjnfC7idMb20XUyJkt/Yt
         MhtQ==
X-Gm-Message-State: APjAAAUdWUQgHdhWlwGIEVKmefYjtb+UgUcX5YdUr2ULQE++ex9CB9gt
        IeBOrZ2tSLekbSK0q2rIj3Tw9DYnsZJHUxJe/Ao=
X-Google-Smtp-Source: APXvYqwE2/51TGbuEMNT4kX/a2TSbMRCm2OBIRImHNGpPNfL58hFfg72fWmR7r6CxUPtRtrl0+vT2mOtNbI52+qN9Nc=
X-Received: by 2002:aed:38c2:: with SMTP id k60mr33330692qte.83.1565732855091;
 Tue, 13 Aug 2019 14:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190809214642.12078-1-dxu@dxuuu.xyz> <20190809214642.12078-2-dxu@dxuuu.xyz>
In-Reply-To: <20190809214642.12078-2-dxu@dxuuu.xyz>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 13 Aug 2019 14:47:24 -0700
Message-ID: <CAPhsuW43rN1sb5sSShd1PYAQDVz1uHCiXF2nXVkMe8xj42xgpA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] tracing/probe: Add PERF_EVENT_IOC_QUERY_PROBE
 ioctl
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, peterz@infraded.org,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 2:48 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> It's useful to know [uk]probe's nmissed and nhit stats. For example with
> tracing tools, it's important to know when events may have been lost.
> debugfs currently exposes a control file to get this information, but
> it is not compatible with probes registered with the perf API.
>
> While bpf programs may be able to manually count nhit, there is no way
> to gather nmissed. In other words, it is currently not possible to
> retrieve information about FD-based probes.
>
> This patch adds a new ioctl that lets users query nmissed (as well as
> nhit for completeness). We currently only add support for [uk]probes
> but leave the possibility open for other probes like tracepoint.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
[...]

> +int perf_uprobe_event_query(struct perf_event *event, void __user *info)
> +{
> +       struct perf_event_query_probe __user *uquery = info;
> +       struct perf_event_query_probe query = {};
> +       struct trace_event_call *call = event->tp_event;
> +       struct trace_uprobe *tu = (struct trace_uprobe *)call->data;
> +       u64 nmissed, nhit;
> +
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EPERM;
> +       if (copy_from_user(&query, uquery, sizeof(query)))
> +               return -EFAULT;
> +
> +       nhit = tu->nhit;
> +       nmissed = 0;

Blindly return 0 is a little weird. Maybe return 0xffffffffffffffff so
that the user
can tell this is not a valid 0. Or some other idea?

Thanks,
Song
