Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D39C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1ADA2081E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578349091;
	bh=+ZtFHVJgJdebazmciUA6EV//BMPwu4bxNtkQZIP6C8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YztgWwoCUrKVT9ab2PnDizC4+5KbX/xoLhs8KCit6BWXyeHyOUpGbvKYS7z6qb0/W
	 jZwAT00h8OOTdqoD3avuOHBr28CGd2/AgnClDo6eKAW0m6yzOVbBpkeHlcUs3HaS21
	 SpA8yVMmWn77S2h+XDUKZgY844W4DDRHkYZVteWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgAFWSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:18:09 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43046 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgAFWSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:18:08 -0500
Received: by mail-oi1-f196.google.com with SMTP id p125so14809389oif.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 14:18:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qa6q9QR2d6sy+ufZnpcE6vi8U62kVIxetSaKdt5u+KI=;
        b=TDzaLU/h7s/GwkIK3G1CWbwOs/H+aIPkYpvA1BnwTQ2AWnm41N3wEUiJNqyjUuwwoO
         iwmSaNRzxQjcLgQr+S+Tdgbq6akpmZtGBR9bd+N0B39M9mOoPG7EgIWHPO3kUkreNblC
         BNNJCd88XSypY8drOJY5MUUGca9KftbutxRnBrjbveaml9GsgFfg7cY7bV0XNqKzs6Ai
         p62Q5kmlPqGK5JDgRZEdJfG/ZFv05bbI0zOWz9xpMx7bbQ3NsWDJvE8Zev+hyH3mmLKH
         n+WIhiJb1+mLwePtYCDrvnsSNkgMM3oJlQpafQh2eE+hzK9qU+DvWAYrC3ilTXHGmzeV
         XNgA==
X-Gm-Message-State: APjAAAX8luGhfX4/OX+4Luep1967OqJ7lPKkgbkkmKMlsAxfNsz1EqK2
        ySBP7FhlvSc0cGcRjJwnmDw7oyk=
X-Google-Smtp-Source: APXvYqxh21NTqM/8tdadWlefrZYmpjLx/kKgfc8D7yWL15iMcrCjPSzd68NcKpPJRJloUbGk/nZKJA==
X-Received: by 2002:aca:cf83:: with SMTP id f125mr6251513oig.15.1578349086755;
        Mon, 06 Jan 2020 14:18:06 -0800 (PST)
Received: from rob-hp-laptop (ip-70-5-121-225.ftwttx.spcsdns.net. [70.5.121.225])
        by smtp.gmail.com with ESMTPSA id j20sm24475338otp.24.2020.01.06.14.18.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 14:18:06 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22043f
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 06 Jan 2020 16:18:03 -0600
Date:   Mon, 6 Jan 2020 16:18:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     jassisinghbrar@gmail.com
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: max3421-udc: add dt bindings for
 MAX3420 UDC
Message-ID: <20200106221803.GA1555@bogus>
References: <20200105225509.21590-1-jassisinghbrar@gmail.com>
 <20200105225547.21672-1-jassisinghbrar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200105225547.21672-1-jassisinghbrar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  5 Jan 2020 16:55:47 -0600, jassisinghbrar@gmail.com wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
> 
> Add YAML dt bindings for Maxim MAX3420 UDC controller.
> 
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  .../bindings/usb/maxim,max3420-udc.yaml       | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
