Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D288C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4D924676
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="hhjj1wL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfLTBaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 20:30:16 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:52475 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbfLTBaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 20:30:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576805415; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=C7CNisc1NMqyk187LsnU6yj93Gtw5ZADc8pi5qlCF7c=;
 b=hhjj1wL9vsAfoW5IEa4oEBKbyRe5Id+Peup7tmbvTxkSGvL8fye7iswxfuA35vc6lySJCv+3
 qR1WZ3woEYdyXCzHgZYJE08/+GLbSaKNPJiqXfJRdPgmHTaQ9fZQWyxPMgDWlWFOSa7MTJnd
 CUNPLL47agWPIrQLQQpNBrSIoIk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfc2425.7f3b35f41a08-smtp-out-n03;
 Fri, 20 Dec 2019 01:30:13 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C3854C447A2; Fri, 20 Dec 2019 01:30:13 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 54E01C43383;
        Fri, 20 Dec 2019 01:30:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 20 Dec 2019 09:30:13 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] phy: qcom-qmp: remove duplicate powerdown write
In-Reply-To: <20191219150433.2785427-5-vkoul@kernel.org>
References: <20191219150433.2785427-1-vkoul@kernel.org>
 <20191219150433.2785427-5-vkoul@kernel.org>
Message-ID: <e489ea10809772a847545fe1ee53215b@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-19 23:04, Vinod Koul wrote:
> We already write to QPHY_POWER_DOWN_CONTROL in qcom_qmp_phy_com_init()
> before invoking qcom_qmp_phy_configure() so remove the duplicate write.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Can Guo <cang@codeaurora.org>

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c
> b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 80304b7cd895..309ef15e46b0 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -885,7 +885,6 @@ static const struct qmp_phy_init_tbl
> msm8998_usb3_pcs_tbl[] = {
>  };
> 
>  static const struct qmp_phy_init_tbl sm8150_ufsphy_serdes_tbl[] = {
> -	QMP_PHY_INIT_CFG(QPHY_POWER_DOWN_CONTROL, 0x01),
>  	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0xd9),
>  	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_SEL, 0x11),
>  	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_HS_SWITCH_SEL, 0x00),
