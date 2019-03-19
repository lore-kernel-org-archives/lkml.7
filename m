Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44BBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36F620989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YWsbwxL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfCSKDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:03:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39450 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfCSKDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:03:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so6132447wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 03:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=E9BFs8WkH/ZGJB9LSb1nvBGbYjMHBI/Uj54YuFoNLC8=;
        b=YWsbwxL1xjRzrxX+nlNT7HrJJfAPwnHZ5G8QbtwUeV3vUQ84CL2o23if8K8p8w9yQY
         3ir2tlvkjAAEKkzxd3VmequdImIGWBrz5YCjTo0E/H+A/Lgl1PJji3uutyV1qwCFdhCn
         PRuAtW+g2U0JGiNnWZkbT+rMiy9Slb0CBSwTyTQw999SXj+CfRBumgZ92WYRPn1iMGL0
         GIOLYV1RZ9BS4MOaLrGAVIxQ36oBel29a879u6fVG4JL7/7Llzk5+noFU1gd2BBBlAL/
         Pi95ya+tklzngR8goD0JpEUUcqkMZbxBRCoL4VdqYjPHOpQp9U5HOvjX1IQGRXG+74tY
         uoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=E9BFs8WkH/ZGJB9LSb1nvBGbYjMHBI/Uj54YuFoNLC8=;
        b=EZj5oQe4xt3UgXV1XSPZuqYA1jGDTAFpsABLdsYnwSzn5t5QhhUofC2Bzdz4ZfU8XG
         6CG4LB63L5qZIpeYFKjNFK2hK2DXkQI+O4k821vTflnRGzztBmUrZJCuYbFMN6rL0+th
         LfaUioXG9C5ZgnTj8wHEXK2PlsHmNswq/n40/6OMJ28Fdn899+copiYuETMwj66M57TR
         T1KXyKW1g6AZCgixX/R01Cptwe1sZQipxf7py/Eo2B/D14plCXaCIvzMyyuWU+CwPkBi
         YLXszq90e2hn8zJqNF+40bFAVQV4PYIW7d+m1qEjhSU1WIUZ8PYy618FA9rzc45MGbrs
         kEEw==
X-Gm-Message-State: APjAAAW6pEu+Lvj5dhpgnZSjh2qva2y6vD0UIguiKZ38Cq0zd1ysziiB
        lbu77zm5Ep2os/jTwE33SlNmiw==
X-Google-Smtp-Source: APXvYqxM1xIccWBhSIGn/XeESj1+Y6oOlzcW2U8kYHiIlGRHafNuFiXUMplGO6PaMfCeGCVm7u5nOw==
X-Received: by 2002:a5d:4750:: with SMTP id o16mr15841745wrs.238.1552989781415;
        Tue, 19 Mar 2019 03:03:01 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id q17sm9257796wrx.38.2019.03.19.03.02.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 19 Mar 2019 03:03:00 -0700 (PDT)
Message-ID: <697115c457a70b458bf7514df72e802fc78e467e.camel@baylibre.com>
Subject: Re: [PATCH] clk: g12a-aoclk: re-export CLKID_AO_SAR_ADC_SEL clock id
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Tue, 19 Mar 2019 11:02:58 +0100
In-Reply-To: <20190304105358.4987-1-narmstrong@baylibre.com>
References: <20190304105358.4987-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-04 at 11:53 +0100, Neil Armstrong wrote:
> When submitted v2 of the G12A AO-CLK IDs, the SAR_ADC_SEL ID was moved
> to the internal non-exported bindings, but this clock is necessary and
> mandatory for the SAR ADC bindings.
> 
> Export it back to the public bindings.
> 
> Fixes: be3d960b0aeb ("dt-bindings: clk: add G12A AO Clock and Reset Bindings")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/clk/meson/g12a-aoclk.h          | 1 -
>  include/dt-bindings/clock/g12a-aoclkc.h | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)

Acked-by: Jerome Brunet <jbrunet@baylibre.com>

