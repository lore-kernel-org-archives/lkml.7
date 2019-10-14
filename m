Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE76ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2881820873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qq0dACQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733035AbfJNOq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:46:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42967 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732708AbfJNOq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:46:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so8108248pls.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Wwkp/o/TiWYKqra6/GbJ8zgmOghxSCR6LMZILbN3AA=;
        b=Qq0dACQaYNnCu7w+uH1q+EXCWhrXZyYx63Ucp9eQ3kdJr7sZiRBBHuY2+z3Z5QsgZg
         5+mv9yf4faaNnydUHWvdHrKOzLzgTLkF84l8AJOsgPuw2vlXPxhNy7EEEXpu9T2aBQD4
         VPgSMXX1H96agXRdv7DYYmYgaIaWqfeRRKo30bJvZ/95X7ncj3YzjrPZ3wAgATaIlDKP
         1w7mfR2l5lSq+jNmMZ4GWj/0k7OFml0qq4+orA/4i0/IMLqJRo83iMebCeg2g9JihrdC
         AW5vSRtIcD2aACwhC+D03rlxE33OBEfHaBfhSsKWhx9PVskRgov+Z+r6UfbHGu0TUOBf
         0Q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Wwkp/o/TiWYKqra6/GbJ8zgmOghxSCR6LMZILbN3AA=;
        b=NZlfVvqooCqDLT1nIBzMBvFrmSHazUc9jqLqktZjYrmiCFJrXCOm94nwVOJaIzsbWS
         nFKyvVn34HRHbtkEhdVuzgFx6OCdDx00I8Meq33A1ihbQIu/lxZUUIXrO2/r4ErNg6Ro
         V7J/1XyxsFGMOWAO6HhiS9iHFYMQjt/QXT0l+D8V3rhBDAAD054yN1HwxUZOJBPZsUeH
         hJk7PHw32KIG76pRiWY8KruNSV9A+2/CTMQG1SpxgVZyjXqMHVRP7OWk4p+WShx/dyOq
         U1/z+umfVA8AzzSBnAdFkURajno86Dpjw9QBIK+es32FWmZ5rYUTs2AyBhopz4NPuXpu
         bWVg==
X-Gm-Message-State: APjAAAUH8SuorywmtynpYnbWUK9LbTlwg0mv1+V1G9iO+tTcxasvoOcO
        4niGn1IKn6ojeFuCCT6lZtTH
X-Google-Smtp-Source: APXvYqwhz1BoUwO6T+uzR5BRZcg5sa7AjCGGCeVyBJ/eYxnWT37A9NIdF8NVa4rvrqjOx7h6M/y/AA==
X-Received: by 2002:a17:902:bcc8:: with SMTP id o8mr30767347pls.256.1571064387153;
        Mon, 14 Oct 2019 07:46:27 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id p190sm22003538pfb.160.2019.10.14.07.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Oct 2019 07:46:26 -0700 (PDT)
Date:   Mon, 14 Oct 2019 20:16:20 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 7/7] arm64: configs: Enable Actions Semi platform in
 defconfig
Message-ID: <20191014144620.GC8583@mani>
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
 <20190916154546.24982-8-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916154546.24982-8-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 09:15:46PM +0530, Manivannan Sadhasivam wrote:
> Since the Actions Semi platform can now boot a distro, enable it in
> ARM64 defconfig.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied for v5.5.

Thanks,
Mani

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0e58ef02880c..8e27777d6687 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -29,6 +29,7 @@ CONFIG_BLK_DEV_INITRD=y
>  CONFIG_KALLSYMS_ALL=y
>  # CONFIG_COMPAT_BRK is not set
>  CONFIG_PROFILING=y
> +CONFIG_ARCH_ACTIONS=y
>  CONFIG_ARCH_AGILEX=y
>  CONFIG_ARCH_SUNXI=y
>  CONFIG_ARCH_ALPINE=y
> -- 
> 2.17.1
> 
