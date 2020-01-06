Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AC4C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B5F207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="dwlz1VRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgAFV55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:57:57 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:18254 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726695AbgAFV55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:57:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578347875; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=Dh6uBBQOO4o59nsJrAsOkHICiEkRHSqYa9UZMQn8AGc=; b=dwlz1VRfaNG37QxpTqFLTVtDGzmc9nANj10LAtck1G8B/QpYid3KToqCsigFdOMLhbEnb1Cs
 PRW/H8Rai0fkCsTFPeLgaPV6wON8SUL4ckh9yRao6mKxGGrw6dKCjIa6txz+upCqhVtQQLOL
 6HC5Npe7r/XrVadX1UkvTz99vOk=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e13ad62.7f4d73e86768-smtp-out-n03;
 Mon, 06 Jan 2020 21:57:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 76AB4C447A4; Mon,  6 Jan 2020 21:57:54 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BEF3EC43383;
        Mon,  6 Jan 2020 21:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BEF3EC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Mon, 6 Jan 2020 14:57:51 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     smasetty@codeaurora.org
Cc:     iommu@lists.linux-foundation.org, freedreno@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, will@kernel.org,
        robin.murphy@arm.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Sean Paul <sean@poorly.run>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 5/5] drm/msm/a6xx: Support split pagetables
Message-ID: <20200106215750.GA4341@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: smasetty@codeaurora.org, iommu@lists.linux-foundation.org,
        freedreno@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        will@kernel.org, robin.murphy@arm.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Sean Paul <sean@poorly.run>,
        linux-arm-kernel@lists.infradead.org
References: <1576514271-15687-1-git-send-email-jcrouse@codeaurora.org>
 <1576514271-15687-6-git-send-email-jcrouse@codeaurora.org>
 <8aec2a4f74fede1cf616b9e2eece3e8e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aec2a4f74fede1cf616b9e2eece3e8e@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 08:27:28AM +0530, smasetty@codeaurora.org wrote:
> On 2019-12-16 22:07, Jordan Crouse wrote:
> >Attempt to enable split pagetables if the arm-smmu driver supports it.
> >This will move the default address space from the default region to
> >the address range assigned to TTBR1. The behavior should be transparent
> >to the driver for now but it gets the default buffers out of the way
> >when we want to start swapping TTBR0 for context-specific pagetables.
> >
> >Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> >---
> >
> > drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 52
> >++++++++++++++++++++++++++++++++++-
> > 1 file changed, 51 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >index 5dc0b2c..1c6da93 100644
> >--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >@@ -811,6 +811,56 @@ static unsigned long a6xx_gpu_busy(struct msm_gpu
> >*gpu)
> > 	return (unsigned long)busy_time;
> > }
> >
> >+static struct msm_gem_address_space *
> >+a6xx_create_address_space(struct msm_gpu *gpu, struct platform_device
> >*pdev)
> >+{
> >+	struct iommu_domain *iommu = iommu_domain_alloc(&platform_bus_type);
> >+	struct msm_gem_address_space *aspace;
> >+	struct msm_mmu *mmu;
> >+	u64 start, size;
> >+	u32 val = 1;
> >+	int ret;
> >+
> >+	if (!iommu)
> >+		return ERR_PTR(-ENOMEM);
> >+
> >+	/*
> >+	 * Try to request split pagetables - the request has to be made before
> >+	 * the domian is attached
> >+	 */
> >+	iommu_domain_set_attr(iommu, DOMAIN_ATTR_SPLIT_TABLES, &val);
> >+
> >+	mmu = msm_iommu_new(&pdev->dev, iommu);
> >+	if (IS_ERR(mmu)) {
> >+		iommu_domain_free(iommu);
> >+		return ERR_CAST(mmu);
> >+	}
> >+
> >+	/*
> >+	 * After the domain is attached, see if the split tables were actually
> >+	 * successful.
> >+	 */
> >+	ret = iommu_domain_get_attr(iommu, DOMAIN_ATTR_SPLIT_TABLES, &val);
> >+	if (!ret && val) {
> >+		/*
> >+		 * The aperture start will be at the beginning of the TTBR1
> >+		 * space so use that as a base
> >+		 */
> >+		start = iommu->geometry.aperture_start;
> >+		size = 0xffffffff;
> This should be the va_end and not the size

This is a bug in msm_gem_address_space_create - I intended the parameter to be
the size.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
