Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F76C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B797820811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqyX4DBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfC2Kqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:46:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36697 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbfC2Kqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:46:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id p10so885737pff.3;
        Fri, 29 Mar 2019 03:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P5KI+uw6w2xbNZwKJJVa/UJVLdDJx9zqKQHba6/pxp8=;
        b=IqyX4DBvPXjyC9rcbMmi58G3wRCu22XJDFlKbRjO3fjA2pfmvZHw3xsOJnYagHLa+3
         YRHIYjWsTZ12yTFkMMMrjtNImC9PhnDzdB8uAqoTkAOjhESJOoYJI0427lfA4kYNbrXB
         aZsrfY5u6Ge3almOed2uUxUojCPElENKZjbro8SITsfEginS/7JpR6Gbr6R08/bnklLq
         eQfOPDFLMv86tQswCSb4qZvgFV7QoBzEvihcTayqBLOBNe6nGbnakIhm49vrGygqVTBQ
         COabEPWUgMJW50eT9Cn1EVODodJrXCd0J02lj/DNP86Tv8RQ+EKVVaOKWuCfGKBw8a/J
         i8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P5KI+uw6w2xbNZwKJJVa/UJVLdDJx9zqKQHba6/pxp8=;
        b=Wsdh6Nz7SKvMGAq/+w8aCtyqVT0dCbzWOPDxYXQyUWd8Yhm3PSbGLOcQWIWHkyT5+9
         b3NyM7Wl0DuuMXsA0JE7vcwUjAIdWlXX+DY/eLRdvhkLtBdqk5s0Ea5sHbk94Sjr8EUT
         5lnWE6DUXgwrkzBMkARxbpo4eIoFkaOLoL14CyI05RVxEWSXxwDuhX1bs/EM9IKk8Kvk
         +xZRqKWH8/iG5v0VVN63MB090K3mlYmR+RQ4ariAI2FMQ5IuZeBHPb1SsOx9fynQ9NQ9
         RQe5blpa2rjHrtt4GINp+aejgWZkCUzlTX8zMC4c+3MStk6rXPlayNNGNDdiPfISW7Rg
         yUgg==
X-Gm-Message-State: APjAAAV5je6jjjpigsfWQ7McyKMS8lo1muxLHtdLr+BX/6pqX7iz370C
        3jftol9Zc4eEyRGsZNJKySs=
X-Google-Smtp-Source: APXvYqyS0o8K5OVhyCf0Y7nB3h5SRscrCCxzT25WTVPsHB65XdzP9uyNVQb5FUQTikLCO6CV90UBig==
X-Received: by 2002:a63:20f:: with SMTP id 15mr6096620pgc.90.1553856402596;
        Fri, 29 Mar 2019 03:46:42 -0700 (PDT)
Received: from [192.168.42.180] (219x120x4x122.ap219.ftth.ucom.ne.jp. [219.120.4.122])
        by smtp.gmail.com with ESMTPSA id b8sm2044449pgq.33.2019.03.29.03.46.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:46:41 -0700 (PDT)
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, lee.jones@linaro.org
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <2741fba1-9aab-d044-15db-54d09e12d309@gmail.com>
Date:   Fri, 29 Mar 2019 11:44:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/19 9:20 AM, Mason Yang wrote:

[...]

> +struct rpc_spi {
> +	struct clk *clk_rpc;
> +	void __iomem *base;
> +	void __iomem *dirmap;
> +	void __iomem *wbuf;

Shouldn't all this stuff somehow come from the MFD driver ?

> +	struct regmap *regmap;
> +	u32 cur_speed_hz;
> +	u32 cmd;
> +	u32 addr;
> +	u32 dummy;
> +	u32 smcr;
> +	u32 smenr;
> +	u32 xferlen;
> +	u32 totalxferlen;
> +	enum spi_mem_data_dir xfer_dir;
> +	struct reset_control *rstc;
> +};
> +
[...]


-- 
Best regards,
Marek Vasut
