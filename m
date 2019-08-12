Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC660C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEAB2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XR1tewy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfHLHrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:47:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37918 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfHLHrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:47:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id g17so103695899wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/TkmzmCFMyqU4MHKNjTxgUU+DI3GkWHVrAyNy+f/OJY=;
        b=XR1tewy8pZSw4N+Xl0PLWK3l41j5iOTg1Jyjkr/RYJ4rPxaP5vYzI0UVL11YX6Wxup
         EGtUb14umTd8OPADsYm9+1ViqC9Fy3cb+B13OTP/1cfmKLgTw+KKuT44D12y/WnR8BHK
         cGKoKsKIMdIRFEMof8dya9mDRwpWi3DWWsJ0InkAZ4bkJ3DlnUlGWycvYMrs7nJL7sT9
         maGiYjdcAwPiVcLXuPotjBoh5dfgzgFcdiuDYHhf1z1swV853RZ211YXKRn/wwYtcCri
         MtBOzUD5NPsnPgqxesk8AMjPWpiBd3IzgsgI+0eFmEM2rrxOscSeEDRMXQeb337W/UcD
         M6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/TkmzmCFMyqU4MHKNjTxgUU+DI3GkWHVrAyNy+f/OJY=;
        b=rtn9tdC6hevGJ9UMFrhq1NTannhzU1lkI6OQD6Rv1H+rd0h0/dE+Dc5EKodMDoSHNc
         Nyxuy6iI8ak/rSpbTqXqDH6l9poKGWy6cfXBfRC+SfUFIKDOevH0Z8oGfmoc1/JanII/
         idZQT098jIhsR8tHjQuGtfdgCp8JkdqdIIvTgVRqBnn4vY+ZE0rkmgw+to/eqDAhQlm0
         mOgGQmmgHgSe4B5HoUQyRiagpqSayFQZ3H0XHWw9lDJmx3Ua2U6SUC68DBWEKo0qR017
         D1DCvdZAnrNaFPg5suZlusdrBZcxHv9Jws/oeljhongYLOHwA+huKH6Rpmr7I1bH2WW1
         ttVQ==
X-Gm-Message-State: APjAAAVvy/dhw4284xeiPOVyEHPAw+fafBq15OpaS24UEyd8hB1bJRao
        w4mczkOamyrZbepPQJ8M5br7hA==
X-Google-Smtp-Source: APXvYqwtsIceym+HBdhg9F4nrHqXzb+kG7g+UQ2T8fIIbXRfQJIJiyfscs23rHM3XDDAKKLObiGM1Q==
X-Received: by 2002:a05:6000:10c9:: with SMTP id b9mr26201744wrx.11.1565596064084;
        Mon, 12 Aug 2019 00:47:44 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id a84sm15915564wmf.29.2019.08.12.00.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:47:43 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:47:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/14] mfd: max8907: convert to i2c_new_dummy_device
Message-ID: <20190812074742.GA4594@dell>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
 <20190722172623.4166-10-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722172623.4166-10-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Wolfram Sang wrote:

> Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
> ERRPTR which we use in error handling.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.
> 
>  drivers/mfd/max8907.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
