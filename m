Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208A4C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6F32087F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1Ek5vNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfDRVwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 17:52:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32844 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfDRVwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 17:52:06 -0400
Received: by mail-qt1-f196.google.com with SMTP id k14so3863873qtb.0;
        Thu, 18 Apr 2019 14:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dW0WRTAYadTssVCzOwPUMJM5MEJOUGulk1lMLmYV03Y=;
        b=d1Ek5vNgYKMKxEA4sVYAXycexZTD/THM3ZyADODYOcAqMUfeOkBMfPTUMeQw2M3A0a
         hAWfq7bFopVgyWqS82MKbL2ghs2NuW9+fxCJr+Knx13u5eN8vnJCuZZ+YdTpeRDz7m2S
         mHK8Ie1pmav8FrPvY+dYT2gK6TqWLDc6ynTwQwLoAGG2dKs8CbmdIrPiWN5ByM18/qXI
         fV+lEBEba1YhKochKJI0TFfRWtFQTA4RBtby9KfAPNGGrbw3R920G1YVkwXuoJpYybH3
         ZFRw/2dQdq5fvBeTZQuKdHjUk7BN1hTopi7VDh1wEMo9rGmelLBiWm+F4rcJWYtDuUHx
         NNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dW0WRTAYadTssVCzOwPUMJM5MEJOUGulk1lMLmYV03Y=;
        b=T7oOcMMGJJbTVjkN68aTMg+VtD/bASg9GVR+d3XiK7m15t7+5GiBtRcao7jE26Exr2
         5+6HOWuw+W93r7ZwW6+0wLK7Uud3PIvJMz2YuN6Mg8vyxjHi4zSt8ixoDS1mhv8piEL6
         sgI/w86UPz1+Yb/YMijW4npdLub11mXhjmud1eTKiLhPBTFOfriyo1OmnCnlSk7F/cmp
         mdXD2yUfAVxBoZzC44QR6lNZpcqb6No6HVO9Eucq5HoIFNg0Q1ldeiOGGr/hxvIIXrES
         jRcUlXQgZwN/UL2UrLjHk4mX72m5xvg40I2gWk81IdqcVbYewBkZ/IWimEcSAy6ji4iL
         ehfQ==
X-Gm-Message-State: APjAAAW4CuVF9yqgexiy66ep+tVyqXIMzvU43+y92CCAXM2m0Kgx67BA
        HR9NW66OEd3skkjOnKLF1gNH1h05hgfU+8rAujpUaA==
X-Google-Smtp-Source: APXvYqzPv4CFpchme7EPI8pDX2b/YbOWgeVN8iWhgX8ZwxOaE2ufVEtU/NKtWXJZloYxSq5p7D56dWr3cunEY8PdkWE=
X-Received: by 2002:a0c:d1f7:: with SMTP id k52mr442511qvh.5.1555624324601;
 Thu, 18 Apr 2019 14:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190418155652.22181-1-alban@kinvolk.io> <CAPhsuW7mhxaEyez4XX+ncUnfg-2wkF4Li+migjYdqON3-2f5_A@mail.gmail.com>
In-Reply-To: <CAPhsuW7mhxaEyez4XX+ncUnfg-2wkF4Li+migjYdqON3-2f5_A@mail.gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 18 Apr 2019 14:51:52 -0700
Message-ID: <CAPhsuW4JrOp59K=jzM-QY1sS2xsj6UP6663Y1Uv3iH-iOtfXSQ@mail.gmail.com>
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

On Thu, Apr 18, 2019 at 2:41 PM Song Liu <liu.song.a23@gmail.com> wrote:
>
> On Thu, Apr 18, 2019 at 8:59 AM Alban Crequy <alban.crequy@gmail.com> wrote:
> >
> > From: Alban Crequy <alban@kinvolk.io>
> >
> > sockops programs can now access the network namespace inode and device
> > via (struct bpf_sock_ops)->netns_ino and ->netns_dev. This can be useful
> > to apply different policies on different network namespaces.
> >
> > In the unlikely case where network namespaces are not compiled in
> > (CONFIG_NET_NS=n), the verifier will not allow access to ->netns_*.
> >
> > The generated BPF bytecode for netns_ino is loading the correct inode
> > number at the time of execution.
> >
> > However, the generated BPF bytecode for netns_dev is loading an
> > immediate value determined at BPF-load-time by looking at the initial
> > network namespace. In practice, this works because all netns currently
> > use the same virtual device. If this was to change, this code would need
> > to be updated too.
> >
> > Signed-off-by: Alban Crequy <alban@kinvolk.io>
>
> Acked-by: Song Liu <songliubraving@fb.com>

Sorry! I didn't see Yonghong's comments. Please resolve those.

Sorry for the confusion.
Song

>
> >
> > ---
> >
> > Changes since v1:
> > - add netns_dev (review from Alexei)
> > ---
> >  include/uapi/linux/bpf.h |  2 ++
> >  net/core/filter.c        | 70 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 72 insertions(+)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index eaf2d3284248..f4f841dde42c 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -3213,6 +3213,8 @@ struct bpf_sock_ops {
> >         __u32 sk_txhash;
> >         __u64 bytes_received;
> >         __u64 bytes_acked;
> > +       __u64 netns_dev;
> > +       __u64 netns_ino;
> >  };
> >
> >  /* Definitions for bpf_sock_ops_cb_flags */
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 1833926a63fc..93e3429603d7 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -75,6 +75,8 @@
> >  #include <net/seg6_local.h>
> >  #include <net/lwtunnel.h>
> >  #include <net/ipv6_stubs.h>
> > +#include <linux/kdev_t.h>
> > +#include <linux/proc_ns.h>
> >
> >  /**
> >   *     sk_filter_trim_cap - run a packet through a socket filter
> > @@ -6774,6 +6776,15 @@ static bool sock_ops_is_valid_access(int off, int size,
> >                 }
> >         } else {
> >                 switch (off) {
> > +               case offsetof(struct bpf_sock_ops, netns_dev):
> > +               case offsetof(struct bpf_sock_ops, netns_ino):
> > +#ifdef CONFIG_NET_NS
> > +                       if (size != sizeof(__u64))
> > +                               return false;
> > +#else
> > +                       return false;
> > +#endif
> > +                       break;
> >                 case bpf_ctx_range_till(struct bpf_sock_ops, bytes_received,
> >                                         bytes_acked):
> >                         if (size != sizeof(__u64))
> > @@ -7660,6 +7671,11 @@ static u32 sock_addr_convert_ctx_access(enum bpf_access_type type,
> >         return insn - insn_buf;
> >  }
> >
> > +static struct ns_common *sockops_netns_cb(void *private_data)
> > +{
> > +       return &init_net.ns;
> > +}
> > +
> >  static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
> >                                        const struct bpf_insn *si,
> >                                        struct bpf_insn *insn_buf,
> > @@ -7668,6 +7684,10 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
> >  {
> >         struct bpf_insn *insn = insn_buf;
> >         int off;
> > +       struct inode *ns_inode;
> > +       struct path ns_path;
> > +       __u64 netns_dev;
> > +       void *res;
> >
> >  /* Helper macro for adding read access to tcp_sock or sock fields. */
> >  #define SOCK_OPS_GET_FIELD(BPF_FIELD, OBJ_FIELD, OBJ)                        \
> > @@ -7914,6 +7934,56 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
> >                 SOCK_OPS_GET_OR_SET_FIELD(sk_txhash, sk_txhash,
> >                                           struct sock, type);
> >                 break;
> > +
> > +       case offsetof(struct bpf_sock_ops, netns_dev):
> > +#ifdef CONFIG_NET_NS
> > +               /* We get the netns_dev at BPF-load-time and not at
> > +                * BPF-exec-time. We assume that netns_dev is a constant.
> > +                */
> > +               res = ns_get_path_cb(&ns_path, sockops_netns_cb, NULL);
> > +               if (IS_ERR(res)) {
> > +                       netns_dev = 0;
> > +               } else {
> > +                       ns_inode = ns_path.dentry->d_inode;
> > +                       netns_dev = new_encode_dev(ns_inode->i_sb->s_dev);
> > +               }
> > +#else
> > +               netns_dev = 0;
> > +#endif
> > +               *insn++ = BPF_MOV64_IMM(si->dst_reg, netns_dev);
> > +               break;
> > +
> > +       case offsetof(struct bpf_sock_ops, netns_ino):
> > +#ifdef CONFIG_NET_NS
> > +               /* Loading: sk_ops->sk->__sk_common.skc_net.net->ns.inum
> > +                * Type: (struct bpf_sock_ops_kern *)
> > +                *       ->(struct sock *)
> > +                *       ->(struct sock_common)
> > +                *       .possible_net_t
> > +                *       .(struct net *)
> > +                *       ->(struct ns_common)
> > +                *       .(unsigned int)
> > +                */
> > +               BUILD_BUG_ON(offsetof(struct sock, __sk_common) != 0);
> > +               BUILD_BUG_ON(offsetof(possible_net_t, net) != 0);
> > +               *insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(
> > +                                               struct bpf_sock_ops_kern, sk),
> > +                                     si->dst_reg, si->src_reg,
> > +                                     offsetof(struct bpf_sock_ops_kern, sk));
> > +               *insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(
> > +                                               possible_net_t, net),
> > +                                     si->dst_reg, si->dst_reg,
> > +                                     offsetof(struct sock_common, skc_net));
> > +               *insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(
> > +                                               struct ns_common, inum),
> > +                                     si->dst_reg, si->dst_reg,
> > +                                     offsetof(struct net, ns) +
> > +                                     offsetof(struct ns_common, inum));
> > +#else
> > +               *insn++ = BPF_MOV64_IMM(si->dst_reg, 0);
> > +#endif
> > +               break;
> > +
> >         }
> >         return insn - insn_buf;
> >  }
> > --
> > 2.20.1
> >
