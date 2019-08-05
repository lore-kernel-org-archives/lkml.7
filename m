Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D225AC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A392A20C01
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dI55BA8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbfHEU5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 16:57:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39913 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730055AbfHEU5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 16:57:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so40341160pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 13:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=MBL6QC5vlpzt5AngG/FRA3lcAQRQn0eH0TwH8QaWuhM=;
        b=dI55BA8Rc5L0QSs0H4asppkLBJnET85ehWDm3dOabaNPcD1tC57hPZW2xlBbrdERdW
         OHHgMQWNrOou2yw+G6GbBnHgHZ2R4uRBYW5UKBrvsZYCVRC1PJEREcnTkKsLYggHyB0C
         dwqSZI5UjSBK8z0e9PBQ+cOAnoVi3HeVuYuQIu8l2sV8Va0ma/a5HOWocV4d5Q835vcj
         hciHn5PxKIER5+hSQoZ3MWizab63fyIunxhFUmW522/kQ2Cx0Mn1RGyni6sJEqv2r7tV
         R/zDWe2jsVp0LAxgE+ZNLdvQ6WQw03tS6lk1RNuNVzNa8k9rpYlRTkISf6G0wo1R51kU
         YK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=MBL6QC5vlpzt5AngG/FRA3lcAQRQn0eH0TwH8QaWuhM=;
        b=CT6b0+i5V04snqC0THCx4qUgPkcw+B8IdkIx5oy9Lbo/qpa9SavMd33Pk4CDCTAJ03
         lyDmEj/risg/Z0ikdDUSCSl3y7dD3zz4+YRON6lVfDpGX+/H3k2s7lU5Y1P09XSQW774
         7tcriIJkyRFZiT47JVwIUaP6OasqCtr/SxqxSRnZCd4Haf6VnLKAr51Bhrc7Xk99MQSC
         p94MTfS/GPGhQgXbToX4bEo3dCV93m9N1ZqDb3MGpYVvbG+rDuuE7oTFpKgjrMKyrQmZ
         L/crmDhCB2N7PyshTPVgI/zXqY56YUNoavr4jtT24U2s+BDs/BIfN4UjH+PFIPgGpRNh
         Fmog==
X-Gm-Message-State: APjAAAUqwDbb5KlgumKacOuKZgZFbZlVVX5cnz6qwGZJaINxoQd8/4uE
        84KSl0+VjNVGfkM6wICMRL2N1A==
X-Google-Smtp-Source: APXvYqzpNga1cFOZRQehsL3w0s7LtZw+r6OECWH41h2VT7tp/iCGiPCuVTQUq2IXEBnZ8xJz7SRYXg==
X-Received: by 2002:aa7:8b52:: with SMTP id i18mr76135064pfd.194.1565038643597;
        Mon, 05 Aug 2019 13:57:23 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:7483:80d6:7f67:2672])
        by smtp.googlemail.com with ESMTPSA id q7sm96589013pff.2.2019.08.05.13.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2019 13:57:23 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: meson8b: add ethernet fifo sizes
In-Reply-To: <20190718093623.23598-1-jbrunet@baylibre.com>
References: <20190718093623.23598-1-jbrunet@baylibre.com>
Date:   Mon, 05 Aug 2019 13:57:22 -0700
Message-ID: <7hr25zgwjx.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> If unspecified in DT, the fifo sizes are not automatically detected by
> the dwmac1000 dma driver and the reported fifo sizes default to 0.
> Because of this, flow control will be turned off on the device.
>
> Add the fifo sizes provided by the datasheet in the SoC in DT so
> flow control may be enabled if necessary.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Queued for v5.4,

Thanks,

Kevin
