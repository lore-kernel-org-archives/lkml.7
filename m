Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7B5C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D6B206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJtcK5Q9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfLMKi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:38:27 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43148 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfLMKi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:38:26 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so6054912wre.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 02:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3PajvE4U89zM4c9b6Z3Ov4BIDK06c8U6cfU/TzH08+0=;
        b=QJtcK5Q98jqQJctfBclFZQgZwwjBBe7trS9gB4hCyVLX3tSbswC2f7apFDXDdc9FCk
         bSiTeoS6TmFJk+AoYOVNAxjSj25sxM3IAj1qt5RBisbzi3o78OJCAe1jJkZGYW/Lqo5C
         DIgWzmDnWmVzjy7AQogXRIMEdKq/kaZjpffj1pcYmTCEHAhkXsezVJYs5b7BDgb4j4Fz
         Mes6GeXbvTrZ1qvmx1RK/WBPqrmY3M7jsf936VM6Bg3ATsNAxkGd5iNk0L6Or7lphiEV
         TU/obVxMZGB6aqGUkXJke/FZofhldvEIfoWJfQWeMudqfsPlxxaPi2IZn6bwJfrEeHC0
         KqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3PajvE4U89zM4c9b6Z3Ov4BIDK06c8U6cfU/TzH08+0=;
        b=O+28fScDgEthYTkvv3CDWsYCJJFJLmu7RjHrjQdHJaDtmczD4xl73UmPqBeb+wQL8g
         bRSNM48urucytfSkJfiBbE2JALP2LJvpuD/de3kcTu2uBaBdUkE6APXcNXNB629GIEJN
         i6okMEgyTCAStfE3DbWvw0RiP8jvV/ADRHXYK72SUMOCQufOV0YzerS72h8nmL+7mK5i
         K4fySZwtVzLnHM8fHqgYTTB0o17o6NuIxy8c2cM+TZd95oWLPi1YyVkJgmF3Mh7bqtmV
         SdOlXfgHaT5fZuIeIv20Up3eKakmIsFdSm5h7q6ZISTYoJobxal6w7EFGCTrPak3PG5l
         hXfw==
X-Gm-Message-State: APjAAAXOZBA9Mq7BfnOw8eVabRhYrcpK2YTiG+Z6EV6DjkjinRlsXv7T
        voze8AiajojhXwr95NKRQnJAzw==
X-Google-Smtp-Source: APXvYqwSlwN/xryi9wsN+GWdpVYtgcBzeElei/4HaQPkIFno6ZioimPpsoWMIS9mGO3ma6clldo8Og==
X-Received: by 2002:a5d:6390:: with SMTP id p16mr12186910wru.170.1576233504648;
        Fri, 13 Dec 2019 02:38:24 -0800 (PST)
Received: from dell ([95.149.164.71])
        by smtp.gmail.com with ESMTPSA id m7sm9626326wma.39.2019.12.13.02.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 02:38:24 -0800 (PST)
Date:   Fri, 13 Dec 2019 10:38:21 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     support.opensource@diasemi.com, robh+dt@kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [RESEND PATCH v3 1/3] dt-bindings: mfd: da9062: add gpio bindings
Message-ID: <20191213103821.GC3648@dell>
References: <20191212160413.15232-1-m.felsch@pengutronix.de>
 <20191212160413.15232-2-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191212160413.15232-2-m.felsch@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2019, Marco Felsch wrote:

> Add gpio device documentation to make the da9062 gpios available for
> users.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> Changelog:
> 
> v2:
> - remove sub-node documentation
> - squash gpio properties into mfd documentation
> ---
>  Documentation/devicetree/bindings/mfd/da9062.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
