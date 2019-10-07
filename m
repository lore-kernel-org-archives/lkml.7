Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B2DECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 23:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5815F20867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 23:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eF+BFSLd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EkvVh0rV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfJGXjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 19:39:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60806 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbfJGXjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 19:39:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4FAEF60AA3; Mon,  7 Oct 2019 23:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570491548;
        bh=pHvuvtluuEtoXPJ6Nnr1FZAfPESLSfIJNq3Czhj/Tf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eF+BFSLdZW6kWhi8Bj27TYR6OHxiDD7OqHapXYILW4v7iMIud07GZ2DtwbmHjwOxB
         gwYJsnXlzaeEM2u6lj0zOYRZcFK8yckCPp5MDM8WrZQGoZmN4+vJmhtC+hYkPq0usD
         OoE7FI1LWujVigJ4/dyVz6PZc/tO5uReQabiI0uM=
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jackp@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BB48D602D8;
        Mon,  7 Oct 2019 23:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570491546;
        bh=pHvuvtluuEtoXPJ6Nnr1FZAfPESLSfIJNq3Czhj/Tf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EkvVh0rV3EOnNjWHRYMlU5CKZy+jEwzajJnDFeq1Wy1Lvy+Sc9EqofQf1mlt41XTn
         1U/Qx61m2O4QGVq3i0nXF+s3f4zRd2PfklU/1LTfuNxYrmd8Xl/XIj/1ArKXu6z+Iz
         6iYD1+JRqWey4KK3yrExKcOsC3pz0Vnjwrmx/9TY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BB48D602D8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jackp@codeaurora.org
Date:   Mon, 7 Oct 2019 16:39:04 -0700
From:   Jack Pham <jackp@codeaurora.org>
To:     John Stultz <john.stultz@linaro.org>,
        Yu Chen <chenyu56@huawei.com>, Felipe Balbi <balbi@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC][PATCH v2 2/5] usb: dwc3: Execute GCTL Core Soft Reset
 while switch mdoe for Hisilicon Kirin Soc
Message-ID: <20191007233904.GC9754@jackp-linux.qualcomm.com>
References: <20191007175553.66940-1-john.stultz@linaro.org>
 <20191007175553.66940-3-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007175553.66940-3-john.stultz@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John, Yu, Felipe,

On Mon, Oct 07, 2019 at 05:55:50PM +0000, John Stultz wrote:
> From: Yu Chen <chenyu56@huawei.com>
> 
> A GCTL soft reset should be executed when switch mode for dwc3 core
> of Hisilicon Kirin Soc.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Yu Chen <chenyu56@huawei.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: linux-usb@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/usb/dwc3/core.c | 20 ++++++++++++++++++++
>  drivers/usb/dwc3/core.h |  3 +++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 999ce5e84d3c..440261432421 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -112,6 +112,19 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
>  	dwc->current_dr_role = mode;
>  }
>  
> +static void dwc3_gctl_core_soft_reset(struct dwc3 *dwc)
> +{
> +	u32 reg;
> +
> +	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
> +	reg |= DWC3_GCTL_CORESOFTRESET;
> +	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> +
> +	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
> +	reg &= ~DWC3_GCTL_CORESOFTRESET;
> +	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> +}
> +
>  static void __dwc3_set_mode(struct work_struct *work)
>  {
>  	struct dwc3 *dwc = work_to_dwc(work);
> @@ -156,6 +169,10 @@ static void __dwc3_set_mode(struct work_struct *work)
>  
>  	dwc3_set_prtcap(dwc, dwc->desired_dr_role);
>  
> +	/* Execute a GCTL Core Soft Reset when switch mode */
> +	if (dwc->gctl_reset_quirk)
> +		dwc3_gctl_core_soft_reset(dwc);
> +

In fact it is mentioned in the Synopsys databook to perform a GCTL
CoreSoftReset when changing the PrtCapDir between device & host modes.
So I think this should apply generally without a quirk. Further, it
states to do this *prior* to writing PrtCapDir, so should it go before
dwc3_set_prtcap() instead?

Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
