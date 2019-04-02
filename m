Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE45C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA05206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JUiUEqhM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfDBHBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:01:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43274 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfDBHBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:01:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id z9so6053856pgu.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 00:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=to7nO3wZcirLehPoKKoyB4khRFaxONhctW/3CrLUmdY=;
        b=JUiUEqhMD5SbQXq4FlL08qCkHgIl6zChPoBhAImH038ZtqKLnEF+vW/3rNg1zxjqMZ
         fI4UbPos3qJYb04Wsmble6/bevgl2l5D6fkCTWXuN+cvCvKRaRfX6xHYdD88MtH6QDtN
         TVIp3L/PrR2d79+utPlOs26u7uZkX7lt1IqdlwnM99L3b/XVklYCuT4ArS+Q11sgnUQ1
         71U/JQnjONq11IHtVY8Lbto0fuMemOQkNGM+BdfxUpC5orBs2rba1CET0cQ0GsGtlOKW
         5n8jpbJsrcRTnagNiaGm4XyJ91BtTONbVwzWiWfs+MiqtRc6b9rqdb+o20/28glWKOM5
         HXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=to7nO3wZcirLehPoKKoyB4khRFaxONhctW/3CrLUmdY=;
        b=rB8E3WBtRDUbAC/ESJUb8ydlve9Jzwf6KHkm1AMnP2mp1oETHToK/pG7W65s43qRn0
         RUcfiLTYIp+lVybQfUkgnKp7t0aJj+fw8EqVHlp3SfMCA/pBYuWywKbY6fRzYWyD2QnU
         I+DaKpNiLeonVTemUmOSpa1JZtT22IdmF3cMhdXTpAAun+TJX73D8u1Sai2IsowdrFtf
         0YAx8fBYmzq51kj5Zbfp+YlA0VcAr5G5IshxAu6u+JZDeAovm3OXoqhCk9v1pR1ABf6T
         OZQ3deVC8Iw6zO6tPxLr+w9oLrf5dh+nLpjOJL6IbKE3AbIEpQdZTFiL0fUHD3w7DXp/
         IC9g==
X-Gm-Message-State: APjAAAWJa0lF93hJADsTxuTBfOiirZj9wgLUa96q/gWtofwF+v0Rij2v
        rZnvI9RIXuhEE7JlXISk4+EEpd9tONFoNg==
X-Google-Smtp-Source: APXvYqxkdTRPgUKbcn225hIRUB5rclUYik7jUdPR8U4xbrRWOZWTrUihW0YDZHosk5KEp7XU0nOf+g==
X-Received: by 2002:a63:3d4c:: with SMTP id k73mr48589027pga.154.1554188497982;
        Tue, 02 Apr 2019 00:01:37 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id d69sm28286561pfg.26.2019.04.02.00.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 00:01:37 -0700 (PDT)
Date:   Tue, 2 Apr 2019 08:01:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: axp20x: Allow the AXP223 to be probed by i2c
Message-ID: <20190402070133.GD4187@dell>
References: <20190318125548.24851-1-maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190318125548.24851-1-maxime.ripard@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019, Maxime Ripard wrote:

> The AXP223 can be used both using the RSB proprietary bus, or a more
> traditional I2C bus. The RSB is a faster bus and provides more features
> (like some integrity checks on the messages), so it's usually preferrable
> to use it, but since it's proprietary, when we want to use the PMIC in a
> multi-master setup, the i2c might make sense as well.
> 
> Let's add that possibility.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  drivers/mfd/axp20x-i2c.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
