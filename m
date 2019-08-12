Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D51C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97974208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SdCHx2C+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfHLHrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:47:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34298 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfHLHrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:47:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id 31so103743411wrm.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dd4nFK3Yasv23+PU/7sIWKW7tGXmGUSqsPun5TNRCtA=;
        b=SdCHx2C+pEDytZ1qdooynzwh/T51cGNO3ky/zsAwJLoj+wJhSm3rpWXCnRkDElus72
         N59FxRwjKVmfSqanlMp+PDvD6BVevCzTcHP0yEh0rh232/hUXRuuZ0jYYGDFln+HvCnU
         SNzJdOQz8enkWPoKwwXXpthKUOrU77Hn0jYjkWgQKD2I+2Wd6oW6Hwnbtukgws6SbPq9
         Z0iG6BdSFj3ha0fJAy6DZfaeOSIsDYfNNVwXzzplEICC9yMIQVnygSZRqdb+9VpxqVGo
         9LYMBqF084pjkPrlaM/2PSv7yGuLy2gcWaBcEdUhkWfA+DedYBzzMB1gW99ZoWfXeVoQ
         35rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dd4nFK3Yasv23+PU/7sIWKW7tGXmGUSqsPun5TNRCtA=;
        b=VovbfDy39bATLa6XyFyAdboVaFKaY8yNdE7MPrGjCalnW+qzl9i6hDrXC4yIODcCQp
         eQmBWgJwK132JKUyPytCHniLO7lagg/96NNGwY1pi3fP1Q6B4nrryFX0mCv85isr2ITo
         pEkLV6xHkrmERu7rqeo1EZm3EdfgQjAn0gxUJJ1fx6R2aud+1qOQADdC2A4MRLeJXIc1
         skTTOynh75NKV6DbeQNm+AifNRKeo6inv8aLCljgzh8jnvHCpEjhQOCdRtEKtSDT2mB2
         lKD8VkDZRpNS+OC3N8sh+L7Hiu6lOOAOgIziZBK2FWMeFkJ78pphMMBMm2/t5gzmfMjc
         Qavw==
X-Gm-Message-State: APjAAAXEWZqrYwJymK7b++KMPFJm+IGGwlHPx1U7Kusp++BgL1/hdeuA
        5F7De8PU0TkZY7XqJqDWHz+N5w==
X-Google-Smtp-Source: APXvYqy8RgVPs2t5iiIzN0JNIMR+Fhmp592y0kdooAnhBgBnKD4Szo7TlxQlSrIpnDaKJzWlaHFWNA==
X-Received: by 2002:adf:f30e:: with SMTP id i14mr7791628wro.288.1565596029972;
        Mon, 12 Aug 2019 00:47:09 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id o9sm9016887wrm.88.2019.08.12.00.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:47:09 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:47:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/14] mfd: da9150-core: convert to i2c_new_dummy_device
Message-ID: <20190812074708.GW4594@dell>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
 <20190722172623.4166-6-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722172623.4166-6-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Wolfram Sang wrote:

> Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
> ERRPTR which we use in error handling.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.
> 
>  drivers/mfd/da9150-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
