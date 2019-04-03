Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B660EC10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845A820882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tlSNg+kT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfDCHqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:46:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39997 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfDCHqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:46:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so4630266plr.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 00:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cld4RhZn5TnQ5gVtif4Sk3V8APHdjBBFec+kPImys0s=;
        b=tlSNg+kTC49DC/j/sOTza0pWRoE021Yg1u2TXlmBwfk8Jl4k/ZjaKb9RiZpRzeWjnM
         yTaIr9ypOCxazcwCIBic5qYzoXfR+UV9qKROHNlNxdbp/7nSpb5e6KhDISl4Qsv6UGeX
         kdbRXynNefCSyjMoiQ/UesiWfIxzCt1zeR5QcPQGeQwVxp/TCp7yFIUCTeihJ/Jlz4QC
         ZOUnV+NDzGidQvjjXpUsSF664EqBDFfnBGAo80vkL9bFE13AZ8GBnCjy0r/L9hUYuprc
         6bpHsanE1IWt8Wkg/sNAvKrbFLoeHxLLTQK00ARWA6tkrMf+oLicbxzkL5Frf8GY8E1W
         6n5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cld4RhZn5TnQ5gVtif4Sk3V8APHdjBBFec+kPImys0s=;
        b=BDCZ8jpxbLAvIhvYFSwUhgSIwJG2zEcOIj5UQMFHFSUFFj5veP6cOFdCSQc4w87YbQ
         I+VX/g+QtOKsu1ZgbcwKS5v8yeOtuMlzX9vgRPO4l2JMglyyhD81YVenyCl5gT1evH6l
         dBW0VZzUj9QaqcJF4gAG94ruwhCH+WtVxcNWbB/4A743Y3rYEr4+527Y+e3YOdmDWn1H
         nqzfQtPI3Dm6A52sjze9KKxU+Bghbgjj9GE9lug6wdqQn1GzY086+tiy5BPsJ5cIGVbQ
         OpHb3zLM+feFUfDIkzf4vK0bLWoR3aecv2s8f6JQYkqDYRkk3gqi7eZl5+BNohRn/xVh
         kkjQ==
X-Gm-Message-State: APjAAAWAjPd9wj0PRpdcwJlhHwggsbZBCwIVouVONx3WzXbcW1BmZ+HA
        KKMGgeJ+Nnoj+74Hq47NnMcXRg==
X-Google-Smtp-Source: APXvYqzaB66xqtTS1PASDFpgTEJmoI+dIOZ+E8wM/vaYNJkuOHnvKhkII2l0fLA0+/zKK+TDUf+dGg==
X-Received: by 2002:a17:902:b60d:: with SMTP id b13mr22534693pls.100.1554277592924;
        Wed, 03 Apr 2019 00:46:32 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id a129sm45468814pfa.152.2019.04.03.00.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 00:46:31 -0700 (PDT)
Date:   Wed, 3 Apr 2019 08:46:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH 1/4] mfd: da9063: convert headers to SPDX
Message-ID: <20190403074627.GC11301@dell>
References: <20190318155728.28365-1-wsa+renesas@sang-engineering.com>
 <20190318155728.28365-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190318155728.28365-2-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019, Wolfram Sang wrote:

> Covnert the headers of the source and include files to SPDX.
> And fix some typos in the descriptions ("interrupt" instead of "I2C").
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/mfd/da9063-core.c            | 8 ++------
>  drivers/mfd/da9063-i2c.c             | 9 ++-------
>  drivers/mfd/da9063-irq.c             | 9 ++-------
>  include/linux/mfd/da9063/core.h      | 7 +------
>  include/linux/mfd/da9063/registers.h | 7 +------
>  5 files changed, 8 insertions(+), 32 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
