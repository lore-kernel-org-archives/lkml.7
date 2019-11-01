Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4E2CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5B92080F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SsOvMknt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfKAJHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 05:07:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42306 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfKAJHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 05:07:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id a15so8975295wrf.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 02:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zayuLgrU2SwBpXkDAfC9yIWopPaj/yTsmqEo3+k5o+g=;
        b=SsOvMknt1CgP4cY/63FFDv1ZR8D0n+krXXaB5s5xMmzPjmA9CkbyU0N+Ejr+ciaV13
         gR97mDAeA039WaHynZ8ezlNuHhZQpK7DX9WAu7zzrQ6a0270jypZhco6I/26gnBb2jh2
         Y5qUbR05PW9qioLG7ivWKF0bD/CUzuo0sU1VYiONAu+QAXowSbW8Fxf6KH06C6W/r2jK
         bp6z+v64ZuLc8XEj9DutDiV/dxcUXN++oy0ASMO2W98M1+gpyHAx46Ax3HGa1hz9IQlj
         sP1CDeTapR1u4KlRtlTZFoUr2PjV8hSeTspziMOPtFRzPizoOin36lQ5OFFG/NPh3lFB
         5+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zayuLgrU2SwBpXkDAfC9yIWopPaj/yTsmqEo3+k5o+g=;
        b=sSzw71KuirrOBmQvUAs+uePi0B/HarRTDyvXS6zJv1Qf+4qBhdW3E2H2a6X3UlaEsD
         u0JWx0N99FAf37B/9BH3djrFi7jXOEtgiDhzR6IAVPa+md3feLEJsKMJNwDWqSzgV0Uw
         1lwjczCx84bRy9a5VJ2sbOrcUJN/fgZd8piNSx9r7jw29wi4SoQlzDgZkzQBhEMQmTyu
         tq3nMvqdkn6QsTVbdD2auxp1elxjMSuUDRWW2tIrSCEDtMHB0vU84pCsEoChh4A6ITiB
         Aqjjp5q2qQ/I9KH+9Dmkc+16+JdI4f4pJTarFd/VQ/k7gH5cIqNtjNgULZD7lkpMjgzT
         aRmg==
X-Gm-Message-State: APjAAAWWqF7eeq2JB7FOro1h+k4QEg5uqT0FmMvu2HPzKfliN3Mz2/cU
        fFYVvuA3Lvzq3XMK8Cbnl6qREw==
X-Google-Smtp-Source: APXvYqyfoMw7OuR1oI2KzzBgFBcp8lQVObfEgf4rxJio3Ka98Rj3xERF8zwG/TDC9/tvnJDSE9vsFw==
X-Received: by 2002:a05:6000:18d:: with SMTP id p13mr9509311wrx.396.1572599273351;
        Fri, 01 Nov 2019 02:07:53 -0700 (PDT)
Received: from dell ([2.31.163.64])
        by smtp.gmail.com with ESMTPSA id n3sm6921838wrr.50.2019.11.01.02.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Nov 2019 02:07:52 -0700 (PDT)
Date:   Fri, 1 Nov 2019 09:07:51 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Barry Song <baohua@kernel.org>, stephan@gerhold.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        James Cameron <quozl@laptop.org>
Subject: Re: [PATCH v2 0/9] Simplify MFD Core
Message-ID: <20191101090751.GH5700@dell>
References: <20191021105822.20271-1-lee.jones@linaro.org>
 <CAK8P3a10w9Xg6U8EgUqPLbucP3A0wc9xO_WNG06LxHrsZkZc1g@mail.gmail.com>
 <e5e7695cc82b4370752f45082be007dbe410c74c.camel@v3.sk>
 <20191021115339.GF4365@dell>
 <ba31d7cb894cb44eacee630e56fae647922f3dc2.camel@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba31d7cb894cb44eacee630e56fae647922f3dc2.camel@v3.sk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019, Lubomir Rintel wrote:
> On Mon, 2019-10-21 at 12:53 +0100, Lee Jones wrote:
> > On Mon, 21 Oct 2019, Lubomir Rintel wrote:
> > 
> > > On Mon, 2019-10-21 at 13:29 +0200, Arnd Bergmann wrote:
> > > > On Mon, Oct 21, 2019 at 12:58 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > MFD currently has one over-complicated user.  CS5535 uses a mixture of
> > > > > cell cloning, reference counting and subsystem-level call-backs to
> > > > > achieve its goal of requesting an IO memory region only once across 3
> > > > > consumers.  The same can be achieved by handling the region centrally
> > > > > during the parent device's .probe() sequence.  Releasing can be handed
> > > > > in a similar way during .remove().
> > > > > 
> > > > > While we're here, take the opportunity to provide some clean-ups and
> > > > > error checking to issues noticed along the way.
> > > > > 
> > > > > This also paves the way for clean cell disabling via Device Tree being
> > > > > discussed at [0]
> > > > > 
> > > > > [0] https://lkml.org/lkml/2019/10/18/612.
> > > > 
> > > > As the CS5535 is primarily used on the OLPC XO1, it would be
> > > > good to have someone test the series on such a machine.
> > > > 
> > > > I've added a few people to Cc that may be able to help test it, or
> > > > know someone who can.
> > > > 
> > > > For the actual patches, see
> > > > https://lore.kernel.org/lkml/20191021105822.20271-1-lee.jones@linaro.org/T/#t
> > > 
> > > Thanks for the pointer. I'd by happy to test this.
> > > 
> > > Which tree do the patches apply to?
> > > Or, better, is there a tree with the patches applied that I could use?
> > 
> > Ideal.  Thank you.
> > 
> > http://git.linaro.org/people/lee.jones/linux.git/log/?h=topic/mfd-remove-clone-cs5535-mfd
> 
> Thanks. My boot attempt ends up in a panic [1]:

New patches have been drafted, reviewed and pushed to the same branch.

Would you be kind enough to boot test them for me please Lubo?

TIA.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
