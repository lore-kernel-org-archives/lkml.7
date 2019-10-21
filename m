Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADEFCA9EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CF52064B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eG9C2g2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfJUGQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 02:16:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42785 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfJUGQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:16:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id f14so7090534pgi.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 23:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z8AislL9bBizOL/3zmH/pFdDSRFzv2U9ezQYDPpf/uY=;
        b=eG9C2g2A4PaRfDjkuUYycqvHLpwFwwXFoIHPEJB4S4aqUilQqRiRg5/brU94N70PeD
         +XbbwDmqAiX+M0nZWiPdZ0r1qUm3xvVo2fsi3TL1IMD9cwuZdQeu1BhWWWD3vazDac0O
         z1Buvm/bypyjVu5q4P3no2LuGvFRpIYNywAetJM8+Gu75G5kIkeStD/j2p7kWv+r2ji8
         911oMY2QK9mqZi22+AJOBF/2NTC59N97cofnI1NMRIOMHtRMcTjpRrZRIzalyGpKHNhp
         Gzw/APURFJ/dMAvGQ7oXi5ITYR04qndf6BcxFQOZ1srgtVPMKwqf58nuZdyTkeaSD2O+
         FPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z8AislL9bBizOL/3zmH/pFdDSRFzv2U9ezQYDPpf/uY=;
        b=SJKeos7l/FXaor3nP00ilhoYD7yZlDQdOAaiC1RRULk2ddUdVkpmcxOQZzBgw8HOLj
         3hJYBf8+TPC3vwUekXCq/enKYy1YXZNdbRzeyiWk3fI3Xipj/v76b6uuRNib5iY5RhdD
         9HIgOZlAPQAODKl4sYU0j0IJ1FXqXZytYmIifuBY2G4u6GNvrd01V8hWeTjoW4Pqbtau
         3HTAkjwmAmbWj3S45Tb4wUkULdoE6tNytZQGUvnZpPergn+icVcdc4GmOth8thwfKK35
         +miKYXJ8THmavOzPlxWhva6KKkuBE4eMEihB5EQT9Y85OKQRtdjxS4CqQWE2dxpgDRBZ
         DcJQ==
X-Gm-Message-State: APjAAAVYdBYQc74HT7hlvVrTlAPi/+50wfOSSWdXtOKC5B8V7Afvh9GQ
        IQO8gL3lCLA7CLi38+BP79H8
X-Google-Smtp-Source: APXvYqzq3YMDZBcNbZq7GPKnRRFgy2SO4k0a07WKf/88S3YXLlZv9fCcV5ut+NIOUDsG42YN1kRNVQ==
X-Received: by 2002:a63:ea48:: with SMTP id l8mr24258354pgk.160.1571638560579;
        Sun, 20 Oct 2019 23:16:00 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:700f:8db6:2442:890f:ac37:8127])
        by smtp.gmail.com with ESMTPSA id a13sm16828601pfg.10.2019.10.20.23.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Oct 2019 23:15:59 -0700 (PDT)
Date:   Mon, 21 Oct 2019 11:45:51 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-unisoc@lists.infradead.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: gpio: Add devicetree binding for RDA
 Micro GPIO controller
Message-ID: <20191021061551.GA12001@Mani-XPS-13-9360>
References: <20191015173026.9962-1-manivannan.sadhasivam@linaro.org>
 <20191015173026.9962-2-manivannan.sadhasivam@linaro.org>
 <CACRpkdY3OC675EjZ4PYhYxnk1XWh4EO-a3JJBha2rdBttySUNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdY3OC675EjZ4PYhYxnk1XWh4EO-a3JJBha2rdBttySUNQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Wed, Oct 16, 2019 at 02:27:44PM +0200, Linus Walleij wrote:
> On Tue, Oct 15, 2019 at 7:30 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> 
> > Add YAML devicetree binding for RDA Micro GPIO controller.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> First: this looks awesome to me,
> 
> Second: since this is kind of a first... could we move the standard GPIOchip
> YAML business into a generic gpiochip .yaml file?
> 
> We currently only have pl061-gpio.yaml and this would duplicate a lot
> of the stuff from that yaml file.
> 
> If you look at how
> display/panel/panel-common.yaml
> is used from say
> display/panel/ti,nspire.yaml
> 
> Could we do something similar and lift out all the generics from
> gpio-pl061.yaml to
> gpio-common.yaml
> and reference that also in the new binding?
> 
> If it seems hard, tell me and I can take a stab at it.
> 

Eventhough I really want to help you here, I'm running out of time
(and you know why). Let's consider merging this, and I'll come back at
it later.

Thanks,
Mani

> Yours,
> Linus Walleij
