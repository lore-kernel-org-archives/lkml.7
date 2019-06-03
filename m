Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBE0C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9970F280FC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EvYzUk3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfFCMbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:31:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41196 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfFCMba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:31:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so11866608wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 05:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4X+BKjND003CtQsEu+k+KAJanuZbQYGlrUQr+5ocFpU=;
        b=EvYzUk3KxhoDlmZYNnORhdLGXpQ+RTHVmdf6+Pgdw65nQ3NyQdkrMDkRzuUP1fn+I9
         WPQQZfB9jp3vWgquy9gNfYbRZNQtTpQ8eOVlH/7leSw+/Mq8GG6ttQHxXuew0F3ieBZj
         s/KM8KMnKwW7uYE4TBZviG9FI4iYnLpJ6d86L+IDFVdwQrAQ2f8kI1ZaWKsfFTaY9NL7
         lPX8a/eikBLOIU1F/xpaGauI7oS8uXCU2r1qWq64P6ldvea/KEceaQZv1yEiK/0u6IJq
         EdweNiFBYg9QUNUP1UM69G1dODugi+rNx92C3vtrSrNgy5/80CAtrqlTz0FrNGoVisHY
         QCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4X+BKjND003CtQsEu+k+KAJanuZbQYGlrUQr+5ocFpU=;
        b=dKb1jHCB2HaYxHo9jWHBoSZ8wbVWIBbTt9yEMiHxKDCZYIx03qJaEAYQaHzNScmEGV
         cLqDcwcjWs1TojC6Q8RqF+6RVFxPpPDN/Z/L9VrGvBevLYwv9FfbSPnUqoaMcBNzxbyD
         HVFfAfS99zpMHNaflc/+0g04Y23ebQ25hAtAL8+aL+XEG5JWsvsC7rilNzzq0N5Gs5vf
         g05b9/8VCFJw9uAS0GfsqcixdNdqPFGBgxLMDBCJreFYaOz0AjJ7sRfqzIiG+r+F0HLJ
         LAeb5A3GpCmWrueANN6EllHbxLKnmu+TurokfWAjqy6Im6L9ubtQKXKMWgX/avjtduLX
         GBug==
X-Gm-Message-State: APjAAAX/OFNs2gscNcYT1gM2isDt1BISdvLKfyG2WMZNoDC4Vx2BYSDH
        mtGjSGwOA6KoptbpBAqtuJYcKg==
X-Google-Smtp-Source: APXvYqw81sDtsOxKKZ85mVia8pbhoEesE471jLmJbbheZK0UTWnVYLHf4UriX72xynwRi7y/P0FgxA==
X-Received: by 2002:adf:f3c7:: with SMTP id g7mr15983765wrp.133.1559565089078;
        Mon, 03 Jun 2019 05:31:29 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id i12sm10373956wrs.43.2019.06.03.05.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 05:31:28 -0700 (PDT)
Date:   Mon, 3 Jun 2019 13:31:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] mfd: cros_ec: Register cros_ec_lid_angle driver
 when presented
Message-ID: <20190603123126.GL4797@dell>
References: <20190517233856.155793-1-gwendal@chromium.org>
 <20190517233856.155793-2-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190517233856.155793-2-gwendal@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2019, Gwendal Grignou wrote:

> Register driver when EC indicates has precise lid angle calculation code
> running.
> Fix incorrect extra resource allocation in cros_ec_sensors_register().
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes in v7:
> - Split patch in two: This is the MFD section.
> 
>  drivers/mfd/cros_ec_dev.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
