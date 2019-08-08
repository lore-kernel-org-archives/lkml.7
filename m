Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BAFC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D6421743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ipcnomnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404114AbfHHQJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:09:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37761 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732662AbfHHQJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:09:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so44345238pfa.4;
        Thu, 08 Aug 2019 09:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ixs9LC/3zHycCEwdS0uClw8qkvA1XtxWo0xApcxIKeE=;
        b=Ipcnomnw1fA9e3yDD0nP25KinbS/zFHRZf01ATCXFDWnS0nbCeRDLETiFooCm4vNmh
         aJxTbUB1hLPIRPLNrHeprr7VohW9/Jg72WhviDZzHLbJnE913YhzPb4prCloIfwctBbB
         Mo6x+DVM2tOm4848ewle86bSdSiEMlbUp/BSdGTDI7tFoMWzPLtzY1IoAYc1O8AaHobb
         OILXtQMP8njZKdjPYpeeTtY1+/ijHSxwl0+eNFiDfG/IFANktY2Fuo6vXxJ72wZDrwWx
         BTT2I+Bwv4xN8T7eHsD32BHb4Vc9AQ6N02QLM5oFJbD+7sBrXNIKJE+fmesJE4Ao2DE9
         5g7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ixs9LC/3zHycCEwdS0uClw8qkvA1XtxWo0xApcxIKeE=;
        b=pWGn2JRDLnZ1n7eH9m/bHohqND0tkDTn2lw1pJl2g9suIR1V8IUqETaAMlfxlr66fi
         9Qo9O8o8mtS9GIcHRjAhXKctWxfCihQaOBhrsOSo+HX3cV0T+m6RM9hy1ZmEIL9jeKbu
         aErN9sqTlKLR7KS+Qf0Bg3GbvizyIKbZTFySYgHssTMToUZkvPNa1Ezk7QO+ccbFm1q9
         cKwDbOr0471AXo65BMiw2aO5iHiT1/5kLl/rMUQiiTq8pT4lfgQWoSFKVDPi+u+h3rNv
         40ZgoyRARN85ePX+7FTOS+PUoDSfp9l94Kjz3uJ1I06vOcl06VYCd2m9bC18AVt3WhMJ
         xk5w==
X-Gm-Message-State: APjAAAWG5kd4JvgCbQ11hbDE4cmfHHJCXHxu5pPq9ZbV8X6GEIreog2o
        drR6bL1e0fONRu/m1VEtgIx0XAG8
X-Google-Smtp-Source: APXvYqxtbRe/Wkfso0tvKa9FTBW3LS6O8vGQQoPLIygjOX9kmcIqyZRvL2v90isUMuTmaQKRPxdARQ==
X-Received: by 2002:a17:90a:8d0c:: with SMTP id c12mr4679212pjo.140.1565280594061;
        Thu, 08 Aug 2019 09:09:54 -0700 (PDT)
Received: from [192.168.1.70] (c-73-231-235-122.hsd1.ca.comcast.net. [73.231.235.122])
        by smtp.gmail.com with ESMTPSA id v12sm82918564pgr.86.2019.08.08.09.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 09:09:53 -0700 (PDT)
Subject: Re: [PATCH] of/platform: fix compilation warning of
 of_link_property()
To:     Anders Roxell <anders.roxell@linaro.org>, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190808141818.22724-1-anders.roxell@linaro.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <a4c12db8-bac3-0093-1f3f-0bd325acb03a@gmail.com>
Date:   Thu, 8 Aug 2019 09:09:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808141818.22724-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/19 7:18 AM, Anders Roxell wrote:
> GCC warns that a negative integer can be returned but the
> of_link_property() function should return a boolean.
> 
> ../drivers/of/platform.c: In function ‘of_link_property’:
> ../drivers/of/platform.c:650:18: warning: ?: using integer constants in boolean context [-Wint-in-bool-context]
>   return done ? 0 : -ENODEV;
> 
> Rework so function of_link_property() return an integer instead of a boolean.
> 
> Fixes: 690ff7881b26 ("of/platform: Add functional dependency link from DT bindings")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/of/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 21838226d68a..86fb8ab8c012 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -625,7 +625,7 @@ static const struct supplier_bindings bindings[] = {
>  	{ },
>  };
>  
> -static bool of_link_property(struct device *dev, struct device_node *con_np,
> +static int of_link_property(struct device *dev, struct device_node *con_np,
>  			     const char *prop)
>  {
>  	struct device_node *phandle;
> 

Hi Anders,

Thanks for catching this.

Another patch was submitted to fix this just before your patch.

-Frank
