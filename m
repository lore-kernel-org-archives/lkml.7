Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512A3C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0292075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578580614;
	bh=7IQ/BT7evr0hO46xa6apmP3QZqY3MOa1nt0hxmRfgFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XZTZV6iu2KHGBMkJ2JzdJ5U63JCkftPbvwx1WQKvV8jI2gsVaFQQCV4aliPNtkQA9
	 CLqIoGcZNIA0OOROaR+F0RH1mhtjyV++UvOlFVk7B6eMR+gIY1/463KcBZBhlDqIL0
	 R1sms6ndN8y2ImArguDucGCt/fcojOXpZbNG0jzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbgAIOgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:36:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730385AbgAIOgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:36:52 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D79B420721;
        Thu,  9 Jan 2020 14:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578580612;
        bh=7IQ/BT7evr0hO46xa6apmP3QZqY3MOa1nt0hxmRfgFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dGC4Beb3Ulpic1VgQEMBIHagk3052sm+9CVIt/Ifr72lbNBZ5ydvIZafauPpqus9J
         4IN/uy2Pf3cynBSoWb0ZgmOjhZBSXXBuzWRuLAyLDv63PrdpaQj84F/DlDCv2+fIsF
         UiwO6Ns8rBHJn4WOM3fgPiEUhEFD9CWTFeZtTyPk=
Date:   Thu, 9 Jan 2020 14:36:47 +0000
From:   Will Deacon <will@kernel.org>
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     iommu@lists.linux-foundation.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] iommu: Add DOMAIN_ATTR_SPLIT_TABLES
Message-ID: <20200109143646.GC12236@willie-the-truck>
References: <1576514271-15687-1-git-send-email-jcrouse@codeaurora.org>
 <1576514271-15687-2-git-send-email-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576514271-15687-2-git-send-email-jcrouse@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 09:37:47AM -0700, Jordan Crouse wrote:
> Add a new attribute to enable and query the state of split pagetables
> for the domain.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>  include/linux/iommu.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index f2223cb..18c861e 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -126,6 +126,7 @@ enum iommu_attr {
>  	DOMAIN_ATTR_FSL_PAMUV1,
>  	DOMAIN_ATTR_NESTING,	/* two stages of translation */
>  	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
> +	DOMAIN_ATTR_SPLIT_TABLES,
>  	DOMAIN_ATTR_MAX,
>  };

Acked-by: Will Deacon <will@kernel.org>

Although a comment describing what this does wouldn't hurt.

Will
