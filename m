Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D566DC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8ABE206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566401141;
	bh=Z133FCcaUexJ59kOIXUWJUTamhLJKJ6ldqxj9NWa3tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XOlcROyNP8AcpbtyCxKLMUkLNyadGztF+P3bwetTAqRldNpxzHdmzj7acbDH1gkg0
	 /Wvt1t5Kd3OMVXRELj0Qfx8+anU6ztg1TEDNULKB3F5kXMQOk+W+yaBtCSisL3PwlT
	 vweJV/zqZn31eqkcNZB+zlWpOEaBE7hfxBfls6Ag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfHUPZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbfHUPZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:25:39 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0307C206BA;
        Wed, 21 Aug 2019 15:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566401134;
        bh=Z133FCcaUexJ59kOIXUWJUTamhLJKJ6ldqxj9NWa3tk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gUDPg5D2HGetVoKEHsW8DXI3N8IRAZgH4Tai4x88ildrlJztU+xVCdx4+3RGx2O2c
         N5xYByPeiRxepUcdRhHOkougwAECZWjBWIx9W0p1/W0+2p3czw/xCZjOZAh7KO7B+o
         cfMKfQyFaTQVwpV34sGMhCCZ2nWA2Elrqu5sjzPE=
Date:   Wed, 21 Aug 2019 16:25:28 +0100
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        Matthias Kaehlcke <mka@chromium.org>, cui.zhang@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com
Subject: Re: [PATCH v10 07/23] iommu/io-pgtable-arm-v7s: Use ias/oas to check
 the valid iova/pa
Message-ID: <20190821152527.6rkgf4g5wgsc7fyq@willie-the-truck>
References: <1566395606-7975-1-git-send-email-yong.wu@mediatek.com>
 <1566395606-7975-8-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566395606-7975-8-git-send-email-yong.wu@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:53:10PM +0800, Yong Wu wrote:
> Use ias/oas to check the valid iova/pa. Synchronize this checking with
> io-pgtable-arm.c.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 72f1880..fa1b38f 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -504,7 +504,8 @@ static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
>  	if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
>  		return 0;
>  
> -	if (WARN_ON(upper_32_bits(iova) || upper_32_bits(paddr)))
> +	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias) ||
> +		    paddr >= (1ULL << data->iop.cfg.oas)))
>  		return -ERANGE;

Acked-by: Will Deacon <will@kernel.org>

Will
