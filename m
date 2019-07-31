Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000CEC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C218A208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564586451;
	bh=QQQ+QpM+RhFqQ/ypjrNEtcmyaMXt5cOebJM7X911U3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GPK55qO/aPMTSYyn70OH12UPJqc2pQEd2BSHxtrEbLme/N+hDRH3H5JkpQP2mr1Fe
	 0qXWKp9aOukVcgWoyWosM2N+odJ4mB5qVStex3s7kn0CzQ6O2AXFJlCQf1dtC0SIG1
	 m+ECuu9cDAaNcFXdil2E7W7rCSP8+v/S1/MBfMAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfGaPUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:32834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729687AbfGaPUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:20:40 -0400
Received: from localhost (unknown [171.76.116.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47D1E206A2;
        Wed, 31 Jul 2019 15:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564586440;
        bh=QQQ+QpM+RhFqQ/ypjrNEtcmyaMXt5cOebJM7X911U3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pZCgA5KOSkUePqoFiBh0M+XwmYjYgiRh+LRMt1765PUQknMeWMvNsOxFTSLJK3gHo
         y4+GodC/ycKnCTdhjcpBlyW1h9rTqiSLP+rAkqY/D9LNoeSD+03Od3J/XoD1buGMgT
         MNKRX12rtv77Quy7hh4WPRwk88B39600tDSGJMCg=
Date:   Wed, 31 Jul 2019 20:49:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] dmaengine: imx-dma: Mark expected switch fall-through
Message-ID: <20190731151926.GV12733@vkoul-mobl.Dlink>
References: <20190729225221.GA24269@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190729225221.GA24269@embeddedor>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-07-19, 17:52, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warning (Building: arm):
> 
> drivers/dma/imx-dma.c: In function ‘imxdma_xfer_desc’:
> drivers/dma/imx-dma.c:542:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (slot == IMX_DMA_2D_SLOT_A) {
>       ^
> drivers/dma/imx-dma.c:559:2: note: here
>   case IMXDMA_DESC_MEMCPY:
>   ^~~~
> 
> Notice that, in this particular case, the code comment is
> modified in accordance with what GCC is expecting to find.

Applied, thanks

-- 
~Vinod
