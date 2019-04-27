Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4273C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 16:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE612077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 16:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X40o9plV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfD0Qfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 12:35:32 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38744 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0Qfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 12:35:31 -0400
Received: by mail-it1-f196.google.com with SMTP id q19so10459376itk.3;
        Sat, 27 Apr 2019 09:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NOqk78nJXkXcRL+pw8N1TzdF4DprB81bwUwgo0cIA24=;
        b=X40o9plVXXwfIt+YZtgG8PCzVZUHGkpepihqlRha8jRHM5qKz2Y9aPppD+cFfUlM/B
         nsa8nlwLPs8RgMMMzhFInsjiTomcS+nuW1oQfN4TSl/s0CK77RAJz11MMSeFRtdiFBzn
         ZqJV14/RgxKo5g3AHjoYfJHHFVnPeAUQBqH8XPKs4U/e79KkZfWZTinVZ0RjSRbLi0qH
         0yJMCgDOwBAGedGv9sc16SD1himyl7Nb36FuLqzTlUYjtVPnsAg/toZ0+jkrl+ULEBTZ
         x/10X7XWLDjmLLf/m3mecyMHrx+NgVMGQo4jUca3i17wQIlvPgEH1o4Xw4GSVLuw4f1j
         tEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NOqk78nJXkXcRL+pw8N1TzdF4DprB81bwUwgo0cIA24=;
        b=a5bf127nTktm0iU4dObrzPisyrRHVpAK430a30TTh7tS4NmFrG8bG/QjSuqYHrm4lF
         nnB8zpsD9naS6kOh3qpwHpyYIbfYqegw3qap1zyaz2y1hNPxg8xZ3fV/mdFg8SaCvXKI
         NXzH9/NRuxop66PZQHHi12iYbcw8SynzGW01MkjOY+70u8rp3SpEKcW3POMS0kT//jGe
         Z2QRzFcx4JdJBVDoOI4ikaeDUprqLjHlecrSdKtBJ4XOuydZ0FULqCURFKaEEMCFy7Lx
         K1jLWGOXYm7qg4HbDW7FysEjK2CU77tN7Gj/zMw0yVaIVVhjBwpJeZtWlpvn3mE9bnG2
         ITMQ==
X-Gm-Message-State: APjAAAVnwQBbOnBIhL5OhwTl/g82hsrSDiYQ7V3SVUxeSDNw+s+TgENN
        sH0nswoU94ZX9/Z6E+D6Up+LfuYOL1G6ZYqCrAc=
X-Google-Smtp-Source: APXvYqx3wxMWABMqTbuRGjQLsMUu+1tTF58DUECQZjqFysFnqnEtZNqmoSgqYH8s7voGO4SmoXcG9857pVB4TO4hYbU=
X-Received: by 2002:a24:b342:: with SMTP id z2mr8848520iti.121.1556382930370;
 Sat, 27 Apr 2019 09:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190426154848.23490-1-alban@kinvolk.io>
In-Reply-To: <20190426154848.23490-1-alban@kinvolk.io>
From:   Y Song <ys114321@gmail.com>
Date:   Sat, 27 Apr 2019 09:34:54 -0700
Message-ID: <CAH3MdRViqmPWm9UaOEO3ZKa5AodL7AGZ4Bb0FzyDcoqRoDmqNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: sock ops: add netns ino and dev in
 bpf context
To:     Alban Crequy <alban.crequy@gmail.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>,
        =?UTF-8?Q?Iago_L=C3=B3pez_Galeiras?= <iago@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 8:50 AM Alban Crequy <alban.crequy@gmail.com> wrote:
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
>
> ---
>
> Changes since v1:
> - add netns_dev (review from Alexei)
>
> Changes since v2:
> - replace __u64 by u64 in kernel code (review from Y Song)
> - remove unneeded #else branch: program would be rejected in
>   is_valid_access (review from Y Song)
> - allow partial reads (<u64) (review from Y Song)
>
>   Note: I have not been able to fully test partial reads on netns_dev.
> The following patches check partial reads in the verifier but it does
> not actually execute the program to check if partial reads generate the
> correct value. I tried to write a BPF program in C and declare the
> struct bpf_sock_ops as a volatile variable and I could get llvm to
> generate the BPF instructions to do partial loads. But then, I get the
> verifier error "dereference of modified ctx ptr R2 off=184 disallowed",
> explained in https://www.spinics.net/lists/netdev/msg531582.html
> What do you think should be done here?

You added partial read tests in test_verifier with raw asm codes.
It should be good enough.

For the compiler generated code causing verifier error, will take
a detailed look later.

Also I did not see a cover letter. For a series with 4 patches, it would be
the best if you can provide a separate cover letter.

> ---
>  include/uapi/linux/bpf.h |  2 +
>  net/core/filter.c        | 94 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 96 insertions(+)
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
> index 2f88baf39cc2..9c77464b1501 100644
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
> @@ -6810,6 +6812,24 @@ static bool sock_ops_is_valid_access(int off, int size,
>                 }
>         } else {
>                 switch (off) {
> +               case offsetof(struct bpf_sock_ops, netns_dev) ...
> +                    offsetof(struct bpf_sock_ops, netns_dev) + sizeof(u64) - 1:
> +#ifdef CONFIG_NET_NS
> +                       if (off - offsetof(struct bpf_sock_ops, netns_dev)
> +                           + size > sizeof(u64))

This will allow something off = 1, size = 4. This is not what we want as
the access is not properly aligned.

You can look at function bpf_skb_is_valid_access(), esp. the two lines below:
          bpf_ctx_record_field_size(info, size_default);
           if (!bpf_ctx_narrow_access_ok(off, size, size_default))
                   return false;


> +                               return false;
> +#else
> +                       return false;
> +#endif
> +                       break;
> +               case offsetof(struct bpf_sock_ops, netns_ino):
> +#ifdef CONFIG_NET_NS
> +                       if (size != sizeof(u64))
> +                               return false;
> +#else
> +                       return false;
> +#endif
> +                       break;
>                 case bpf_ctx_range_till(struct bpf_sock_ops, bytes_received,
>                                         bytes_acked):
>                         if (size != sizeof(__u64))
> @@ -7727,6 +7747,11 @@ static u32 sock_addr_convert_ctx_access(enum bpf_access_type type,
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
> @@ -7735,6 +7760,10 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
>  {
>         struct bpf_insn *insn = insn_buf;
>         int off;
> +       struct inode *ns_inode;
> +       struct path ns_path;
> +       u64 netns_dev;
> +       void *res;
>
>  /* Helper macro for adding read access to tcp_sock or sock fields. */
>  #define SOCK_OPS_GET_FIELD(BPF_FIELD, OBJ_FIELD, OBJ)                        \
> @@ -7981,6 +8010,71 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
>                 SOCK_OPS_GET_OR_SET_FIELD(sk_txhash, sk_txhash,
>                                           struct sock, type);
>                 break;
> +
> +       case offsetof(struct bpf_sock_ops, netns_dev) ...
> +            offsetof(struct bpf_sock_ops, netns_dev) + sizeof(u64) - 1:
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
> +               off = si->off;
> +               off -= offsetof(struct bpf_sock_ops, netns_dev);
> +               switch (BPF_LDST_BYTES(si)) {
> +               case sizeof(u64):
> +                       *insn++ = BPF_MOV64_IMM(si->dst_reg, netns_dev);
> +                       break;
> +               case sizeof(u32):
> +                       netns_dev = *(u32 *)(((char *)&netns_dev) + off);
> +                       *insn++ = BPF_MOV32_IMM(si->dst_reg, netns_dev);
> +                       break;
> +               case sizeof(u16):
> +                       netns_dev = *(u16 *)(((char *)&netns_dev) + off);
> +                       *insn++ = BPF_MOV32_IMM(si->dst_reg, netns_dev);
> +                       break;
> +               case sizeof(u8):
> +                       netns_dev = *(u8 *)(((char *)&netns_dev) + off);
> +                       *insn++ = BPF_MOV32_IMM(si->dst_reg, netns_dev);
> +                       break;
> +               }
> +#endif
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
> +#endif
> +               break;
> +
>         }
>         return insn - insn_buf;
>  }
> --
> 2.20.1
>
