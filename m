Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32BCC17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA812196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573587097;
	bh=tnIvAM21Lk7J03KNXw80scA/GnDd6p9OSB2RLSkk2UE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ha+3ROLiKygvLNAJnUV5tUKJvmZME2FJ8vONlGhNa8em0VVZ74X4oTGH9GTHYHhpR
	 ZXoXsMXtETUphuHlRX0MxjQtWCNTxkWX9QZoRpmAtQirlFQpyy3NigQlBhR1e6KSNH
	 KMZEqLEQp6JVHy0LNfm666jDzkAnYC3WKHrWwXS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKLTbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:31:36 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42960 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfKLTbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:31:36 -0500
Received: by mail-oi1-f195.google.com with SMTP id i185so15911436oif.9;
        Tue, 12 Nov 2019 11:31:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fQ8tuKZ2UW9QCYz0BR497mmF0XiSrRa5eQinsz9A154=;
        b=IG408rLuTfrfP9QSpyE/4Z+t4bIynyERrxUO6GyORDLhICovaCU2Vh95aDmPK+5CsH
         rtZF68mpFRTc0akpceNEbh9eirrCcm/qLQCSodt5Tmtxvut4VQaWbwYmHrRZRLx2RwSu
         hrOwcX7it+EJvbNyNXmxfzLGDtTrjRy6VDqvd0NX6bQ6Xar+5vOwQjHuRXfCdrQuevs4
         UWGR+/AgMMqs6nKYuWLUho+OKK2ybzxCMxpBrutLk+Cjs/KyUpTFZRNCaptxHoX6lIlh
         Z3EybUL3UlivHBSatjXMT8k98dEXr4geACeLflcpBq5jWFodoJL46Xr6KYyuAdd68WKo
         KSBw==
X-Gm-Message-State: APjAAAWeIOl4usA4owpQAnvAjbPvEwmV3D2qZdB4tMHvFvHCRzGPxQ26
        iZd6ZDWn9+so85L44aqx9g==
X-Google-Smtp-Source: APXvYqz6AhgOyVl+Xgvdhm4Trx/gVZNkFu8ggUGq6yRbip4wF4kcWnuuo46df/TkPFftZd8m7FNXKg==
X-Received: by 2002:aca:5301:: with SMTP id h1mr522205oib.154.1573587095176;
        Tue, 12 Nov 2019 11:31:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d5sm5903145oic.23.2019.11.12.11.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 11:31:34 -0800 (PST)
Date:   Tue, 12 Nov 2019 13:31:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: pwm: allwinner: Add H6 PWM
 description
Message-ID: <20191112193133.GA27088@bogus>
References: <20191108084517.21617-1-peron.clem@gmail.com>
 <20191108084517.21617-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191108084517.21617-2-peron.clem@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Nov 2019 09:45:11 +0100, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> H6 PWM block is basically the same as A20 PWM, except that it also has
> bus clock and reset line which needs to be handled accordingly.
> 
> Expand Allwinner PWM binding with H6 PWM specifics.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
