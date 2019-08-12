Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78849C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BC2208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ikjVWDKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfHLHrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:47:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35037 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfHLHrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:47:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so10887014wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=O//ZUJclnc89ssdCIp6IXRbvP5J4HOCWWkGmeHnshes=;
        b=ikjVWDKs7zk2gMXW618LuG9ZlbwJfxfKfpswwBih3LT+f2prrn2AiyQlCV64qGHTxi
         WyHbAyEiCYKAzjcgJcFR+AEkKP81o8ZGbyFTx/svYREKYKQcrxSVozbIhRtb6HP1WBZJ
         rvYEk8YMPkWtIMjxCHRfcBBDevDWHK89V4JSinDHIienpcqfb/9CHLVgapYg1A2LOGMQ
         h2oLIAjsa1aVEX5UQjhZWlREXPDWd+C5eKAAWYyOJo4RWDMczjcMT6ERA3+QJ687+Hla
         m26kWBrOBc9VBtIScu4mjoNK7ukx2VVGP92GPLZJPYdI5RMEfCn8mTAxd//cqWIV4BHR
         Nr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=O//ZUJclnc89ssdCIp6IXRbvP5J4HOCWWkGmeHnshes=;
        b=LuAts5HFWn6EDW5QAAADnrxxufRKODSGR73XMduQG6/vl7dx6jqyftOdAhq7ABro85
         pJ/sWWRu5yh2QE1WG4hoSnuUF8AyJ/Y+iU61mgde9S9IaRnDahE2UbD08N18fEF1ek9F
         KdynXTHDHCQOQQu4w0NMLPlJWU4MiBoDr0rXg3dPKFm2N0aWcF44hFTiL0Jk1zOPMqO3
         htnz+deaIjI23aR18N1eAXIPQJukovBsWYA5WXwFRPnriFdYExYqZ/xwoR9sj947HAk0
         iWgWwfVTdJHjbMLZqlfVMMUUELZWWIFSGeS+7D6A/Mn9qp8BHSc2bIJ8zXnLfi6KhYGU
         Dulg==
X-Gm-Message-State: APjAAAX2z5h3dI3wmsoTUfiQKHm7Wpb0EHryK1jzH4ffzVl5IL/S6yxV
        jBC7rLzSBHGQ/W4SK6188oznoQ==
X-Google-Smtp-Source: APXvYqxROLNIpJcshRuUg7v/sJFGI601/3sZPrBt9dM+9ZulYyEFFUhjIG6e2Jixa7B4FaGk4L7DMg==
X-Received: by 2002:a05:600c:2311:: with SMTP id 17mr25612596wmo.68.1565596049000;
        Mon, 12 Aug 2019 00:47:29 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id p10sm10489933wma.8.2019.08.12.00.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:47:28 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:47:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/14] mfd: max77693: convert to i2c_new_dummy_device
Message-ID: <20190812074727.GY4594@dell>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
 <20190722172623.4166-8-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722172623.4166-8-wsa+renesas@sang-engineering.com>
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
>  drivers/mfd/max77693.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
