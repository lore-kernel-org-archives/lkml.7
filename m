Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74C8C2D0D1
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5742465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="mjGdugZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfLTAWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 19:22:36 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:13671 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726964AbfLTAWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 19:22:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576801355; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=0HCPeM+2tQgXQBZ2loRXEQuQRtDGjn8UcT4p31niOms=;
 b=mjGdugZqEq+bZYoqZk792WM1QIcrTOj/BwiK9OYpvryn+XeM4NI2papGaVLJpuSd//kZo4LM
 8++YW+4rLzGUldGU/eqIUqBC+pEfzNv8jRyjxkwRWb/ZVNxYyQGhafQ1f/lpa5XXmXB8B6vP
 d9aljT2rkne0bw79JKnAldaE1pA=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfc144a.7faa39a1d8b8-smtp-out-n03;
 Fri, 20 Dec 2019 00:22:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2237EC433A2; Fri, 20 Dec 2019 00:22:33 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9FA20C433CB;
        Fri, 20 Dec 2019 00:22:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 20 Dec 2019 08:22:32 +0800
From:   cang@codeaurora.org
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Asutosh Das <asutoshd@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] phy: qcom-qmp: Add optional SW reset
In-Reply-To: <20191219150433.2785427-4-vkoul@kernel.org>
References: <20191219150433.2785427-1-vkoul@kernel.org>
 <20191219150433.2785427-4-vkoul@kernel.org>
Message-ID: <ff83ac1f0ec6bca1379e8b873fd30aa2@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-19 23:04, Vinod Koul wrote:
> For V4 QMP UFS Phy, we need to assert reset bits, configure the phy and
> then deassert it, so add optional has_sw_reset flag and use that to
> configure the QPHY_SW_RESET register.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c
> b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 06f971ca518e..80304b7cd895 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -1023,6 +1023,9 @@ struct qmp_phy_cfg {
> 
>  	/* true, if PCS block has no separate SW_RESET register */
>  	bool no_pcs_sw_reset;
> +
> +	/* true if sw reset needs to be invoked */
> +	bool has_sw_reset;
>  };
> 
>  /**
> @@ -1391,6 +1394,7 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg 
> = {
> 
>  	.is_dual_lane_phy	= true,
>  	.no_pcs_sw_reset	= true,
> +	.has_sw_reset		= true,
>  };
> 
>  static void qcom_qmp_phy_configure(void __iomem *base,
> @@ -1475,6 +1479,9 @@ static int qcom_qmp_phy_com_init(struct qmp_phy 
> *qphy)
>  			     SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
>  	}
> 
> +	if (cfg->has_sw_reset)
> +		qphy_setbits(serdes, cfg->regs[QPHY_SW_RESET], SW_RESET);
> +

Are you sure you want to set this in the serdes register? QPHY_SW_RESET
is in its pcs register.

>  	if (cfg->has_phy_com_ctrl)
>  		qphy_setbits(serdes, cfg->regs[QPHY_COM_POWER_DOWN_CONTROL],
>  			     SW_PWRDN);
> @@ -1651,6 +1658,9 @@ static int qcom_qmp_phy_enable(struct phy *phy)
>  	if (cfg->has_phy_dp_com_ctrl)
>  		qphy_clrbits(dp_com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
> 
> +	if (cfg->has_sw_reset)
> +		qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
> +

Yet you are clearing it from pcs register.

Regards,
Can Guo

>  	/* start SerDes and Phy-Coding-Sublayer */
>  	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
