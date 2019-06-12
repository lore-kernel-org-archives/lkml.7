Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF72C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B7C207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s4x/t4m1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437672AbfFLJlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:41:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46916 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406059AbfFLJlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:41:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so16082750wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 02:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DjwvTNI/CdJpPRhUaL8QOE53B9cqUtgqTen6I5hJkuI=;
        b=s4x/t4m1Bv3JIF78+tmkQNOT/deiMfzEpipdoQhG2GclFb+x8Xoyh2T5CTQ2shXxAA
         OX1jQtq/3E/xHZrUUrIFX/AyZt9ztwKkZNKjQrl+7dxhwZ36m2Oo9n6zUMfzWkvQ2jio
         14Grqt/yrRY90POB4j5SApoWtQHH+dKxcNAXYyo79iBFIBJZhRfKOdm4yEvRPacKkd0o
         Jq4VXyv5BhfIxcaj43cAaIkDoJM3KdhafzzJrivIsZ84Tvy2IeLmUgmTY3Kg9ZRY1KH9
         5KYUE7Pl0mpk6I/QCbZ07u5WGZzzWS+hzKI9P4t1gz8rhBEipSIaB3bkJEz9VJu5ASUN
         VYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DjwvTNI/CdJpPRhUaL8QOE53B9cqUtgqTen6I5hJkuI=;
        b=EzF+tK12aOsInEtbGle6KZmMtcehqGFlnmgE6kVWMUn0BGwoNhEXsVw22X3b27ZnU1
         jltQTZo11ieHIqTpwvIBP58zjRrdmUJKfYhSMyEvN1T9onY4t2hcqw5MKhE9hYHEcVo6
         6555LjBfk3FSyLIMS1yQBCcp2Nybf+ZoIFGZ8Pn1pjjFMY0dLtaHoj4WTPv42viZS2Hk
         DoslCB/YxagXRGZkdSy2MEg4Uv66XQsEfic6VE45TffJshA3zY2JGXZwfWdVLh2ypzXa
         rzjO5jQlHTD4PbPp1Rz41X6RaOH/7GvC3OUQVzkL8yZ629jtGJ/6lAHZbS1yHPDtf+I2
         FZCQ==
X-Gm-Message-State: APjAAAULbdgnAdum0Xr7Re8S0RSlisbZbBi0Ox9RU7iiUX5kyYjemlto
        HzaXT5ZqgKY2jciLSwH8ZaqpybxF4xw=
X-Google-Smtp-Source: APXvYqyjWINeFcR5hi2Rkm+lpyNCDo9ZFhr032AbmzqnGxorzE/fWtCRWvVLOcy4f592VJi86h87yw==
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr54141291wrw.65.1560332504489;
        Wed, 12 Jun 2019 02:41:44 -0700 (PDT)
Received: from dell ([185.80.132.160])
        by smtp.gmail.com with ESMTPSA id 6sm17596767wrd.51.2019.06.12.02.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 02:41:44 -0700 (PDT)
Date:   Wed, 12 Jun 2019 10:41:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mfd: rk808: Prepare rk805 for poweroff
Message-ID: <20190612094142.GH4797@dell>
References: <20190607124226.17694-1-stefan@olimex.com>
 <20190607124226.17694-3-stefan@olimex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190607124226.17694-3-stefan@olimex.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jun 2019, Stefan Mavrodiev wrote:

> RK805 has SLEEP signal, which can put the device into SLEEP or OFF
> mode. The default is SLEEP mode.
> 
> However, when the kernel performs power-off (actually the ATF) the
> device will not go fully off and this will result in higher power
> consumption and inability to wake the device with RTC alarm.
> 
> The solution is to enable pm_power_off_prepare function, which will
> configure SLEEP pin for OFF function.
> 
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---
> Change for v3:
>  - Remove useless warning messages
>  - Change poweroff error messages
>  - Add explanation comments
> Changes for v2:
>  - Move pm_pwroff_prep_fn to header
>  - Check pm_power_off_prepare before make it NULL
> 
>  drivers/mfd/rk808.c       | 50 +++++++++++++++++++++++++++------------
>  include/linux/mfd/rk808.h |  1 +
>  2 files changed, 36 insertions(+), 15 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
