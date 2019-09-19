Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA735C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DD321848
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RxBIEWkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390899AbfISPF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:05:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38582 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389179AbfISPF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:05:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id a23so3522101edv.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 08:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yic2bDSQvOGyK05i6zWexPg+z8iu2akZCAIBwfSlM4U=;
        b=RxBIEWkzx/5W626K0TPy3NrQD+9xUc2EtjQq5wij6HuQ4p6J8/jo5dqn0wVA5Xnd18
         m6jKndTL7m3KJWdcqYOd4bsX0jZ7Vpbu5CEpsnoYfC/es2QHVjlN1+TMtJpntIs21qlr
         O11fuKKCW0K7V+2I6q9rIXJZFLDAbAN7KSxiBeGQmspKYs5LogftnMCA/QSS4D+5fbOf
         AKHw+EUSbdFxbZeYccacevGazTtWWjnf3dPhGTeBsBgjYaCXheAf3LA/dFJlW8vnlUeK
         e6jlulH6fQf0bErESyCyq7GoPE2/efqefs5t7xY6Sd2zGC8XeaCm1KufYPTcGcBnoC/D
         QXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yic2bDSQvOGyK05i6zWexPg+z8iu2akZCAIBwfSlM4U=;
        b=ob7/g6DpiM14DcgNeXQexkFI0JfxIZUaMIN7YeAD4rh2YqrYDT1+Xvha2Vt27Ll17o
         wO3ea2JWVedSBzzR1YzCF2a4nO+X5BR2oMe4kzbmA1ZUOo9DcvFe6ro8QJE09M3/p2aY
         Z/SmFCdQHUkfFA5vWKTZ5ox5cgxOVPh7xpb9eyuWkohAMOczB4LURxY2kyCrVhbESZHd
         amG1XzFy4Uo2hEBxXSJauFnNPcQdoWi6Xcz7LGgtDUJP3PGbNIiMQNA9wCTJPqhG/1mg
         4AuyqjOhR9r+0l2rJL8JHsvUBc27tH4aVPTesc57GTkdGmmAMFez19dXfWohGNT5WzcX
         LhGg==
X-Gm-Message-State: APjAAAXBReB72B4HEx1ujEGsvGXkL4cviIur+gAYGUNiq/sKLM7PxFzp
        L4Zbn645D/T8AHsqbrkzc0jaxA==
X-Google-Smtp-Source: APXvYqxNqq5i16Ldy9K5kJrRzW5FWYXXym5RB8VVgZepY0ldECJaTECor9Qc5brFdyWW9WM/8SUoEA==
X-Received: by 2002:a17:906:76c2:: with SMTP id q2mr14903775ejn.202.1568905524420;
        Thu, 19 Sep 2019 08:05:24 -0700 (PDT)
Received: from lophozonia ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id e39sm1689919edb.69.2019.09.19.08.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 08:05:23 -0700 (PDT)
Date:   Thu, 19 Sep 2019 17:05:21 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        jacob.jun.pan@linux.intel.com, joro@8bytes.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        robh+dt@kernel.org, robin.murphy@arm.com
Subject: Re: [PATCH 5/8] iommu/arm-smmu-v3: Add second level of context
 descriptor table
Message-ID: <20190919150521.GD1013538@lophozonia>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
 <20190610184714.6786-6-jean-philippe.brucker@arm.com>
 <3e69caf7-4e8a-4bce-7a89-51e21a0134b1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e69caf7-4e8a-4bce-7a89-51e21a0134b1@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 05:13:05PM +0200, Auger Eric wrote:
> >  #define STRTAB_STE_0_S1FMT		GENMASK_ULL(5, 4)
> >  #define STRTAB_STE_0_S1FMT_LINEAR	0
> > +#define STRTAB_STE_0_S1FMT_4K_L2	1
> As you only use 64kB L2, I guess you can remove the 4K define?

I prefer defining all values, but I suppose I can get rid of it.

> > +	cfg->tables = devm_kzalloc(smmu->dev, sizeof(struct arm_smmu_cd_table) *
> > +				   cfg->num_tables, GFP_KERNEL);
> > +	if (!cfg->tables)
> > +		return -ENOMEM;
> goto err_free_l1
> > +
> > +	ret = arm_smmu_alloc_cd_leaf_table(smmu, &cfg->tables[0], num_leaf_entries);
> don't you want to do that only in linear case. In 2-level mode, I
> understand arm_smmu_get_cd_ptr() will do the job.

OK, that might be better

> 
> > +	if (ret)
> > +		goto err_free_l1;
> > +
> > +	if (cfg->l1ptr)
> > +		arm_smmu_write_cd_l1_desc(cfg->l1ptr, &cfg->tables[0]);
> that stuff could be removed as well?

Yes

> By the way I can see that
> arm_smmu_get_cd_ptr() does a arm_smmu_sync_cd after. wouldn't it be
> needed here as well?

No context table is reachable from a STE at this point, so we don't have
to invalidate anything.

> > @@ -1815,7 +1935,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
> >  	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> >  		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
> >  
> > -		if (cfg->table.ptr) {
> > +		if (cfg->tables) {
> >  			arm_smmu_free_cd_tables(smmu_domain);
> >  			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
> I don't get why the arm_smmu_bitmap_free is dependent on cfg->tables.

Simply because arm_smmu_bitmap_alloc() and arm_smmu_alloc_cd_tables()
are both performed in arm_smmu_domain_finalise_s1(). A domain returned
by arm_smmu_domain_alloc() is not fully initialized, it still needs to
be finalized by arm_smmu_attach_dev(). So here we check whether the
domain has been finalized or not. Zero being a valid ASID in this
driver, we can't check whether cfg->cd.asid is valid, so we check
cfg->tables instead.

And I forgot to clear cfg->tables after failure of domain_finalise in
this series, I'll need to fix it.

Thanks,
Jean
