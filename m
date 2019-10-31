Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6596CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 06:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF2D2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 06:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TpBIzfwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfJaGl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 02:41:29 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40973 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfJaGl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 02:41:29 -0400
Received: by mail-oi1-f194.google.com with SMTP id e9so346595oif.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 23:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M5aqfRUwMC8kkZNS08EKrqYaYUA7QXeP5u3u8FUlnsQ=;
        b=TpBIzfwnhWtYz1ac0q/WtKeIOkg2bl0BExkdEvRboPM5W/ia7X63B/GeJPDjxwBAss
         Vqv766ulgHm726Z5m+6TO78QFbj8V+z+59zcdUMmJZQs7li/AzHyfP3rdsXFyyJRNMsY
         /h6ksG0cwjsN7tnrHVbLhufnD8yZ3uHfNq/pf1w8h/9Ro2i/Ng/7UF2hglXJ0MCfMf/4
         O42JQN5VWgjTmE8LZeDtr2NFsuyA0ZNSry0g168qoLTHHjcFqbOAi8xxjbp2vWtlUhL4
         D6fuVBKCfsscc0QXJ/5ao4RDNRDgWa+gSAe4yKrm+qbi9KVdQzvBTqNBGeAxQwGbjLru
         elQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M5aqfRUwMC8kkZNS08EKrqYaYUA7QXeP5u3u8FUlnsQ=;
        b=VnNCKO9um/N7RwiBaPKU4jh8gS4PEWg5LoXsx7hslFYr8TakonDvmBGLpdzrnFPFNC
         Dr8SFKNOr/U2YsbMsZoJ0AcrQADuQReAwHi2ApqOfgJD19yDZBqgVBucR3U39EPN84gz
         ZkQ1PsQGANYAjPB3oi/GrnD7p1TnsNedXSV4iXfN4HjfWr6r5opkPz0wDzEfgzbUJ7dP
         UG6LoAegO4/QerWaO8P19RpC/kyTnQ0tE7AhjthG8rOAsmXOBvOycokIKRHabMfURQQa
         sux4Vv59KYG5jIQlSXBl1x4z3zcnpQFNA0TCryIyGYEzM43F6jGkTGsNFQMxALzcD6DJ
         9gEA==
X-Gm-Message-State: APjAAAWsVsClsO7clFiKyZjj4l2xRoSjevfA4kktAuPLv3TaRXfpfZFw
        RPIPP+RbwBHHpRUnFxVg3EtMyOLQN4rYhgu9FK8OCA==
X-Google-Smtp-Source: APXvYqziUkmRJkxhjBwfWg3KbrZSONgKs5i7yaP6xmaWXghCp4DmWaGD9OFRC20Q30jMl6QH5W9EwTOpi6/pu3qeyB8=
X-Received: by 2002:aca:cc11:: with SMTP id c17mr2768954oig.147.1572504086843;
 Wed, 30 Oct 2019 23:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191006053916.8849-1-brgl@bgdev.pl> <CAMRc=Me3Q=67fCDrFM38LAGXCd+apJybLYVfyrfwmwYa5L1CmQ@mail.gmail.com>
 <CAK8P3a3tUg4SBtO0xb2GAHfegp23WF4TLymzqFfra2-fGLRO7w@mail.gmail.com>
 <CAMRc=Me8g2gFiag0UQwuu4UZONcowQw900+MUbGF+4-E0z09Zg@mail.gmail.com>
 <CAK8P3a2mh+Eh+W1GFL2Mi5R3t55SRwWyXW_iBxXB-nBhdCO8LA@mail.gmail.com> <20191030213555.GA25515@infradead.org>
In-Reply-To: <20191030213555.GA25515@infradead.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 31 Oct 2019 07:41:16 +0100
Message-ID: <CAMpxmJXOANjxZgTcReRmd6TGaUKNi=8Cxwj4K69aRY=bF3jDiw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] drivers: add new variants of devm_platform_ioremap_resource()
To:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 30 pa=C5=BA 2019 o 22:35 Christoph Hellwig <hch@infradead.org> na=
pisa=C5=82(a):
>
> On Mon, Oct 21, 2019 at 09:29:30PM +0200, Arnd Bergmann wrote:
> > > Is Christoph's work in next? The series doesn't apply cleanly on next=
,
> > > I needed to fix a couple conflicts. What branch should I rebase it on
> > > before resending?
> >
> > Not sure, maybe Christoph can comment.
> >
> > Your patches would best go through the char-misc tree and be based
> > on top of that, for Christoph's I think the idea is to have some go
> > through the architecture maintainer trees, and have whatever is
> > left go through my asm-generic tree.
>
> Actually I thought of just doing an ioremap tree for this merge window.
>
> What kind of changes does Bartosz have?  I'm kinda missing the context
> here.

Just the series you've responded to here, but I don't think it should
conflict with your changes (not very much anyway).

Greg: can this be picked up into char-misc?

Bart
