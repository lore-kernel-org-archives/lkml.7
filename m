Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D63C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7FF820657
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vAxkn0Pu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbfC2VDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:03:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40439 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730190AbfC2VDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:03:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id b11so1566398plr.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 14:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Vt85FaSQvqSIgKmDkeu3cTPdbJWz0R1Jr3LXR2DaZMQ=;
        b=vAxkn0PutHy75vymlaYCr9b6cXJFoQ5sN7eMLjCm6t6xKUjJK52dgImDwhTiPFaFcF
         Y3QzWSJx21qR4zu44IcoJaWpkLmTiYG4DrN1UcfUeSnqtb4SQypbrdqCsH5uh+oPRtIx
         i2hvC5oydY9vyyhyQc1HbPgS2+7DuiZ+pNZZs9qoCLEiq7YuiMyfib+bpuZHJmEerlTB
         T0IavAV9MH0or2fli4yUfSFqKtmtB4SxHC6kzfJoNe2Iwgx+6ennrsbBtcQMHWuH3omI
         yyvgMt5+1QgzX5XXoSjBxT4Qi9CecSpcV+0sZVNupQxFpoqisNtFRze+F5Bs9YoJSRXm
         HyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Vt85FaSQvqSIgKmDkeu3cTPdbJWz0R1Jr3LXR2DaZMQ=;
        b=J5KkWeg1XTiRqTF6dHiWlqYax/E2fhN9Vyj3tL8FTKeE2w+02VXyk4PUjlE+5f/1tR
         V6wYclzltZ4E1w2mnfbkVVb3FVQ7oQU2YHhqz0NU0sYgBdzh+5kbOCy9+sSBIAgDe47u
         EAv8w3hpf7aeQ6a6AsbZU55abpVOdgcjgWeeH9fpOChhvT7+YWOmJoj3K85ThScNJUVG
         I5lSKVqrT17f/Z6C3jPsiGCDh23UbCRz01dvp4m/6qfnNWa3WMefjymSwPLfmXl+GNZ3
         m0NbXwVnv1/5v/ZUE0B8HH0aM3jP1GH0TdN4HEhBQ+jApZjuWjoMc3ullYkViU+qQu9G
         V/Dg==
X-Gm-Message-State: APjAAAU7bl4LZc9OkyRkif9bBu3jxO1Q3KBEWuY8A/sm6a5uYwIsWD3x
        3WF5UCkITgFywfAgopE5Um6WNw==
X-Google-Smtp-Source: APXvYqzOT9qF0rIQW7Sax/XLVqPEkN0JDYAgoPre6kteLlO417SK5GBon+3AATWMw2qP3k3H2MoEjw==
X-Received: by 2002:a17:902:bb90:: with SMTP id m16mr52733859pls.49.1553893386859;
        Fri, 29 Mar 2019 14:03:06 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id y37sm4086752pgk.78.2019.03.29.14.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 14:03:06 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     arm@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] ARM: multi_v7_defconfig: enable the Amlogic Meson ADC and eFuse drivers
In-Reply-To: <20190328205122.27092-2-martin.blumenstingl@googlemail.com>
References: <20190328205122.27092-1-martin.blumenstingl@googlemail.com> <20190328205122.27092-2-martin.blumenstingl@googlemail.com>
Date:   Fri, 29 Mar 2019 14:03:05 -0700
Message-ID: <7hftr5wfzq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> With the SAR ADC driver ADC measurements can be taken though the IIO
> framework. Additionally the SAR ADC has a channel which is connected to
> an internal temperature sensor. The calibration data for this internal
> temperature sensor is stored in the eFuse.
>
> Enable the SAR ADC driver and the eFuse driver for the 32-bit Amlogic
> Meson SoCs so we can expose the chip temperature to userspace through
> the IIO hwmon driver (whose config option is already enabled:
> CONFIG_SENSORS_IIO_HWMON=y).
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Queued for v5.2,

Thanks,

Kevin
