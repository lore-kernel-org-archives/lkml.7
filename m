Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633D2C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296942081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gT01dcZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfCGRMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:12:55 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36766 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCGRMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:12:55 -0500
Received: by mail-ua1-f67.google.com with SMTP id e15so10443020uam.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 09:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GJttKmZ86M1cNsEb4ZAgihVD13fIgqGm+JiJZjTDdp0=;
        b=gT01dcZxggRLrOaGDUfYG/Fwp6L1NkWCwPd41T6+lc7JIugh7ItGZFNTAS8cZZ8YwW
         pTffBpCgT3HIgEtwAu2/B1e3/hOvpy0Y7h1d/uzdi7MCzvu3lTNjGXfyKenkxaedWDEW
         Xd35m09J/sj53jTi8C5TkknKLiOaCf+ppXQjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GJttKmZ86M1cNsEb4ZAgihVD13fIgqGm+JiJZjTDdp0=;
        b=nU0vlFDfTZLYf6laadpbuqAqGQYDCYlJkU07HN0xtXy949YS5MjQCq9EZgTQDd/cxv
         gImGW9Yu/NoMO5EIxNtSNT1zrxiLpG35bnie9QqEI2hsEerIusESZ3TCGlBbrGoTiAjr
         5M6tmuFY9BJSirOiy8t3pgjeV5DtY7lybPz9Kd6YRW0BAZYyP4cCXGnpoPTb0250d2nL
         RdXshcJjHVVqtZZbdMNB6jMOtsYEVEI4wglgO0ZS8qQl+IfQnB71D3aSwSp/vP7JO19S
         nSxbRQwRIZceZ5tUNKfQAFMw0L+RA8ARd4cEqpcDK1xf26JqZhgAkstCOC7RKuGN+Hwo
         O/Gw==
X-Gm-Message-State: APjAAAVGnqCO3XiReb5doWCrPSDCqCLaNN81kbu1H801ejt3KMJmhVzF
        deZjOeSRBkHa2bSeohLRnNR6nKOYTf4=
X-Google-Smtp-Source: APXvYqyc7CXYoYDO0w76qLppSSE2BfXw2LZgF0VxL9U55t//3ytctRCGJ03jD7Vu1Tk6G8ERSmGkhg==
X-Received: by 2002:ab0:6299:: with SMTP id z25mr7511283uao.69.1551978772893;
        Thu, 07 Mar 2019 09:12:52 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id a9sm1495023vka.51.2019.03.07.09.12.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 09:12:52 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id f88so10441057uaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 09:12:51 -0800 (PST)
X-Received: by 2002:ab0:6556:: with SMTP id x22mr7380981uap.10.1551978771436;
 Thu, 07 Mar 2019 09:12:51 -0800 (PST)
MIME-Version: 1.0
References: <20190307010153.81157-1-bvanassche@acm.org> <20190307012417.GU1758@mellanox.com>
 <8a5bd9ae-ebfe-687c-2868-d0f2a610d1e0@acm.org> <20190307072428.GJ1789@mtr-leonro.mtl.com>
 <4d90c392-5b6a-fea0-e6cf-c49ac19fdf30@acm.org> <20190307154020.GN1789@mtr-leonro.mtl.com>
 <CAGXu5jLBPpKOT-NV1P0nuFeSQYfoNY_8B0V4gcQg18xHPUVbhQ@mail.gmail.com> <20190307170230.GR1789@mtr-leonro.mtl.com>
In-Reply-To: <20190307170230.GR1789@mtr-leonro.mtl.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 7 Mar 2019 09:12:40 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJDmEFA7=WuDnr0U6t9BTDFtd_WsB5HeryNKoZSaBW8oA@mail.gmail.com>
Message-ID: <CAGXu5jJDmEFA7=WuDnr0U6t9BTDFtd_WsB5HeryNKoZSaBW8oA@mail.gmail.com>
Subject: Re: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 9:02 AM Leon Romanovsky <leonro@mellanox.com> wrote:
>
> On Thu, Mar 07, 2019 at 08:52:51AM -0800, Kees Cook wrote:
> > On Thu, Mar 7, 2019 at 7:40 AM Leon Romanovsky <leonro@mellanox.com> wrote:
> > >
> > > On Thu, Mar 07, 2019 at 06:53:54AM -0800, Bart Van Assche wrote:
> > > > On 3/6/19 11:24 PM, Leon Romanovsky wrote:
> > > > > My simple patch passes too :).
> > > >
> > > > Can you repost your patch?
> > >
> > > https://patchwork.kernel.org/patch/10841079/
> > >
> > > As Rasmus wrote, the thing is to avoid a < 0 check. In my patch,
> > > I converted a <= 0 to !(a > 0 || a == 0) expression.
> >
> > I'd be happy either way. Is there a larger benefit to having a safe
> > "is_non_negative()" helper, or should we go with the minimal change to
> > the shl macro?
>
> I personally prefer simplest possible solution.

Acked-by: Kees Cook <keescook@chromium.org>

Can this go via the rdma tree?

-Kees

>
> >
> > -Kees
> >
> > --
> > Kees Cook
> -----BEGIN PGP SIGNATURE-----
>
> iQIcBAEBAgAGBQJcgU6mAAoJEORje4g2clinE94P/0pHFmUgwzRrVLxjqmnynNPC
> e+azQISKrZ4EBI5Is7VwFJuxtiZvsTveCxX0NpRxk3TLfHbA4V9jz4meJ6smp4UQ
> Z1uRnPbj2z5iucFN/8SelQvNTmqfvbuRSKpZ08XLxBB4XIAjFaNBbmD+REe7iSGD
> xiYNp96oHvKnzGZq/eViqz0rogewsTLHoEBwDkfgyDIqwO0/3qVElNhW7Z6g/v/7
> 2D4yZiB82wIBf+00taEQNnpI/3naVvqdfl34iYGuq51Fd2S36lfmMZ1DUffd/Eq+
> jRq8PiNisFK+0A/96hwi2npVN0LS4tA5at6PHhqOfVxMOt/XAmeKu3cCaxHhjbfb
> Oi2+X9/EBDdgVmylssQFwjNaLuXB00109IVDcQGgzTsN8xoTNiwla8gt3fVhDWt+
> X0jQuSnqtANt75/0mucirBoUppCB59aZ9ygolWe4UwBpVV0ZGH/0MFwcOhlpglGB
> PbrKaTxP3qQeil8wGXQsJyPGOCLBGh1Qj0C6NG1wsJSX/Zq8awEoz+JlYCXezaq6
> 4R0jSHu50BGp7gt5iePRGeUhjPFVGHucJZ2b6fuDZ3ARN8MtQYmrYDyRqnFJZsCE
> UZFd4SZ8UzfIETd17IowOmOs62HwXyIi1WzoWjiHsNjH2dxwiB6Lh1JBvAFQgzJ1
> 0wRa0DMnyLzmIoOdyvQm
> =NFtk
> -----END PGP SIGNATURE-----



-- 
Kees Cook
