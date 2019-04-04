Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AB0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC1320882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n7WADhpe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfDDHEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:04:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42796 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfDDHEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:04:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id r15so872999pfn.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 00:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1x1za49zgtXlRBj1jjBd9xTQtHxTAwIG3nNp8uNy+Ok=;
        b=n7WADhpey5JLb+2igSpqhpLheFG8QWl40JaltcKCGiyQDq1BzDu9LdV26PgjVFP8xM
         L4d+MPWVwmJPgODKETgjk85rg8EtLgoGOlAGfE8x65Vea3ExlKc0UYKzfTfh3oYYL8cz
         nwA9609enwJYdIEJreISe7/WORlYDVDRvnPMfewmzIn6Z/VbceezAg305Nz21ivHsKz1
         IW8F09fW1oKZjKUr21pIpz/Kg1sYJjKnqmcYCgBNJJKCNN8paGl76z5VyM75phq6PBYX
         X6qusAKtlBEi2+zLpPiVK6ZkCjuaEgXp0LkY7y++l6ANtAiuZzzTz8QlLeX84vYW1KV+
         +4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1x1za49zgtXlRBj1jjBd9xTQtHxTAwIG3nNp8uNy+Ok=;
        b=n00+QPBsJb7jylF9kmCf/HL9esOsaJ3qjS5eDymWsngE9GG6qn8L1CSYrg7aj+8X5F
         UI2g1LqrZLhYTpfeFNv8yRXS7g+6sOsRGWU4Q/7tOhRr/L24QWdE6PhRjPpFqHUGU4Ns
         1IluJv1k4KNUQVBG8Li8b4NmreYbUEHo7hhuqIn0ir0yRu9ZuAa1p/wzbev1Fj58byb3
         UqjCuNSbboWUiD9qpxWF9E7te25hAgjVYQxw6UV2Sfu+0PoYSgX3ZxKYSW1JICEVYD3H
         BfvTeDtcFNCfGFxO3NIeD4RQ6MTEiwbI3S0GV55UnxTaVEGm+EZYW+RzLRXJQDUi/2MZ
         pXJw==
X-Gm-Message-State: APjAAAUgT8EBxxc7XgcD5/oCJR/nMNDYlSzr+ngFSg3lqDPoGO8GsOLI
        C18id6/sQ1ZQ72kh7LCYvQp+eg==
X-Google-Smtp-Source: APXvYqz6TCxrrzG6pS1LmyKsolsrnARq+bT/qBApUmQOHId3fLsQvaQ9K61PxYYjDOXV7soq5YnJJg==
X-Received: by 2002:a62:292:: with SMTP id 140mr4222720pfc.206.1554361487870;
        Thu, 04 Apr 2019 00:04:47 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id h65sm47908048pfd.108.2019.04.04.00.04.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 00:04:47 -0700 (PDT)
Date:   Thu, 4 Apr 2019 08:04:41 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v8 05/11] mfd: core: document mfd_add_devices()
Message-ID: <20190404070441.GG6830@dell>
References: <20190403090108.24788-1-brgl@bgdev.pl>
 <20190403090108.24788-6-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190403090108.24788-6-brgl@bgdev.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Apr 2019, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add a kernel doc for mfd_add_devices().
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---
>  drivers/mfd/mfd-core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
