Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81043C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B0E2073C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfKOOyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:54:02 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39534 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfKOOyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:54:02 -0500
Received: by mail-lf1-f67.google.com with SMTP id j14so8235090lfk.6;
        Fri, 15 Nov 2019 06:54:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mu9+wgM6XkfzdKKlF5dXeY4gxFgiKpiiwAYwkmjc6JE=;
        b=ZnPCo376Qo53igixJIVxZMEs5cCcrcgm+E8DsKvxNBfb9wEpbZPE6wbYBXgFU6vfnk
         NGBIdc5NiV7EvjlDrzSPtlfstZ7z2hNc7AhiHXGH4JzcnHY+ZOYiSaJ7uL7sDn1jDj/U
         zAaQkYzGf25TjXMY9LZf9m3zWZBYLiNKsEgs9U2WQve4yvaPoExoLh72Os1jUkcZc4Et
         92r0Vy7wBvivG4re6ewT042Wy7/lqv5UtToUXjSDeBwvuqVTFyBVSkZgG36l9ImfYdc1
         qEVdmhr9/OXtr8BaEn3Ttnx/6Cx1omDqlFFXGD8N12W1kY919WtHmlqQZqptT6/PC38d
         7w9A==
X-Gm-Message-State: APjAAAViOoBg7l6gyw1PENSwLBsRza32ROYs7K2lFA9PbogB68MM754T
        mwwPkudq2ILCDdrAfdX5q1U=
X-Google-Smtp-Source: APXvYqzz4BwbUT//05loXmFBAG9xODwwL+gvqBNBbiY5AFUeFmm624GoMdyRIyBv85PqmAHn5nuluw==
X-Received: by 2002:a19:895:: with SMTP id 143mr11366811lfi.158.1573829639925;
        Fri, 15 Nov 2019 06:53:59 -0800 (PST)
Received: from localhost.localdomain (dywkrds9pgkw0nqj03z-t-4.rev.dnainternet.fi. [2001:14bb:490:e1bf:ac2a:25e5:b4fe:bd3f])
        by smtp.gmail.com with ESMTPSA id q24sm3901354ljm.76.2019.11.15.06.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 06:53:59 -0800 (PST)
Date:   Fri, 15 Nov 2019 16:53:51 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH] mfd: rohm PMICs - use platform_device_id to match MFD
 sub-devices
Message-ID: <20191115145351.GA13474@localhost.localdomain>
References: <20191107133012.GA4296@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107133012.GA4296@localhost.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lee, Stephen, Mark & All,

On Thu, Nov 07, 2019 at 03:30:12PM +0200, Matti Vaittinen wrote:
> Do device matching using the platform_device_id instead of using
> explicit module_aliases to load modules and custom parent-data field
> to do module loading and sub-device matching.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> 
> Thanks to Stephen Boyd I just learned we can use platform_device_id
> to do device and module matching for MFD sub-devices. This is handy
> in cases where more than one chips are supported by same sub-device
> drivers. For ROHM it currently is clk and regulator - but also the
> RTC when BD71828 is in-tree.

I have been preparing driver for yet another ROHM PMIC (bd71828) - and
the patch has been taking a few spins as RFC now. I would like to send
first non RFC version of it - and I would like to write it on top of
this patch. Is it Ok if I include this patch in the series - or should
this stay as independent change? I would like to try avoid conflicting
patches.

Br,
	Matti Vaittinen
