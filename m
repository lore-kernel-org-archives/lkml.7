Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A10C10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733F921738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QSRkGaPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbfDEMgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:36:33 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52983 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDEMgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:36:32 -0400
Received: by mail-it1-f194.google.com with SMTP id x132so9150460itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 05:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KiJg70GvckL+n0CcPjFwPts1fFJWjS2/ayIe1LKyLXo=;
        b=QSRkGaPlDD7tz1s32kaKWDx+oEK+CXrs2ZFwafVZYK958PLekvt5DoIKN9sSGXNpDR
         ue5k8pnbklaeG5+Z/z18iRK7XgHHH38y1Xg+6UW7mJaeCmtOcNvvy+fYHdAnGjvTIXBy
         tnpgciI7wWQ9kiSNn6hxWFsA+HrKvlYEHuW9BwNrjcq7t/7LmH9uXMLyVqwpPxV2kEW+
         uxRlNHHao5shlz4X6XQAGosIZKM6O7xl9on0LuOqczXQaulwIwJPZRycHmRGgo7Hvu7J
         6mSBh+0lqasAeXXXbp29ZtkBbTLDLsgXwZxxvO+eHNhndefsCQCq3BHNPC0CTIYwZZql
         dZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KiJg70GvckL+n0CcPjFwPts1fFJWjS2/ayIe1LKyLXo=;
        b=rAlZHxor53QDR2oPDZqLFWYDVz78bmYznLSo4A5mw7UUyS++QcFI6XPyXdt/v3nz3d
         IVelYCQX40XSX2SYJhuUzTVWdxwb/SSOk/RXjWzM0MFeBEiOFRTxt7/PHjLrxuqcdpku
         tuJFOhPlTbRmICzwmqSLT0cUKTK1n4N9qCOVeDKQVUBUdKgWgmZ6UZvztyoM7JrZ9oGv
         ImDNpL1QUgKcz/JQW3EZ43wt85qWQhPQsOqTsrhIG+BdFBO/XPhPbJ0sY9R8TjbGrRRr
         Fw6lzBQ5IKCL6Ssvj021f0/gH2K4VxlqNHVGnbjzZV8q2j/phS7R14yid9ffyTEE6axN
         vX/w==
X-Gm-Message-State: APjAAAWdzbPnfnJC83/ncR3iA3uB6bpEWiwTGNJN8HlyfzFCq9D9dXry
        ETyr5AwQaipA+AF+vdzi+FOUssyZhj1mk31/FjYzxg==
X-Google-Smtp-Source: APXvYqzmcn+CV+tb4tqriGkXeFclzJvKggx13DxoQEiFlTqGIBp1D+pbCmoP8wmBPppNjwn54g7z/rrCWkSIFRuxXaU=
X-Received: by 2002:a02:8c59:: with SMTP id j25mr9228424jal.4.1554467791465;
 Fri, 05 Apr 2019 05:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000e02450058593df62@google.com> <000000000000db3c59058595f0ac@google.com>
 <CAJKOXPcrimyMrK7LBbZLaqHGhS5dSCcBC1X01_pRY5evCD7n5Q@mail.gmail.com> <20190405100850.tojfhy3ob5gprwo7@breakpoint.cc>
In-Reply-To: <20190405100850.tojfhy3ob5gprwo7@breakpoint.cc>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 5 Apr 2019 14:36:20 +0200
Message-ID: <CACT4Y+bNKFEYDmaXvKhF_h3i1cm_aiSxWT+ppgz=-PAwd_i0tg@mail.gmail.com>
Subject: Re: BUG: using __this_cpu_read() in preemptible code in ip6_finish_output
To:     Florian Westphal <fw@strlen.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        amritha.nambiar@intel.com, Alexei Starovoitov <ast@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Edward Cree <ecree@solarflare.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Li RongQing <lirongqing@baidu.com>,
        netdev <netdev@vger.kernel.org>, petrm@mellanox.com,
        Sabrina Dubroca <sd@queasysnail.net>,
        Song Liu <songliubraving@fb.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yonghong Song <yhs@fb.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 12:09 PM Florian Westphal <fw@strlen.de> wrote:
>
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On Wed, 3 Apr 2019 at 03:14, syzbot
> > <syzbot+51471b4aae195285a4a3@syzkaller.appspotmail.com> wrote:
> > >
> > > syzbot has bisected this bug to:
> > >
> > > commit 97cdcf37b57e3f204be3000b9eab9686f38b4356
> > > Author: Florian Westphal <fw@strlen.de>
> > > Date:   Mon Apr 1 14:42:13 2019 +0000
> > >
> > >      net: place xmit recursion in softnet data
> >
> > I am seeing this as well on ARMv7 board booted from NFS root (exynos_defconfig):
>
> Sorry about this, the fix is now in net-next though:
> 28b05b92886871bdd ("net: use correct this_cpu primitive in dev_recursion_level")


Krzysztof, just in case, you can see the current bug status on
dashboard as well. E.g. for this one it says:

Fix commit: net: use correct this_cpu primitive in dev_recursion_level
