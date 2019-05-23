Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4A0C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93D121851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MiZVEMh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389323AbfEWTV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:21:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33387 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390344AbfEWTVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:21:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id c66so7805208wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 12:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+AsttdkF/OvZdxrRB18xex+EGbhnUq0bTn8ba7mXT2E=;
        b=MiZVEMh1LahbDicTGKYdAJmetVoDnUx3GPEcti62tJxHXUOHaVciB2jaMaLe8yBS/R
         9xXsbDyL4uOdwcTOSzrDoxD1BNoGx616C+/EgfHhE5KCrHrxKhxZ9oAW724n6IZCTtFi
         eWCBqodnisibUm2gIruYwXgNd0VBkRyA+SrFzZfeaLCvwq208MI4hxdlchQZGw99cPc8
         3hHe1wXz/vhlVg7cE/Zn2LHED6Hz/rwrw+kjWY7U8b8p4dON6t7gnO+ZESWETAyFFMB1
         1kvSb6L5klqCh0jZ7khnkTsC+V5c77H4LiSDORkK9yWf+HUHjad8bgoZFtAG1xCVUr6I
         miKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+AsttdkF/OvZdxrRB18xex+EGbhnUq0bTn8ba7mXT2E=;
        b=pJtxkM2yZhKh+dcETfpAsef4C3OYlSI0/CgpDkfJt+j+5gFPJrwFAWIAIx/+To2pnY
         UohOFhUIwvEgSEP5QIc8FWjH6nD6vgsO2mePdzWrxUjJ/8ynFf33o+VvM2VYGp2lGd0Q
         ggCNLP9tX46NZgtEU/lTE6yIIXHECd9nPRdizUFutxzuCqrlyPqqkp6rz+jL8s1wJQ6Z
         S00NeP3AUbybF/6IX2gBynUCg8fCQcs5v4uDyGOdqo6S6SbqxCbpi5vEQpGsy/ELzfey
         gjdP+XHvWxegD0lMakADo68XaZkJeWYnrAGb0EYpl+6pANs2j8UyS6a8fFbXkwOW8t36
         CKMg==
X-Gm-Message-State: APjAAAXB0C0AZtOUrvlwoCPE6S2prPwOpebN/S7rrx86vqRd5kPPvgMu
        sXu9YCWhNSJ1XmXraxq9m5IOew==
X-Google-Smtp-Source: APXvYqwz+aa9cC1mkduutvE6e+qiFfQt6D2M5mN34x6291O7m64ahRcSIK5WD/xERoq280zUbDHX9g==
X-Received: by 2002:a1c:f61a:: with SMTP id w26mr12956452wmc.47.1558639305630;
        Thu, 23 May 2019 12:21:45 -0700 (PDT)
Received: from [192.168.43.165] ([37.170.182.188])
        by smtp.googlemail.com with ESMTPSA id h15sm93457wrs.49.2019.05.23.12.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 12:21:45 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers/ixp4xx: Implement delay timer
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org
References: <20190523181602.3284-1-linus.walleij@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3496e81f-ea63-794d-0d8a-8eba9f2f6853@linaro.org>
Date:   Thu, 23 May 2019 21:21:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523181602.3284-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,


On 23/05/2019 20:16, Linus Walleij wrote:
> This adds delay timer functionality to the IXP4xx
> timer driver.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

The patch does not apply on tip/timers/core





-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

