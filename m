Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B430CCA9EC8
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 22:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FBA21D7A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 22:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vo2VfrEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441677AbfJQW4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 18:56:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45603 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389846AbfJQW4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 18:56:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1so2185355pgj.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 15:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PEzTPXIiSWrjhtZyK0IAxlrMGgnaWS5bFQ/GX6txWdQ=;
        b=vo2VfrEvnriZfqVf6yyx5d6daMZFh1S8KpVp4FM557gEvO4z2U2sf1wONXedsiupfk
         CkJmU32vKyQRmFxfKS1ZyvbJk1As7A6lAZZuzfy05lCiqguMpoU7AGVF5OPfO50j3zsQ
         ycdNPZ8eeobGBmhDA/GqMk8SQ9J7q1isvA5PMi262bLCn9hEV0PPD90vyQwjXiysboQz
         0SxNaUTWjZ/CThNNFEnMGDppeI9nTpFv/lL7mmbHdWmQFM+sYL62DfO6NAkROh+yyLNu
         k9GbTbnSXJAOVMbeyuGIFdvd6EILTZxgkSR/Xv6TlKx5XtQSKN6wd1XrnKuzcjhiBeth
         VpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PEzTPXIiSWrjhtZyK0IAxlrMGgnaWS5bFQ/GX6txWdQ=;
        b=GFjtBYjCZqI9afhYmP/A8jbNdh7LJgiWVuikwcUGntyTtdxD3GP9KhmEqejI3to4M5
         Frf6vXW+PDXM4waITI6iS9kyfZJ82oltDUjJ2q5t1ibgokbJAFMhN3nZjgcYiiUWFT3C
         ESh4S36pTiVSjxtroUBlFIXgWdwaqr0eIvrxHWKOQVLb7vg8zuj8iAbF0MGGxLZiaM+F
         /kFtHV0bquNb4MgPDssHw7IKnAzUAdil23csVZ4wmsaA34n7YK5kV66v8P+U3grCjjbi
         KBUxHN0ZVBA7zRVppZWfs8Fb6hiufOTDctd5m7aiEjwNBpl8zh3uJY+JhlpXfSCseAFW
         FPKA==
X-Gm-Message-State: APjAAAWB2GSz033A2qVVoRVZTfqoQre68+I6DoSDaNx0Yqlc+yR8fVju
        Is6grEiqQnEJVh5fdZH11kS6JA==
X-Google-Smtp-Source: APXvYqwGX8tr4KBqHwbDLtZIMeKEgGtLYeAuokq/qC1U2pE6TwlwTOj/80mw3ewLkSLSHi2CXpRQ/Q==
X-Received: by 2002:a17:90a:8d13:: with SMTP id c19mr7157506pjo.136.1571352979203;
        Thu, 17 Oct 2019 15:56:19 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m9sm4089454pjf.11.2019.10.17.15.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 15:56:18 -0700 (PDT)
Date:   Thu, 17 Oct 2019 15:56:16 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: Enable QCA Bluetooth over UART
Message-ID: <20191017225616.GB4500@tuxbook-pro>
References: <20190926225604.46514-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926225604.46514-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26 Sep 15:56 PDT 2019, Jeffrey Hugo wrote:

> This enables Bluetooth on the Lenovo Yoga C630.
> 
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>

Applied, thanks

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 8e05c39eab08..0134a84481f8 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -169,6 +169,7 @@ CONFIG_BT_HCIBTUSB=m
>  CONFIG_BT_HCIUART=m
>  CONFIG_BT_HCIUART_LL=y
>  CONFIG_BT_HCIUART_BCM=y
> +CONFIG_BT_HCIUART_QCA=y
>  CONFIG_CFG80211=m
>  CONFIG_MAC80211=m
>  CONFIG_MAC80211_LEDS=y
> -- 
> 2.17.1
> 
