Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF929C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D94820661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqZS0H/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfCGRyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:54:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46456 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfCGRyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:54:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id g6so11995746pfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 09:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1E4iENPCWdT2C4QeTm1iBis4EFtMd3s1mWmYsVGpNM=;
        b=RqZS0H/ivQpTcktytXHy/lqkxba9ommM+Nnxrite6YkxaDM3uLGGMPG+09MpM/1npL
         41OOo/OZBo3GEWIir3kfhgK0SAu3CAJCr1b21m/VMtmjpC72sk1aXwrNmK6PB3VsdXyw
         GNlr1xlheqOILs2VheSkMeiihTsOvhK5ic7dKnXgspQi5xSihz1oCBRBV0J9WA8vgQvR
         05hRwP3Db3+7TI1rL5U9gii2F7zLGmAGjlBMllO9Obu4AXg9IipqMAGBijlfWCA5UTbr
         aGTffvZx79vp4EdOyNDRzd7+bxXaA8DKapVLoF3ERwMiBORlvp/ZRErOuiA9HXaEbMn8
         P+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1E4iENPCWdT2C4QeTm1iBis4EFtMd3s1mWmYsVGpNM=;
        b=Hy2ZfEVvr9NKUyNbzYLE4lpdARRDbVLZjnUGmRhF/4qZt3OxfJ6HQJKEht4bqUdZH2
         oPMQH7ZhVpiKhdIGvpCx1hq7NYdx6/mDmke1h1YEzG5hIj2O5foXUYWQAzWcaNjTAxrG
         IYz6p965RFVa/RtNTVqXlUq+3/8c1v4yKt1HL+8cWM0+Hd9jbqh1vP9B0rD8gs/GYDQ6
         x40YQiydSmCVp7fzrrJqAasu3u3jpJjNO0UQwQYxNZzLgNmHJa7ZWVbrQerWtI1JqaTB
         7YB4kBgIp7IO3E0o52Pw8wgKmcy8GhotP8ppF+Z3dUuupxB/ZatwLtod1cz2ERvw9Q+N
         0NtA==
X-Gm-Message-State: APjAAAUnBN0OqQHigP/gH+0v+P8MdbGF63QI9PCRdxxjkMPru59XGKdl
        JrS6yOXGQNff3VNYNZF63chTl3B4X3y2DFcJEmjxsw==
X-Google-Smtp-Source: APXvYqy4peGbU17UbH85NO5uI5I0DgZxsk+9kg3qi1cY9tvmP/cg1wmafOMz1RPUGXShLD2znZjXEMflpYwqDL//8L4=
X-Received: by 2002:a63:40c1:: with SMTP id n184mr11935550pga.225.1551981270756;
 Thu, 07 Mar 2019 09:54:30 -0800 (PST)
MIME-Version: 1.0
References: <20190307162101.29204-1-natechancellor@gmail.com> <20190307.094952.931716686086981512.davem@davemloft.net>
In-Reply-To: <20190307.094952.931716686086981512.davem@davemloft.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Mar 2019 09:54:19 -0800
Message-ID: <CAKwvOdk3iedWAbKOTR2UvQn-JLMZuU4_Jz6J=rDdjz0=_tNAGg@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: Avoid sometimes uninitialized Clang warnings
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 9:49 AM David Miller <davem@davemloft.net> wrote:
>
> From: Nathan Chancellor <natechancellor@gmail.com>
> Date: Thu,  7 Mar 2019 09:21:01 -0700
>
> > @@ -565,7 +565,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
> >       u32 ts_master_en = 0;
> >       u32 ts_event_en = 0;
> >       u32 value = 0;
> > -     u32 sec_inc;
> > +     u32 sec_inc = 0;
> >       bool xmac;
>
> Please don't break the reverse christmas tree ordering here, thank you.

Every codebase has its own unique code style. *wonders how
clang-format could or could not handle that rule*

Thanks for sending the patch Nathan; if you could resend with the
declaration order changed so that the line width decreases going down
in the order, you can add my Reviewed-by tag.
-- 
Thanks,
~Nick Desaulniers
