Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA7FC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB38A2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXcVghTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfDSW7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:59:42 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37312 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfDSW7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:59:42 -0400
Received: by mail-it1-f196.google.com with SMTP id u65so10350863itc.2;
        Fri, 19 Apr 2019 15:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vnMl9QufHWeKqWpHvzndv041maEwiL/0hMQzJUIU77I=;
        b=SXcVghTSx0kLE9c4ECxgKHFj5/E+7jIPziyBsgbfsKjOfksLfiXNK0A2Y2MbLGnEUT
         f1FqPc8DoPeYsbPaTLtLDJD5LcATY2qg2uuCuMxOBTdBL+G0UFpRfWgCNXwB8HbhT9OE
         d1kUPjoFUKtaihte7ZE1KN1BP2MFjh/Ma6bxmq+bA8XYe7hPqU3UtLx7n34craL/KSfP
         i9ZuVqIuArlThbaRhc2kYgTPBg/QI6TigWk3X0H4zAlark/sUC6GQ3d/tcymXoQK1iiu
         7CoXqgBEFoFNnG/WPgNMAPZYjwXKjdbmwh27PBdSqpMRTvI6YxkfvKaRaLL+er4770rN
         9uaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vnMl9QufHWeKqWpHvzndv041maEwiL/0hMQzJUIU77I=;
        b=g1NL4hPZnHKqF0Aq5wmwrGgQ/L6Nq6OMFSJaaPE2IuLNem/a2vmxunfXLSUlvAWFk3
         EQtbEPQF7uXEoAZ2jjyiM63b9fSelCC901Ar9QXbdd82CZ4mm9LSQbhU5MTeHENC08LN
         vovLzpngPF/AyoMmzOdKIubcjqOsQ26P9z1gln9ZZhGn+Qlmt8xPydkU1FGueai9Fe5i
         vq6EJXi+RY4WB8nV+tiMwvfIAwIgoaNAb8yujZoXdUxSDE4URTfwayx/Li9fsgQQGH1X
         0dlsFuGHnBWTTc0qf5Mc0glfqcSu8bczdnE+U+WRSsKfBaM6oiqdDt/zK7QrvXNK8gLZ
         X6Uw==
X-Gm-Message-State: APjAAAUmn3AhQHAmMajf/qCb2WWBF0ffpU1yWxBZdNP4ayireEh0M/Ne
        gTX9l+FkTTBzBRZ9B+isGfheSlfcm5VWyR7RriU=
X-Google-Smtp-Source: APXvYqzzgRScKNCXkpIywakET3E0qZieSINPLp92ypxW3WH1QnZKa/QZ1z0X6NK0EAMxpdFb42k3pJlJnDvUbhDdYMs=
X-Received: by 2002:a24:4210:: with SMTP id i16mr4696113itb.37.1555714781085;
 Fri, 19 Apr 2019 15:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190418155652.22181-1-alban@kinvolk.io> <CAH3MdRUMavDst+KssmV=EtwQTudq12ZvXhiP-qiBb+24R8vpGA@mail.gmail.com>
 <CADZs7q6XahoWDKWu90xEais_kJ1rKekcXWd2Lh+WyvKiJCtG1w@mail.gmail.com>
In-Reply-To: <CADZs7q6XahoWDKWu90xEais_kJ1rKekcXWd2Lh+WyvKiJCtG1w@mail.gmail.com>
From:   Y Song <ys114321@gmail.com>
Date:   Fri, 19 Apr 2019 15:59:04 -0700
Message-ID: <CAH3MdRUiXrVwHKHb-XuQffrDAEZHovjxCvRtQ69J-=_L=FX2Ng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: sock ops: add netns ino and dev in
 bpf context
To:     Alban Crequy <alban@kinvolk.io>
Cc:     Alban Crequy <alban.crequy@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Iago_L=C3=B3pez_Galeiras?= <iago@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 4:51 AM Alban Crequy <alban@kinvolk.io> wrote:
>
> On Thu, Apr 18, 2019 at 11:31 PM Y Song <ys114321@gmail.com> wrote:
> >
> > On Thu, Apr 18, 2019 at 8:58 AM Alban Crequy <alban.crequy@gmail.com> wrote:
> > >
> > > From: Alban Crequy <alban@kinvolk.io>
> > >
> > > sockops programs can now access the network namespace inode and device
> > > via (struct bpf_sock_ops)->netns_ino and ->netns_dev. This can be useful
> > > to apply different policies on different network namespaces.
> > >
> > > In the unlikely case where network namespaces are not compiled in
> > > (CONFIG_NET_NS=n), the verifier will not allow access to ->netns_*.
> > >
> > > The generated BPF bytecode for netns_ino is loading the correct inode
> > > number at the time of execution.
> > >
> > > However, the generated BPF bytecode for netns_dev is loading an
> > > immediate value determined at BPF-load-time by looking at the initial
> > > network namespace. In practice, this works because all netns currently
> > > use the same virtual device. If this was to change, this code would need
> > > to be updated too.
> > >
> > > Signed-off-by: Alban Crequy <alban@kinvolk.io>
> > >
> > > ---
> > >
> > > Changes since v1:
> > > - add netns_dev (review from Alexei)
> > > ---
> > >  include/uapi/linux/bpf.h |  2 ++
> > >  net/core/filter.c        | 70 ++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 72 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index eaf2d3284248..f4f841dde42c 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -3213,6 +3213,8 @@ struct bpf_sock_ops {
> > >         __u32 sk_txhash;
> > >         __u64 bytes_received;
> > >         __u64 bytes_acked;
> > > +       __u64 netns_dev;
> > > +       __u64 netns_ino;
> >
> > Maybe we can define netns_dev as __u32?
> >    __u64 netns_ino;
> >    __u32 netns_dev;
> >
> > There is a hole at the end which can be used if the next
> > field to be added in the future is a __u32.
> >
> > From
> > static inline u32 new_encode_dev(dev_t dev)
> > {
> >         unsigned major = MAJOR(dev);
> >         unsigned minor = MINOR(dev);
> >         return (minor & 0xff) | (major << 8) | ((minor & ~0xff) << 12);
> > }
> >
> > device num is encoded in a u32.
>
> I could do that but there are already two occurrences of "__u64
> netns_dev" in bpf.h:
> - struct bpf_prog_info
> - struct bpf_map_info
>
> Should I keep it a u64 for consistency with the rest of bpf.h, or
> change it to u32?

Agreed. We probably should keep it to be __u64 to be consistent with others.
