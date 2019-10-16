Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DC3FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED9D20854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZdZfTpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392085AbfJPJs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:48:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54815 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392065AbfJPJs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:48:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so2151170wmp.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 02:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iQTEy8UXFGNr/FdOe7iND6VR46p8IWrfWOuMln2JTYU=;
        b=ZZdZfTpiIUaMrIV4BWVDOdaeQMZ8BQi3QI0QA/5kmySHz6rxYJY1Rv1AhnjnRIbW0O
         1l8+DsY7UcFfVmPqgzyacq8wAxP+EX9rdn6ANCLfyOX7bQ3ix5aob9VGT3W+MiZ5n8s4
         xdFD3YNihzyzclsQ27U3NbNfKak8IG+bDWtgMxOmVrxS+4zZz+7eHfAearIPVx7O4e43
         wIf3P2Za2RUKrK3pZ4iSy98Y4+K7ubRXRPHo/hRmzm4C8mQcUq9NMKG+eEU89YY9kfoE
         4KX2NJ7NO24fPm9g45BDPKOGOJhYjCh9ikZ4C5gVw4BVE3GRacyMQsz3FEWMU7U/V7+n
         YmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iQTEy8UXFGNr/FdOe7iND6VR46p8IWrfWOuMln2JTYU=;
        b=KikdTyteH9OYcQGbEiXGTMY49XLyh/8M2TrP8JABltAicb9PzbSLy/kuNDZix+yUws
         t90z/p0F2GpCWL51xOoLA0aGKr65761y2HLScgNuiauM0wOyeNjnomVSi88FRDECPgQe
         ujwcKBvic5ExG6bEfmh/1xLcFtS0HKCH3Gun0KsgVJoF/X5xWKnzrIjBaEP8sw0OSSbm
         QFL50OXhPCflG2HwPSlGEEbwbHCpFXmMmnBb7ND6O7puqXuATR4K3dJAh+IYh3UDJz/u
         5xmLk1SMtdTvLhTvwJojHm3dHFiUUwnW8abH6k7xVfGu284xQzqgU+hwOIeL4NnmEaKb
         gk4w==
X-Gm-Message-State: APjAAAXWpjN+on8aJhuVbtxWGtxa+E36yQsV2sC0ok4u1a0Sn0Px0Ang
        NG0roR6SZ8Mxl67TRvy1cMXqRA==
X-Google-Smtp-Source: APXvYqxXlPXCL0knKbkdHTjpJOD+EZQvj/zxHayInG5YUOAEsEwDnXPfuddylcztatyogiSWvF9X9g==
X-Received: by 2002:a1c:1bc5:: with SMTP id b188mr2685843wmb.164.1571219334851;
        Wed, 16 Oct 2019 02:48:54 -0700 (PDT)
Received: from dell ([95.149.164.86])
        by smtp.gmail.com with ESMTPSA id p85sm2163443wme.23.2019.10.16.02.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 02:48:54 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:48:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: arizona: switch to using devm_gpiod_get()
Message-ID: <20191016094851.GC4365@dell>
References: <20191003002832.GA13466@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191003002832.GA13466@dtor-ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Oct 2019, Dmitry Torokhov wrote:

> Now that gpiolib recognizes wlf,reset legacy GPIO and will handle it
> even if DTS uses it without -gpio[s] suffix, we can switch to more
> standard devm_gpiod_get() and later remove devm_gpiod_get_from_of_node().
> 
> Note that we will lose "arizona /RESET" custom GPIO label, but since we
> do not set such custom label when using the modern binding, I opted to
> not having it here either.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/mfd/arizona-core.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
