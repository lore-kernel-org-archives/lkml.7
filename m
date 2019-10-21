Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12797CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F5D2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xIoHYOEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfJULkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:40:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43910 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfJULkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:40:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so8331976wrr.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 04:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tUXlJyf/EwF52UBQUMrINYmFP1uDjIe8LBm7MrH/x50=;
        b=xIoHYOEMyhGDXoCpQ9jHFyb0ii1+Dwvu1Q9SEfKtsUww4GbJQQy6Z+jQ8cl+fpelw3
         ThXt8MFnHE4WeoE8+UnlJTQA1ZYeRuSyGiCfFTKaC0OBBqbot6eli99dXr5TzBuwDLdg
         hv/656/7etodYAz4ZGpUNsv4u+8lHsnz3JDcP+0QvO0l0qDRgeRmohlWKezDuIXl11Ai
         bYLHo0gILQbudud59jMRUdxxPNbWw0pXm0FHqeuVlxs2z/vrj8cchV+e99cxB6Xbntp6
         Qh4S59PcwuPmISifpJ/a8LUwevqg/nE1p3vXY/gT+dfP349mVoc7XFJ3DhM7T9EHY4cW
         un/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tUXlJyf/EwF52UBQUMrINYmFP1uDjIe8LBm7MrH/x50=;
        b=qMsTJKiptUC+pupp8Z9IumIxIao0f/DtOpQ2eQ2y0WN10ohWqhk7p58lKysVlh39HX
         Ow5jGiz+sQyGsj7JTax4RLhurDJE8OyjThCQQcagIwQ5BUv+rpR6ncY2b7b5xAarA34Y
         OKLbe0lQJy8XdZYZQCGcA+J2TEI9OHclP5x2rIFUAfdYTBVWTskI2xyvAbfKwo5YBvhE
         SnuSCjlJ0WxX5qUz5yKYz8nVsazWj689YIENIrWM0/1dlCWXqCOyPg9WgkMhhPdCKUZ1
         GaJaTToCoJtaqd5uRk4z6RSJQKVYLkSx/tuP7uDF1E57eLBJoR+zXQFkvdo/pymWWsk7
         2y3Q==
X-Gm-Message-State: APjAAAXV9pvUM3WJiNlH2GGb+DoM1tLxeLa5Xfp2yURGlfj4eF0Og3s1
        5wLV6fywF/h1tgFuLYRB+WVp3g==
X-Google-Smtp-Source: APXvYqxexJrH8EZOViFVhYDgj4YbzWFLCGz4GvVoQtRfylB+aLylAjaNDXZyGLJlTyeyaGzLKfhkRQ==
X-Received: by 2002:a5d:5222:: with SMTP id i2mr14222242wra.271.1571657999840;
        Mon, 21 Oct 2019 04:39:59 -0700 (PDT)
Received: from dell ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id p20sm9851205wmc.23.2019.10.21.04.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 04:39:59 -0700 (PDT)
Date:   Mon, 21 Oct 2019 12:39:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Barry Song <baohua@kernel.org>, stephan@gerhold.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        James Cameron <quozl@laptop.org>
Subject: Re: [PATCH v2 0/9] Simplify MFD Core
Message-ID: <20191021113957.GC4365@dell>
References: <20191021105822.20271-1-lee.jones@linaro.org>
 <CAK8P3a10w9Xg6U8EgUqPLbucP3A0wc9xO_WNG06LxHrsZkZc1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a10w9Xg6U8EgUqPLbucP3A0wc9xO_WNG06LxHrsZkZc1g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019, Arnd Bergmann wrote:

> On Mon, Oct 21, 2019 at 12:58 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > MFD currently has one over-complicated user.  CS5535 uses a mixture of
> > cell cloning, reference counting and subsystem-level call-backs to
> > achieve its goal of requesting an IO memory region only once across 3
> > consumers.  The same can be achieved by handling the region centrally
> > during the parent device's .probe() sequence.  Releasing can be handed
> > in a similar way during .remove().
> >
> > While we're here, take the opportunity to provide some clean-ups and
> > error checking to issues noticed along the way.
> >
> > This also paves the way for clean cell disabling via Device Tree being
> > discussed at [0]
> >
> > [0] https://lkml.org/lkml/2019/10/18/612.
> 
> As the CS5535 is primarily used on the OLPC XO1, it would be
> good to have someone test the series on such a machine.
> 
> I've added a few people to Cc that may be able to help test it, or
> know someone who can.

Wonderful.  Thank you.

> For the actual patches, see
> https://lore.kernel.org/lkml/20191021105822.20271-1-lee.jones@linaro.org/T/#t
> 
>     Arnd

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
