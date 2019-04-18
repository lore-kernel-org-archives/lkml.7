Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540B3C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A902217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHlzK5lw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfDRVly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 17:41:54 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33565 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfDRVly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 17:41:54 -0400
Received: by mail-qk1-f195.google.com with SMTP id k189so2040696qkc.0;
        Thu, 18 Apr 2019 14:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MdDRHQShD7ihvuBtYtC/04Pbgnh7z8l0D7NLMNuzIYU=;
        b=CHlzK5lwUOzlCtkJTFOO/gjek7pbZmruZIxa7Xm+dkd1YDGKGxjJpbH7GS9JUtakFa
         pfvid743Q5/SV0i1sFoe55S1v+7ltcsvEjPWYjjEGRWozbbkNgghQBg5x9/Ltt09pn6J
         Xi7bthd13MDyelQL8wDRM7Qx1r0Tz4H3CwLXp+TbIiKs1H9Fhksej7DIWYXm5pFzyzvA
         M4WEpyVDtVuIUPwkC2L0hqMG+yrS5RSTHp7jXFZhPpIhLMsYrPELMvHMiPm7t0XzK6m1
         wO/of+Jt92JuEfZtDr+9MBWkMXOOrogloYp/h0oc6mk7g1WTDxfMs1mR/rERassjVseQ
         2/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MdDRHQShD7ihvuBtYtC/04Pbgnh7z8l0D7NLMNuzIYU=;
        b=GjBLyaw7XWizilqWsV9EYscxi+WCtWdgnzsFzHDajT7BWP2eai3Y1Y9nrW9Dv7Otbt
         Q4GDB04mvDFr8QJbFV9ThKWBky5w3IZN6ZaYMLsiIxf/TtXyY2iM9KFmcTOyBbJ3blg/
         b/yFEGjSGYVC3fdCRIdIxmG0dFqrikv1LM3+V3dGMKVwFglaZl64OXriapFqjT3NAvcP
         rQ9TI0L4O1NTbXY5208uc/dfkZhFwA7admZUoWNIxceC2fX3DQKu3G3BrfftUbQXWnHw
         iB2Es1Zc2AWVLPZz/utHNPkUYXoRWBoo6jay36dicuG8NtQocT+sMSM0sGmtN/htZm5K
         vLMg==
X-Gm-Message-State: APjAAAUUeWvAlPtK1z2ww9f6mvQEm8Pf0d8f01mJLQZ6gIksh2nLlSG9
        CbzF2lFGGbWi5rzP7B7j3gjVuCqez/iUGqpVm0E=
X-Google-Smtp-Source: APXvYqx3GfVB03OIuWzyMHn/tL3di3yoeXmLRo7ppcOKS6Z6/wNHuc4lKaDtSdc3ys+rsRKbrnpMLL+v+m3eeUEGJcw=
X-Received: by 2002:a05:620a:15f5:: with SMTP id p21mr292290qkm.5.1555623712968;
 Thu, 18 Apr 2019 14:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190418155652.22181-1-alban@kinvolk.io>
In-Reply-To: <20190418155652.22181-1-alban@kinvolk.io>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 18 Apr 2019 14:41:41 -0700
Message-ID: <CAPhsuW7mhxaEyez4XX+ncUnfg-2wkF4Li+migjYdqON3-2f5_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: sock ops: add netns ino and dev in
 bpf context
To:     Alban Crequy <alban.crequy@gmail.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Alban Crequy (Kinvolk)" <alban@kinvolk.io>,
        =?UTF-8?Q?Iago_L=C3=B3pez_Galeiras?= <iago@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 8:59 AM Alban Crequy <alban.crequy@gmail.com> wrote:
>
> From: Alban Crequy <alban@kinvolk.io>
>
> sockops programs can now access the network namespace inode and device
> via (struct bpf_sock_ops)->netns_ino and ->netns_dev. This can be useful
> to apply different policies on different network namespaces.
>
> In the unlikely case where network namespaces are not compiled in
> (CONFIG_NET_NS=n), the verifier will not allow access to ->netns_*.
>
> The generated BPF bytecode for netns_ino is loading the correct inode
> number at the time of execution.
>
> However, the generated BPF bytecode for netns_dev is loading an
> immediate value determined at BPF-load-time by looking at the initial
> network namespace. In practice, this works because all netns currently
> use the same virtual device. If this was to change, this code would need
> to be updated too.
>
> Signed-off-by: Alban Crequy <alban@kinvolk.io>

Acked-by: Song Liu <songliubraving@fb.com>

>
> ---
>
> Changes since v1:
> - add netns_dev (review from Alexei)
> ---
>  include/uapi/linux/bpf.h |  2 ++
>  net/core/filter.c        | 70 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index eaf2d3284248..f4f841dde42c 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3213,6 +3213,8 @@ struct bpf_sock_ops {
>         __u32 sk_txhash;
>         __u64 bytes_received;
>         __u64 bytes_acked;
> +       __u64 netns_dev;
> +       __u64 netns_ino;
>  };
>
>  /* Definitions for bpf_sock_ops_cb_flags */
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 1833926a63fc..93e3429603d7 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -75,6 +75,8 @@
>  #include <net/seg6_local.h>
>  #include <net/lwtunnel.h>
>  #include <net/ipv6_stubs.h>
> +#include <linux/kdev_t.h>
> +#include <linux/proc_ns.h>
>
>  /**
>   *     sk_filter_trim_cap - run a packet through a socket filter
> @@ -6774,6 +6776,15 @@ static bool sock_ops_is_valid_access(int off, int size,
>                 }
>         } else {
>                 switch (off) {
> +               case offsetof(struct bpf_sock_ops, netns_dev):
> +               case offsetof(struct bpf_sock_ops, netns_ino):
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
> @@ -7660,6 +7671,11 @@ static u32 sock_addr_convert_ctx_access(enum bpf_access_type type,
>         return insn - insn_buf;
>  }
>
> +static struct ns_common *sockops_netns_cb(void *private_data)
> +{
> +       return &init_net.ns;
> +}
> +
>  static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
>                                        const struct bpf_insn *si,
>                                        struct bpf_insn *insn_buf,
> @@ -7668,6 +7684,10 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
>  {
>         struct bpf_insn *insn = insn_buf;
>         int off;
> +       struct inode *ns_inode;
> +       struct path ns_path;
> +       __u64 netns_dev;
> +       void *res;
>
>  /* Helper macro for adding read access to tcp_sock or sock fields. */
>  #define SOCK_OPS_GET_FIELD(BPF_FIELD, OBJ_FIELD, OBJ)                        \
> @@ -7914,6 +7934,56 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
>                 SOCK_OPS_GET_OR_SET_FIELD(sk_txhash, sk_txhash,
>                                           struct sock, type);
>                 break;
> +
> +       case offsetof(struct bpf_sock_ops, netns_dev):
> +#ifdef CONFIG_NET_NS
> +               /* We get the netns_dev at BPF-load-time and not at
> +                * BPF-exec-time. We assume that netns_dev is a constant.
> +                */
> +               res = ns_get_path_cb(&ns_path, sockops_netns_cb, NULL);
> +               if (IS_ERR(res)) {
> +                       netns_dev = 0;
> +               } else {
> +                       ns_inode = ns_path.dentry->d_inode;
> +                       netns_dev = new_encode_dev(ns_inode->i_sb->s_dev);
> +               }
> +#else
> +               netns_dev = 0;
> +#endif
> +               *insn++ = BPF_MOV64_IMM(si->dst_reg, netns_dev);
> +               break;
> +
> +       case offsetof(struct bpf_sock_ops, netns_ino):
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
