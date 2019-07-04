Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7864CC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 18:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5718821670
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 18:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxZiuhbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfGDSWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 14:22:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34270 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfGDSWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 14:22:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so3429386plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 11:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=49RKdZb8IIkI3+0BX8wWpyu8JU1kt+cg0DgkZkLzmHQ=;
        b=bxZiuhbvu7gj8r66QOfCt00uKvIwZGfRFI7lp3ObZkA0J8E7LZqzN7oVsp5hGVxHIr
         bxdHg4b6TP7BtDl2ZBoQdNlax8PghFlFmcysYTK/ju8LcoZ8m8m19UdonvTku9pWkgs2
         Iaa7US2TJ0WtgNgnBtbWdL7QZIQlg9jRN0LWoQpguW7/DBPGYG9j2k0bVSK0cP5tQLBI
         UP+ztfnbWV/kS18DUDIIq1Bw/ji+CYnftI3Au1MpqhLMEpThBe0N4ryRHnJNTKf76fWa
         GDndeDIp2DhbEYehzut1mQQ7WwnsyCVsOsv74wErEsiQz/r7a6hQ6kQLAwY6+kHfR3AD
         pXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=49RKdZb8IIkI3+0BX8wWpyu8JU1kt+cg0DgkZkLzmHQ=;
        b=gMilEY+R5GyGLCsazwKWKL8Tag5neLlaJoFUtL/W/50Se/on3ulrgFq+j5zuHzmS01
         GPbyjFKFclDlfv7zvrbDf4zkNzsKFyNq9bcMiohBKUhIDD38w+fpoo/Eowdq+1A7RNB1
         mKfxi1T9fu3ymkIREkqXjRaqulrmsM8TCWTtXCB7SmxfB2QL6PJY1uodQIGBMcMZ7Nk3
         SzrbP7W9NROrElqAHnGyJXVUCtRY2x19VeB4Ucbr8qJQmOHQ35fhbKbyt8tiuY25QdfG
         iHgL2ccgZUgAYzraXBqPAZACF6mvZs45uuSc0Vi0PasXxEsATw3ZgCD4zcWcE7ElYHp0
         KPow==
X-Gm-Message-State: APjAAAXmsNOEq7M7KmI2IbfR2tHYx7VHx0ZsptzMpe3JQWFMNcSyKl1N
        HQfaYSLsW3MrE1DflqkHsonEqg==
X-Google-Smtp-Source: APXvYqwEPNKxrXbrR8Sdnw3wDwHG5QxDj+xW59knWJIH0vuARI+MCJ+AEmaVAbAb7mYceyZZ81YJ5A==
X-Received: by 2002:a17:902:ff11:: with SMTP id f17mr51796069plj.121.1562264528372;
        Thu, 04 Jul 2019 11:22:08 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k16sm6647443pfa.87.2019.07.04.11.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jul 2019 11:22:07 -0700 (PDT)
Date:   Thu, 4 Jul 2019 11:22:05 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     ohad@wizery.com, jeffrey.l.hugo@gmail.com, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: q6v5-mss: Fix build error without
 QCOM_MDT_LOADER
Message-ID: <20190704182205.GH1263@builder>
References: <20190704064649.51748-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704064649.51748-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03 Jul 23:46 PDT 2019, YueHaibing wrote:

> If QCOM_Q6V5_MSS is set but QCOM_MDT_LOADER is not,
> building will fails:
> 
> drivers/remoteproc/qcom_q6v5_mss.o: In function `q6v5_start':
> qcom_q6v5_mss.c:(.text+0x3260): undefined reference to `qcom_mdt_read_metadata'
> 
> Add QCOM_MDT_LOADER dependency for QCOM_Q6V5_MSS.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: f04b91383456 ("remoteproc: qcom: q6v5-mss: Support loading non-split images")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for catching this, Applied.

Regards,
Bjorn

> ---
>  drivers/remoteproc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 9b0f0cb..28ed306 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -116,6 +116,7 @@ config QCOM_Q6V5_MSS
>  	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
>  	depends on QCOM_SYSMON || QCOM_SYSMON=n
>  	select MFD_SYSCON
> +	select QCOM_MDT_LOADER
>  	select QCOM_Q6V5_COMMON
>  	select QCOM_RPROC_COMMON
>  	select QCOM_SCM
> -- 
> 2.7.4
> 
> 
