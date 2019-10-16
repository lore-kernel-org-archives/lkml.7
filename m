Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A994C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECA720854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="l5x1Vw+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391015AbfJPHg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:36:29 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42799 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbfJPHg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:36:28 -0400
Received: by mail-vs1-f66.google.com with SMTP id m22so14935977vsl.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qe50GbZLQRllpuQvATvkx8bEhPSzudVQM7HSFSmEcqo=;
        b=l5x1Vw+AifeukGvQl9qOlNjchU0byCxsiNuVC/wLdzx3JAF0gqmbkCNXOr9FzTZdPp
         w9+mgNpDiDOQsqKTMADmoZZC8coYmgv/De1dyaFsHYwshJ4ASgvIzVBONkqKf6hDTBHZ
         JFclIxNc0ZhuePS2bjfY6gCJyBH6ikBhqrnxs6c+gENEZQX5mNw1BZhNuuXy0DKAjSoR
         n0JBLgpY8Eyb2pb7nfcNbAwPMPPN/LhhToh3yfaoLCFZL+Rx5q3jAOK1CbmLTch4J8oP
         qxtoZ7j8UuHZr0bkkvw2p2nBT+EhVlmevzHACoCNhE7U1ygaGPiLOWXtFPY86ao8xjDV
         vwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qe50GbZLQRllpuQvATvkx8bEhPSzudVQM7HSFSmEcqo=;
        b=DkXRFPAOCuZXfrUVYmfDJ3RlRhJu0SpzYvBLpB5LLBaszCIJ8uvxTdY/ft5ugHbj4f
         L6TYy7mdgjKEJP8zsyAE7t1VHwHyBAtQTl3qGDhKx62+R8lhSZpUmF1x6EbhIYwQgc3o
         IwmiGoKBrVVs7MOiBj919AFGiY9auM8ewQwHnhismN3DyvmAWoFxGx9Imq2Hb7Ekb9SS
         cIOohAwawLiuZPJXga4rjJ/rq4+zpCooVo4Vd1lIjNhh9GBTHhV/PyLJqtKqJOwRDuhL
         7PY7T2zPRzedtzd/3MHl6Yn8DKT/p6tsDSX3bH0HhRa2tm3gyZMgCF2CEK0kZudS63XO
         qhyQ==
X-Gm-Message-State: APjAAAVVWN6U+Ehh7wi08WMkZ6rQkItLbOY7RNCRkzykJagkmzh9QmSN
        AgYBSCkBa3uMyXIpIMen+P1ti++P5XZ1R8/1BapXsw==
X-Google-Smtp-Source: APXvYqwpQsX8XDUKsMfMEkQSA0p4CQbdijqex0x7A7VShelbL+ZQrXv0eMhDptdmMbVegT+VCOz1tJhzZAzrEwpnPWI=
X-Received: by 2002:a67:edce:: with SMTP id e14mr16842513vsp.182.1571211387638;
 Wed, 16 Oct 2019 00:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191011234402.374271-1-bjorn.andersson@linaro.org>
In-Reply-To: <20191011234402.374271-1-bjorn.andersson@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 16 Oct 2019 13:06:16 +0530
Message-ID: <CAHLCerOnj24B8wZxuqbBgt1UtxO5E7Caa8WTP=o3bXJv-QDy1Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm CPUfreq HW driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <mripard@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 5:14 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> The Qualcomm CPUfreq HW provides CPU voltage and frequency scaling on
> many modern Qualcomm SoCs. Enable the driver for this hardware block to
> enable this functionality on the SDM845 platform.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

You beat me to it. :-)

Acked-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index dea051a64257..45e55dfe1ee4 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -85,6 +85,7 @@ CONFIG_ACPI_CPPC_CPUFREQ=m
>  CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
>  CONFIG_ARM_SCPI_CPUFREQ=y
>  CONFIG_ARM_IMX_CPUFREQ_DT=m
> +CONFIG_ARM_QCOM_CPUFREQ_HW=y
>  CONFIG_ARM_RASPBERRYPI_CPUFREQ=m
>  CONFIG_ARM_TEGRA186_CPUFREQ=y
>  CONFIG_ARM_SCPI_PROTOCOL=y
> --
> 2.23.0
>
