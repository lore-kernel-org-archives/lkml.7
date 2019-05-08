Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5EDC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5219121019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BFtRrccy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfEHLgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:36:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43767 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfEHLgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:36:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id r4so11446882wro.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 04:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VYEsTIrTb6DJazaNiImOw+whc/ESSBeWBeOW5FS1TNw=;
        b=BFtRrccy+NYqC9lMrlxqJyr0TAUtw4PZ/PimeadDxCHkBCmC9gtjj1QR66imPx8Ws/
         01qVIzJKdt38VSrItPx9vuAeXj0l3833LRGAz9Ny54L+jAyeYn+QdMxhD0WJJNmG0tmA
         xxDJusICIc/IfrL1WpaEg0GlEU24zDX+mU538hPNBT1owY15vPadE6rIBx9iKV6hHBgt
         oEltg7DxKDSZmP/Qtuasp1wA3C67a33U7qBnrHs/9DhctVlS+ZQ2SF7oIRLcSq34EtMe
         jg6T6aAgEo5zbeI9l1ceEv+uCDYwI3CEJW0jwM134W4DmhpYm0Z/31o2aXKImMcFOWiX
         5U7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VYEsTIrTb6DJazaNiImOw+whc/ESSBeWBeOW5FS1TNw=;
        b=d7r/rEXf/sNKl6q9KfJPE+BUyJJZeUbIDpTaJf+5ujiNJOekHZL8UVu0cItSpnEYQo
         3ygLZ8WqJAXAaDDs1boTTbASZeKIcyipoT0kM+cy0CqTLWNuMcxcqDFei4PuXNM+u76y
         eqLRyXQIAjN1brAVopusCB736JuCiulxxvcCkHb6UOb4G1e07+6NkRpdWHkMPx7AaGT7
         4F9fWPXPdJRDOLsvoRqoPc+yUllpDzf07Mx6rTqZB5ZiE1U8L4hj46dw+2/6k/jrN90k
         8W8H3asOOTxCm+DNjuGnHHsWiM4CvTV8vRgbZTiqDHGhMePjMUYI4+GfJdcGORw+yiGX
         R26w==
X-Gm-Message-State: APjAAAUQp6X/flWU+9AfOiGakTwf0ypHjKPLxghZJskDzWwf0Yv6wsOt
        7/c+0ul3Ug8oPApFay1N/0asvg==
X-Google-Smtp-Source: APXvYqzkVUcylD7EpwjDOvpTADOo5oDkH3ay31bK1cH9dx2YK+OA5OxIhE9LWRHgvVgDMDhkhbCfGg==
X-Received: by 2002:adf:c611:: with SMTP id n17mr3029684wrg.101.1557315379540;
        Wed, 08 May 2019 04:36:19 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id c130sm2539799wmf.47.2019.05.08.04.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 04:36:18 -0700 (PDT)
Date:   Wed, 8 May 2019 12:36:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, rdunlap@infradead.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 3/7] dt-bindings: mfd: LMU: Add
 ti,brightness-resolution
Message-ID: <20190508113617.GC31645@dell>
References: <20190506191614.25051-1-dmurphy@ti.com>
 <20190506191614.25051-4-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190506191614.25051-4-dmurphy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 May 2019, Dan Murphy wrote:

> Add ti,brightness-resolution to the TI LMU binding to define
> whether the device uses 8-bit brightness or 11-bit brightness.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
