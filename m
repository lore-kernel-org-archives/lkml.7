Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3A2C17447
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B17222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573637697;
	bh=i+Joc5v+V3O8xh5ub9/iSdLqMTC5+7ARcRlXYmXtWlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vQZFS8tSqPNoOn+CXSUXh47o+fS79GdzPpyKtJxo9sqfMQuDlSe5LVZ04HdgYxFZL
	 ADHcO8/6VFkFpsp/HkKizZjsUXoE6Eu5cxJZlrUsaR9bFuhBSxvP1FF34Zog/1Uxnf
	 PJPBqhECOPWQmt1ZH2dN2RXur/DZnl+hGOaZOJic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfKMJe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 04:34:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfKMJez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 04:34:55 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66C042196E;
        Wed, 13 Nov 2019 09:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573637694;
        bh=i+Joc5v+V3O8xh5ub9/iSdLqMTC5+7ARcRlXYmXtWlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B8q6SK7Q3Y5wEqXTNkiWUBkmMSmUTe8bqsvVGwk2N5qQlBUW5Z40gwUHAI/KbsXcp
         AgEc1nopCTmHLvs+3JEit7+xEPjItyxJThy0o+QyPYeIMEMeFHKFKBNu0XFEMeo86Y
         DipAB+VmiO1zOUJCCK+XeSGeSfFkkw8OM6HZVDUY=
Date:   Wed, 13 Nov 2019 09:34:48 +0000
From:   Will Deacon <will@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <maxime@cerno.tech>,
        Vinod Koul <vkoul@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm SDM845 display and gpu
 clocks
Message-ID: <20191113093448.GA25438@willie-the-truck>
References: <20191109024234.1757452-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191109024234.1757452-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 06:42:34PM -0800, Bjorn Andersson wrote:
> Enable the drivers for the display and gpu clock controllers on Qualcomm
> SDM845, needed in order to get these features working. These drivers
> provides power-domains and can as such not be compiled as modules.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7fa92defb964..7fd999be3de3 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -726,6 +726,8 @@ CONFIG_MSM_MMCC_8996=y
>  CONFIG_MSM_GCC_8998=y
>  CONFIG_QCS_GCC_404=y
>  CONFIG_SDM_GCC_845=y
> +CONFIG_SDM_GPUCC_845=y
> +CONFIG_SDM_DISPCC_845=y
>  CONFIG_SM_GCC_8150=y
>  CONFIG_HWSPINLOCK=y
>  CONFIG_HWSPINLOCK_QCOM=y

Acked-by: Will Deacon <will@kernel.org>

Will
