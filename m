Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187A1CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0BD20882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m6pK6vuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfJUMkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:40:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39627 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfJUMkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:40:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id r141so3048805wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=R5D7lr/7jPesG94tDWWwewjuwTYhPDAmBpCs+r4T4K4=;
        b=m6pK6vuf3zpfjYZiGwMjh4xEQNU8Jky+3d+vqNeRRo4QNKGmDjFmsXBFb1dsmCDt1j
         B4qQwOXFYqtnP6AEwzy0FmeUmbpZw2XOh6hLGKvtykf2EH3bg1xs5lsviBNA6AlfDTf5
         KIq57yciKs6q4t7U2tRyWO+Yi1esIUmAFcOD28xFbEpOlDcbdMAxWrxChRzgWuqpNH2o
         BFKLudO/cihRDU+AeqZxue7IUaxBbsYA6l+NrebQm/GxybCbqZ2Hk+yINyEoNzgoJNFx
         9/w3pGmCOWz61kvGWNHDL5RRk4s3n6H0dT9eVKYahC4yQdQEu0wXYoHgT71VAT+pWhaA
         V2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=R5D7lr/7jPesG94tDWWwewjuwTYhPDAmBpCs+r4T4K4=;
        b=N/pzSk9Z/9+Ji2J4lXOMQFXlN49L5n29V3gKko+W9NBT6PZ3HI/IkejkhHhzoErOaW
         p2sgIRl7zRJEuG2JphD/LR40ibWgDl1iH/v8Zms1d6xih9tdluB98KnO42dIH+negFie
         D0FAD76jWpIfdxuwDFTKiTsJphizsUsyqX/pfGETpEvnADMK4jWgt9ewASlhNunNF4ok
         8QkBZUZNwlw6EH2UMoXP0vp6R4JqlbIGOQUBdNZ+Qi2ywfpugx9GILL2yC7kEYfmT46T
         o3Vdd/Jux/ybUHTZXduBlVIaVmKJFkPSaehrvjoq8ELQnd6oOx4HFH9hn/05OukeBjjA
         pfDw==
X-Gm-Message-State: APjAAAU89TGSrLRx9VVC6imlHDMmMVIR18hBdTUrvhV1qNWHprUJLHNK
        SdpnjbqfliUVlJfCKWw+SJj2Jg==
X-Google-Smtp-Source: APXvYqygSkjRPrINjQ872Z7i/CXf6swgTY/j+zBGNLsSdX512ZbOY6uNqpviRydt4/B1X1h1jhbOlQ==
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr19843498wmb.125.1571661629651;
        Mon, 21 Oct 2019 05:40:29 -0700 (PDT)
Received: from dell ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id s14sm1100012wmh.18.2019.10.21.05.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 05:40:29 -0700 (PDT)
Date:   Mon, 21 Oct 2019 13:40:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v2 7/9] mfd: mfd-core: Protect against NULL call-back
 function pointer
Message-ID: <20191021124027.GG4365@dell>
References: <20191021105822.20271-1-lee.jones@linaro.org>
 <20191021105822.20271-8-lee.jones@linaro.org>
 <20191021123235.royyfp4mxrvsgioh@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021123235.royyfp4mxrvsgioh@holly.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019, Daniel Thompson wrote:

> On Mon, Oct 21, 2019 at 11:58:20AM +0100, Lee Jones wrote:
> > If a child device calls mfd_cell_{en,dis}able() without an appropriate
> > call-back being set, we are likely to encounter a panic.  Avoid this
> > by adding suitable checking.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/mfd/mfd-core.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> > index 8126665bb2d8..90b43b44a15a 100644
> > --- a/drivers/mfd/mfd-core.c
> > +++ b/drivers/mfd/mfd-core.c
> > @@ -28,6 +28,11 @@ int mfd_cell_enable(struct platform_device *pdev)
> >  	const struct mfd_cell *cell = mfd_get_cell(pdev);
> >  	int err = 0;
> >  
> > +	if (!cell->enable) {
> > +		dev_dbg(&pdev->dev, "No .enable() call-back registered\n");
> > +		return 0;
> > +	}
> > +
> >  	/* only call enable hook if the cell wasn't previously enabled */
> >  	if (atomic_inc_return(cell->usage_count) == 1)
> >  		err = cell->enable(pdev);
> > @@ -45,6 +50,11 @@ int mfd_cell_disable(struct platform_device *pdev)
> >  	const struct mfd_cell *cell = mfd_get_cell(pdev);
> >  	int err = 0;
> >  
> > +	if (!cell->enable) {
> 
> Oops.
> 
> Cancel the R-B: ;-). Shouldn't this be !cell->disable() ?

Yes. Looks like a C/P error.

Will fix and add your R-b.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
