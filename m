Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698A1CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A444214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388626AbfJVPtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 11:49:17 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:33974 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387659AbfJVPtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 11:49:16 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 0ADED3C0579;
        Tue, 22 Oct 2019 17:49:13 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F24eroNkNbDo; Tue, 22 Oct 2019 17:49:07 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 76C173C009D;
        Tue, 22 Oct 2019 17:49:07 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 22 Oct
 2019 17:49:07 +0200
Date:   Tue, 22 Oct 2019 17:49:04 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     <kuninori.morimoto.gx@renesas.com>
CC:     <patch@alsa-project.org>, <broonie@kernel.org>,
        <twischer@de.adit-jv.com>, <perex@perex.cz>, <tiwai@suse.com>,
        Jiada Wang <jiada_wang@mentor.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: rsnd: dma: fix SSI9 4/5/6/7 busif dma
 address
Message-ID: <20191022154904.GA17721@vmlxhi-102.adit-jv.com>
References: <1550823803-32446-1-git-send-email-twischer@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1550823803-32446-1-git-send-email-twischer@de.adit-jv.com>
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san,

On Fri, Feb 22, 2019 at 09:23:23AM +0100, twischer@de.adit-jv.com wrote:
> From: Jiada Wang <jiada_wang@mentor.com>
> 
> Currently each SSI unit 's busif dma address is calculated by
> following calculation formulation:
> 0xec540000 + 0x1000 * id + busif / 4 * 0xA000 + busif % 4 * 0x400
> 
> But according to user manual 41.1.4 Register Configuration
> ssi9 4/5/6/7 busif data register address
> (SSI9_4_BUSIF/SSI9_5_BUSIF/SSI9_6_BUSIF/SSI9_7_BUSIF)
> are out of this rule.
> 
> This patch updates the calculation formulation to correct
> ssi9 4/5/6/7 busif data register address
> 
> Fixes: commit 5e45a6fab3b9 ("ASoc: rsnd: dma: Calculate dma address with consider of BUSIF")
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
> ---
>  sound/soc/sh/rcar/dma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
> index 0324a5c..28f65eb 100644
> --- a/sound/soc/sh/rcar/dma.c
> +++ b/sound/soc/sh/rcar/dma.c
> @@ -508,10 +508,10 @@ static struct rsnd_mod_ops rsnd_dmapp_ops = {
>  #define RDMA_SSI_I_N(addr, i)	(addr ##_reg - 0x00300000 + (0x40 * i) + 0x8)
>  #define RDMA_SSI_O_N(addr, i)	(addr ##_reg - 0x00300000 + (0x40 * i) + 0xc)
>  
> -#define RDMA_SSIU_I_N(addr, i, j) (addr ##_reg - 0x00441000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400))
> +#define RDMA_SSIU_I_N(addr, i, j) (addr ##_reg - 0x00441000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000 * ((i) / 9) * ((j) / 4)))
>  #define RDMA_SSIU_O_N(addr, i, j) RDMA_SSIU_I_N(addr, i, j)
>  
> -#define RDMA_SSIU_I_P(addr, i, j) (addr ##_reg - 0x00141000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400))
> +#define RDMA_SSIU_I_P(addr, i, j) (addr ##_reg - 0x00141000 + (0x1000 * (i)) + (((j) / 4) * 0xA000) + (((j) % 4) * 0x400) - (0x4000 * ((i) / 9) * ((j) / 4)))
>  #define RDMA_SSIU_O_P(addr, i, j) RDMA_SSIU_I_P(addr, i, j)
>  
>  #define RDMA_SRC_I_N(addr, i)	(addr ##_reg - 0x00500000 + (0x400 * i))

Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>

This patch lives in our tree for a while without any issues.
It still applies cleanly to v5.4-rc4-18-g3b7c59a1950c.
Any chance to see it in vanilla?

-- 
Best Regards,
Eugeniu
