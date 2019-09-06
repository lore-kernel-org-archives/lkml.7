Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B8AC00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94CB20644
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fC8CMseB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395040AbfIFQ4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 12:56:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45388 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfIFQ4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:56:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id y72so4862126pfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 09:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=khSISmDs8BJQ4FTYTxZnbVWIBB1FiQsVmFwhUOKpZSM=;
        b=fC8CMseB6BVuogyR2ZnoGXAzlmprqs0RnjlaUVhsO9bmGmb0nKhxhAVrn3gPPV/PYP
         56oRNaUcfjBU9HpWd/dakx4VbHzqZv8e6jsppXkCTh11JRPQsPZftZeTXfdktv60CR2T
         hyNO9VdPrZg6YjEphv1OthPcXOxKq00gdUin3fAbqosi206DNtuJIgb3OT6fqRDndBBq
         jeU/i7O5wrfUA7KmFi+CCNTJ3jkO2CFsoK/yN03UvvBtuzXSj68uz913/WegIDkpk+FU
         pc8OjttkDKFRwHI+dapGTtDmQlAieCTqq4rpwUgC+m5it3R1fLYRf1pPJ0sLGir4KMI8
         D4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=khSISmDs8BJQ4FTYTxZnbVWIBB1FiQsVmFwhUOKpZSM=;
        b=ojs0NJjynW6m5djKUYQBK+f/ADCDy2ZImi1j5XKE5NhxyvF6h7teQyi4chQRCAMdU8
         C9O6wPII5pGMP+itDBMvWPcUgav+Dpbrh/pY/+tppk0JUACRqHALDL/YXxd6rNKYSyBP
         0UdOVV73dob+qoBm9UKocwSFOPSbiTtxqJ19bpT/UhDuEhE5DVPfYRQofAVhmMKT801R
         /nU2TV6gfaqFlNfdW2rI7AA1bnYqVRqNFNGBcMMGnDQJhXhHTsIxhKv/gMxy8lkdHLoH
         ilWxInlEkEeK3393sQuNdcvCxdFxbSSi5JxMCDJbPSi7TZa9fGHNL0PRz6EHBH/p6b2U
         1F4w==
X-Gm-Message-State: APjAAAX5HJIPhSepAvp/Yut1JEhFTsMVBritP3HUaOGyWG+2hJNWQJx5
        aZJ3fXw2D0062LschW7XU+2g0g==
X-Google-Smtp-Source: APXvYqxHMfju2ZwUAufiqyWRVABILob2U6DZ8JT+r0SfPfvsaI+o2zremKpT6Ldth18K0bYYbX6+NA==
X-Received: by 2002:a62:524a:: with SMTP id g71mr11734144pfb.154.1567788972891;
        Fri, 06 Sep 2019 09:56:12 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id u9sm6435931pfn.29.2019.09.06.09.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Sep 2019 09:56:12 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: meson: mark PM functions as __maybe_unused
In-Reply-To: <20190906152438.1533833-1-arnd@arndb.de>
References: <20190906152438.1533833-1-arnd@arndb.de>
Date:   Fri, 06 Sep 2019 09:56:11 -0700
Message-ID: <7h1rwtict0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> The meson_vrtc_set_wakeup_time() function is only used by
> the PM functions and causes a warning when they are disabled:
>
> drivers/rtc/rtc-meson-vrtc.c:32:13: error: unused function 'meson_vrtc_set_wakeup_time' [-Werror,-Wunused-function]
>
> Remove the #ifdef around the callers and add a __maybe_unused
> annotation as a more reliable way to avoid these warnings.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

