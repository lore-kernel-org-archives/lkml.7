Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988D5C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2E120700
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZ63z1xb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388824AbfJDN6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:58:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34440 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388667AbfJDN6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:58:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id y135so9695117wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 06:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Dw8CR7XEfOJ9npS37MQu+Odwfp7WIPeVgi6WO13Fiz8=;
        b=NZ63z1xbbA8zyZllIg94iS2Gl8dmSZBFbzDDievubTzQdWyhcPRpEpeqP+TRNnITBz
         ESTirw/C1bsYg1SuDnnPBJoMOcwl5y/M+eR0bUavEA/ImrQFbYKnadf5eH05cZTKhFmw
         r4YgwYc2d9D1+Rb0vStCa7no5QfdjzMq63m4qJ/dicCu11SXBtao9lggWXcmhn+YhxOv
         k0hZLFhUuDXnuMe9WJZjeS0EyYkhPiVgW77yoCELJM1OW1uW2e1NnL/ZBiloAx04WdjN
         uebT2jmwJsNhAxnoexJkFkU0n1UiwwgZ0qoOJjfZUlIwen+NptFgGovzzTXuX0saHPQ1
         P3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Dw8CR7XEfOJ9npS37MQu+Odwfp7WIPeVgi6WO13Fiz8=;
        b=D0IG0R2vm7gU9DlrbG8m46x71cZkQNT4DB4AXQt/jSSYp+P9quUFMDRox9PByBTNva
         jM1oy8IrtN69IZA+vSPxdcoVj8XjDmIEEWycsjN27a8buTL0YnN7k0lppwIgPPVWYkAC
         cw4F25ijiYYXZ5yA5uwsHeT0Ly7xykOKDA+94K5fCRhSP8lgQu/FR/SijDbxtUwtgvxa
         hKUKOFl0Jh4sS+Sw0f/XjNpz7gCcHOZFtxKtc2zc7Q3RLe64zQv/XLTt61IlON1Bqosq
         pU8PxLhgVZP8+Gp4IPCGTKg/k1A12spu0iieM3IzPG2eASoc7ozPfCD6ZSej+K6uw5ae
         R0sw==
X-Gm-Message-State: APjAAAUBRukkUcPsaDbHOPwoTs1P/4UMeUlAyVx7fPf9DVanCI878B1Z
        Z+NMm8XdevJCB/RjZv4FWx+J3w==
X-Google-Smtp-Source: APXvYqxsSuehmxsrNPOlj9JuBPTRmUAulOr74tH9QtvFC3b0fMLFsR6SbdAFKt15AEdgwZaAq8dRAA==
X-Received: by 2002:a7b:c776:: with SMTP id x22mr10088165wmk.123.1570197521770;
        Fri, 04 Oct 2019 06:58:41 -0700 (PDT)
Received: from dell ([2.27.167.122])
        by smtp.gmail.com with ESMTPSA id m18sm12287804wrg.97.2019.10.04.06.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 06:58:40 -0700 (PDT)
Date:   Fri, 4 Oct 2019 14:58:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-input@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 1/3] mfd: mc13xxx: Add mc34708 adc support
Message-ID: <20191004135839.GG18429@dell>
References: <20190909214440.30674-1-lukma@denx.de>
 <20190909214440.30674-2-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190909214440.30674-2-lukma@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Sep 2019, Lukasz Majewski wrote:

> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The mc34708 has an improved adc. The older variants will always convert
> a fixed order of channels. The mc34708 can do up to eight conversions
> in arbitrary channel order. Currently this extended feature is not
> supported. We only support touchscreen conversions now, which will
> be sampled in a data format compatible to the older chips in order
> to keep the API between the mfd and the touchscreen driver.

Please take this opportunity to split all the ADC stuff out into an
ADC specific driver.

> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> 
> ---
> Changes for v5:
> - Remove adc_do_conversion() callbacks from struct mc13xxx_variant
> - Remove duplicated MC13XXX_ADC_WORKING #define
> 
> Changes for v4:
> - None
> 
> Changes for v3:
> - None
> 
> Changes for v2:
> - Change the return code patch when the mc13xxx ADC is performing conversion
> - Introduce new include/linux/mfd/mc34708.h header file for mc34708 specific
>   defines
> 
> Changes from the original patches:
> - ADC conversion functions prototypes added to fix build error
> - Adjustments to make checkpatch clean (-ENOSYS, line over 80 char)
> 
> This patch applies on top of Linux 5.3-rc8
> SHA1: f74c2bb98776e2de508f4d607cd519873065118e
> ---
>  drivers/mfd/mc13xxx-core.c  | 98 ++++++++++++++++++++++++++++++++++++-
>  include/linux/mfd/mc34708.h | 37 ++++++++++++++
>  2 files changed, 133 insertions(+), 2 deletions(-)
>  create mode 100644 include/linux/mfd/mc34708.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
