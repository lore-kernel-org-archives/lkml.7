Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C4EC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3D8218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hRilNm7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfDWPki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:40:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37703 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbfDWPkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:40:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so7805140pgc.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JQGb1p56JzSO7bsl1HRkDuz2rCXp3bub9Rkq4RYh9zY=;
        b=hRilNm7aEtfn1aLSBwKJZWWsYs0hMfE78j2khsgdSnVw10MydE+abWFWJ+Xi617Mie
         m/K8Ah73TPb+RE2L6LU1ydkdvM4ViFkadDvbVCQKyu0MoVJUM+dtD9Hjcniz4xjQrbLH
         TBoKUapBIIvb6mUawZN4eOwowHJT3o7A0u7nghUOpTxXqnO75BvWDNJSkQiDVIqlh6pw
         f4hF/2n4s48B1rXRxnAKCCHOKc6SmKo8qwDAGeuer1YFiC/JWu3hXGRmS2MH1YeJ7Vm4
         xiPVstqmdlSOCyf+LaJB2aaa2VOxC6zh7Z1Gh3HNPDiE9dwLYReyScrVlzvQvAldf16/
         eyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JQGb1p56JzSO7bsl1HRkDuz2rCXp3bub9Rkq4RYh9zY=;
        b=PlICnBlRTqUz86UCX4vPtDSkYqr1PG9jGQmXneQfsEH8bT5qSf4XIQ2LvUQif6kFy8
         KD2ftOOl9n99fntUtlqxYeqit3PL+q71ACIbfsLjN/Hp7ZrZQozKbBd0oOVECDoEMsSo
         4dithx7GbHoOAw2m2kqCULRDx2KnYr601MOSjUiGadIdWMt4ogl8eQgeKwNlNWgcilbC
         Nx9nFObcT6cUuyD4Q8/3zH/HAuTGOshLlhdXKejL2x+/KyqEhpe5dG3WS77VhVXRIOLm
         Hxz39ZkWZ96KkSHKyxjA+pKFg6Dx1e2ds0uBQ0z/OIQqRwKSkiFEIewsz4Vt68eakFEZ
         OTxg==
X-Gm-Message-State: APjAAAWyZ5kJ28hFWjQxa20YYXqM5Xvd72OfHnHaYl2p592WVRwDXrM2
        bzx5MKQ6j+ugnzKrbuXhFvAaSeMyxPF/48I66+QBow==
X-Google-Smtp-Source: APXvYqz4OHY3in8q29G464jBbYmMvo7lc8P9rHlRWDUgVJOtPpl1f9jbfmNwMvPHNKzwkQhY0a1Kv51sw0c48x5NdAM=
X-Received: by 2002:aa7:8c9a:: with SMTP id p26mr28120772pfd.251.1556034036646;
 Tue, 23 Apr 2019 08:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190422173838.182736-1-venture@google.com> <CAK8P3a0k_8+R9FeyZsL6Egvi1Z-G0VrvR0TWXzGHryqxTr6thg@mail.gmail.com>
 <CAO=notxuYsBzWBnNran5jH0RujSBeti6-HsjasCRP6Sq0MwGNA@mail.gmail.com> <CAK8P3a24h=0JLZnZWOmzRqM70uhw3QZ_HcYDXST7F6TgSuW6YA@mail.gmail.com>
In-Reply-To: <CAK8P3a24h=0JLZnZWOmzRqM70uhw3QZ_HcYDXST7F6TgSuW6YA@mail.gmail.com>
From:   Patrick Venture <venture@google.com>
Date:   Tue, 23 Apr 2019 08:40:25 -0700
Message-ID: <CAO=noty2QN6H_x3RMjqOrY9b0xLLz=MBk6Fb6yCdW9+J0a-bSA@mail.gmail.com>
Subject: Re: [PATCH] soc: add aspeed folder and misc drivers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     gregkh <gregkh@linuxfoundation.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org, arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 8:33 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Apr 23, 2019 at 4:24 PM Patrick Venture <venture@google.com> wrote:
> >
> > On Tue, Apr 23, 2019 at 1:08 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Mon, Apr 22, 2019 at 7:38 PM Patrick Venture <venture@google.com> wrote:
> > > >
> > > > Create a SoC folder for the ASPEED parts and place the misc drivers
> > > > currently present into this folder.  These drivers are not generic part
> > > > drivers, but rather only apply to the ASPEED SoCs.
> > > >
> > > > Signed-off-by: Patrick Venture <venture@google.com>
> > >
> > > Looks ok, but please resend to arm@kernel.org or soc@kernel.org
> > > so we can track the submission and make sure it gets applied if
> > > you want this to go through the arm-soc tree.
> >
> > Thanks, I didn't see those come up in the get_maintainers output.
> >
> > I had a longer question related to this patch progression -- if I am
> > moving the aspeed gpio driver to the soc folder, the soc tree may have
> > the soc/aspeed folder in their next, but the gpio tree wouldn't
> > necessarily.  I know the branches sync up when things are merged at
> > the top, but I wasn't sure if there was another mechanism for this?
>
> We can generally deal with merge conflicts like this, or you can ask
> the respective maintainers about it and let us figure something out.

Thanks for explaining that.

>
> In this particular case, why would you move the gpio driver into
> the soc folder? If there is a proper subsystem for a driver, it should
> not be in drivers/misc or drivers/soc.

Ok, that makes sense. I was trying to get a sense of what belonged in
soc versus the subsystem folders.  My thinking from the limited
reading was the purpose of a SoC folder was to contain the drivers
that were only associated with a system-on-a-chip and not a part you
could buy and place on any board.  A tmp421 sensor is just a generic
part, versus the pwm controller, which is only for the specific SoCs.

That said, there are quite a few misc drivers associated with the
Aspeed parts -- and there are two under review now, so there's a
strong motivation to move those at least into the soc/aspeed folder.
Thanks for these clarifying remarks.

>
>        Arnd
