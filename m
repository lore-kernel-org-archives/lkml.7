Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175F6C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FE0206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576815875;
	bh=YJoEbl3GVJKkXKHwpK0jxsiCrbFpl9/Z0ryYt5awwCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZGuiWp6Ovvo5UxIrUeAy6nHeqR6t/HwaRpdJFLzm/mE8AV/sikqG1/YE/eOpHeoqh
	 gttnfGWs9/JyfklW7Db4fF/RjYuxnOu7jXpOT65x1eiX7AxNtpAhkeszCajzoLE1Rk
	 RO2Q/CuBInkxkAcaA28pw7J2yM39pu5t99TR+WfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfLTEYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 23:24:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfLTEYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 23:24:33 -0500
Received: from localhost (unknown [106.201.107.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9F1B206EF;
        Fri, 20 Dec 2019 04:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576815872;
        bh=YJoEbl3GVJKkXKHwpK0jxsiCrbFpl9/Z0ryYt5awwCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vh7LEXeYNSkcRiQDpdHCE7tE1BhgYVn3FMBnUNRXJm2xKq1rg6CS3aYrHFMebYw/K
         U+kFbj4K4qykzcVgCJ/ENVJa8gBrUu33D5N7jKlw90Lx6n5kPHMIhNWeMsVR7+84CA
         kEgzIJttTNF/BvHciea6TWaCQHzcr7H9cbkik6zM=
Date:   Fri, 20 Dec 2019 09:54:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     cang@codeaurora.org
Cc:     Asutosh Das <asutoshd@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] phy: qcom-qmp: Add optional SW reset
Message-ID: <20191220042427.GE2536@vkoul-mobl>
References: <20191219150433.2785427-1-vkoul@kernel.org>
 <20191219150433.2785427-4-vkoul@kernel.org>
 <ff83ac1f0ec6bca1379e8b873fd30aa2@codeaurora.org>
 <9ef99dcac59dbdc59c7e5eb1a8724ea2@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ef99dcac59dbdc59c7e5eb1a8724ea2@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-12-19, 08:49, cang@codeaurora.org wrote:
> On 2019-12-20 08:22, cang@codeaurora.org wrote:
> > On 2019-12-19 23:04, Vinod Koul wrote:
> > > For V4 QMP UFS Phy, we need to assert reset bits, configure the phy
> > > and
> > > then deassert it, so add optional has_sw_reset flag and use that to
> > > configure the QPHY_SW_RESET register.
> > > 
> > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > ---
> > >  drivers/phy/qualcomm/phy-qcom-qmp.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c
> > > b/drivers/phy/qualcomm/phy-qcom-qmp.c
> > > index 06f971ca518e..80304b7cd895 100644
> > > --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> > > +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> > > @@ -1023,6 +1023,9 @@ struct qmp_phy_cfg {
> > > 
> > >  	/* true, if PCS block has no separate SW_RESET register */
> > >  	bool no_pcs_sw_reset;
> > > +
> > > +	/* true if sw reset needs to be invoked */
> > > +	bool has_sw_reset;
> > >  };
> > > 
> > >  /**
> > > @@ -1391,6 +1394,7 @@ static const struct qmp_phy_cfg
> > > sm8150_ufsphy_cfg = {
> > > 
> > >  	.is_dual_lane_phy	= true,
> > >  	.no_pcs_sw_reset	= true,
> > > +	.has_sw_reset		= true,
> > >  };
> > > 
> > >  static void qcom_qmp_phy_configure(void __iomem *base,
> > > @@ -1475,6 +1479,9 @@ static int qcom_qmp_phy_com_init(struct
> > > qmp_phy *qphy)
> > >  			     SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
> > >  	}
> > > 
> > > +	if (cfg->has_sw_reset)
> > > +		qphy_setbits(serdes, cfg->regs[QPHY_SW_RESET], SW_RESET);
> > > +
> > 
> > Are you sure you want to set this in the serdes register? QPHY_SW_RESET
> > is in its pcs register.
> > 
> > >  	if (cfg->has_phy_com_ctrl)
> > >  		qphy_setbits(serdes, cfg->regs[QPHY_COM_POWER_DOWN_CONTROL],
> > >  			     SW_PWRDN);
> > > @@ -1651,6 +1658,9 @@ static int qcom_qmp_phy_enable(struct phy *phy)
> > >  	if (cfg->has_phy_dp_com_ctrl)
> > >  		qphy_clrbits(dp_com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
> > > 
> > > +	if (cfg->has_sw_reset)
> > > +		qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
> > > +
> > 
> > Yet you are clearing it from pcs register.

updated now, will send v2

> > 
> > Regards,
> > Can Guo
> > 
> > >  	/* start SerDes and Phy-Coding-Sublayer */
> > >  	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
> 
> I thought your change would be like this
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c
> b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 8e642a6..a4ab4b7 100755
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -166,6 +166,7 @@ static const unsigned int sdm845_ufsphy_regs_layout[] =
> {
>  };
> 
>  static const unsigned int sm8150_ufsphy_regs_layout[] = {
> +       [QPHY_SW_RESET]                 = 0x08,
>         [QPHY_START_CTRL]               = 0x00,
>         [QPHY_PCS_READY_STATUS]         = 0x180,
>  };
> @@ -1390,7 +1391,6 @@ static const struct qmp_phy_cfg sm8150_ufsphy_cfg = {
>         .pwrdn_ctrl             = SW_PWRDN,
> 
>         .is_dual_lane_phy       = true,
> -       .no_pcs_sw_reset        = true,
>  };
> 
>  static void qcom_qmp_phy_configure(void __iomem *base,
> @@ -1475,6 +1475,9 @@ static int qcom_qmp_phy_com_init(struct qmp_phy *qphy)
>                              SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
>         }
> 
> +       if ((cfg->type == PHY_TYPE_UFS) && (!cfg->no_pcs_sw_reset))
> +               qphy_setbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);

Well am not sure if no_pcs_sw_reset would do this and side effect on
other phys (somehow older ones dont seem to need this). That was the
reason for a new flag and to be used for specific instances

Thanks
-- 
~Vinod
