Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C04C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2AC022CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566401096;
	bh=aJZsxkGaQIRowffpW+JaxO8NMT7WvvZzsQ6yeIDlrnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uDAe3rVGj8urSsGcZIVblodk+h08Av6BRr5mkO9b8ceSZVQ1XkBkkEdoDPxbFw11v
	 BxCZorT0XsPI/WWXaHu5KqTMq0e38JnPe8FjWk2W5enJHN6/Sn6pI+9kfjWegliFqg
	 1oTgAJoeJuPkQU0fh00ZqyU8T8e/CtZ7tH4aw+3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfHUPY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:24:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbfHUPYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:24:55 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01291206BA;
        Wed, 21 Aug 2019 15:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566401095;
        bh=aJZsxkGaQIRowffpW+JaxO8NMT7WvvZzsQ6yeIDlrnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RiD+8qlujqamNghbph/UTRtAZcnnXOpbJFfcJRF+s/5Mrfv1RKTDq2/TyeRJwLysN
         WJYvAUdnD9ZieVbBt5P/zVGwMp/DMlFpIVIjbWDQDAXI/qNLEkrtPTM8+HKzJyLsf8
         Rg6tay5H6JGnc5+Qh8NBXe3tmebq2AFCmCoYet2I=
Date:   Wed, 21 Aug 2019 16:24:49 +0100
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
Subject: Re: [PATCH v10 09/23] iommu/io-pgtable-arm-v7s: Extend to support
 PA[33:32] for MediaTek
Message-ID: <20190821152448.qmoqjh5zznfpdi6n@willie-the-truck>
References: <1566395606-7975-1-git-send-email-yong.wu@mediatek.com>
 <1566395606-7975-10-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566395606-7975-10-git-send-email-yong.wu@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:53:12PM +0800, Yong Wu wrote:
> MediaTek extend the arm v7s descriptor to support up to 34 bits PA where
> the bit32 and bit33 are encoded in the bit9 and bit4 of the PTE
> respectively. Meanwhile the iova still is 32bits.
> 
> Regarding whether the pagetable address could be over 4GB, the mt8183
> support it while the previous mt8173 don't, thus keep it as is.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 32 +++++++++++++++++++++++++-------
>  include/linux/io-pgtable.h         |  7 +++----
>  2 files changed, 28 insertions(+), 11 deletions(-)

[...]

> @@ -731,7 +747,9 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>  {
>  	struct arm_v7s_io_pgtable *data;
>  
> -	if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas > ARM_V7S_ADDR_BITS)
> +	if (cfg->ias > ARM_V7S_ADDR_BITS ||
> +	    (cfg->oas > ARM_V7S_ADDR_BITS &&
> +	     !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)))

Please can you instead change arm_v7s_alloc_pgtable() so that it allows an
ias of up to 34 when the IO_PGTABLE_QUIRK_ARM_MTK_EXT is set?

With that change:

Acked-by: Will Deacon <will@kernel.org>

Will
