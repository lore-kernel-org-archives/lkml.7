Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94130C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F6D2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwQVKBlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfEGRwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:52:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39145 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfEGRwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:52:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id g9so1131490plm.6;
        Tue, 07 May 2019 10:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3hWkoDSJOZrfkTI64LpT00O3NiHbk0Ob1pJ65mVFON8=;
        b=JwQVKBlKDR92Sclejlu6Vw2HEiOQ94zveEodXjIxNpRKXX/8QP/ICWdvWDwa4eKxIL
         9x6Y2YrvN0jM6eBBCUIDzg2wUc7GCnowlNy6K1KkASCQdcV59d4QIsxSf71IYZILRf96
         h9t6FQ2wjKVqYwMkQ7B1S/QP5s76pj/6/uj0TIJqIl7uUNh+jcuAUBvRZLrmz031NFFd
         BVqdGZrbqCCk/bTfnHb2lvbNMJ4nq34bC9x7KKG+vF7fDu9+bPE89gNpo0ZVoECB+CNG
         kxgfFa2hdzWd45g/DfPIU6N4IdmsDDCZXQMwtgn4uCT7l7r3tovrR4ecZQGcoyEFxMkm
         gAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3hWkoDSJOZrfkTI64LpT00O3NiHbk0Ob1pJ65mVFON8=;
        b=HBOzabr1SXrzVkDUJ/eViMqflGDEr3dH1OZz+y3JXAgt3n8B+Lm99lKo6j8ruvVR02
         Fvd6AjnPkAR0dJxcsA1olwXKeSetV7aGn4G5WozfkoAXlSEQ9MY5k0deA3evyEGTcXw5
         eSTBpuRNFgOoTwZNfOTE1qtUvi7o3X/X92iDJ5Uj0FPoyZMd8S3xsdoFjYgbXlzuDiwQ
         67Yq9mJ7KsJ/yMTy2w0d7WkiEwPKV0tvhG7m3wZ9C8Q9OKMa0AC1GDQrzCrBLoUje2Yo
         7LoDEh402AQmDur8OFtmUQ5MK9hhjo0KDCm8cgg49volUnn8PT1FCG50uaDlnPsKNbFJ
         KYfA==
X-Gm-Message-State: APjAAAUcVoGsopC/DpSuYAIPy1f2GnYn8XWlMIw2DXUK9EmfqddA49dg
        hL81qiXjMMN2uf3rKMTFHFA=
X-Google-Smtp-Source: APXvYqwV2fTFNQXeeczraLQ8ZQHBYaNpzObxLES0PAOQWGcz6OqTVaRRZV1VJ+05CjQtDMabO/z4ag==
X-Received: by 2002:a17:902:8343:: with SMTP id z3mr25340601pln.240.1557251528475;
        Tue, 07 May 2019 10:52:08 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id g128sm19504187pfb.131.2019.05.07.10.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:52:07 -0700 (PDT)
Subject: Re: [PATCH] of: Add dummy for of_node_is_root if not CONFIG_OF
To:     Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-rockchip@lists.infradead.org, jwerner@chromium.org,
        groeck@chromium.org, briannorris@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190507044801.250396-1-dianders@chromium.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <a3573253-e3de-0a82-8af3-6bacea20bd97@gmail.com>
Date:   Tue, 7 May 2019 10:52:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507044801.250396-1-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/19 9:48 PM, Douglas Anderson wrote:
> We'll add a dummy to just return false.

A more complete explanation of why this is needed please.

My one guess would be compile testing of arch/sparc/kernel/prom_64.c
fails???

-Frank


> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  include/linux/of.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 0cf857012f11..62ae5c1cafa5 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -653,6 +653,11 @@ static inline bool of_have_populated_dt(void)
>  	return false;
>  }
>  
> +static inline bool of_node_is_root(const struct device_node *node)
> +{
> +	return false;
> +}
> +
>  static inline struct device_node *of_get_compatible_child(const struct device_node *parent,
>  					const char *compatible)
>  {
> 

