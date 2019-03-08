Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1BBC10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03B820684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga2Oxs4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfCHGa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 01:30:29 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34482 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfCHGa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 01:30:29 -0500
Received: by mail-io1-f68.google.com with SMTP id e1so15903818iok.1;
        Thu, 07 Mar 2019 22:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+I6X8lV42nEy0XlSbCb8AiyODVlQAAox042t7liW4s4=;
        b=ga2Oxs4yrQTvpsqktT8rOgc8T3sxv+Wcd8M2NwjFe0Y9WyZ4mlW+C70TMsh6UsxNL5
         +otaTzTkY6GPHtAl+lgtgx0Tc8sO+Zo2NMyLtU6G8j3Sh+DrUFNCeQLjs/FlsEg1ybnu
         gQC+mAO8pQHMqEze12EdSGC/FmGeb8EGEjWwiofCtJQWwdj6PBnPpj8wFhUjtRTB8QtY
         gUDONlFpN8DFlA6gFMXAS5/7hMBP7ynYIK+YD7h+5yDxY8I8TBNNY2m9PzLVu40GRmBc
         wwRhwhBgHFx4eznOaznjfaMoKHzNWnjJpZvTSZ6khf+OoYV/9tvR1fH2wBXat02gJovD
         3fiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+I6X8lV42nEy0XlSbCb8AiyODVlQAAox042t7liW4s4=;
        b=uPbOwHTUo+Ova/HVwEtH0rkcsmn64HipYwPooLJim2o5nmnjomd4ds4rY+sqh9bzuT
         Yh5mXCY8GQehf3FB78BSp71McT2RxZjAuXUQE43GLQnFrs1zU1zS3zIzW8Xm8AmIqi+G
         UiMmfmXuO6lj0JMxUTmlrkZJviZ1aw+uwzoaCpIODbfOS8aWW1f5YRt8jOKAbW0JmyyW
         aFwywztZAEKhLho8X6KrvAppHEmTmHfmIRpkdvnjgsbvS07dHyWls2U0+l8Q2G/p3Pf7
         idy4hsFW8npg0opbM47oSW+aaBa5oh5Fsvy7U1JG0uCICAriwnbT95SOsovtPVkyDLJF
         93Cg==
X-Gm-Message-State: APjAAAUZdaRjW4WqPHymNe/w+EwSH3BdGlt4hmGt1fzJz8L58NhvOQCt
        wDEsQJdQfydxF2POTKfDt2hBjceRTd8YOG0zN38=
X-Google-Smtp-Source: APXvYqy9XzyOz+gAEgcQng8TVsUOMz2yoKB+zw1icPQc9sHT1ZMXyGHZBqm+cObmOrRKqtWj7uffw8FZ+SUQ7UgI5vo=
X-Received: by 2002:a5e:9412:: with SMTP id q18mr8260509ioj.233.1552026627695;
 Thu, 07 Mar 2019 22:30:27 -0800 (PST)
MIME-Version: 1.0
References: <20190308060938.17305-1-tsu.yubo@gmail.com>
In-Reply-To: <20190308060938.17305-1-tsu.yubo@gmail.com>
From:   Y Song <ys114321@gmail.com>
Date:   Thu, 7 Mar 2019 22:29:51 -0800
Message-ID: <CAH3MdRWKvif5Q-bP7nU26g8WTzL5Ox2R43hZbRS+ZRRwzaYyOg@mail.gmail.com>
Subject: Re: [PATCH V2] bpf: fix warning about using plain integer as NULL
To:     Bo YU <tsu.yubo@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, ongliubraving@fb.com,
        Yonghong Song <yhs@fb.com>, David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, yuzibode@126.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 10:12 PM Bo YU <tsu.yubo@gmail.com> wrote:
>
> Sparse warning below:
>
> sudo make C=2 CF=-D__CHECK_ENDIAN__ M=net/bpf/
> CHECK   net/bpf//test_run.c
> net/bpf//test_run.c:19:77: warning: Using plain integer as NULL pointer
> ./include/linux/bpf-cgroup.h:295:77: warning: Using plain integer as NULL pointer
>
> Fixes: 8bad74f9840f ("bpf: extend cgroup bpf core to allow multiple
> cgroup storage types")
>
> Acked-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Bo YU <tsu.yubo@gmail.com>

There should be no empty line between tags ("Fixes" and "Acked-by").
"Fixes" tag should be all in one line. My previous reply may be
wrapped by the email client, which is not my intention.

> ---
> V2: Add fix-up tag from Yonghong
> ---
>  include/linux/bpf-cgroup.h | 2 +-
>  net/bpf/test_run.c         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 695b2a880d9a..a4c644c1c091 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -292,7 +292,7 @@ static inline int bpf_cgroup_storage_assign(struct bpf_prog *prog,
>  static inline void bpf_cgroup_storage_release(struct bpf_prog *prog,
>                                               struct bpf_map *map) {}
>  static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
> -       struct bpf_prog *prog, enum bpf_cgroup_storage_type stype) { return 0; }
> +       struct bpf_prog *prog, enum bpf_cgroup_storage_type stype) { return NULL; }
>  static inline void bpf_cgroup_storage_free(
>         struct bpf_cgroup_storage *storage) {}
>  static inline int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key,
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index da7051d62727..fab142b796ef 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -16,7 +16,7 @@
>  static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
>                         u32 *retval, u32 *time)
>  {
> -       struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = { 0 };
> +       struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = { NULL };
>         enum bpf_cgroup_storage_type stype;
>         u64 time_start, time_spent = 0;
>         int ret = 0;
> --
> 2.11.0
>
