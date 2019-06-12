Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E77C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADAC20874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fEIUYbES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438708AbfFLNJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:09:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41517 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbfFLNJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:09:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id s21so15072742lji.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 06:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MYYBvt30/Tw2U53d4ncQQ8BJSAS7aEExu9CI5ehaRYQ=;
        b=fEIUYbESteaOEWXcp9jd1ip7LLMYbEGVOrQNAT3OqsOxsIPG6WVQwvCZE85HIg8FMU
         oAJcpcWnWawsbblDgnVUPfBVy/MjKDQCYn+hVrC6aDbm7jmLJDDdOeYn7ovnkA3c95RJ
         llSYqcqgco3znDjGJhQC/s0KMf/0CGgldGKLIZELciWkI5jAcYnilJXkUTuUj4XICqxS
         27Zqa7abianHydTHDyrbogg/uHipI3Cn1g50hRO7vazuNTagb4IIWJANZlWyOrrQK89R
         BzOEVtM4Gvmvr4sh93YP7UzMiZLLDbKCab70zFec3PK/DXbVmOUhA6hGuNvnRhjhsrJx
         bIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MYYBvt30/Tw2U53d4ncQQ8BJSAS7aEExu9CI5ehaRYQ=;
        b=dOcrdIoUJc/oQJw24iL2i8KwY6L9l9rrXs/Y4Z4dh2GtM1PKHqKwb6BggkgrLZff7v
         KngMw9C7HiED4JGC6MtbyG6mBBU3Bynied75v4eOfXdX9YpyscgqJnRs7htc6fVZoO/K
         zUU6e1LHyLyc3pKIxpK9seG6Fq2r04VQgWSP+BigGnmUHblC2nt8CUbI74b2/upvl5ks
         cLUfCFmkVl3ka9ZNZBv/nDx4CNvwkLOqEQvX6NnOgES0QLXlQbT1zix8CFulGz8g7ezt
         Ja3JdjZDIKAQb2zVOZqn16qVlcQypjyJsLilKY+h8JIC+iix84Jx+csL5Z9Glg17F1sE
         C/iw==
X-Gm-Message-State: APjAAAXm+m0zvCb8I1JSSCsWCY9KYcFVMRLX3zMrTSdBl4HPVEUHJDWB
        G0IcQICz5WYk8tVbRdphDRyoAQ==
X-Google-Smtp-Source: APXvYqzrSNdsWoOOTt2HzSZxGlgWX2BVIElZpnF0OUUPgprivZCkMq0Ej/jRwNVnwYyDfYkPbOohUw==
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr13251760ljm.180.1560344944488;
        Wed, 12 Jun 2019 06:09:04 -0700 (PDT)
Received: from centauri (m83-185-80-163.cust.tele2.se. [83.185.80.163])
        by smtp.gmail.com with ESMTPSA id s14sm905487ljd.88.2019.06.12.06.09.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 06:09:01 -0700 (PDT)
Date:   Wed, 12 Jun 2019 15:08:58 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH] phy: qcom-qmp: Correct READY_STATUS poll break condition
Message-ID: <20190612130858.GA11167@centauri>
References: <20190604232443.3417-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604232443.3417-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 04:24:43PM -0700, Bjorn Andersson wrote:
> After issuing a PHY_START request to the QMP, the hardware documentation
> states that the software should wait for the PCS_READY_STATUS to become
> 1.
> 
> With the introduction of c9b589791fc1 ("phy: qcom: Utilize UFS reset
> controller") an additional 1ms delay was introduced between the start
> request and the check of the status bit. This greatly increases the
> chances for the hardware to actually becoming ready before the status
> bit is read.
> 
> The result can be seen in that UFS PHY enabling is now reported as a
> failure in 10% of the boots on SDM845, which is a clear regression from
> the previous rare/occasional failure.
> 
> This patch fixes the "break condition" of the poll to check for the
> correct state of the status bit.
> 
> Unfortunately PCIe on 8996 and 8998 does not specify the mask_pcs_ready
> register, which means that the code checks a bit that's always 0. So the
> patch also fixes these, in order to not regress these targets.
> 
> Cc: stable@vger.kernel.org
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
> Cc: Vivek Gautam <vivek.gautam@codeaurora.org>
> Fixes: 73d7ec899bd8 ("phy: qcom-qmp: Add msm8998 PCIe QMP PHY support")
> Fixes: e78f3d15e115 ("phy: qcom-qmp: new qmp phy driver for qcom-chipsets")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> @Kishon, this is a regression spotted in v5.2-rc1, so please consider applying
> this towards v5.2.
> 
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index cd91b4179b10..43abdfd0deed 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -1074,6 +1074,7 @@ static const struct qmp_phy_cfg msm8996_pciephy_cfg = {
>  
>  	.start_ctrl		= PCS_START | PLL_READY_GATE_EN,
>  	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> +	.mask_pcs_ready		= PHYSTATUS,
>  	.mask_com_pcs_ready	= PCS_READY,
>  
>  	.has_phy_com_ctrl	= true,
> @@ -1253,6 +1254,7 @@ static const struct qmp_phy_cfg msm8998_pciephy_cfg = {
>  
>  	.start_ctrl             = SERDES_START | PCS_START,
>  	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> +	.mask_pcs_ready		= PHYSTATUS,
>  	.mask_com_pcs_ready	= PCS_READY,
>  };
>  
> @@ -1547,7 +1549,7 @@ static int qcom_qmp_phy_enable(struct phy *phy)
>  	status = pcs + cfg->regs[QPHY_PCS_READY_STATUS];
>  	mask = cfg->mask_pcs_ready;
>  
> -	ret = readl_poll_timeout(status, val, !(val & mask), 1,
> +	ret = readl_poll_timeout(status, val, val & mask, 1,
>  				 PHY_INIT_COMPLETE_TIMEOUT);
>  	if (ret) {
>  		dev_err(qmp->dev, "phy initialization timed-out\n");
> -- 
> 2.18.0
> 

msm8996_pciephy_cfg and msm8998_pciephy_cfg not having a bit mask defined
for PCS ready is really a separate bug, so personally I would have created
two patches, one that adds the missing masks, and one patch that fixes the
broken break condition.

Either way:

Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
