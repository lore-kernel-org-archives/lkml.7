Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB5AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60343214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="keOshBDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfEHLs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:48:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45233 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbfEHLs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:48:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so26767169wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 04:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=D4Jo/XXXOC25kVFpYwybJdxL1MfdXCcgejboptGVtec=;
        b=keOshBDoBv1ga5JLsBEUcLmNcujufn/CqoX0gVvR+CT5/TflWfm4FTfw+hKVwHQxnB
         FJPFwVgdANIoLoWAFjWx7MBzTykx/kqvHL9hDccWUafAPiFCIYNoGG/N2NZXh5rst7Ge
         aUunvK0asgzzZUb80Ke/vQrkFSYZu7mPcN7Y42r10j71qdvbLCKbQp0EAggtSwcuP4qO
         3OH8oFfPNA0J9MEKwzQykvbUs43wpnkTVMg/nxjD7HSWZHduooFJ0LL40btDPgf7Enki
         GM2rNXNmgD/wFit3ujmUrbntm9wrJaTCUw5fKcDd+T81DqtesT303ge2Y8O9dQC6wNJa
         1ALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=D4Jo/XXXOC25kVFpYwybJdxL1MfdXCcgejboptGVtec=;
        b=DHAkA5ui6m6n06E88LzGr5kakRUgXKVeEGAC1BPK1fEg8fWVzcs49CfEKDjv3vHJt7
         1embSaTNq3ItECBrbTLnHmviDEth6JAY5PGD8gUZI7jeseXZyCkrLE7bSUE9+ThKhObG
         waelomR9d7xgC361j1G2mR3o+Kig9fEAZsXWlp3+Uu/B+wDXU3HgR9Cs4mc2xn1uMHE/
         nHW1w3CAQvH6mV+dDpbNTJKVIMwmlChjqOCteP6aG/BE6c0773cBjF18Q64LDu/xFloZ
         0W+Pu5sThs/Mc1LXL2okSq8RQkWcU010XiquuYpP/yAA3QTljg7aiUQsnd4OzV2oBz9j
         KLrA==
X-Gm-Message-State: APjAAAWe/quV/tnawh+o9vgXSPFAttR/MSSzxQhj5kX4pPr7XkgWYvvc
        M2c5MJ/4OkqG4G/sR2n/xwDV2w==
X-Google-Smtp-Source: APXvYqxQAfWGC5LW1oPICeT2TShfePBZh77cJn/03Sn/YejS8bHJX6kLK73yWaNFGUQdRMk7amwhAA==
X-Received: by 2002:adf:e288:: with SMTP id v8mr25780499wri.7.1557316106230;
        Wed, 08 May 2019 04:48:26 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id j3sm17999261wrg.72.2019.05.08.04.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 04:48:25 -0700 (PDT)
Date:   Wed, 8 May 2019 12:48:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] mfd: max77620: Provide system power-off
 functionality
Message-ID: <20190508114823.GL31645@dell>
References: <20190505154325.30026-1-digetx@gmail.com>
 <20190505154325.30026-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190505154325.30026-6-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 May 2019, Dmitry Osipenko wrote:

> Provide system power-off functionality that allows to turn off machine
> gracefully.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/mfd/max77620.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
