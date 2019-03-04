Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04644C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C2A206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="CoS12fVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfCDVAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:00:12 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36485 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfCDVAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 16:00:12 -0500
Received: by mail-ed1-f65.google.com with SMTP id g9so5399314eds.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 13:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OLc0ibkAmchCGTxToaaCwCRsekagoy4TfEFJ3UAO+Go=;
        b=CoS12fVaB0VsojAGHaE3D0hRGfCB9X3jwldPe71XVgP/9PXfYL9++KnupUsiN+U/XH
         xr1A2jNjdc9rPCe7AA/uhdWLgfYnWZ3NdiF9LzXuVql1ov2MoxtYt9wyfPhXAJ0EE3o3
         iWAeokAnmsKlCPFBRmBna4OXXePUOlnsGYfCk/ErS9sqDfsb5tqq9d72YeGMxo1Iadop
         DuVOzsae8L6sCBbn5UQiP8JQFwTHbrbXKYaQ24lVHADsmZ+AH10ZR0yJM4Tcj+kMYfsc
         +XXMe3nS2Cp09SBY3hLHrMq652NIuEKm96tflBOpQVC7GmedxIiObizHpc6UadYsyH0O
         bEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OLc0ibkAmchCGTxToaaCwCRsekagoy4TfEFJ3UAO+Go=;
        b=VKgBFI2Tqoyn1SllbYMzvvLQEmiI9tuSxuXHSTFCPKiHyd/A++03LKEEgEmFTkWliT
         tmblQSvGl94k+MROJjOfALvmP7iSZ4y7h2AroVzSd3zM0HN9wDoYztf2gDUVjLbdLXFC
         Bd0BSpV0Wk7bsucuAvPa7o4LfCMM0kTOKckow8Oj9eHgdDdBndOHUxc3/wBoa87HZ1Jm
         NPRXvTlqhCXW0auWakcD/yiib6PAzGeEriNbr7wFtzAxXO3GS17cYk7Ot4ZIdU7EHQw/
         vsdXl0RijZTqmUaEiLWVUqbi0+GvXYlO5fmGnvO0DvuwYkNA/FebxEyzuq7pNBEiFBut
         8waA==
X-Gm-Message-State: APjAAAV4O3cRaVE5Ii3tHIyl6YtqPz1cftnx+5Ln2LvndrciUTUb2aWs
        QIbVyq7qzYNSGAKwE46B2KRvBQ==
X-Google-Smtp-Source: APXvYqwZPP7jvUGNaNK7GLMabg+Kcf7XozohG70j4gvYKD7j7ZT+xGjWVZLQaacPuNy2KQceDacsEw==
X-Received: by 2002:a50:d2d7:: with SMTP id q23mr17031878edg.120.1551733210300;
        Mon, 04 Mar 2019 13:00:10 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6c0:76e:3ddf:44fc:d22b:95ce])
        by smtp.gmail.com with ESMTPSA id x45sm2422924edb.42.2019.03.04.13.00.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 04 Mar 2019 13:00:09 -0800 (PST)
Date:   Mon, 4 Mar 2019 22:00:08 +0100
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
        Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ignore sysctl_devconf_inherit_init_net without
 SYSCTL
Message-ID: <20190304210007.sqlkp5ylt5qy2hjf@brauner.io>
References: <20190304203822.2094613-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190304203822.2094613-1-arnd@arndb.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 09:38:03PM +0100, Arnd Bergmann wrote:
> When CONFIG_SYSCTL is turned off, we get a link failure for
> the newly introduced tuning knob.
> 
> net/ipv6/addrconf.o: In function `addrconf_init_net':
> addrconf.c:(.text+0x31dc): undefined reference to `sysctl_devconf_inherit_init_net'
> 
> Add an IS_ENABLED() check to fall back to the default behavior
> (sysctl_devconf_inherit_init_net=0) here.
> 
> Fixes: 856c395cfa63 ("net: introduce a knob to control whether to inherit devconf config")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/ipv4/devinet.c  | 4 +++-
>  net/ipv6/addrconf.c | 3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index cd9033245b98..eb514f312e6f 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -2614,7 +2614,9 @@ static __net_init int devinet_init_net(struct net *net)
>  	tbl[0].extra2 = net;
>  #endif
>  
> -	if (sysctl_devconf_inherit_init_net != 2 && !net_eq(net, &init_net)) {
> +	if ((!IS_ENABLED(CONFIG_SYSCTL) ||
> +	     sysctl_devconf_inherit_init_net != 2) &&

I'm sure I'm just being stupid here but wouldn't this still trigger the
warning or is sysctl_devconf_inherit_init_net unconditionally defined?
The error you're reporting makes it look like it isn't.

> +	    !net_eq(net, &init_net)) {
>  		memcpy(all, init_net.ipv4.devconf_all, sizeof(ipv4_devconf));
>  		memcpy(dflt, init_net.ipv4.devconf_dflt, sizeof(ipv4_devconf_dflt));
>  	}
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index da5a21050ba9..4ae17a966ae3 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -6905,7 +6905,8 @@ static int __net_init addrconf_init_net(struct net *net)
>  	if (!dflt)
>  		goto err_alloc_dflt;
>  
> -	if (sysctl_devconf_inherit_init_net == 1 && !net_eq(net, &init_net)) {
> +	if (IS_ENABLED(CONFIG_SYSCTL) &&
> +	    sysctl_devconf_inherit_init_net == 1 && !net_eq(net, &init_net)) {
>  		memcpy(all, init_net.ipv6.devconf_all, sizeof(ipv6_devconf));
>  		memcpy(dflt, init_net.ipv6.devconf_dflt, sizeof(ipv6_devconf_dflt));
>  	}
> -- 
> 2.20.0
> 
