Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE35C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B4E205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SILCAyeq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfLJTCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:02:16 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33371 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbfLJTCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:02:16 -0500
Received: by mail-pj1-f68.google.com with SMTP id r67so7767237pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 11:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OQfRjsctq07bGONJSMNK5xeyNODUsGkcRHUxYCc8g7g=;
        b=SILCAyeqYZkfiGWeLnU1e9E7rnZFBNzmUHTtrq34RIAFHV4jn8eOcNrZ159HiZEY38
         kmjLvMsFvXSnvloHvWchwJk3qkmVWGGCVhj2Ncy0NFnLrGlvvnb44UuBliZW1BvzGBR+
         p9jwz1CkvGO3WNZqJBtkq8ej6k6noCI9p0h6CvDSUCnjymNVLLBVRRgPlGoWCKWXXEiT
         HhuQgONTPCJMBV7yZQZ47dHIp4EzevNQF4q6xmZojk7HRhsWApsVz8TTKYtAKwftvWbv
         EBWqgpIZ9vD+2pmdWmqe2SUQM6K3mhpAggMC/2bIcXxtnxLnzAuvIdjiIKMRy1WtOv/B
         Ry5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OQfRjsctq07bGONJSMNK5xeyNODUsGkcRHUxYCc8g7g=;
        b=unmxtmUpWKbvwpHZikZh314zHZTzglCE21Kd9rX2tNRtrNAPDVrDV4iSJKF25plv4w
         kzGxboVmeUMiOXqvfxTCgHFRinApe13Pgxvle6y0Q31VwSsDbuG1RmKRMkpSiBfLhuVe
         43MnfAz9399VcdUhZM1GDx1LDEtGk0+9DhAO8V1GfsrvxyVddhVW+KTomCWYymL/ACm4
         CiTbh/qm2YYuVeICriPnx4pQUq9b1Uanmd0XVGOcX4sgOOG+uAgc8flDDetBTpRghejL
         /bC/PCE2tmHwkX9Y73H7U7inbm+PfDUZbJaKdkuKvs+FUrs9SNANCBvrx1WfR/wcgIFG
         wNyg==
X-Gm-Message-State: APjAAAXYK7E6fihefjg4y6l5AoOsWFIeJ+MhZYldVZVDd4h3H6PjVkab
        Fyc/5sB1f+PuG5e5o3KmkZZDLw==
X-Google-Smtp-Source: APXvYqykCBwtoFRp8nwsDGDv9eRderBwI2uMWFfJQXOofMmm5xq302SkaOu5OG3WLV9lW+/EArTGZQ==
X-Received: by 2002:a17:90a:8a0c:: with SMTP id w12mr7084397pjn.61.1576004535850;
        Tue, 10 Dec 2019 11:02:15 -0800 (PST)
Received: from yoga ([2607:fb90:8497:e902:4ce0:3dff:fe1c:88ba])
        by smtp.gmail.com with ESMTPSA id j18sm4132196pfn.112.2019.12.10.11.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 11:02:14 -0800 (PST)
Date:   Tue, 10 Dec 2019 11:02:11 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] phy: ufs-qcom: Invert PCS ready logic for SDM845 UFS
Message-ID: <20191210190211.GE314059@yoga>
References: <20191209135934.1.Iaaf3ad8a27b00f2f2bc333486a1ecc9985bb5170@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209135934.1.Iaaf3ad8a27b00f2f2bc333486a1ecc9985bb5170@changeid>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09 Dec 14:00 PST 2019, Evan Green wrote:

> The SDM845 UFS phy seems to want to do a low transition to become
> ready, rather than a high transition. Without this, I am unable to
> enumerate UFS on SDM845 when booted from USB.
> 
> Fixes: 14ced7e3a1a ('phy: qcom-qmp: Correct ready status, again')
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>

As concluded offline, the current logic is correct, but for some reason
we need a longer timeout on this particular device.

Regards,
Bjorn

> ---
> 
> Bjorn,
> At this point I'm super confused on what the correct behavior
> should be. Lack of documentation doesn't help. I'm worried that this
> change breaks UFS on some other platforms, so I'm hoping you or some
> PHY folks might have some advice on what the right thing to do is.
> 
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 091e20303a14d..c4f4294360b6e 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -1657,7 +1657,7 @@ static int qcom_qmp_phy_enable(struct phy *phy)
>  	if (cfg->type == PHY_TYPE_UFS) {
>  		status = pcs + cfg->regs[QPHY_PCS_READY_STATUS];
>  		mask = PCS_READY;
> -		ready = PCS_READY;
> +		ready = 0;
>  	} else {
>  		status = pcs + cfg->regs[QPHY_PCS_STATUS];
>  		mask = PHYSTATUS;
> -- 
> 2.21.0
> 
