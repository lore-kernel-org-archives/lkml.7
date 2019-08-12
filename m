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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B04C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E892A20665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh4lij5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfHLQCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:02:46 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38409 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfHLQCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:02:45 -0400
Received: by mail-qk1-f194.google.com with SMTP id u190so13668277qkh.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 09:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1rJ0SsKCAn4Ps4kvl42htxRnl/ptd0icgYCU1kjPkA8=;
        b=eh4lij5RQuha4+CgRVyoKGjqU7Vl9JdikQ8hoI1bTsZSDgh41YBd9LEtcO2luBc9m+
         vFKMLEn8LQ7cbvTk0YcQkXU0+jVwp2Q6Wk/t6LHv7C8wxZO/BHDa4TUb5qZutTp7/1w+
         j8xfkx3kVqGmMZ5fNXqeryFH7ArCQwt+tktFrqYc6SVmNAC7HQhjF8ptHv8CZnanBtiX
         WzUTzd+Gk+LxSiiZFfhQoeBTzcp3qG/K1C/iEpRtmzEsFC3vO4NTXq6GgXgQGe8VZxjV
         CvvRMWFRQD3l1RPsdrFINiY8J0fHFEbNou03AjCnfzDX5NQ7yHojXH8DS+FMrJl3yLJ5
         HVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1rJ0SsKCAn4Ps4kvl42htxRnl/ptd0icgYCU1kjPkA8=;
        b=HgI2kpFZVjVpoHC1NKSUAIFdWdgMuMGekXga1bZwRRmjjPzRH7joanSkoL3p4CIjVB
         NswUzyHcUe17umt/I93U1mbQdRJpB3NMemhLCQH7QMQi/footRW24JNCxlajXM7OLnJD
         JcnGOoJaFANr/tQR7XIlyq/eKNLvXAVzG215f2eJLwLruNif22ZJlDY4SmjSZ2ow/x1l
         1z5QeVJcdbMIwkIaZkQUEwxNHLbJ0VLcffU5Kc0IAEdTt5FdZApyHq0A5WQMlFF7U0wT
         SRI/aqBfpFq24ycgsKJ0xcRAfIYn4WKDFNm04hiXoAu/ajK+MY9gt51JmMO2ZIHwVmGV
         fpUQ==
X-Gm-Message-State: APjAAAW10LCnou2gny2W6RTOVYyCPR+DdU8EmsEXv9cdgQia0kLKRGOs
        YXPmKlfsIFJCAtETfCer5GHrnhZ5sF6Hv04dhUHyhBU6ydHgPg==
X-Google-Smtp-Source: APXvYqzkV3FFvD9Am1HIqK13jwA6kzpNy6INN75Qi9ylgzcbj6zcZ2JMkEbSchjr00UxEAJJoHYxWEjwblYI5lzyJxg=
X-Received: by 2002:a37:b646:: with SMTP id g67mr30240549qkf.92.1565625764674;
 Mon, 12 Aug 2019 09:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190809214642.12078-1-dxu@dxuuu.xyz> <20190809214642.12078-3-dxu@dxuuu.xyz>
In-Reply-To: <20190809214642.12078-3-dxu@dxuuu.xyz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 12 Aug 2019 09:02:33 -0700
Message-ID: <CAEf4BzYsfpkze7ohmusztW3Hc8FUsu5jHk2kpmffmMkejpxq6g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] libbpf: Add helpers to extract perf fd
 from bpf_link
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

On Fri, Aug 9, 2019 at 2:48 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> It is sometimes necessary to perform ioctl's on the underlying perf fd.
> There is not currently a way to extract the fd given a bpf_link, so add a
> a pair of casting and getting helpers.
>
> The casting and getting helpers are nice because they let us define
> broad categories of links that makes it clear to users what they can
> expect to extract from what type of link.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  tools/lib/bpf/libbpf.c   | 19 +++++++++++++++++++
>  tools/lib/bpf/libbpf.h   |  8 ++++++++
>  tools/lib/bpf/libbpf.map |  6 ++++++
>  3 files changed, 33 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ead915aec349..f4d750863abd 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4004,6 +4004,25 @@ static int bpf_link__destroy_perf_event(struct bpf_link *link)
>         return err;
>  }
>
> +const struct bpf_link_fd *bpf_link__as_fd(const struct bpf_link *link)
> +{
> +       if (!link)
> +               return NULL;

I'm not sure about all those NULL checks everywhere. It's not really a
Java, passing NULL is ok only to xxx__free() kind of functions,
everything else shouldn't expect to deal with NULLs correctly, IMO.

> +
> +       if (link->destroy != &bpf_link__destroy_perf_event)

While this is clever, it doesn't handle case for raw tracepoint
already. It is also anti-future proof, as when we add another use case
for bpf_link__fd with different destroy callback, we'll most probably
forget to update this function.

So let's instead introduce enum bpf_link_type and make it standard
part of "abstract" bpf_link. Please also add getter

enum bpf_link_type bpf_link__type(const struct bpf_link *link)
{
    return link->type;
}

to fetch it. That way users will also be able to write generic
functions potentially handling multiple kinds of bpf_links (and there
won't be a need to just "guess" the type of bpf_link).

> +               return NULL;
> +
> +       return (struct bpf_link_fd *)link;
> +}
> +
> +int bpf_link_fd__fd(const struct bpf_link_fd *link)
> +{
> +       if (!link)
> +               return -1;
> +
> +       return link->fd;
> +}
> +
>  struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog,
>                                                 int pfd)
>  {
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 8a9d462a6f6d..4498b6ae459a 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -166,6 +166,14 @@ LIBBPF_API int bpf_program__unpin(struct bpf_program *prog, const char *path);
>  LIBBPF_API void bpf_program__unload(struct bpf_program *prog);
>
>  struct bpf_link;
> +struct bpf_link_fd;
> +
> +/* casting APIs */
> +LIBBPF_API const struct bpf_link_fd *
> +bpf_link__as_fd(const struct bpf_link *link);
> +
> +/* getters APIs */
> +LIBBPF_API int bpf_link_fd__fd(const struct bpf_link_fd *link);

But otherwise these new APIs look great, thanks!

>
>  LIBBPF_API int bpf_link__destroy(struct bpf_link *link);
>
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index f9d316e873d8..b58dd0f0259c 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -184,3 +184,9 @@ LIBBPF_0.0.4 {
>                 perf_buffer__new_raw;
>                 perf_buffer__poll;
>  } LIBBPF_0.0.3;
> +
> +LIBBPF_0.0.5 {
> +       global:
> +               bpf_link__as_fd;
> +               bpf_link_fd__fd;
> +} LIBBPF_0.0.4;
> --
> 2.20.1
>
