Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85251C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DED621783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HRefi9sb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfJASnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:43:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36886 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfJASnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:43:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id y5so8689872pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 11:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wOlYko7NkoTZki/CziEJgME03XS7kkXPkXPHoWO1dek=;
        b=HRefi9sbT2b8lKM1WA3enIvk00lwiNRmnkNkKSSjyabgnBjMrPgZ5KhzSXRskxRsKd
         QPiV6aRNC/atiPa5n4nqYGou7cgzn1B+N2aCxqv4Ffq+jtGGeoZoretuydUH967g8Pj2
         yL5S/SJ34sS0JfgIGx00jUUmcACqxYwQ8nTgE0U6LGDKhGzYfYoFqx+AfKd/seDQZENB
         a6xEN5oxCFehW8GtdPFZwuRF+LDNLGrqfg3C8JSUhM357Kg8XNh9Vl4w2fMZmDZI+i4y
         yQCRbVcp65ztpPn81L6u4KxYTwdenOBjLvmYHG/3tCRwGM3uT9VgEtnrQCo8+3dy0Gpn
         6ASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wOlYko7NkoTZki/CziEJgME03XS7kkXPkXPHoWO1dek=;
        b=b+5bcOd0YumJvY7pkzZ7G2uK6rf7WgeKFHZS8TtDQF7D6CvJrKsBET6pQJqsFQrEAi
         HlEg/09eoOIiz3aHjBkDiXIiH7EgWwuP1I6K7PYj0RVPuS/rJJDMOqR9nBrvjKwX6a6e
         kvzc7jwug6d2gQXaug0FdMLpRG4EPoFjgqFS3G7muvrY3kPn/H1o91ZJVlSwgHZITJpG
         bVBWuPvJqiAt89jy9lvVfN65TDTSBEsqJnjmcwYiIFMA61MolFxpnhk3Liaauid/iEVl
         SPFpZeaAPIR2AAs3s18yBwxs9o5Wc3cEdLXaaEw6fkGZG4rwndY1plx26sisC0iBqdmq
         yLyg==
X-Gm-Message-State: APjAAAXc8DI1BzRQk3ndVtvpZjxfUCkVjINkooffNYkZA/bkikjFVl8z
        Aapb+T7nczb4wh5OiW6EXTo3
X-Google-Smtp-Source: APXvYqwLF+mpra8npi1MtsuyWuY9HY6bRBWMk0uyodiiNMMhRMbM1EYftY19y+KeALm5cn5na/b0Qg==
X-Received: by 2002:a17:90a:1150:: with SMTP id d16mr7411913pje.2.1569955398457;
        Tue, 01 Oct 2019 11:43:18 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:631a:1d56:6a:8714:31a4:1f8])
        by smtp.gmail.com with ESMTPSA id q33sm13274538pgm.50.2019.10.01.11.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 11:43:17 -0700 (PDT)
Date:   Wed, 2 Oct 2019 00:13:09 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com
Subject: Re: [PATCH v3 3/3] MAINTAINERS: Add entry for IMX290 CMOS image
 sensor driver
Message-ID: <20191001184309.GB7739@Mani-XPS-13-9360>
References: <20190830091943.22646-1-manivannan.sadhasivam@linaro.org>
 <20190830091943.22646-4-manivannan.sadhasivam@linaro.org>
 <20190923090752.GK5525@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923090752.GK5525@valkosipuli.retiisi.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 12:07:52PM +0300, Sakari Ailus wrote:
> On Fri, Aug 30, 2019 at 02:49:43PM +0530, Manivannan Sadhasivam wrote:
> > Add MAINTAINERS entry for Sony IMX290 CMOS image sensor driver.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  MAINTAINERS | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f7c84004187d..0ee261fca602 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14962,6 +14962,14 @@ S:	Maintained
> >  F:	drivers/media/i2c/imx274.c
> >  F:	Documentation/devicetree/bindings/media/i2c/imx274.txt
> >  
> > +SONY IMX290 SENSOR DRIVER
> > +M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > +L:	linux-media@vger.kernel.org
> > +T:	git git://linuxtv.org/media_tree.git
> > +S:	Maintained
> > +F:	drivers/media/i2c/imx290.c
> > +F:	Documentation/devicetree/bindings/media/i2c/imx290.txt
> > +
> >  SONY IMX319 SENSOR DRIVER
> >  M:	Bingbu Cao <bingbu.cao@intel.com>
> >  L:	linux-media@vger.kernel.org
> 
> Please squash this change to the first patch.
> 

Oops, looks like you already said this in previous review as well. Will
do.

Thanks,
Mani

> -- 
> Sakari Ailus
