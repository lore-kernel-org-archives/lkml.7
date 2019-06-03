Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC173C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9447427F98
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u0FiRAG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfFCMwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:52:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40464 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfFCMwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:52:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id p11so7097682wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 05:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wq4yXJBlhuJZxMm1hF9bS2M5hccH7sIFbHfwg9bPyr8=;
        b=u0FiRAG1N1Uc7hXsujUHXgiHeLFDEduvv2RaP9IH4uBuwimI4HmDFnwWTCj/YuqzlN
         GHtC4OSLAXSoEGZgkYrBiCnnjYAKdsQrWDtYs70f+dbavzGxEnWcuxe2ScUjnutYWmvo
         gzD56w7XjOfdy/bHa3vFc9EzoVt0VT5wuf+1hIyrpuT2FHQHWHjZ9Bm+Bp6Unu/7mqxU
         9G+YzbZmQCJm07mZ24PQbLpTNBU6ijYualwFvtX6LIdd1lsxYKIamM4UrdxzzT5kFulT
         itq42B17nQ5vpo/TxNUMY36cNp3NsCWrx90hg7OleUfxzpTp5ofnjUaZuFERuMLbV+wg
         NdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wq4yXJBlhuJZxMm1hF9bS2M5hccH7sIFbHfwg9bPyr8=;
        b=hU39v8fLGKDVQ0ly06jaTK8ALjFgT4k0eq8E49cswXZhQ2Svj4KQ/Z3sy2zsMZui2G
         TJv4LGhLfFTAepkm4ifv8H64LNG0PTZFYn4hYBQWX1gtstnjhcduCFHL/Ollpzbv4kVS
         4jbs16ZHvXYZ8Llc4/H99As8NVdcSDMuY+Rip9CJqrWQAFfEaYO2lwEbjiot8SIrz+wT
         dpoL4+y/IhO2l5K/2aQnOyhT8JJpf8eo1zHZvE/4Y36oPNVUua/weLm/U26MXUbP0yWO
         OLHGAoLoQKoXugyuYVq7YbFzhkGwio4ArczNlXqGz1gWKCAXzubgrYQG+2sjCQAUoe6b
         bmuA==
X-Gm-Message-State: APjAAAVMEQbcxbdulJZDPleeKgFt6Ve2jCxkf27SAkJ2rujeRQSO1PCj
        WSHmIGBdezNjP7pYRiDbVWztcg==
X-Google-Smtp-Source: APXvYqyHqS828di86eR4vgH2o4EKGJYQNKkueq2r86n9Zcm0f3WrLAXn3vXIJ40ZJjMdjHZWGSyg0g==
X-Received: by 2002:adf:eb45:: with SMTP id u5mr2393533wrn.38.1559566329776;
        Mon, 03 Jun 2019 05:52:09 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id o3sm11745269wrv.94.2019.06.03.05.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 05:52:09 -0700 (PDT)
Date:   Mon, 3 Jun 2019 13:52:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: menelaus: Remove superfluous error message
Message-ID: <20190603125207.GT4797@dell>
References: <20190521204304.21295-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190521204304.21295-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019, Alexandre Belloni wrote:

> The RTC core already has error messages in case of failure, there is no
> need to have another message in the driver.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/mfd/menelaus.c | 2 --
>  1 file changed, 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
