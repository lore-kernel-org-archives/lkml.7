Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713CAC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D36921530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AykjrtNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfEHLxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:53:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53768 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfEHLxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:53:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id 198so2897451wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 04:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lQpYdKueKd5GodvUSuXNOvFoEgO6IktebbFb9QN9iWA=;
        b=AykjrtNqhwZKTNyKdi3loPGsyOQ6pj6vMupWy72eN3oJnHqGLGcu3N4HSjLt6+F9B/
         sXQP5z3gHPaE36AnKDkgHDwgrHW95o8rv7UJHhpY2j32hgC/BDwGF5Dy3xx+aKgdPxDq
         m2bP5sY219WiO1MRcLKWD6QMIEDN6/rIrfuZ/olk4HbYwV1ECPMkgonPEHbs6NJB6Kat
         8gcmLnzQ0ULxTePPDXi/Cz6zVyLjoRcGbkDdbhvE0D+lBMN3Ah7kw3ii2F7mfn8TRbra
         lerPjTbi7INob6Ci8zBxyjpAJ6xAmlyZ9JuqW7gbzqUyA8/n6mNr/EpjHv7D9FMANs0I
         tqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lQpYdKueKd5GodvUSuXNOvFoEgO6IktebbFb9QN9iWA=;
        b=a8usHu/NljtKyyxbAyC0FII99AecfB2naFCOVr4Gf+M4pzwy9rKAC1VH0V3BGMEkym
         pib9Q9eQkIoFycBhOi7Ui8K+UEWVx8K1fz9nKJhSqQ/al7MyDBa9zCDpsVbsBk27Pz7P
         /MCTSpN8KWr1M/UhJvZ+7f0ZL9hryiTGldsZNxia7pBRtVvWzFg0bt76Wv1598e2Xjvq
         /Pbi+VjKJy7o4ctV4wIQ39GOxEzj2C146iAYoBCHDzwCy7R0wZhg98qskWX78RLfHGLJ
         NfypAD5PpoHkoCB3aDW5Hb5lONONnquVy/1jirv4w5AbxYjz9Sn1A3jX6Dl42NW6jWIZ
         8bQg==
X-Gm-Message-State: APjAAAW77nVd7mmomAZj74jmakPFYWTWJysyikDtxEhiX5Dvb0vrjPLD
        p0Je/dkyTPDu7H6ha27fTKVTwA==
X-Google-Smtp-Source: APXvYqxHUiE2SWdc0d3qosb62vYh2L55jvapOGaR1hhteA8wydi1budIpEccC8GDTAtWGKYT1zyPcQ==
X-Received: by 2002:a7b:cb58:: with SMTP id v24mr2614038wmj.121.1557316409784;
        Wed, 08 May 2019 04:53:29 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id d4sm34521361wrf.7.2019.05.08.04.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 04:53:29 -0700 (PDT)
Date:   Wed, 8 May 2019 12:53:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, rdunlap@infradead.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/6] mfd: ti-lmu: Add LM36274 support to the ti-lmu
Message-ID: <20190508115327.GO31645@dell>
References: <20190507201159.13940-1-dmurphy@ti.com>
 <20190507201159.13940-4-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190507201159.13940-4-dmurphy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 May 2019, Dan Murphy wrote:

> Add the LM36274 register support to the ti-lmu MFD driver.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/mfd/Kconfig                 |  5 ++---
>  drivers/mfd/ti-lmu.c                | 14 ++++++++++++++
>  include/linux/mfd/ti-lmu-register.h | 23 +++++++++++++++++++++++
>  include/linux/mfd/ti-lmu.h          |  4 ++++
>  4 files changed, 43 insertions(+), 3 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
