Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AABC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCCF205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TflF0o6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389388AbfG2Tlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:41:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45988 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389354AbfG2Tla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:41:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so28743647pgp.12;
        Mon, 29 Jul 2019 12:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Dz0GgmO6qmE4MAFGR84AXHaHxqY/lTl7uea6qX+5fg=;
        b=TflF0o6MX/qgWOrImqmQhbskmpRfUcujvsFhX2SQtANavL0oW5ZxLsZ8OihRYbMJLl
         BNBPgCCLOpCPk5nNeYoGxtruxxdC4QCxCr42U0csHNkcMNLiTre3ZmXyuAeH7gbFPjc2
         Dr8Mi5U2xT5ZW7ToeWuG6rbiKKuTYeGN+GTUhIjK0TO4c35oWVl/dtIIuZiWxxRAmOpw
         LjyRvgswDWQl7v4Eyr8nsOl6Lpf+NGOmgHLLAz9iv+q4ICLFu4nOsj6rIWiFi5GjsEjE
         GRE6MtkCpocWDtzFvils9en7a2003O3ljjYpsgsrUa7DWrqRmkMch0ONFm8IbTgt9I7Z
         OaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Dz0GgmO6qmE4MAFGR84AXHaHxqY/lTl7uea6qX+5fg=;
        b=gUMbFr9uafrwB9Inh7NxeLOBbTDsUX0iechzf1hnGN9iyTJidqKxb+g/pP58CprQTm
         MqUt5TwGJ2oK4Rfz07SXVSkL87mbO/nPmT96mrAd/+saxi28UVmpYnft1VZl1ycWK1UT
         VGGP/kia1jvUx8fcc+WY7k988xhgRPLDaGcTy7tOUl9zlyJSHN8/bxRn2s7/bmbxJE7L
         Lt+NoTMFndER6mozuJcyE7v3C3yKLDIV2XLkRMZE+IGwKbRwfFTPAXcN9cjUxj8wr0sB
         4cK8g6JzO5x7uMwQ9FKCAMUrCc4WgxvESG0ft8V+do6W+CWcOUZWhOIvddLYNwD0xhFi
         kyYA==
X-Gm-Message-State: APjAAAWHlyGa7pnKBZ7hyvIx/z7SmRsXv5VXGEqHhDOpbg3erOLIIW/I
        wCrdCmLZ4MhoIFYfi1XaHRM=
X-Google-Smtp-Source: APXvYqwYFWImrD12nOO6O4tljP+JRCjkjw66pzAW6I8GeoaAGPbNiPFbQl+QlKHEMKqzZDwQjGv7JQ==
X-Received: by 2002:a62:26c1:: with SMTP id m184mr36658332pfm.200.1564429289372;
        Mon, 29 Jul 2019 12:41:29 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id o24sm18978199pgn.93.2019.07.29.12.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 12:41:28 -0700 (PDT)
Date:   Mon, 29 Jul 2019 12:42:15 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     broonie@kernel.org, l.stach@pengutronix.de, mihai.serban@gmail.com,
        alsa-devel@alsa-project.org, viorel.suman@nxp.com,
        timur@kernel.org, shengjiu.wang@nxp.com, angus@akkea.ca,
        tiwai@suse.com, linux-imx@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v2 1/7] ASoC: fsl_sai: Add registers definition for
 multiple datalines
Message-ID: <20190729194214.GA20594@Asurada-Nvidia.nvidia.com>
References: <20190728192429.1514-1-daniel.baluta@nxp.com>
 <20190728192429.1514-2-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728192429.1514-2-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 10:24:23PM +0300, Daniel Baluta wrote:
> SAI IP supports up to 8 data lines. The configuration of
> supported number of data lines is decided at SoC integration
> time.
> 
> This patch adds definitions for all related data TX/RX registers:
> 	* TDR0..7, Transmit data register
> 	* TFR0..7, Transmit FIFO register
> 	* RDR0..7, Receive data register
> 	* RFR0..7, Receive FIFO register
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 76 +++++++++++++++++++++++++++++++++++------
>  sound/soc/fsl/fsl_sai.h | 36 ++++++++++++++++---
>  2 files changed, 98 insertions(+), 14 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 6d3c6c8d50ce..17b0aff4ee8b 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c

> @@ -704,7 +711,14 @@ static bool fsl_sai_readable_reg(struct device *dev, unsigned int reg)
>  	case FSL_SAI_TCR3:
>  	case FSL_SAI_TCR4:
>  	case FSL_SAI_TCR5:
> -	case FSL_SAI_TFR:
> +	case FSL_SAI_TFR0:
> +	case FSL_SAI_TFR1:
> +	case FSL_SAI_TFR2:
> +	case FSL_SAI_TFR3:
> +	case FSL_SAI_TFR4:
> +	case FSL_SAI_TFR5:
> +	case FSL_SAI_TFR6:
> +	case FSL_SAI_TFR7:
>  	case FSL_SAI_TMR:
>  	case FSL_SAI_RCSR:
>  	case FSL_SAI_RCR1:

A tricky thing here is that those SAI instances on older SoC don't
support multi data lines physically, while seemly having registers
pre-defined. So your change doesn't sound doing anything wrong to
them at all, I am still wondering if it is necessary to apply them
to newer compatible only though, as for older compatibles of SAI,
these registers would be useless and confusing if being exposed.

What do you think?
