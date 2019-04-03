Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BEDC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 23:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452D62147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 23:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNX7xlhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfDCXJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 19:09:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38225 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDCXJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 19:09:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id g37so152787plb.5;
        Wed, 03 Apr 2019 16:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nb5v+nzHef3JUkcAdPDowbv0xJPeWycG8FJI20WdCag=;
        b=SNX7xlhzSEBNPGwOEGqvrex65zPFVwuofmdG9ZEzg5Wdhxp5rm2elCVsQirx8/7IYU
         mKwNXRM8sMkMO0u80FfNTkDSAUVhF/LpqfP36s5qEP+euxRjuxQ4o+nQuSUduUtQbeyY
         i16LAxAhzgwR+mxfYz8/GCTMGDHSb/0TJ9OG1A2nXMo9YoaqvD08DUHevmVF4zOnguZt
         VV+taBrNtcE59xJ64pXef+Z0/vnHqt5JZmxaWK3BqFyHBEI72O+NCypAJugWSL+lfU2h
         mteGTR4dl1/dq8UxE7lupCC5FLmuVib9HzNn8a+QJNWcMPcP4ceCwy9qnAP1hFV2i9V6
         cy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nb5v+nzHef3JUkcAdPDowbv0xJPeWycG8FJI20WdCag=;
        b=reA+Mr5YV7QbHssEFPA3y5RpuyKoDZ0+9VqiE07tAU4JL6kAQLFF5g7D0TU/J3OymY
         QPvV0GsK5GEEgEIWr6FFQEXLE20vVBIjA6piEsbbuLOYXYV4CldEt+zMA7cSyR22UjoT
         JhtSxkWnL/Lk8hW7+UBt4fRbSk5Iw8awJR4cQ/rFSIiNZ3oujelDm9ZV954DcH5aZxRi
         LkV3XuSAjxIhfnx6Zsd8zzknzwQlGtEK1gsdU1VFIwuDUKlGDIpmKY3PDfLV2Hj/rFUe
         K83dtK+oczGoXAVRDmjw+1RDHsBWBF8XTE7IdfVUPxE9zQQEbd+VGMTervMeWTY0PfyI
         rlsQ==
X-Gm-Message-State: APjAAAWpyepksgj1mLuok9FTQja03n4Uyc5e5xFfk+k+wV9kuesrAWlz
        45hnRgWEKGtBmlt+U2x7v4WcBuTP
X-Google-Smtp-Source: APXvYqyL/EskDEE6CVjaYT3QRe/qidClexhHB32MFF2U76caaWieqAc9A8WDyiNuSUL6qujSbZ8OzQ==
X-Received: by 2002:a17:902:7587:: with SMTP id j7mr2694274pll.304.1554332981799;
        Wed, 03 Apr 2019 16:09:41 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id y1sm10909962pgc.29.2019.04.03.16.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 16:09:41 -0700 (PDT)
Date:   Wed, 3 Apr 2019 16:09:39 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v7 4/4] Input: goodix - Add GT5663 CTP support
Message-ID: <20190403230939.GH53104@dtor-ws>
References: <20190321082104.2874-1-jagan@amarulasolutions.com>
 <20190321082104.2874-5-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321082104.2874-5-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 01:51:04PM +0530, Jagan Teki wrote:
> GT5663 is capacitive touch controller with customized smart
> wakeup gestures.
> 
> Add support for it by adding compatible and supported chip data.
> 
> The chip data on GT5663 is similar to GT1151, like
> - config data register has 0x8050 address
> - config data register max len is 240
> - config data checksum has 16-bit
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/goodix.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index de5b80a08f41..c558b091749c 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -219,6 +219,7 @@ static const struct goodix_chip_data *goodix_get_chip_data(u16 id)
>  {
>  	switch (id) {
>  	case 1151:
> +	case 5663:
>  	case 5688:
>  		return &gt1x_chip_data;
>  
> @@ -1003,6 +1004,7 @@ MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
>  #ifdef CONFIG_OF
>  static const struct of_device_id goodix_of_match[] = {
>  	{ .compatible = "goodix,gt1151" },
> +	{ .compatible = "goodix,gt5663" },
>  	{ .compatible = "goodix,gt5688" },
>  	{ .compatible = "goodix,gt911" },
>  	{ .compatible = "goodix,gt9110" },
> -- 
> 2.18.0.321.gffc6fa0e3
> 

-- 
Dmitry
