Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29CFC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCEA21479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EEb6b5GN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfEHKZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:25:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35157 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfEHKZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:25:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id w12so13016427wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 03:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PaqzO9al4lxA936zY+spe2YORCqLvjGbaUUHSrafi3k=;
        b=EEb6b5GNUr7bsYl/13ISQmF2h/5LBWSJkbvH6DNaQ0ZXyDAGV41LYDaQohaSxYCYzU
         RYgjwqkGH+E59hKG4JmHHzikh/aU4z5evz3j0WOUn2SqaiVqZKwq3CJ2EdM5jPRA2jhf
         SKCqVRUUl/ZGf3eDUpLHZ/o2XqFtVPFzdKtz1kZ7GsdxAV5veHc5edqL8oMafcAnwFKC
         4UaAtP0QXCf4S7mOVRtdeMCViDfF9vWmUbe3yN+RmyvUZYE1894b6g3oYYx9ErO5a/HX
         zgt43oYIMfZOozp7YmsqsCn5U+wWTw64iUpAvnRUn/zcDd8xEdRSXqKhvYlukjoLfzOj
         MJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PaqzO9al4lxA936zY+spe2YORCqLvjGbaUUHSrafi3k=;
        b=JMrT/i38bt3mSBghwQ/LVze+9aYMvP8g42y/MQCa3fixxvljY0cdfbFotH95kp6aSk
         B3De9qEVPAg2f4BRnh1fw+VjxeUyHxKVugE3kgpVPSsNUS3MtYGow/yO37X3Q3Kfbvso
         KqglH7RTPIafLm/6cYGn6m8MwCQmY57+Z49OKINQRba02qJFXc6Z6mzkwh782ySuQqIX
         kiEKbJRVynaFiWotG73tc/4k8DvvGbnQwIcEVaXD9PLh1ScyvQClBmqnT6aryjGmC5+B
         92fwXySzWK4zbgdn3reM/S05WI6M5fP6b96QWO8nokDLV1pu+LY7R1CCSNRXFqhyIJ4T
         cYyA==
X-Gm-Message-State: APjAAAXvIo2oQV2aFcUogCAlGqWEpNB3ptGniCZUlkGv3/E3nM9+zlMs
        EgWP7Fx2wxu2ppapSOE2de7Z2A==
X-Google-Smtp-Source: APXvYqz7H7fEpsZn4oC8Tv6c320q/odXG2NZeDdHFsKUvo4mP1qvW3GULokZIO6R3GZ1NGG5p/3lTg==
X-Received: by 2002:a5d:518d:: with SMTP id k13mr9026224wrv.285.1557311110705;
        Wed, 08 May 2019 03:25:10 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id b10sm28463131wrh.59.2019.05.08.03.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 03:25:10 -0700 (PDT)
Date:   Wed, 8 May 2019 11:25:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mfd: axp20x: add USB power supply mfd cell to AXP803
Message-ID: <20190508102508.GH3995@dell>
References: <20190418161804.17723-1-wens@kernel.org>
 <20190418161804.17723-2-wens@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190418161804.17723-2-wens@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2019, Chen-Yu Tsai wrote:

> From: Chen-Yu Tsai <wens@csie.org>
> 
> The AXP803 has a VBUS power input. Its functionality is the same as the
> one found in the AXP813. Now that the axp20x_usb_power driver supports
> this variant, we can add an mfd cell for it to use it.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mfd/axp20x.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
