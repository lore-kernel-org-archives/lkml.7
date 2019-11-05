Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD09C49EAB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06DC217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Svr0IOsn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388497AbfKEKRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:17:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51744 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388154AbfKEKRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:17:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id q70so20171794wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 02:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fNwu5Brajivr2NZ+53CyrBT2A5quV+LusyMm1pW2iI4=;
        b=Svr0IOsnkV9uVg/wKUTFvPy0qCkSTYOZs+R3aU79Dp+7ujp/ZXBprGDTPc0rLHfI7s
         VXryGU7kIKqHDwe5tREK11WYlbZq4eWm3Kc2rtO7mC+OpAWnx4dlQKjg6NEfCRyLa5ea
         bLew8FfugD4c6fjaiQY+vFWl9Z1poGasldw4clK9AQEJxMgQ4KxSTmV5PKOdZYCmwfPV
         9i1t3A/3UK5mO6Trk1Skr6MyslHPEnuzjTWerWmFz20fGmbsaoe1u5HC2DI4sPp8xukM
         yfMq8tdIjgrLh0cCpwnPQRm+X9bEDFydYxFRKXammO4Kq3Kw0D6cJhX5XpaNlE4VInNV
         itfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fNwu5Brajivr2NZ+53CyrBT2A5quV+LusyMm1pW2iI4=;
        b=NRycaUTLRzhauIdVTUlCqbK9nfpxxhOp532p8iOYvHEscxUbls7Z73uWzNxBiP0J+a
         ZfLwLsAfihou+s78aruYVufT+HFzqzvowvmRn5dyJlTeTCAEoXHXHEq+7d/UnaZOmXN2
         Ohg2EAcH/+mCbUVC/gpZYOEIAEIW3JP3+yR6banFT3l93cds+iK/qPdtAmX6+tmGc5a7
         HVOrQPjVuox5qNcIpqaHTu+XfCtGSv8dCwJIjHp2pUK0Yu2GsN4b3ogZR9hC2k2fgFJ9
         Kr5Q+K509FbUL1b7LcwQ1SPKSr6ZkorNBFcvBjblXeQn1N6WfkGdtE+6RHs87AsSqcq7
         S/jA==
X-Gm-Message-State: APjAAAU3Ks5a5sIhXMSQEzTVvAsdH7SRQ4RYLzAZu1Jyt8U9iN12WpC1
        K0t5t/USvnqZjGCcxsNREBzrJQ==
X-Google-Smtp-Source: APXvYqwco7NI1yNgZpp2/qpqSq4V+HjXy7jIUynHKwu8FbE4cdXYH516yi26h8p96gVT/T4eKt2BBg==
X-Received: by 2002:a7b:c5c9:: with SMTP id n9mr3623783wmk.94.1572949066778;
        Tue, 05 Nov 2019 02:17:46 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id d2sm25272593wmd.2.2019.11.05.02.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 02:17:46 -0800 (PST)
Date:   Tue, 5 Nov 2019 10:17:44 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Subject: Re: [PATCH 38/46] video: backlight: tosa: use gpio lookup table
Message-ID: <20191105101744.kzdpopq25slbfuue@holly.lan>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-38-arnd@arndb.de>
 <CACRpkdajkSh6Bbvpfycm83j1GuCm+pTfw9fQS53JEfG2i07MKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdajkSh6Bbvpfycm83j1GuCm+pTfw9fQS53JEfG2i07MKg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 11:04:44AM +0100, Linus Walleij wrote:
> On Fri, Oct 18, 2019 at 5:43 PM Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > The driver should not require a machine specific header. Change
> > it to pass the gpio line through a lookup table, and move the
> > timing generator definitions into the drivers itself.
> >
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-fbdev@vger.kernel.org
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > ---
> > I'm not overly confident that I got the correct device names
> > for the lookup table, it would be good if someone could
> > double-check.
> 
> You're anyway doing more than required for the people who
> may or may not be using this platform. Brokenness can surely
> be fixed later, it's not like we are taking down the entire Amazon
> cloud or something.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Same here. I read, I did't see anything wrong but I can't test.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
