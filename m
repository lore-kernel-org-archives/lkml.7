Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46459C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 16:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13895217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 16:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JhmzFIJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgABQF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 11:05:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50232 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbgABQFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 11:05:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so5998022wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 08:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=INDmQoNk/tJLRjiqxNPsW2gTLEyOqRnXAOa6Y+CM3Pw=;
        b=JhmzFIJCwdx9ggVuJa79e18cPxwtou1gcE2KkF73nX52YP4KJfuBKD6A9MvYxQTB58
         ZnhIgjy+uRa72LkOh/wX8AHmX1zPfwDvM2hpfzsCbUIZi/ccsvGD6ONponzCPHA2/406
         9BHfB01Fm+tcSETuQixDIKAzq+WpXxLcKg2vOMEkC+DZLT53n1NWMUGolQQu0tQSxIdd
         zr6eTSmrAxXpOS/Q/51yb93kLZsvvbmjVOyiQYQj4lClGK8OPiMQyfY2m6+7z8H9KeDK
         XBpF6baVTfB61xHzqc3d/ze4fNF2Upt6T/lijlv5QSLL6V1VZumqs/lvEFGwT5OKOT+w
         6K6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=INDmQoNk/tJLRjiqxNPsW2gTLEyOqRnXAOa6Y+CM3Pw=;
        b=c6gAiX5FJRXGMX7v3961lUOmp1s+XhR5qh09SQj1a518Nvg8UQ4JTbD4kfZ/59Zpzg
         FRQ0EBD3DMD8ZoErvoJKMmoNtUI9W/ndgaIjsP8u1VKUYWCeT0IXZAIo3OaCOQjPYbc8
         xTssn6eZWG13QCqluRquThDuetB+9nTPp/QxJK/N8+xoXg+nx1RG7EU0WOHt4c6hWQYx
         qI5HZ1KWaETELOglzl2vU6UG5MzW+AgSnQ2b+XZKUIJCPd0QEzcjs5Jg9mfIC9uWjlPM
         e+qb6URQzoIbaHsLjHF0YHXLjYbWGzp2Ld0eupuDPXtI9gxz2NQFgEeSB9V0SHL/pLtk
         +X0g==
X-Gm-Message-State: APjAAAVV+4zbMhg4JASEj+jfNl0PztHY+WT1tvyRD491z8EEjTWqfBto
        cDWDyiewZyBcA9ESklJccmbD1A==
X-Google-Smtp-Source: APXvYqyEivYwaP2ns3ILcszz/Grz4Of7NPSptL4+RXbkbFEpLOYTTlIS/61sIXEmkPh/gB/NCcDmKQ==
X-Received: by 2002:a05:600c:d7:: with SMTP id u23mr14220226wmm.145.1577981123996;
        Thu, 02 Jan 2020 08:05:23 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id t125sm9077685wmf.17.2020.01.02.08.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 08:05:22 -0800 (PST)
Date:   Thu, 2 Jan 2020 16:05:34 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        boris.brezillon@bootlin.com, airlied@linux.ie,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        peda@axentia.se, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] fixes for atmel-hlcdc
Message-ID: <20200102160534.GJ22390@dell>
References: <1576672109-22707-1-git-send-email-claudiu.beznea@microchip.com>
 <20200102090554.GB29446@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200102090554.GB29446@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Jan 2020, Sam Ravnborg wrote:

> Hi Lee.
> 
> How do de handle the two mfd related patches?
> 
> > I have few fixes for atmel-hlcdc driver in this series as well
> > as two reverts.
> > Revert "drm: atmel-hlcdc: enable sys_clk during initalization." is
> > due to the fix in in patch 2/5.
> > 
> > Thank you,
> > Claudiu Beznea
> > 
> > Changes in v3:
> > - changes dev_err() message in patch 4/6
> > - collect Acked-by tags
> > 
> > Changes in v2:
> > - introduce patch 3/6
> > - use dev_err() inpatch 4/6
> > - introduce patch 5/6 instead of reverting commit f6f7ad323461
> >   ("drm/atmel-hlcdc: allow selecting a higher pixel-clock than requested")
> > 
> > Claudiu Beznea (5):
> >   drm: atmel-hlcdc: use double rate for pixel clock only if supported
> >   drm: atmel-hlcdc: enable clock before configuring timing engine
> 
> >   mfd: atmel-hlcdc: add struct device member to struct
> >     atmel_hlcdc_regmap
> >   mfd: atmel-hlcdc: return in case of error
> 
> Would it be OK to apply the to drm-misc-next, or shal they go in via
> your mfd tree?

How are they related to the other patches?  Do they have build-time
dependencies on any of the other patches, or vice versa? 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
