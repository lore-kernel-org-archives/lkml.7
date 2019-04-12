Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CC5C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B3A218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2mjXBhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfDLSQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:16:32 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38765 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfDLSQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:16:31 -0400
Received: by mail-qk1-f193.google.com with SMTP id g1so6218268qki.5;
        Fri, 12 Apr 2019 11:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FmUdBgaJZh+Gngkzif7g8W2IFkXxCNDKMNrS5dHh2z0=;
        b=K2mjXBhWJOJb2vwiEKxfbQwRCEmAu/g5naIL2fHOEtaYMEcMaClcjKoG40AW5t/zCi
         0vekJYU0FRfKPUOYlXXuwb9vAKQmRWnM3CrpZi2VyPQ7Mz6OpEFBpnwlFXQbAiiAQcxJ
         zuCYmdheQlJFP1/xOtiMWeDTPBWYDnh8H8eUarU8MrxWXZ07HTRs4txyQtwsk9aO5UTE
         oiTmSCh/R9fSWVbZujtUhiHNUmRsa4+7uixOx9BIybB49QXi3y2hB2/xEFv0IGyjkim8
         pNdL6z7yj4INXM4VWsIn/5mvZmqksnJ44IjVw8MAIvpqZEPcYVd3r08GCCpmGlyRIZNn
         JxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FmUdBgaJZh+Gngkzif7g8W2IFkXxCNDKMNrS5dHh2z0=;
        b=fElPPvTmKtbXEqvr4Ghl1STTVnvOLJpNqC0IcdlnZJVd4ZjvkQM9rlspCDM4IvX9FH
         aLQ16LSC3DEdBjHNyQWVJ95Ho2IUgng63J7FgMhvam66i07fwPyTWSb28g/0eYcusiCM
         OfYS5YD9qZyrZKrJ8Ayh2z3Ok4h93tbGrdZgPYIG+GpTYGEeowilFNYxx7M0vcJ1Gpx3
         QLctuYqOKWI8wCy4ihl5BAupWW4KPzvTH/bT+PoYSZsKiS3/KMsdxcTaHjrA6HnOS9Fw
         GPoCpjJ+snhCN3eZc1Iebpzty3w6DtsnMLKdxtjfqk/y26HRD05rJ5cgty1QAIpSqvFD
         aJtA==
X-Gm-Message-State: APjAAAUCtZWEQnKoJF9l3ktIhpDncGe+ccfhkJhm/tFKY3YjvatGv90K
        O9pV4M09ZFXafZldUGKaXDO7XUXJwc4Nb7WlF6A8AtQr
X-Google-Smtp-Source: APXvYqzg3+WRNYkw1el8uQySnJ7ld890dG7Qt7n/84w9ekqluxDnBk9/OhpCRHrE81Fp215/Y9XBsYMCuiYVy14dGwo=
X-Received: by 2002:a05:620a:1597:: with SMTP id d23mr44170928qkk.226.1555092990542;
 Fri, 12 Apr 2019 11:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190412100018.20852-1-alban@kinvolk.io>
In-Reply-To: <20190412100018.20852-1-alban@kinvolk.io>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 12 Apr 2019 11:16:19 -0700
Message-ID: <CAPhsuW7FJ5DWMA9RzO2SH0whcYdTt5oiYHLAMZzSnXTkY0h+wQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: sock ops: add netns in bpf context
To:     Alban Crequy <alban.crequy@gmail.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, alban@kinvolk.io,
        iago@kinvolk.io
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 3:02 AM Alban Crequy <alban.crequy@gmail.com> wrote:
>
> From: Alban Crequy <alban@kinvolk.io>
>
> sockops programs can now access the network namespace inode via
> (struct bpf_sock_ops)->netns. This can be useful to apply different
> policies on different network namespaces.
>
> In the unlikely case where network namespaces are not compiled in
> (CONFIG_NET_NS=n), the verifier will not allow access to ->netns.
>
> Signed-off-by: Alban Crequy <alban@kinvolk.io>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  include/uapi/linux/bpf.h |  1 +
>  net/core/filter.c        | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 31a27dd337dc..5afaab25f205 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3069,6 +3069,7 @@ struct bpf_sock_ops {
>         __u32 sk_txhash;
>         __u64 bytes_received;
>         __u64 bytes_acked;
> +       __u64 netns;
>  };
>
>  /* Definitions for bpf_sock_ops_cb_flags */
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 22eb2edf5573..f5e75b6fecb2 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6758,6 +6758,14 @@ static bool sock_ops_is_valid_access(int off, int size,
>                 }
>         } else {
>                 switch (off) {
> +               case offsetof(struct bpf_sock_ops, netns):
> +#ifdef CONFIG_NET_NS
> +                       if (size != sizeof(__u64))
> +                               return false;
> +#else
> +                       return false;
> +#endif
> +                       break;
>                 case bpf_ctx_range_till(struct bpf_sock_ops, bytes_received,
>                                         bytes_acked):
>                         if (size != sizeof(__u64))
> @@ -7908,6 +7916,38 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
>                 SOCK_OPS_GET_OR_SET_FIELD(sk_txhash, sk_txhash,
>                                           struct sock, type);
>                 break;
> +
> +       case offsetof(struct bpf_sock_ops, netns):
> +#ifdef CONFIG_NET_NS
> +               /* Loading: sk_ops->sk->__sk_common.skc_net.net->ns.inum
> +                * Type: (struct bpf_sock_ops_kern *)
> +                *       ->(struct sock *)
> +                *       ->(struct sock_common)
> +                *       .possible_net_t
> +                *       .(struct net *)
> +                *       ->(struct ns_common)
> +                *       .(unsigned int)
> +                */
> +               BUILD_BUG_ON(offsetof(struct sock, __sk_common) != 0);
> +               BUILD_BUG_ON(offsetof(possible_net_t, net) != 0);
> +               *insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(
> +                                               struct bpf_sock_ops_kern, sk),
> +                                     si->dst_reg, si->src_reg,
> +                                     offsetof(struct bpf_sock_ops_kern, sk));
> +               *insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(
> +                                               possible_net_t, net),
> +                                     si->dst_reg, si->dst_reg,
> +                                     offsetof(struct sock_common, skc_net));
> +               *insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(
> +                                               struct ns_common, inum),
> +                                     si->dst_reg, si->dst_reg,
> +                                     offsetof(struct net, ns) +
> +                                     offsetof(struct ns_common, inum));
> +#else
> +               *insn++ = BPF_MOV64_IMM(si->dst_reg, 0);
> +#endif
> +               break;
> +
>         }
>         return insn - insn_buf;
>  }
> --
> 2.20.1
>
