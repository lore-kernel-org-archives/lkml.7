Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC17C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7A7206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfCDVHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:07:36 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37578 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDVHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 16:07:35 -0500
Received: by mail-qt1-f193.google.com with SMTP id a48so6718315qtb.4;
        Mon, 04 Mar 2019 13:07:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ypEz3FRHqiy0FA9/U6WYzdxE3vpPiR35rS4t8g2B83g=;
        b=hFiV0ZiLI1TN/HsBGYr1/cKusYAkO9yNEDBY+V93MGLouBsIDynqcxifgAu1AzT7oJ
         C5NkoCFOFpsT/jfSY/WYYTz4XvT3LtyZVOH8WVdIFkTjdMGOZNXteeKtUxLY7pEpvkag
         IPT0yVA2g18hXBHwGrH+dAQMw/B7Y3Xq7FkbawhAQoTnOe0EstuoSA/UaUA2h3sozBRH
         WsSU/ezRlGSHJERxbQrXelFc22dfCija+t4KMfTWZTq8URQ7eii5qaVtAzN8RxtyQeuK
         u2x04BqcsOScf1PshULUedFeUnbNC1KnQLRBr0MhSEAD5g1LPKhq3mPDoo65HK7YTS22
         rWUg==
X-Gm-Message-State: APjAAAUrDNnSjNKTt5JQTXeJn8Fg2rhoHDLDuBDtTcYSaWrAd83n/asn
        xWEujsojwT9enDOYRzyyfQiMNkXgESbHfNA68po=
X-Google-Smtp-Source: APXvYqySJPaCiVWnNIKU6KvWpslbcSK8fUY4IMsxo1FutqzSby8d0fcerZQpo+Feah9GVWNAdWfNRmt7J29zDiVQ5NI=
X-Received: by 2002:ac8:445a:: with SMTP id m26mr15921905qtn.212.1551733654609;
 Mon, 04 Mar 2019 13:07:34 -0800 (PST)
MIME-Version: 1.0
References: <20190304203822.2094613-1-arnd@arndb.de> <20190304210007.sqlkp5ylt5qy2hjf@brauner.io>
In-Reply-To: <20190304210007.sqlkp5ylt5qy2hjf@brauner.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 4 Mar 2019 22:07:17 +0100
Message-ID: <CAK8P3a2NGnvnNhLBBrEGC1SNE+TV13hPC7_P6TQu8cy5kro91A@mail.gmail.com>
Subject: Re: [PATCH] net: ignore sysctl_devconf_inherit_init_net without SYSCTL
To:     Christian Brauner <christian@brauner.io>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Zhu Yanjun <Yanjun.Zhu@windriver.com>,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        David Ahern <dsahern@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 10:00 PM Christian Brauner <christian@brauner.io> wrote:
>
> On Mon, Mar 04, 2019 at 09:38:03PM +0100, Arnd Bergmann wrote:
> > When CONFIG_SYSCTL is turned off, we get a link failure for
> > the newly introduced tuning knob.
> >
> > net/ipv6/addrconf.o: In function `addrconf_init_net':
> > addrconf.c:(.text+0x31dc): undefined reference to `sysctl_devconf_inherit_init_net'
> >
> > Add an IS_ENABLED() check to fall back to the default behavior
> > (sysctl_devconf_inherit_init_net=0) here.
> >
> > Fixes: 856c395cfa63 ("net: introduce a knob to control whether to inherit devconf config")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  net/ipv4/devinet.c  | 4 +++-
> >  net/ipv6/addrconf.c | 3 ++-
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> > index cd9033245b98..eb514f312e6f 100644
> > --- a/net/ipv4/devinet.c
> > +++ b/net/ipv4/devinet.c
> > @@ -2614,7 +2614,9 @@ static __net_init int devinet_init_net(struct net *net)
> >       tbl[0].extra2 = net;
> >  #endif
> >
> > -     if (sysctl_devconf_inherit_init_net != 2 && !net_eq(net, &init_net)) {
> > +     if ((!IS_ENABLED(CONFIG_SYSCTL) ||
> > +          sysctl_devconf_inherit_init_net != 2) &&
>
> I'm sure I'm just being stupid here but wouldn't this still trigger the
> warning or is sysctl_devconf_inherit_init_net unconditionally defined?
> The error you're reporting makes it look like it isn't.

The declaration is unconditional in include/linux/netdevice.h, so the
compiler does not see a problem, it simply doesn't create a reference
when it sees that the code path is dead.

The error message I quoted is from the linker, so this is in turn
not a problem after there is no reference to the variable.

      Arnd
