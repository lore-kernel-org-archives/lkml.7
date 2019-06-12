Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C1EC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53070207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v9c3s1/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437663AbfFLJlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:41:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40273 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437298AbfFLJlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:41:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so5783800wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 02:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GbyCcP0P6CtvOUhdOB2kGSjXvxXCXy0VBA/B3vFhrYM=;
        b=v9c3s1/Ac06DyH1iUKtg7MdnBEsehlR5I0sut5tbdZ8qlsFcfAmYKJU8KJQcu5o5Lb
         y42upQrN3qOS0CtmlPoFSNambsDTHhzG9C/L8/PHIKCMqTiLdEvEWcQx4diMP0k0uswh
         JKRA9sj9V1Vavijyu3+LKDhUFhhWqI4a9zV4VSKgsc8gqNt95OyZgrpV8Cvp5nCajLjK
         eS/6zB6jAo2ApKcWPq5YRF0LYXhGfdOzfRy8uly0VYPQ5Hw3XxHaFDaNhBTi31ucaJtf
         5fGm3zRfxAJqZ2IFlRngUk+yQgB+RWOU7mk8scPoJfyPmV3GmXzYYsWCSGqVqWsRLKWE
         3lPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GbyCcP0P6CtvOUhdOB2kGSjXvxXCXy0VBA/B3vFhrYM=;
        b=MM2GFvZeKapdp6gv0F+9NalzOvLnD9JMiejjvHhmb8LEs6GFMSSgv78BTrgEyNfJjy
         eekyw2ILyQtWcklAsKY9pwEalSrS5sHF/w+FAlwT8s9GY4Wkl4NECesM4n9+y+KEm5OT
         ajjDciySes+RioLUM2pSaABolBwKauAwXhknWtrm5gU0raliSfTx2RZCVzXtlqw5blkU
         c0f0QQ/jqQeLYQVH22DElyRuznrqIiF9UDV4pWfFEVX9drLvAtdRVnWOxLHrzErBbvgC
         5cTgg2WTK/WwP5t6i+joa2plJtB1PlVn389Y8fZjAtSbPHyPQPyuJeHBa0hi7qTdW0V3
         OeEA==
X-Gm-Message-State: APjAAAVu+ug87J8PUKw+dlr7JJk/XIOxN63q7vcan5lxwFZNbhnX1H8B
        9ZKt1/+xxBqoXcQjET2BYnwLimqLlJA=
X-Google-Smtp-Source: APXvYqygiw+/5k24/WpB6qD2mtSTr45HzlnWx9+WNEOkC2du6jSGIMSHh2qVU7IcSAPxRhf2t++/rQ==
X-Received: by 2002:a1c:678a:: with SMTP id b132mr20709233wmc.17.1560332493322;
        Wed, 12 Jun 2019 02:41:33 -0700 (PDT)
Received: from dell ([185.80.132.160])
        by smtp.gmail.com with ESMTPSA id v67sm4493632wme.24.2019.06.12.02.41.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 02:41:32 -0700 (PDT)
Date:   Wed, 12 Jun 2019 10:41:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mfd: rk808: Check pm_power_off pointer
Message-ID: <20190612094131.GG4797@dell>
References: <20190607124226.17694-1-stefan@olimex.com>
 <20190607124226.17694-2-stefan@olimex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190607124226.17694-2-stefan@olimex.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jun 2019, Stefan Mavrodiev wrote:

> The function pointer pm_power_off may point to function from other
> module (PSCI for example). If rk808 is removed, pm_power_off is
> overwritten to NULL and the system cannot be powered off.
> 
> This patch checks if pm_power_off points to a module function.
> 
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---
> Changes is v3:
>  - Add explanation comments
> Changes in v2:
>  - Initial release actually
> 
>  drivers/mfd/rk808.c       | 17 +++++++++++------
>  include/linux/mfd/rk808.h |  1 +
>  2 files changed, 12 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
