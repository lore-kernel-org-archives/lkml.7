Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58BBC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73161206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yU153rUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfLPQWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:22:15 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34098 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfLPQWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:22:15 -0500
Received: by mail-wm1-f66.google.com with SMTP id f4so236694wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 08:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GnQyCw6x7n+jK/JpwBjmwmwD0/tfdVHGIHYKi0tkEAg=;
        b=yU153rUAiGDMblyab1aLX5Xp3Uw5PYZqTAT8vixm/kZ4L5x7wgHyWk71KcxTeKGeth
         HskWwIi2VauSQ2NDfPFH0JTev1/wTYwIskArt8N1P1tAeS6LBUbbXIKKTNzd8ZyyJpvu
         V1kYKxpVGQz316/1D0zfG3H66S+IM8fVVmzKWkL/0ePtwstdBFP1hgZ/SA/Lj8kJZEwI
         fXeBCSWTtqmSD9SQk/kpov3lOk+co+SuNKs2Ld3MJVYhvWOX8MVA95kbtEYNbQOUTx2h
         Vin/whhGQOylyIQzh+ozGUAp92a3LfIL21EUIstV5LHXz97hBKwX47iZmIutTRpyxpfB
         H0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GnQyCw6x7n+jK/JpwBjmwmwD0/tfdVHGIHYKi0tkEAg=;
        b=JzCZhyNXqpWzM31isvR1sUkrAt6nTCNfGsCuMQWPYC2cm7gTMrTxelh6qOzTUL4emj
         8UgaUBwc6mGGdIk0dOwnAunrCLOQjtDtcnFyCzDN2XsrCx4hzyBCQ8f3Jw82DQsdKEcE
         SvhGTFMb/Um/ilKPBmOb8clDjmBpGnowqaHaV0Mk45CCQbdlFy6a7utLWQusIftJqzp9
         PyXX71gfnC/4YKbNH14HOe+ysftVn0UMnUeQQlOTmV36AJ9yZwKGedU1dUAaqL/w4vnG
         zkyWk8KdwRtRtVN8tzRBH5IxRCpCSDeUPwK5QnNV4kQDzNWSY+fu8D1rYy/IGWSfDkkm
         3MEA==
X-Gm-Message-State: APjAAAV+YoQFHIGW4Del+sN5CBm/LBkOG6EenqiiufKDqgPcDZXMQIRC
        i0bx/87OWAtSWazfhTOIQufD1g==
X-Google-Smtp-Source: APXvYqwvgRXgwlg/FjNnaLLIZCy6reV92SEVT6xh253ko0RuVtrnL2bgwwuPhxFDXUCM6NeHCChZhA==
X-Received: by 2002:a1c:e289:: with SMTP id z131mr29743147wmg.18.1576513333139;
        Mon, 16 Dec 2019 08:22:13 -0800 (PST)
Received: from dell ([185.17.149.202])
        by smtp.gmail.com with ESMTPSA id x10sm21920943wrp.58.2019.12.16.08.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 08:22:12 -0800 (PST)
Date:   Mon, 16 Dec 2019 16:22:12 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     sam@ravnborg.org, bbrezillon@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] mfd: atmel-hlcdc: return in case of error
Message-ID: <20191216162212.GP2369@dell>
References: <1576249496-4849-1-git-send-email-claudiu.beznea@microchip.com>
 <1576249496-4849-5-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1576249496-4849-5-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2019, Claudiu Beznea wrote:

> For HLCDC timing engine configurations bit ATMEL_HLCDC_SIP of
> ATMEL_HLCDC_SR needs to be polled before applying new config. In case of
> timeout there is no indicator about this, so, return in case of timeout
> and also print a message about this.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/mfd/atmel-hlcdc.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
