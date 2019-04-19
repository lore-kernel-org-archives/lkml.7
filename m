Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B0EC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F9A20643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="lS4guyEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfDSTBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:01:46 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45876 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbfDSTBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:01:44 -0400
Received: by mail-ot1-f67.google.com with SMTP id e5so4992712otk.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gQ1OLQuUyf7zoPs/qRTP7vFrHHjp78fRi3tvzv8ZqbY=;
        b=lS4guyEjVn2wJpj2XmtHtPyIt4u+T27qEpkOiNgd0ApwGOGfruYf3foKIDPmiAesyj
         Rpu2uN57aihGqk2uYMnqD3e5qjtpLPlGJud6clSCBY9kZkG/B/Mqe2sUPRlCkzgqyvgk
         E17M8EsxCVqEGqD1iouNf0bwaLrQLslFhLCVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gQ1OLQuUyf7zoPs/qRTP7vFrHHjp78fRi3tvzv8ZqbY=;
        b=erGzasZ5RYoxzSoVbgln9sx+X0wykxI/CbLamNstnM/k0FmgyBleV9KWjfvqLcDQjT
         rYe12BPRVa0Ms/y/LmQVOXjpHW7TeWasN8o7k7gFTg/o5GSMD0v8beBklAfZDJK8E0Zq
         lmDOMcwjendGLoDEnaPqeZLW8Ib6W8J0K0egM/aKnnS9BU69WOHKH36taLGur5krHb0X
         7IIYBZKavkIGF7EYPXCrHw2wnFXZMujrKjc7X4+Mro2AdkjrCSUxgg72dbS8nLdHN7lV
         wB+gE71tTBX3O6vBWaGg5HXbmUtsS2JSn8tnMMgN+VhNNItscutR2445Ws7pWRCHrP79
         yYYw==
X-Gm-Message-State: APjAAAWrSiUr+QtOc/PIoG7Z1c4AaBoo9yJVar8vKfesvKe2t2WMARAM
        NGlCtFumikRSa20zncsehVFB2zKJA7JY5/BYEfK5XO5DKv4=
X-Google-Smtp-Source: APXvYqwHY1voNH2CeyZ/3+Ob/1Rp2t5SWWUKHGMyoGPrM1BsMI8AbRSRlnwBmogvi4615SFQEHxP5mk3Rl26z4r7PRc=
X-Received: by 2002:a9d:7f89:: with SMTP id t9mr1741319otp.169.1555674676864;
 Fri, 19 Apr 2019 04:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190418155652.22181-1-alban@kinvolk.io> <CAH3MdRUMavDst+KssmV=EtwQTudq12ZvXhiP-qiBb+24R8vpGA@mail.gmail.com>
In-Reply-To: <CAH3MdRUMavDst+KssmV=EtwQTudq12ZvXhiP-qiBb+24R8vpGA@mail.gmail.com>
From:   Alban Crequy <alban@kinvolk.io>
Date:   Fri, 19 Apr 2019 13:51:05 +0200
Message-ID: <CADZs7q6XahoWDKWu90xEais_kJ1rKekcXWd2Lh+WyvKiJCtG1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: sock ops: add netns ino and dev in
 bpf context
To:     Y Song <ys114321@gmail.com>
Cc:     Alban Crequy <alban.crequy@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
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

On Thu, Apr 18, 2019 at 11:31 PM Y Song <ys114321@gmail.com> wrote:
>
> On Thu, Apr 18, 2019 at 8:58 AM Alban Crequy <alban.crequy@gmail.com> wrote:
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
>
> Maybe we can define netns_dev as __u32?
>    __u64 netns_ino;
>    __u32 netns_dev;
>
> There is a hole at the end which can be used if the next
> field to be added in the future is a __u32.
>
> From
> static inline u32 new_encode_dev(dev_t dev)
> {
>         unsigned major = MAJOR(dev);
>         unsigned minor = MINOR(dev);
>         return (minor & 0xff) | (major << 8) | ((minor & ~0xff) << 12);
> }
>
> device num is encoded in a u32.

I could do that but there are already two occurrences of "__u64
netns_dev" in bpf.h:
- struct bpf_prog_info
- struct bpf_map_info

Should I keep it a u64 for consistency with the rest of bpf.h, or
change it to u32?

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
>
> for netns_dev, looks like we have encoding like
>    (minor & 0xff) | (major << 8) | ((minor & ~0xff) << 12)
>
> it is possible user may access like:
>    u16 dev = sk->netns_dev;
> the compiler may translate into a 2-byte load
> or even
>   u8 major = (sk->netns_dev >> 8) & 0xf
> the compiler may translate to a byte load of &sk->netns_dev + 1 or 3
> depends on endianness.
> I suggest we relax the access pattern now to avoid patch later.

Ok, I can do that.

My use case was to compare (struct bpf_sock_ops)->netns_dev/netns_ino
with the value from a map prepared from userspace, i.e. the value of
netns_dev/ino is an opaque buffer for the BPF program, so the problem
is unlikely. But I've got bitten by a similar thing before (struct
sk_msg_md->remote_port/local_port was read in one go as a u64) so we
can improve this a bit.

Thanks for the review, I'll do the rest of the requested changes
probably end of next week.

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
>
> Although there are a few discrepancies,  I suggest to use u64 for
> kernel as __u64 is typically
> used in user space.
>
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
>
> The #else branch is not needed. During is_valid_access check, if CONFIG_NET_NS
> is not defined, the program should have been rejected.
>
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
>
> The same as above, this else branch is not needed.
>
> > +#endif
> > +               break;
> > +
> >         }
> >         return insn - insn_buf;
> >  }
> > --
> > 2.20.1
> >
