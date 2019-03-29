Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34686C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB119218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ibnDC32K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbfC2Uw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:52:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33764 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730104AbfC2Uw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:52:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id b12so1774497pgk.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 13:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=cGY50xjzFVSSIAoX5cwCjdfaK62U/LdZu8eZMT/M774=;
        b=ibnDC32KJ2cDA6C2Tt7GSOXBsRpxpQl+4E0ViAi7xIhikv0fQyNapSvygQ4MoFHdE/
         3T2KlVhKW4qsiu+jUZtBB+CCZWJqq15zjkb4NwkBAhl7v6njxzDrx+eN8ZYK9v21Pxbx
         srX6wu3I5wlRGthaD8pKC+XEysMjn/+2ZV8POrMezmywHO7gGjewMY9o4JNAaBtJpYIJ
         07JVx02iOQ9ugzvVbK1g9z2tShHHbRHZv8uw2WcepuJ0Sjk4Y/p8idBleiqFGdEwHOpF
         Do5dQV8gpQsc+C9bgm19DXLN60P7ebOua+bELkUIonYLOzpyBoLzEb6yRwSEoQZUiiZ8
         XHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=cGY50xjzFVSSIAoX5cwCjdfaK62U/LdZu8eZMT/M774=;
        b=FjYB26CThRQKoZ7H77MEVHxQOmFyoBP4IFhdhyIP99C8HPiBrQDyziCbeoEY7mm6nn
         Mz5Yjs4gR3JCRA46fTDLuDofwUO6VxFXKsZbH7xfIHkStV47sS//DZjg7k4TTVbmMfsq
         30TlvMnueHNjFl1U7zbSVetmeLhZlAi4Y5aHf58wORDzhupBlaPjtMffaJkfcau8ZHmx
         A+SQD02+cn+Z90Ck5pRPDksB7dXcKvgLruBqTVu317NyeQquupfALx6T35FJuWM66ZyJ
         WsKfmANw/E1nlQSQpOmX4ceg4bMlHQUSezmwu2FSQDTJBxni6N4P9yrffaZy6pK+zPJm
         YjVQ==
X-Gm-Message-State: APjAAAXCDifOfNOTasoRQiHLSrGEFhdxO7Al8r1sDb/YqGENbZdKHur6
        XRkFk92U7C5qsuWiilIRVwc+Aw==
X-Google-Smtp-Source: APXvYqxvt7ngPciCp5/4DEnTpJkJyGJSP1TfNvd1SSO+6ZdawVnV/KXvMTnwArFRfikZKd+tOqMMzw==
X-Received: by 2002:a63:4a4d:: with SMTP id j13mr47074131pgl.16.1553892746309;
        Fri, 29 Mar 2019 13:52:26 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id n65sm10301733pfb.160.2019.03.29.13.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 13:52:25 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] arm64: dts: g12a: Add boards peripherals
In-Reply-To: <20190325101453.3009-1-narmstrong@baylibre.com>
References: <20190325101453.3009-1-narmstrong@baylibre.com>
Date:   Fri, 29 Mar 2019 13:52:24 -0700
Message-ID: <7hmuldwghj.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Following [1], add regulators, bluetooth and ADC keys on :
> - meson-g12a-x96-max
> - meson-g12a-u200
> - meson-g12a-sei510
>
> Dependencies :
> - Patch 1, 2: None

Queued for v5.2 (branch v5.2/dt64)

> - Patch 3: SAR ADC node at [2]
> - Patches 4, 5, & 6: USB nodes at [3]

Looks like I can queue these as soon as there's a stable clock headers
branch I can use.

Kevin
