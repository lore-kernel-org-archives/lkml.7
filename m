Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE1EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15AA92085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tHvDwaOy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfHLHnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:43:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51289 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfHLHnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:43:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so11232950wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IuMqqll90qz4yLGgMcmknjUlSLebc3a/mXTNYfALqow=;
        b=tHvDwaOyhEmIGVn2o6ioCQw5CjcLBRr+nisiWIcR5nBJy+T1n7rkUTj7p98coRDMyi
         xnilIkMxFj9iH6EdTAbDHv2K8e0TnKZDKDg+NmVZph2+NiZgbKxKXOycTBeunEBLF4ZL
         ktNVV+i/R30vngIBwAc/kZvANRnJTuyUvHe694Yf5SOtr7dkwxvgwWp0tDlP6Y8yADRZ
         htw4NvRpPw9/ky0khBzo7J5+lUQiqXuqCqvx9RalO5wW7+c4FJvl8Y9Mg8DiCOBzGdYK
         wP7oz80YHbOtatnkEfh3qjERNXxvmNMYVCHYHO5At6Wn/zWiYuuuqxYS4psgx18pNXm5
         seng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IuMqqll90qz4yLGgMcmknjUlSLebc3a/mXTNYfALqow=;
        b=DQGhfBD+CXOO390WwGyOEAyDvw2AinY8R61sS7Bh4w0u9YB4/XYJFOahBXNKr0AxJV
         wHwrXHgGYutSg50gw/7woVMyakKRfJsJ7UVuFdYt5NdwiTJzSHd8JJqlpp2Ew+heRp+5
         nX7Q0SWGVMyGZ8/c83fFXFnODHaTOBCSfd6jxVF29Upq/CtcoeV7t5Fe63Re3RKN0yLD
         qDWM+PGNU1vDXrB7jWsGqhf7BaxejbsYIJmTrbldnB1jftRV84XYGtJE9cUHn7HdmooS
         e58oAk+rKsjiimdd+ZMaBGvgqQMk4eN1M6ieSKLWFln4S0y8MJN4CA+nlZiHROg4HYE1
         oPEg==
X-Gm-Message-State: APjAAAWGPiHI3GEz8fc/4iUblPhMdzj82GUZ9e2SZ/A4g5uw5Yjj1mer
        0cHeZwCZjd0TekcEs/depYVho4iLEZE=
X-Google-Smtp-Source: APXvYqzZBcso2nKOF9JX9qj/EzMuYD+AfP8cBvrvx9FI6EywX0muyFzVWbT1rAGKRpgydNaY4PFWHA==
X-Received: by 2002:a1c:13:: with SMTP id 19mr25543885wma.162.1565595831370;
        Mon, 12 Aug 2019 00:43:51 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id x6sm19112196wmf.6.2019.08.12.00.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:43:50 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:43:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: timberdale: Use dev_get_drvdata
Message-ID: <20190812074349.GR4594@dell>
References: <20190723115103.18647-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190723115103.18647-1-hslester96@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2019, Chuhong Yuan wrote:

> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/mfd/timberdale.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
