Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C9CC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198352084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kCFk8tj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfEOMtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:49:23 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51886 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfEOMtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:49:23 -0400
Received: by mail-it1-f194.google.com with SMTP id s3so4596102itk.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 05:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+GFSJ1Koy8Si0K5sXRcA8ZC/zU9KgNxm9g2aj30I4eQ=;
        b=kCFk8tj84FOx+psvF8/YHbnE2IILGZ2tt4L5oEjShzpHPGmUHdZav3vVziD0qk8FBe
         kS4IcnBhgjuOaMvPm+IFK2lgowVpCpgVCwbtNI+YfUZcR8cIj0A3EjpTsA6KNjC733IM
         mXnFDIj/eaCfO5wfwY4ixwNfqe/kU+sbw2lxf31LJJsADpxSKHySERshIMjtKvAeolvQ
         5kIhi4OuS7xWsAKiB6uhrMwC5BibM9UcDskeq8+AbZy74C/9ksjCOHsbSk9HfaQQeoR9
         eKoBsmo04JDle/SO+rp6GZ+qonQC4skO6jbOwNpy9d1Rkok7qz3PzSPp/yNr/6zAbb5G
         N9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+GFSJ1Koy8Si0K5sXRcA8ZC/zU9KgNxm9g2aj30I4eQ=;
        b=IHs1vWwBIBdtpR/7I5ZClMJgRvZw67btuv9t84vURuGNzJHp1V6ySKCj5Ve99xfydT
         2SarCKSi/4Tw1nMv+PWV3Z4ltstEoxgxWMbDXVqdA7OcckZPp8+/YKjfy49ROH8PZOS8
         hY5oT+R6ANsgGAL+iiws+MKaBDjj2DC9unH5U7JDUccv45EwHo7hxx4UDboUuLI9W0dF
         I0FdX2nqZtIBIpG7cI0Imy0Mgoj3hYXmvBja7dKpd3RKesgudAD9cg3wE1UBOHzwEuru
         Wui3e/ClcFvqDugxYnPQ+zqmXVDT7YAY40ZuD3JSY82Al29yCN4VF7Yp0VqmPQZHMZNG
         L8Dg==
X-Gm-Message-State: APjAAAXQCrawoL/ALgmkkSYK8aCnHqp/3cXX3OwRZg4Zd/6yn+/KbnzV
        Ssa+rk4781RLlwZ+nL1nY+q5Pe7i8Gw=
X-Google-Smtp-Source: APXvYqzHeU+KgELUyM0+d8l9eN8p8X38YXlvIDCnC19xRK3orLHsAi+j9EUb1g7KwUJQqngW9VPswg==
X-Received: by 2002:a24:94c6:: with SMTP id j189mr835055ite.97.1557924562092;
        Wed, 15 May 2019 05:49:22 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id 74sm105226itk.3.2019.05.15.05.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 05:49:21 -0700 (PDT)
Subject: Re: [PATCH 18/18] arm64: defconfig: enable build of IPA code
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, Ben Chan <benchan@google.com>,
        Eric Caruso <ejcaruso@google.com>, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190512012508.10608-1-elder@linaro.org>
 <20190512012508.10608-19-elder@linaro.org>
 <CAK8P3a3f++abVkXo3eEky5+xx+Jpp3ApFbWfwvh4rekQzpmepw@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <e7a0bff9-ee4a-0842-3e4d-c3e0da9e8523@linaro.org>
Date:   Wed, 15 May 2019 07:49:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3f++abVkXo3eEky5+xx+Jpp3ApFbWfwvh4rekQzpmepw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/19 3:23 AM, Arnd Bergmann wrote:
> On Sun, May 12, 2019 at 3:25 AM Alex Elder <elder@linaro.org> wrote:
> 
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 2d9c39033c1a..4f4d803e563d 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -268,6 +268,7 @@ CONFIG_SMSC911X=y
>>  CONFIG_SNI_AVE=y
>>  CONFIG_SNI_NETSEC=y
>>  CONFIG_STMMAC_ETH=m
>> +CONFIG_IPA=y
>>  CONFIG_MDIO_BUS_MUX_MMIOREG=y
>>  CONFIG_AT803X_PHY=m
>>  CONFIG_MARVELL_PHY=m
> 
> Since the device is not needed for booting, please make this
> CONFIG_IPA=m instead to keep the kernel image a little smaller.
> 
>      Arnd
> 

Oops, yes, that was my intention but I forgot to fix that
before I sent it out.   This code works as a module, but
in order to make the whole system allow the module to be both
removed and re-inserted safely, I need some work to be done
on the modem end and that's beyond my direct control.  I have
been testing with it as a kernel built-in driver in the mean
time.

In any case, it is my intention to have it be normally built
as a module and I will ensure that when I send out future
revisions of this series.

					-Alex
