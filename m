Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF01C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B0D2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kD2Of6u7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfDAKHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:07:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36706 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfDAKHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:07:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so4517777pgc.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 03:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=d/vek/aANpCfeXzP6qL0CHXxA4CEIJDEj/Q65uAxJpk=;
        b=kD2Of6u7eYlMKbKFrNN8gi5GWHhh80C1YyQu9E9eMCqn4ZaYYnv4mTZn/FcOAob9+S
         opmyZC8XU+LLB6JooZkUMlLmT6susvGO3asN0gs3357I1Rm34s2sGZJPgk+/K4fwEgNz
         8XPdgkgQgc07LejfiENvPHtHs/MfG1M8T9jq/TY6zJ6F7RowDoaLVWKQvtfZP4HaeEqa
         74KNFePvTm+A9rTxI+pNp4t+zp3rwRj3vrZJKtWwIaUjITglCXYlRzdTOLi8+QIWqSSr
         XJJSuMT3OCzsWgWPB1JSBHwYvAVO6cxTR2NzeZ8YTMtwODGYb6RzvghpqGGQjxl+Eb5G
         GYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=d/vek/aANpCfeXzP6qL0CHXxA4CEIJDEj/Q65uAxJpk=;
        b=e1fsdxo6r6Opfi28+NI8k45r6jryljiX4GV6Vdvqfl3y1OJ+CLSJ8h73+bhENn3axY
         LEDV2KYLMmtCK88oCooQX3ZK1mCBYyaWfm3uGGPqXWdeaK6tM4wzH2qlbUTIM0U2RW3K
         wPXigo3u2oTW175l6SeF0IKFnWlmzXGpinCW0+KPOHq0QG3MT9MbNj/tUvc67efy9aBh
         AsE5MEJcQaqXy5aTx07QJDYRS6moCNvDLAcWoMYV4LIEeOqu2eumdiDUoI+uX6lk7u8R
         7jTR0Suw7iA1ald2aNnxo2NEmNno/R/lc0By2ABTS6NlSWWXSLBxRhDNN9+TsmoxXNaM
         IdcQ==
X-Gm-Message-State: APjAAAVSOrjOg7jKNXO1mAiSuNcXaKz0Sr0sgulBakIi1711uZNh97ae
        d44BldgI8GIkNIbMqgCFjK5aPw==
X-Google-Smtp-Source: APXvYqzoyM6pQkYp/HrTm8zhpI5OJqbbP4D85sp5putF9qh9mtlmHpBQulGVf3ybxL9caQy2aIDKUw==
X-Received: by 2002:a62:26c1:: with SMTP id m184mr31597456pfm.102.1554113225174;
        Mon, 01 Apr 2019 03:07:05 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id e13sm16165696pgb.37.2019.04.01.03.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:07:03 -0700 (PDT)
Date:   Mon, 1 Apr 2019 11:06:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     groeck@chromium.org, enric.balletbo@collabora.com,
        bleung@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: cros: Update EC protocol to match current EC code
Message-ID: <20190401100659.GA4187@dell>
References: <20190228002725.57444-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190228002725.57444-1-gwendal@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019, Gwendal Grignou wrote:

> Chromebook Embedded Controller protocol is defined in the kernel at
> cros_ec_commands.h.
> The source of trust for the EC protocol is at
> https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
> 
> Only needed changes have been picked up from this file to the kernel
> include file leading to gaps between the upstream version and what the
> latest ECs can do.
> 
> Fill the gaps to ease future integrations. Changes from the original
> files is header/footer for license and include files for alignment.
> 
> Check this include file works on ChomeOS kernel 4.14 and 4.19 on eve.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  include/linux/mfd/cros_ec_commands.h | 3627 +++++++++++++++++++++-----
>  1 file changed, 2935 insertions(+), 692 deletions(-)

I'm pretty lost as to what's happening with this set now.

Once you have corrected all of the patch formatting issues and
collected all of the Acks to-date, could you please re-submit as a
new/clean patch-set please?

Just to clarify, please don't reply-to, as this can get out of hand
very quickly.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
