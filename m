Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E54C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721E3207FA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9tGQr8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfKORGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:06:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55680 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfKORGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:06:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so10369313wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 09:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Y5MJHqtNtFIobgpfRZOfB8CZPQUSZcxswGUH39N9I+Y=;
        b=S9tGQr8sq9mcB88XNynEsu81GzPnWcU38nGxFcNSXIQSQYIwXg3NR1sLRBOIazMlk6
         u4BMzkjir18NpNODSq/icnrCvO6/qnAXwYU7LyQlnV+V9QAa/9JG5GvNe51ssC40Wjmv
         O/r5SkjFmoYTRzrqsmN9aJKAEToFRtsBa67sfNMzw0iuNVaMjHYB7p2XFTeoWACjN4B4
         gxk2RZ/+aBG/UkF1HNihPVwI0bitmPtvKvJGGQod2IjHbEO58kfMEZFunievsA8Hhy9O
         B2u3inoUXHCSUPU24SqaiP7nWYGkItt0Ld+21yOW1aCXIPQ5Q8xHKu95f6Hl4Arnc7Nx
         /v4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Y5MJHqtNtFIobgpfRZOfB8CZPQUSZcxswGUH39N9I+Y=;
        b=KhIAerUDVICotO9WCuWSLzuPnhEo7t+lcEDf8Z0j9Mhc5gCOYYvb/vpiC3pnqFdlzN
         mdLKV6FjivTkK1rxwc0tj6i94IgtEaJPWt/AGBeKxxm8HBfg8jbgpHdWp5tP0E3STf1L
         CH9wEou1TTdGjMhshtDiyRP8aKuDsJRQvKH/MRlb0Yr5b8ARq7p06WPhqk6JGJ3Mkw35
         ecPVTDbdUtQG3eeNX0TchYHV/mVp4lPPhIdFXWLIDbvRYacBCgA8fkY6ghKJgH+prbDj
         p5J2HzrVwrGwWB7jjhvc7cO1aJnOsWeMIa2MUGuylJ+cEmaOu7N8A+TJRqf5q3uCBrH7
         35KQ==
X-Gm-Message-State: APjAAAUxW1u7kNGyZMYKZoysfcMc4+EjpoIf+x8OCCcloI6puUD8KfE1
        vffktv9BtX/rD/tMsClyG6HYLg==
X-Google-Smtp-Source: APXvYqy36u9K+MsHIXvLVgvEkw4C5fLut5weG0W/PtPuyvUyrk/8Id9YPCu3owUcjWzJvNlYhAFg5g==
X-Received: by 2002:a1c:1b07:: with SMTP id b7mr16015477wmb.111.1573837590783;
        Fri, 15 Nov 2019 09:06:30 -0800 (PST)
Received: from dell (host217-42-66-89.range217-42.btcentralplus.com. [217.42.66.89])
        by smtp.gmail.com with ESMTPSA id d20sm14215913wra.4.2019.11.15.09.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 09:06:29 -0800 (PST)
Date:   Fri, 15 Nov 2019 17:06:15 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH] mfd: rohm PMICs - use platform_device_id to match MFD
 sub-devices
Message-ID: <20191115170615.GB24158@dell>
References: <20191107133012.GA4296@localhost.localdomain>
 <20191115145351.GA13474@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191115145351.GA13474@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019, Matti Vaittinen wrote:

> Hello Lee, Stephen, Mark & All,
> 
> On Thu, Nov 07, 2019 at 03:30:12PM +0200, Matti Vaittinen wrote:
> > Do device matching using the platform_device_id instead of using
> > explicit module_aliases to load modules and custom parent-data field
> > to do module loading and sub-device matching.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> > 
> > Thanks to Stephen Boyd I just learned we can use platform_device_id
> > to do device and module matching for MFD sub-devices. This is handy
> > in cases where more than one chips are supported by same sub-device
> > drivers. For ROHM it currently is clk and regulator - but also the
> > RTC when BD71828 is in-tree.
> 
> I have been preparing driver for yet another ROHM PMIC (bd71828) - and
> the patch has been taking a few spins as RFC now. I would like to send
> first non RFC version of it - and I would like to write it on top of
> this patch. Is it Ok if I include this patch in the series - or should
> this stay as independent change? I would like to try avoid conflicting
> patches.

You can draft this patch in.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
