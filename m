Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E57CC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1815223BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559651801;
	bh=6OleqzP9quO2zeSwzsj8bZMeC8Hf2G1MKsJM7hbM2y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w9fmgLss+P9qbCbfvokBDU9xraJr4wupf/YlvQzaGEf4RqyBw4Cigvj2Ye6v3+Zhk
	 pEu3HyVlaDw8on3LzV7+qUSEb29TEbX54EAvznj8Ccu9UQfCXRnHNl43LqdsFgaHSM
	 T+Y1jTRjO8nKDZQrqNkWNBSfCVbhHc48lB1DDOy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfFDMgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:36:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbfFDMgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:36:40 -0400
Received: from localhost (unknown [117.99.94.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D25C52231F;
        Tue,  4 Jun 2019 12:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559651799;
        bh=6OleqzP9quO2zeSwzsj8bZMeC8Hf2G1MKsJM7hbM2y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sL71fl8ksf2Ja1HmqStkjNNeRgC7UL/xPDVK/wp7YJZkONHwjxdusA5XmNr9iQnHA
         CPnGDlVR4TZRrq9zl16yEt13Z0/3Kl035kY7Ipn6UGuSrr5bTvLzkbrE9x2QIXqbiL
         YxbXRHqG6DcMl7mNpHZRpPIhA1VPbU0b0bh/0aTI=
Date:   Tue, 4 Jun 2019 18:03:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     yibin.gong@nxp.com
Cc:     robh@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, mark.rutland@arm.com, dan.j.williams@intel.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 5/8] dmaengine: fsl-edma: add drvdata for vf610
Message-ID: <20190604123331.GE15118@vkoul-mobl>
References: <20190529090848.34350-1-yibin.gong@nxp.com>
 <20190529090848.34350-6-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529090848.34350-6-yibin.gong@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-05-19, 17:08, yibin.gong@nxp.com wrote:

> @@ -205,8 +228,9 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  	if (!fsl_edma)
>  		return -ENOMEM;
>  
> -	fsl_edma->version = v1;
> -	fsl_edma->dmamux_nr = DMAMUX_NR;
> +	fsl_edma->drvdata = drvdata;
> +	fsl_edma->version = drvdata->version;
> +	fsl_edma->dmamux_nr = drvdata->dmamuxs;

And can we avoid the duplication here, you have version and dmamuxs
represented in two places. But right now it looks logical so the removal
should be done after this series

-- 
~Vinod
