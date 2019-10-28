Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013F3CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB61C218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572301249;
	bh=VSBk7YAMwCwbsPuvRCBw6UeuvHY7STvzXKIvzV2nyuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XH3Ga3nNsyhFD7eVIMrQ0/QEg/mRX7OQNF3VneEcL8Awt60z/+f3XjXoWOjWRLN/R
	 Hm3OaVGi4Yl9ozp1w48oYrVJqvaNCCNOouCWxHyc9y1xTaWLbd2fD8oOZnNOSdRCl0
	 6X5gJDnWbFK0QXqjR1rxJyzgRABxU4UTCX6GyOFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfJ1WUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 18:20:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbfJ1WUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 18:20:48 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F6A821479;
        Mon, 28 Oct 2019 22:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572301247;
        bh=VSBk7YAMwCwbsPuvRCBw6UeuvHY7STvzXKIvzV2nyuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0gosvq7R5GnXKiYYLDbPH29ONaAKpYHE02ZEPnzDUcqvXqhp72Teg/Ds/g3vOOu+v
         FG4avd2WmHPRGFFlHNloeY/x+Kqn7qS/tlQLnwyI/SyJIWS26MT+8t3UyWWDNnzYML
         dc4R4LPqV+P2GObHwW+vgu32hGQhqxFZzIWcYSL4=
Date:   Mon, 28 Oct 2019 22:20:42 +0000
From:   Will Deacon <will@kernel.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     iommu@lists.linux-foundation.org, freedreno@lists.freedesktop.org,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Clark <robdclark@chromium.org>,
        Joerg Roedel <joro@8bytes.org>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iommu/arm-smmu: fix "hang" when games exit
Message-ID: <20191028222042.GB8532@willie-the-truck>
References: <418d8426-f299-1269-2b2e-f86677cf22c2@arm.com>
 <20191007204906.19571-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007204906.19571-1-robdclark@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Oct 07, 2019 at 01:49:06PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> When games, browser, or anything using a lot of GPU buffers exits, there
> can be many hundreds or thousands of buffers to unmap and free.  If the
> GPU is otherwise suspended, this can cause arm-smmu to resume/suspend
> for each buffer, resulting 5-10 seconds worth of reprogramming the
> context bank (arm_smmu_write_context_bank()/arm_smmu_write_s2cr()/etc).
> To the user it would appear that the system just locked up.
> 
> A simple solution is to use pm_runtime_put_autosuspend() instead, so we
> don't immediately suspend the SMMU device.

Please can you reword the subject to be a bit more useful? The commit
message is great, but the subject is a bit like "fix bug in code" to me.

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> v1: original
> v2: unconditionally use autosuspend, rather than deciding based on what
>     consumer does
> 
>  drivers/iommu/arm-smmu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 3f1d55fb43c4..b7b41f5001bc 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -289,7 +289,7 @@ static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
>  static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
>  {
>  	if (pm_runtime_enabled(smmu->dev))
> -		pm_runtime_put(smmu->dev);
> +		pm_runtime_put_autosuspend(smmu->dev);
>  }
>  
>  static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
> @@ -1445,6 +1445,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	/* Looks ok, so add the device to the domain */
>  	ret = arm_smmu_domain_add_master(smmu_domain, fwspec);

Please can you put a comment here explaining what this is doing? An abridged
version of the commit message is fine.

> +	pm_runtime_set_autosuspend_delay(smmu->dev, 20);
> +	pm_runtime_use_autosuspend(smmu->dev);

Cheers,

Will
