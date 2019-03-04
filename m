Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E786C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DC8206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Vc9E9Aeq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfCDVIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:08:39 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39992 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDVIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 16:08:39 -0500
Received: by mail-ed1-f66.google.com with SMTP id 10so5414122eds.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 13:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xi0XdFTCf8NeV+jIYlO5na2vh2J2DcCHyyItFCX1l0M=;
        b=Vc9E9AeqGPizsHCe6KkjaId6FYyAtMA2mwVAJOPXzsK93VYaIWCgA2O8ScLyNA6yw3
         dw4Gp1ALjJ62XvvYLQtwjWDzeBg59S2hOzd/053To+9vlcr43H5EHQSTklUV8ElZ6yFA
         X/hsZxCgNfgndu8a/oYqSvpFUljVeYGhsEO4g+lTBxcJiTesVYCg8EjU0MHlS33WLBCi
         LKdmHfICbZMV59rmscPaCHOhEngjbvFssroFKHXgPVtEDiSMLD2YRfcJeWQrwo8hWZle
         qgdjiIisIGJZstE81z79vATvQqNXgeuF7JQns7YnocGtPudjpRvjt5ghlu56asiMo8JR
         Qlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xi0XdFTCf8NeV+jIYlO5na2vh2J2DcCHyyItFCX1l0M=;
        b=sahHz3i7lyclecIw30qbl/NJt/7FS/yTae5nfBE5a/8S06XraMSw9M2uyl7sQZR4Rd
         lA6xmEWkl16btFoHpSiuygzwHZmIcQE3Ksc6rTEBacgvZmXOJTOoOmOMexJDT4y6iv8S
         /g/oZvIbwE1Kinb7RcjDrrmmQ1gWPCB7VhLW3cja+tU05gkA1S7Te5xRp3wrMu34Wp04
         LxkLSXQMpEHkJMbm28KTa4NLF6v/JfBhfuyKu38SzapuKpClbJW75mAyigovUceXUd6Y
         FbRUCB7kSr4mypKX6T5/wNT7dl4QishPvrf5yUxl3vJLZSYWuybcRUDS5p3A/DD52MJA
         RiYA==
X-Gm-Message-State: APjAAAUS7u99ifhLLoRrzbm2K0sRfbkQZUKrYfAQDxt1nO0e/KMA64FD
        l6FomjNv5ci/LKXSA0zoztXkmw==
X-Google-Smtp-Source: AHgI3IbmIPl/wy+QEYJmdxLjpd0A+EdNA3gR3FHdpPUcnY6eeaPGEO9BBrsrvIArbFVRu6ubNEFP/g==
X-Received: by 2002:a50:ac09:: with SMTP id v9mr16782631edc.3.1551733717724;
        Mon, 04 Mar 2019 13:08:37 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6c0:76e:3ddf:44fc:d22b:95ce])
        by smtp.gmail.com with ESMTPSA id q55sm2424999eda.19.2019.03.04.13.08.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 04 Mar 2019 13:08:37 -0800 (PST)
Date:   Mon, 4 Mar 2019 22:08:35 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Arnd Bergmann <arnd@arndb.de>
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
Subject: Re: [PATCH] net: ignore sysctl_devconf_inherit_init_net without
 SYSCTL
Message-ID: <20190304210834.ozejr3y6yyvh5i5n@brauner.io>
References: <20190304203822.2094613-1-arnd@arndb.de>
 <20190304210007.sqlkp5ylt5qy2hjf@brauner.io>
 <CAK8P3a2NGnvnNhLBBrEGC1SNE+TV13hPC7_P6TQu8cy5kro91A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a2NGnvnNhLBBrEGC1SNE+TV13hPC7_P6TQu8cy5kro91A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 10:07:17PM +0100, Arnd Bergmann wrote:
> On Mon, Mar 4, 2019 at 10:00 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > On Mon, Mar 04, 2019 at 09:38:03PM +0100, Arnd Bergmann wrote:
> > > When CONFIG_SYSCTL is turned off, we get a link failure for
> > > the newly introduced tuning knob.
> > >
> > > net/ipv6/addrconf.o: In function `addrconf_init_net':
> > > addrconf.c:(.text+0x31dc): undefined reference to `sysctl_devconf_inherit_init_net'
> > >
> > > Add an IS_ENABLED() check to fall back to the default behavior
> > > (sysctl_devconf_inherit_init_net=0) here.
> > >
> > > Fixes: 856c395cfa63 ("net: introduce a knob to control whether to inherit devconf config")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  net/ipv4/devinet.c  | 4 +++-
> > >  net/ipv6/addrconf.c | 3 ++-
> > >  2 files changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> > > index cd9033245b98..eb514f312e6f 100644
> > > --- a/net/ipv4/devinet.c
> > > +++ b/net/ipv4/devinet.c
> > > @@ -2614,7 +2614,9 @@ static __net_init int devinet_init_net(struct net *net)
> > >       tbl[0].extra2 = net;
> > >  #endif
> > >
> > > -     if (sysctl_devconf_inherit_init_net != 2 && !net_eq(net, &init_net)) {
> > > +     if ((!IS_ENABLED(CONFIG_SYSCTL) ||
> > > +          sysctl_devconf_inherit_init_net != 2) &&
> >
> > I'm sure I'm just being stupid here but wouldn't this still trigger the
> > warning or is sysctl_devconf_inherit_init_net unconditionally defined?
> > The error you're reporting makes it look like it isn't.
> 
> The declaration is unconditional in include/linux/netdevice.h, so the
> compiler does not see a problem, it simply doesn't create a reference
> when it sees that the code path is dead.
> 
> The error message I quoted is from the linker, so this is in turn
> not a problem after there is no reference to the variable.

Perfect!

Acked-by: Christian Brauner <christian@brauner.io>
