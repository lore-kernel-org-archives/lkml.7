Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B15C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6553021738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dRPDTNZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfDWWHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:07:01 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41624 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbfDWWHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:07:00 -0400
Received: by mail-vs1-f65.google.com with SMTP id g187so9225653vsc.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oSxIGA8gUh/Ki1zPwTNkG4y9fyDrsJ7jFAaFBs+VOkQ=;
        b=dRPDTNZ5/nDge/MaqwsObHEqgu9g16gyDrl8IAYONtJplWS/Xx5TEe0TqTaTFIzEZt
         c3OY5+TSWczXDV1AG8OkrStxr4Sm+zDEu43v8729egQzabMCIS6cEZ0p08RJZGPl3OHd
         LHTAOacko1/529RbdqTQydTddkE8eMuhtYw+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oSxIGA8gUh/Ki1zPwTNkG4y9fyDrsJ7jFAaFBs+VOkQ=;
        b=dHnrpBqWx0WzecZmyjXxM07RBgrUu8jOQAL9m5UEjYDLZaNiXRl/Xs7QUtNHiV7gUM
         PKaWIsadMBdHVn55tfUQogj6LSIlWyF1M0+lu97nc6rPrq33YL3phG7AeSu3bBiLcrKz
         pohqgvZsNCF+tlzdoEhRbVT6iJPxTqog9QDYA9677f6FSVMoldOQOEMyP+HcVCGGJMdJ
         YCppAJHb0o1cBDRaCEPxHQZzyi3ZBNrWGH/CVgYd+tRpXf2fZxL2ZxAj+asA/3gOLgD/
         cBaJxy2AWuHevhMAfg9SCIITsPsJ+bTfzQHNF4Rv+EDKbfGSf+Wil+f+7X2VdnP85n8u
         P80Q==
X-Gm-Message-State: APjAAAXd9FHe+HMTxDcHRs1THlNqicwsg5q2bc3XUwDU+xGhUukaFj01
        DnUm7Os5Px/uhcD7945zDubr6IXesOY=
X-Google-Smtp-Source: APXvYqw8J3CeiqnmtMWchkj7f8SIVMpzgbvgJkUtaqZGAkMrUKYSZrZLmZTiPyaav1TKD+tSAZIdDA==
X-Received: by 2002:a67:d387:: with SMTP id b7mr5147730vsj.57.1556057218943;
        Tue, 23 Apr 2019 15:06:58 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id q203sm5189772vkq.43.2019.04.23.15.06.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:06:57 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id f15so9212597vsk.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:06:57 -0700 (PDT)
X-Received: by 2002:a67:f849:: with SMTP id b9mr14860664vsp.188.1556057217005;
 Tue, 23 Apr 2019 15:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c8f45a0584e69ea9@google.com> <CAGXu5jLBd-u=ywxiEjmrLMj9TMRVnLOHHKfWKQ_fEosDFjPoog@mail.gmail.com>
 <20190423215127.GJ3758@cisco>
In-Reply-To: <20190423215127.GJ3758@cisco>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Apr 2019 15:06:45 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLmfN2jT0+V0RDwVZjBEw2Vm6QVH1KR_gykFg_b+3Wu7w@mail.gmail.com>
Message-ID: <CAGXu5jLmfN2jT0+V0RDwVZjBEw2Vm6QVH1KR_gykFg_b+3Wu7w@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in seccomp_notify_release (2)
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        coreteam@netfilter.org, Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Martin KaFai Lau <kafai@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Network Development <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Song Liu <songliubraving@fb.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Will Drewry <wad@chromium.org>, wenxu@ucloud.cn,
        Yonghong Song <yhs@fb.com>,
        syzbot <syzbot+b562969adb2e04af3442@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 2:51 PM Tycho Andersen <tycho@tycho.ws> wrote:
>
> On Tue, Apr 23, 2019 at 02:39:52PM -0700, Kees Cook wrote:
> > On Mon, Mar 25, 2019 at 1:02 AM syzbot
> > <syzbot+b562969adb2e04af3442@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    1bdd3dbf Merge tag 'io_uring-20190323' of git://git.kernel..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=12ae5b93200000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31fb246de2a622
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=b562969adb2e04af3442
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162ca25d200000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1733b53b200000
> > >
> > > The bug was bisected to:
> > >
> > > commit a799aea0988ea0d1b1f263e996fdad2f6133c680
> > > Author: wenxu <wenxu@ucloud.cn>
> > > Date:   Wed Jan 9 02:40:11 2019 +0000
> > >
> > >      netfilter: nft_flow_offload: Fix reverse route lookup
> >
> > This bisection looks bogus?
> >
> > However, I _can_ trigger the problem on this kernel version with this
> > config. (And not with Linus's latest tree.)
> >
> > The PoC is identical to the prior report[1] that we thought was fixed.
> > Perhaps the fix didn't actually fix it? (I mean
> > a811dc61559e0c8003f1086c2a4dc8e4d5ae4cb8) But it's been silent for 29
> > days now, so I'm not sure what's going on.
> >
> > Tycho are you able to reproduce this on the older tree?
>
> It looks like this case is using TSYNC and NEW_LISTENER together:
>
> syscall(__NR_seccomp, 1, 0xb, 0x20000140);

Ah, thanks. My eye-diff didn't work. :)

> and I did fix a uaf with TSYNC and NEW_LISTENER in this series:
>
> https://lore.kernel.org/lkml/20190306201413.14153-2-tycho@tycho.ws/T/#u
>
> which seems like it's probably related. I don't think the above ever
> got applied though?

Whoops, I lost this. Let me go dig that up. Thanks!

-- 
Kees Cook
