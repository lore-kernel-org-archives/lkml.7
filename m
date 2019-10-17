Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F294FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A0E21835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rLw/zBLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408420AbfJQQfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:35:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37399 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732537AbfJQQfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:35:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so1993561pfo.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 09:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=n6iC9aFIm7u0dU/zNM/QcsEIHkk1HFiJjgCYQoT2Mo4=;
        b=rLw/zBLGb832jZnhC2XQDPu8GmL2TDqIyAqgKiHS1bkVHYZkpv31ojFkQe9yoiJosu
         OATsID2jjJR5fxB+f27xypsvogvi6NjOdJuEY7WyxCWVO7QiPmERQP2+3LNeZNHKeyYy
         U22+IPML7CXzC6MXwg06aYBKwbQvWV1aigUizyhhQR+EVGzHw+1AhnxJoW8lCCKcuziZ
         eCRAX7bq4dZl7sJRffrCj8kB0V6/MnbvHkNqZ1ZUfVoC4MD5M4rHy2E4APOoapoH4CAg
         2xNy2mueNekGx0CHPQDYJUVPgXpm0OnuDNHVMnK6kDtFcEwWHo03utLEe0wjkTK/Sp3/
         oztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=n6iC9aFIm7u0dU/zNM/QcsEIHkk1HFiJjgCYQoT2Mo4=;
        b=qLEOryUskj311KccLw/rapNHetZR/s4O9pg7qZ4iDl8XpK8Jty2WekycmK7jOojubD
         iAAgeTqOVx1WhoNlrmCsvayuhtMWmJDck47q1TEw5KbpsKIKB5it18pgx69sOresMUZy
         6S5ux3LlOohqGS/vKE1yJdjmOm6QCQ62oQli2SCopcoBRO46hwEPbjBSg/c6YN9XInrX
         lM698s3DSl7H6l1VivRwv/5bj0UUtBVH28dLiPfjMpiZ5pRqS+ub3FnBsCd0CnxCBFym
         37M1nSt7Qwjiy5jou2fmehpndtivsRuXuHV7Po5GTkYNbI7yIZcw87plCG23wxSd/YoP
         divw==
X-Gm-Message-State: APjAAAWD4dMBPplITOf/bcuJre2B/HrgdQMBOMKWn6CPf1JEKcHWtsOM
        a75zb/QOlULkrSN5SF5/Wx9vSg==
X-Google-Smtp-Source: APXvYqx8QHZBP4DAVpyoFFyUNQRbXJjtCE3kG8SFGsa5w0UJekNJKz/9aCD9K0RXSuH2lXuA6W7rnQ==
X-Received: by 2002:a63:82:: with SMTP id 124mr5391099pga.112.1571330142686;
        Thu, 17 Oct 2019 09:35:42 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:d8f2:392e:5b44:157d])
        by smtp.gmail.com with ESMTPSA id j10sm3548870pfn.128.2019.10.17.09.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 09:35:41 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>,
        amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v7 4/7] arm64: dts: meson: g12: Add minimal thermal zone
In-Reply-To: <7hsgnsfxpx.fsf@baylibre.com>
References: <20191004090114.30694-1-glaroque@baylibre.com> <20191004090114.30694-5-glaroque@baylibre.com> <7hsgnsfxpx.fsf@baylibre.com>
Date:   Thu, 17 Oct 2019 09:35:41 -0700
Message-ID: <7ho8yfba8y.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> Guillaume La Roque <glaroque@baylibre.com> writes:
>
>> Add minimal thermal zone for two temperature sensor
>> One is located close to the DDR and the other one is
>> located close to the PLLs (between the CPU and GPU)
>
> nit: subject should be "arm64: dts: amlogic" (not meson).
>
> I fixed it up when applying,

I got it backwards, this one was right, the other ones with "amlogic"
should be "meson". I (re)fixed it in my 'v5.5/dt64' branch.

Kevin
