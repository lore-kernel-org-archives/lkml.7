Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEBEC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0545A21928
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LAwSAOYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390839AbfISO6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:58:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46300 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387407AbfISO57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:57:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id t3so3438261edw.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 07:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eEK3lLhQaGb6Uf5dm+fgmb2DX85yl5wvHqgPEcR4Tns=;
        b=LAwSAOYhenFH3sp+/nJqQR/xEhMF07jQ0LzJnulzYtxXyS6jo42nxoXy0LJ7ZQOdQ0
         k4zJxD4gKB3toDN/TXFgQAVO9NSFVRiN7KtT9M+2g/5WmVGHnsY7t+cB21TQGs6f9ygX
         uMDn/eVqzoP7f2yfdGe4KtjcdoZ2aYJtKvmYVTQJQGv9x+oyGVcKnkwukDs1WhzKLbN9
         2+X6nk+uTZY14iW7DQz1hJ6vVP8zUHPrHUKf5DVh8wCbVmSxfReX9wCreMqNT0/cr579
         2ce/53jovih8tAQyzGGbyrEbwO8/Ju7DWwFOEeQWhonRepegb/JHdn2h0fQh872/fFK7
         tgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eEK3lLhQaGb6Uf5dm+fgmb2DX85yl5wvHqgPEcR4Tns=;
        b=Mh398njBSU9EHmV94rQVW+kkn2V0U+ZFaAfg3SIvSUtRHAjRc+/vgmAv8oEJE6LZwO
         poNsnQWzKNcbVfKgFoM8X81ubKeP7ulHYwSS66oPwCUCtPSHuZz4mDCJv0EISytoyGAF
         YjAA/8HPvN1hdfPDKyFIo4F2P/cd565v3L+pCnqk7YYfCFJLakTV0m2oAaiF5e5J3th8
         b9YXRWMU5UUou+JVOnYpQUWmtFp1yMBkHVkPOitMP/L4f/yM+geT6ZaEpBKChW4xD4mt
         OKGbQfa2uRfKOZ9gf3WTrm3Zjxs+aIcBInKqa8eDmuiKsfVaWbX4c3EPhgKnCb1Br+ow
         atFQ==
X-Gm-Message-State: APjAAAX6xM+i6MLSIcHlRl9Ktc7WcRWlfXrWrsINePPfCM1hHCgMik/m
        3/fTAtyxphGm/j5ipNEAU7b4bDo36r2/7Q==
X-Google-Smtp-Source: APXvYqwk1K+MGMggp+/l3DiL4j0oR3ZGy4qRdCDJYY4eyD0SE8qOKY+ATrvkN66cEC/bhZ+wwLlWaQ==
X-Received: by 2002:a50:d718:: with SMTP id t24mr1264594edi.168.1568905078372;
        Thu, 19 Sep 2019 07:57:58 -0700 (PDT)
Received: from lophozonia ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id a22sm1038936ejs.17.2019.09.19.07.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 07:57:57 -0700 (PDT)
Date:   Thu, 19 Sep 2019 16:57:55 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        robin.murphy@arm.com, jacob.jun.pan@linux.intel.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eric.auger@redhat.com
Subject: Re: [PATCH 4/8] iommu/arm-smmu-v3: Add support for Substream IDs
Message-ID: <20190919145755.GB1013538@lophozonia>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
 <20190610184714.6786-5-jean-philippe.brucker@arm.com>
 <20190626180025.g4clm6qnbbna65de@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626180025.g4clm6qnbbna65de@willie-the-truck>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 07:00:26PM +0100, Will Deacon wrote:
> On Mon, Jun 10, 2019 at 07:47:10PM +0100, Jean-Philippe Brucker wrote:
> > In all stream table entries, we set S1DSS=SSID0 mode, making translations
> > without an SSID use context descriptor 0. Although it would be possible by
> > setting S1DSS=BYPASS, we don't currently support SSID when user selects
> > iommu.passthrough.
> 
> I don't understand your comment here: iommu.passthrough works just as it did
> before, right, since we set bypass in the STE config field so S1DSS is not
> relevant?

What isn't supported is bypassing translation *only* for transactions
without SSID, and using context descriptors for anything with SSID. I
don't know if such a mode would be useful, but I can drop that sentence
to avoid confusion.

> I also notice that SSID0 causes transactions with SSID==0 to
> abort. Is a PASID of 0 reserved, so this doesn't matter?

Yes, we never allocate PASID 0.

> 
> > @@ -1062,33 +1143,90 @@ static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
> >  	return val;
> >  }
> >  
> > -static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
> > -				    struct arm_smmu_s1_cfg *cfg)
> > +static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
> > +				   int ssid, struct arm_smmu_ctx_desc *cd)
> >  {
> >  	u64 val;
> > +	bool cd_live;
> > +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> > +	__le64 *cdptr = arm_smmu_get_cd_ptr(&smmu_domain->s1_cfg, ssid);
> >  
> >  	/*
> > -	 * We don't need to issue any invalidation here, as we'll invalidate
> > -	 * the STE when installing the new entry anyway.
> > +	 * This function handles the following cases:
> > +	 *
> > +	 * (1) Install primary CD, for normal DMA traffic (SSID = 0).
> > +	 * (2) Install a secondary CD, for SID+SSID traffic.
> > +	 * (3) Update ASID of a CD. Atomically write the first 64 bits of the
> > +	 *     CD, then invalidate the old entry and mappings.
> > +	 * (4) Remove a secondary CD.
> >  	 */
> > -	val = arm_smmu_cpu_tcr_to_cd(cfg->cd.tcr) |
> > +
> > +	if (!cdptr)
> > +		return -ENOMEM;
> > +
> > +	val = le64_to_cpu(cdptr[0]);
> > +	cd_live = !!(val & CTXDESC_CD_0_V);
> > +
> > +	if (!cd) { /* (4) */
> > +		cdptr[0] = 0;
> 
> Should we be using WRITE_ONCE here? (although I notice we don't seem to
> bother for STEs either...)

Yes, I think it makes sense

Thanks,
Jean
