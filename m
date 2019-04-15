Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B25AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4419D20825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiqN6WEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfDOGGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:06:21 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34355 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDOGGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 02:06:21 -0400
Received: by mail-qt1-f193.google.com with SMTP id k2so17866570qtm.1;
        Sun, 14 Apr 2019 23:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4/UChsdU2amoRbbLoVMCMK2p9TTZvTcx10ZikRtGm24=;
        b=EiqN6WEuQ7w2WOycYPKRU9KXiG1v+VQRQM/+/nFzZHTQ6KW6G/+a/OEALtxlPjHAmM
         y1pql/BD0O6Z2t//Y6i0o7fI3sx8z0Kmp0+0xl+c7bH4mjQXdgluRs0ByzMeaL3kUbn2
         /44K0XLZBskvKuRYgfyuvdSJShxWLiRAdk6OP89ZG6vo2oYo5ASqB5J4Lm4NHYqb1LAt
         nC89Dj7XLRxAi6QHgG6HXNbL2MmGq/aE8DR1kXMmr+xPwW/Ycc7MNUZVcRpdBKz6k63w
         Q160/6aQ1ktS/VFr5cBpHycEwsfH243k092RyqPkiXaXXZuuusz8KoMs6D5wqq3fZYJ8
         aUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4/UChsdU2amoRbbLoVMCMK2p9TTZvTcx10ZikRtGm24=;
        b=pZJD9oo6A2bo7sxB1EVFXDqhgLp9O27X5KTtAYRVgLjtmIyUEanOw1t03IUXBHB8NB
         U3HigEC5H3eAF4zVov3uxeSwiuw1n6uXu5VY/28ePAAGTYUV87vFszowmitDnDJJKmPF
         yyDBj60Q/GufZeHLNAI9jQfuc1sd/LD1Ted2PM/2lCF8y1dnRdPF7B+Qzt9LWCyTIstT
         5451P0O6Q8LPaHfZWFLAFaoHHx9WIiZLIbZCcBJhIUVCN+wCoyifehaZX7iMlODSqGDq
         C93RZSyjZOiv3xrRlapnQmCb+t/59dqhV35ue/roKDioEjaGjWlbNGQmWAm6p3chFGkg
         FnTA==
X-Gm-Message-State: APjAAAX4b0UjO4lIeog64G8a2/YvX8+t4gZVisa/87cmTFcd2xFdZw4P
        iqvr7L8qUJI44aPlEYtmuWkn5dBUzNAMVeITp2Y=
X-Google-Smtp-Source: APXvYqy5lPQlScbOE1dPv5eOdwKtocoKLud4KGI3RZ6PWfesfoMLtCvv9qMKqgniQy7T7xLapXj3bOaLAnVFQLnvYw0=
X-Received: by 2002:a0c:8b4a:: with SMTP id d10mr58195957qvc.29.1555308379845;
 Sun, 14 Apr 2019 23:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190414165846.22107-1-alban@kinvolk.io>
In-Reply-To: <20190414165846.22107-1-alban@kinvolk.io>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Sun, 14 Apr 2019 23:06:09 -0700
Message-ID: <CAPhsuW67c73LfJOj1uZs26awMeE8VpUMtjYGRgLSezVM0DZ=fg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: add map helper functions push,pop,peek
 in more BPF programs
To:     Alban Crequy <alban.crequy@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Alban Crequy (Kinvolk)" <alban@kinvolk.io>, iago@kinvolk.io,
        Mauricio Vasquez B <mauricio.vasquez@polito.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 10:00 AM Alban Crequy <alban.crequy@gmail.com> wrote:
>
> From: Alban Crequy <alban@kinvolk.io>
>
> commit f1a2e44a3aec ("bpf: add queue and stack maps") introduced new BPF
> helper functions:
> - BPF_FUNC_map_push_elem
> - BPF_FUNC_map_pop_elem
> - BPF_FUNC_map_peek_elem
>
> but they were made available only for network BPF programs. This patch
> makes them available for tracepoint, cgroup and lirc programs.
>
> Signed-off-by: Alban Crequy <alban@kinvolk.io>
> Cc: Mauricio Vasquez B <mauricio.vasquez@polito.it>

Acked-by: Song Liu <songliubraving@fb.com>


> ---
>  drivers/media/rc/bpf-lirc.c | 6 ++++++
>  kernel/bpf/cgroup.c         | 6 ++++++
>  kernel/trace/bpf_trace.c    | 6 ++++++
>  3 files changed, 18 insertions(+)
>
> diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
> index 390a722e6211..ee657003c1a1 100644
> --- a/drivers/media/rc/bpf-lirc.c
> +++ b/drivers/media/rc/bpf-lirc.c
> @@ -97,6 +97,12 @@ lirc_mode2_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>                 return &bpf_map_update_elem_proto;
>         case BPF_FUNC_map_delete_elem:
>                 return &bpf_map_delete_elem_proto;
> +       case BPF_FUNC_map_push_elem:
> +               return &bpf_map_push_elem_proto;
> +       case BPF_FUNC_map_pop_elem:
> +               return &bpf_map_pop_elem_proto;
> +       case BPF_FUNC_map_peek_elem:
> +               return &bpf_map_peek_elem_proto;
>         case BPF_FUNC_ktime_get_ns:
>                 return &bpf_ktime_get_ns_proto;
>         case BPF_FUNC_tail_call:
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index e58a6c247f56..fcde0f7b2585 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -713,6 +713,12 @@ cgroup_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>                 return &bpf_map_update_elem_proto;
>         case BPF_FUNC_map_delete_elem:
>                 return &bpf_map_delete_elem_proto;
> +       case BPF_FUNC_map_push_elem:
> +               return &bpf_map_push_elem_proto;
> +       case BPF_FUNC_map_pop_elem:
> +               return &bpf_map_pop_elem_proto;
> +       case BPF_FUNC_map_peek_elem:
> +               return &bpf_map_peek_elem_proto;
>         case BPF_FUNC_get_current_uid_gid:
>                 return &bpf_get_current_uid_gid_proto;
>         case BPF_FUNC_get_local_storage:
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index d64c00afceb5..91800be0c8eb 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -569,6 +569,12 @@ tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>                 return &bpf_map_update_elem_proto;
>         case BPF_FUNC_map_delete_elem:
>                 return &bpf_map_delete_elem_proto;
> +       case BPF_FUNC_map_push_elem:
> +               return &bpf_map_push_elem_proto;
> +       case BPF_FUNC_map_pop_elem:
> +               return &bpf_map_pop_elem_proto;
> +       case BPF_FUNC_map_peek_elem:
> +               return &bpf_map_peek_elem_proto;
>         case BPF_FUNC_probe_read:
>                 return &bpf_probe_read_proto;
>         case BPF_FUNC_ktime_get_ns:
> --
> 2.20.1
>
