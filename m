Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52057C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0E921848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z6CtY8Ie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404438AbfJPJ67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:58:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43832 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404428AbfJPJ66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:58:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id j18so27267717wrq.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 02:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1JJaHMcbMsbLe6bqOLxOZ4LA46aSJph85+5srfwddWk=;
        b=Z6CtY8IeYv/HalcBoW1F/i9nFOEGtJcyEHLoTrJvOWkIrd7lsT0xGlWgWf/K+rBQaV
         GskTrw0KVuyJnWRsXo1QRtbZrtbEmVXy6hmQjA885Flilf/60H3DwOWlNCKL1TQ+uagD
         +GYutWOKmMVT6l7T3Ssr4pldQBte6lcC3va70H1zg+ozKAgwmuS3qMu9PiqDbWwwgI5D
         WP6dPtAagarekTDLslk9G/w0JGWABtcnhIq/hcg0FuWexqNJyX1OcoTZYdRtV9cQ6HK6
         0xgkHsj9mEqNbHSmxHo2EPWYXe7m90BhUMzXCElEJ/zK2zS13aSNLhU9ywm/T0X8s/oW
         LqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1JJaHMcbMsbLe6bqOLxOZ4LA46aSJph85+5srfwddWk=;
        b=QoajzA+C4fVmIh1plJqyur5wlhGbWL7P3TeeI44nhJZN0YRZ/CIFI55K1O1gqW2TVB
         sQqvf3g+dlD2Fy+P4rNDr6MopSXJ6JS+5ZofewzwkgUgXhTlx5EFpYlGidjMIMaGxYWs
         DAJBgyZvtRgGGqwj+vHa3aoAAVqJSuoe/UkeAQxqxqt35pH+Mjs4YT5a8cOyrVEgTBY+
         TUvjAkglHN+PYq3hAFzmvtTYSj9FLCtYRHxT0SGRzk0Q6Dfm2x/6hRR4wm/9Cayh2vDs
         4BwKkijeWN7HrIPqxDN8RD8sQJE99AcFyNaYN0Vs+G0KFjYcbU9qcLFw843Rx+4VfT+G
         03jw==
X-Gm-Message-State: APjAAAUPyl3teG9wx/lyDZ88nRr/04EgUVcZECVoNrdDDoGWT/sFsc/5
        yjDL3HTV5rV+LdIR2zSadWC5eg==
X-Google-Smtp-Source: APXvYqzgKc4cNaPan7mRsJhVE2PgVKuFZ0jCy08TlGBE7OnPIIcloQPqzJoWdX2wrupcxjGbazR3lw==
X-Received: by 2002:adf:e403:: with SMTP id g3mr1789093wrm.294.1571219935315;
        Wed, 16 Oct 2019 02:58:55 -0700 (PDT)
Received: from dell ([95.149.164.86])
        by smtp.gmail.com with ESMTPSA id w125sm3964759wmg.32.2019.10.16.02.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 02:58:54 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:58:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] mfd: twl: endian fixups in i2c write and read wrappers.
Message-ID: <20191016095853.GE4365@dell>
References: <20191013093015.1395332-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191013093015.1395332-1-jic23@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2019, jic23@kernel.org wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Use a local variable to ensure correct endian types for
> intermediate results.
> 
> Identified by sparse when building the IIO driver.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
>  include/linux/mfd/twl.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
