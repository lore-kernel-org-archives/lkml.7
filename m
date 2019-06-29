Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3847EC5B57C
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 19:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10624216FD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 19:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfF2TkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 15:40:17 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32939 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfF2TkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 15:40:17 -0400
Received: by mail-lj1-f194.google.com with SMTP id h10so9176198ljg.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 12:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mS7NbHPTU5zxr4PB5iLA0AQQQ8J8KIDuDHXph6+7nRY=;
        b=ZPs20tTt2vyTRMC1PiHdzjH3uQwO/Xg4Hgq4ZYrOOxtnmfZ4yjPehrUj26sY3FmyOc
         IVDDioRhPkxG1fomdgtiABLvGbXjggbe10SlQrovcX8lo4jz33G1vIrQ1YOxiuajR1cj
         J8bhSWVWCU0WzabCjgVzHfkIZUP/Z2hUhCtksH2hS6SiA3IJY62K9srH7/e20/f3dJrN
         Gx1QD3iGDxL1ZhMFaeprFY5AdD0kQL3WqxtWn24YD772hCDNBg+oBk6yIo90K3uoV5EI
         D+W8++IIdTPfNmTi5SXgdHzsKmWXwEpn3S477wd6ks2F1TEWeBwJsk/YMiwEcjXc8tsT
         OPcw==
X-Gm-Message-State: APjAAAUV2E0KuR1uaEmFiqOxM1aBXlJ/GHE1TT30/ftGWsOnt9trlMFU
        NLZwVlRDYNve2Qug2BYY/tqkI8W2NL+79jaXSyO54DKERQI=
X-Google-Smtp-Source: APXvYqwN0+ksHHBiKjpUh37/8JcKiiuAy7OyftGGvM3hM04uAp6wt3EfoMhDs4ClkreVLwL1R8nV50KmaI9rDBaNVSo=
X-Received: by 2002:a2e:3013:: with SMTP id w19mr9626540ljw.73.1561837215301;
 Sat, 29 Jun 2019 12:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnkfhxxw9keiNj_Qm=2GBYpY38HAq28cOROMRqXfbqq8wNbWQ@mail.gmail.com>
 <20190628225533.GJ11506@sasha-vm> <1560226F-F2C0-440D-9C58-D664DE3C7322@appneta.com>
 <20190629074553.GA28708@kroah.com>
In-Reply-To: <20190629074553.GA28708@kroah.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Sat, 29 Jun 2019 21:39:39 +0200
Message-ID: <CAGnkfhzmGbeQe7L55nEv575XyubWqCLz=7NQPpH+TajDkkDiXg@mail.gmail.com>
Subject: Re: net: check before dereferencing netdev_ops during busy poll
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Josh Elsasser <jelsasser@appneta.com>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 29, 2019 at 9:45 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jun 28, 2019 at 07:03:01PM -0700, Josh Elsasser wrote:
> > On Jun 28, 2019, at 3:55 PM, Sasha Levin <sashal@kernel.org> wrote:
> >
> > > What's the upstream commit id?
> >
> > The commit wasn't needed upstream, as I only sent the original patch after
> > 79e7fff47b7b ("net: remove support for per driver ndo_busy_poll()") had
> > made the fix unnecessary in Linus' tree.
> >
> > May've gotten lost in the shuffle due to my poor Fixes tags. The patch in
> > question applied only on top of the 4.9 stable release at the time, but the
> > actual NPE had been around in some form since 3.11 / 0602129286705 ("net: add
> > low latency socket poll").
>
> Ok, can people then resend this and be very explicit as to why this is
> needed only in a stable kernel tree and get reviews from people agreeing
> that this really is the correct fix?
>
> thanks,
>
> greg k-h

Hi Greg,

I think that David alredy reviewed the patch here:

https://lore.kernel.org/netdev/20180313.105115.682846171057663636.davem@davemloft.net/

Anyway, I tested the patch and it fixes the panic, at least on my
iwlwifi card, so:

Tested-by: Matteo Croce <mcroce@redhat.com>

Regards,
-- 
Matteo Croce
per aspera ad upstream
