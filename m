Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14224C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88DC2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTDYYIfm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfDCPK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:10:59 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43743 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCPK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:10:59 -0400
Received: by mail-oi1-f196.google.com with SMTP id t81so13842797oig.10;
        Wed, 03 Apr 2019 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lzMC/mhjUzU/UXzu/tSBRxO/Evzp7DFktBGaL6e8F80=;
        b=FTDYYIfmX4y9hQWp0spmoFLZjG6v0D6uhxL6DkPLopyJ8pbdurmr76l1d25e77JBxs
         0skYQWrj1rp0EyEfpbGQ5q8mU2vKIfxmbvnlItl+u7cW7/53RY2lGeZwpg10nbliJ81i
         W3dFtdJYVaB6mhi9WVOaAEEbuk+RIfw+aUPBYCo5DbPeiP3C+zUSjy9Eh1ivyTmMOwT9
         vmm7YQZAI54BZx0cBbHuKl9ukWVq6pdH1a4AHv0lG35SdaZ8iG7qX3k0LX2ALTN0d66C
         Zd2JutXylxcWSRUOamU5a5QGkbroEPbaoLbZsUlD3lzO+yB0QWMzCAEohXigcDQ2OrDA
         qk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lzMC/mhjUzU/UXzu/tSBRxO/Evzp7DFktBGaL6e8F80=;
        b=e/glger+RR3+E+LlNsR7hQ+/TXz8R45VDrX05sp3iTuaO01wS6tMtfCCZ55xq/6LWm
         JaNHosn+O5lOcch/UsWdbmjABbWbIkhRLbw+SwpJFelnV/e3TPz+g3EV6mDul7PSaUz9
         zxIdFztrIvZUj+2aUJtMqfSooGGcKb7L76aePp1iaT0aC2f/eO/gjeO3baI8b2TPDHvb
         pD+GTluPjx7I2hREubovkR7VagJrTk6fjL1OwF0YCkIB3J8p8Kud6WYxDN+A4Nqv7kAN
         YcdS7ajbk82uMhZeWB3FqxqXnmIE11JdlxElQVnp9n9e6bupiA4heSyRhczIPDdNISCM
         N3IA==
X-Gm-Message-State: APjAAAW73seo/gNAJnRetJzCbdtF0Dn7PLDN5Dy447X1uz84YCcWYyyi
        xkziWhd7DVfFla1LpgJMNjA=
X-Google-Smtp-Source: APXvYqwW7j9UAmgEZNGEF/veC1bcL7KXYkgSi+A+kjoMY9vK15wT0/p1m4gq6eWx3+aRFYVCfL75Fg==
X-Received: by 2002:aca:bb07:: with SMTP id l7mr619839oif.142.1554304258469;
        Wed, 03 Apr 2019 08:10:58 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id u22sm6579965otk.49.2019.04.03.08.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 08:10:57 -0700 (PDT)
Subject: Re: [PATCH] watchdog: Convert to use devm_platform_ioremap_resource
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Barry Song <baohua@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
References: <1554231713-14137-1-git-send-email-linux@roeck-us.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <b0500cb2-c07b-34e1-5eec-88e24e711085@gmail.com>
Date:   Wed, 3 Apr 2019 08:10:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554231713-14137-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/2019 12:01 PM, Guenter Roeck wrote:
> Use devm_platform_ioremap_resource to reduce source code size,
> improve readability, and reduce the likelyhood of bugs.
> 
> The conversion was done automatically with coccinelle using the
> following semantic patch.
> 
[snip]

For:

>  drivers/watchdog/bcm7038_wdt.c    | 4 +---
>  drivers/watchdog/bcm_kona_wdt.c   | 4 +---
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
