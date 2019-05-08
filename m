Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0867EC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8C8214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xJVgfbsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfEHIkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:40:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35869 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfEHIkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:40:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id o4so26048091wra.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 01:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5iV39oc7txFj1z14zStSzaic9qElbV7eM3bDdq2xNNs=;
        b=xJVgfbskTFpOrVO5RDoCGZrBXAQvJ7kr9yPJqSZVrEPUOuf48XOQL0xxm2Vx46zXbc
         +hG2kyg6u1/4yWPAwHu9AAnlGLSET2uQbA64QFgbNe4FBMqYbP5QWgmCgoHNOcWDNpFX
         hB9h3Kv5A/1bl6F8REG+lJSe/guSxnIZ73zrYHp8tENPVnROsePUZiVVjK7rcc+m70DK
         J/tTuiQTJdo11FqR5+F31zeGdMzTbQKOVEyQx7lku6gVFKzVTB9CloBBDQEEtR6iuUef
         E93Sd8aWp+Of26Z7kvQhkX8KwKy6Y+brLkL5Edua8zQhB8rV41ic3lyIpi4vvHnsFBDz
         gl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5iV39oc7txFj1z14zStSzaic9qElbV7eM3bDdq2xNNs=;
        b=bqzE8xDbbFLPGRHGycV++pbeT+cEYsw7oSRPonqHlBlGaIVUmYVo2WNDzGAQ2axrjT
         SQAbwH56bVSbq+lUKXCQaoK9clXSnW+bnhYRy6klpXhzMPbcX5wQZSlnjaqu6Tx38hT7
         rRituWwNwVYDbfkYuvywqg9cY8+Sn5KRd+M/nV/0Q73wiYuCE3XvMyuQuVZepxRX5z4h
         qmYVwcP4NkAWKeBXlg22nn2RSoE3tdqP2/XVSrH1kF/ayom6HBfEwisjfpXAan6pa72K
         2DcfNHDDJZyCfB3/HYoSY9xem+97zXCpjTDbUwgaKnNUoBa+fAQqXxZpNjoK2SyzIbOd
         v49Q==
X-Gm-Message-State: APjAAAUR9FuZt0ZQegnfpwRBWtdJct17OhOVPGH0J3IAvnA7VAfzbTS+
        qhJEF/5uu4pUk+qOsf+o/ANmZw==
X-Google-Smtp-Source: APXvYqxT+p0H0/0rz0V5Jy4z/rmjEc/g5TciAjBtClxe3ObnYCxgA/8wzzmEJYlDAKpAIRAW1Pb3vw==
X-Received: by 2002:adf:f508:: with SMTP id q8mr7952043wro.225.1557304834919;
        Wed, 08 May 2019 01:40:34 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id i9sm2526835wmb.4.2019.05.08.01.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 01:40:34 -0700 (PDT)
Date:   Wed, 8 May 2019 09:40:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: sun6i-prcm: fix build warning for non-OF
 configurations
Message-ID: <20190508084032.GF3995@dell>
References: <20190416122506.3180853-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416122506.3180853-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019, Arnd Bergmann wrote:

> When CONFIG_OF is disabled, we get a harmless warning about an
> unused variable:
> 
> drivers/mfd/sun6i-prcm.c: In function 'sun6i_prcm_probe':
> drivers/mfd/sun6i-prcm.c:151:22: error: unused variable 'np' [-Werror=unused-variable]
> 
> Remove the variable and open-code the value in the only place
> it is used, so it can get left out as well without CONFIG_OF.
> 
> Fixes: a05a2e7998ab ("mfd: sun6i-prcm: Allow to compile with COMPILE_TEST")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mfd/sun6i-prcm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
