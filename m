Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D37DC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383F921848
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sm1kYe9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403808AbfISPGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:06:38 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42340 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390897AbfISPGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:06:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id y91so3495788ede.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 08:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oUQUKfGGLyoufGiv0FoEyuW3RCfv5lyXYP4LRA9yUnI=;
        b=sm1kYe9P5pTViCKFjNk/d6ebqMWyJNooZxf91TSUePYb/5i7/VaEYPsMPIc2wfZVi8
         P/ooqN0dZaXdOGopagPyYfk47lN5uurdLwK5TuwLmyhYW1FITstvFCYOZDjE+2XBbEGs
         DVxBofb6ZPhP/lrm+qE4xpNtlFMAcMZAd1Ca6mP8mwuQVxEQi5Rsqjk+fTKinMoccU00
         yhhDKLGlRrtw55fnv6F+DBvplwGlSB8NUvnA7oH0UD9rik/SsDa/qisHAdtFxMcNHJ5E
         poqcqtsjOyIKhSbiF+IAS/z0wbnfXeBUqDE1jU6R7i186QYsRgMIkQLl1pqPo1r1IhhB
         MT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oUQUKfGGLyoufGiv0FoEyuW3RCfv5lyXYP4LRA9yUnI=;
        b=rdptH/W3iAaHWIFG/Js+UN6s4Rv7Xc2oCkBUFltexMaVSAYNEl0UwGYyJ2eUuXlQUQ
         7duPu8L8Cef7YGadlM6J2GiAssLRxJ2K8xK5bxmoFb7Jdvnv2aSgZK7JyWmHXrol0+5N
         eWtl7OikbN3zsHVTgTf1KJcjNyEgALWg7FbrSdZ6Yg4XhnVZkzLPdc4myk9BsW1aSOqY
         Cj+wuGuFRjSIMlOua/70fVFv1Vxcy1bPs2SLxYyXGXp3E9UEf1B1dFuLuMU6Yzc532S0
         8XoftKtnmcQektcTCw7DqKRa8RNWhcGR12ljBevMNAIF3WG3zG13zLl4+KbHpeYV8ZAe
         fjtA==
X-Gm-Message-State: APjAAAUgCIkoKRYXuGlbaPXPJJ/DSsmnGotdL0ktpFlsv/1oitxNOuMS
        5dcuNH0NnnpidvjQMYMoIxFbcA==
X-Google-Smtp-Source: APXvYqyS7bkpasvboOin36PhpvvHG70FNN59FYjP0q8duVqRlwWW9FcPkvkPkK/8rnvVy/QAXxBLOw==
X-Received: by 2002:aa7:d295:: with SMTP id w21mr9488517edq.302.1568905596363;
        Thu, 19 Sep 2019 08:06:36 -0700 (PDT)
Received: from lophozonia ([85.195.192.192])
        by smtp.gmail.com with ESMTPSA id a19sm1374424edy.37.2019.09.19.08.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 08:06:35 -0700 (PDT)
Date:   Thu, 19 Sep 2019 17:06:34 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        robin.murphy@arm.com, jacob.jun.pan@linux.intel.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eric.auger@redhat.com
Subject: Re: [PATCH 6/8] iommu/arm-smmu-v3: Support auxiliary domains
Message-ID: <20190919150634.GE1013538@lophozonia>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
 <20190610184714.6786-7-jean-philippe.brucker@arm.com>
 <20190626175959.ubxvb2qn4taclact@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626175959.ubxvb2qn4taclact@willie-the-truck>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 06:59:59PM +0100, Will Deacon wrote:
> > @@ -666,8 +668,14 @@ struct arm_smmu_domain {
> >  
> >  	struct iommu_domain		domain;
> >  
> > +	/* Unused in aux domains */
> >  	struct list_head		devices;
> >  	spinlock_t			devices_lock;
> > +
> > +	/* Auxiliary domain stuff */
> > +	struct arm_smmu_domain		*parent;
> > +	ioasid_t			ssid;
> > +	unsigned long			aux_nr_devs;
> 
> Maybe use a union to avoid comments about what is used/unused?

OK

> > +static void arm_smmu_aux_detach_dev(struct iommu_domain *domain, struct device *dev)
> > +{
> > +	struct iommu_domain *parent_domain;
> > +	struct arm_smmu_domain *parent_smmu_domain;
> > +	struct arm_smmu_master *master = dev_to_master(dev);
> > +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> > +
> > +	if (!arm_smmu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))
> > +		return;
> > +
> > +	parent_domain = iommu_get_domain_for_dev(dev);
> > +	if (!parent_domain)
> > +		return;
> > +	parent_smmu_domain = to_smmu_domain(parent_domain);
> > +
> > +	mutex_lock(&smmu_domain->init_mutex);
> > +	if (!smmu_domain->aux_nr_devs)
> > +		goto out_unlock;
> > +
> > +	if (!--smmu_domain->aux_nr_devs) {
> > +		arm_smmu_write_ctx_desc(parent_smmu_domain, smmu_domain->ssid,
> > +					NULL);
> > +		/*
> > +		 * TLB doesn't need invalidation since accesses from the device
> > +		 * can't use this domain's ASID once the CD is clear.
> > +		 *
> > +		 * Sadly that doesn't apply to ATCs, which are PASID tagged.
> > +		 * Invalidate all other devices as well, because even though
> > +		 * they weren't 'officially' attached to the auxiliary domain,
> > +		 * they could have formed ATC entries.
> > +		 */
> > +		arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
> 
> I've been struggling to understand the locking here, since both
> arm_smmu_write_ctx_desc and arm_smmu_atc_inv_domain take and release the
> devices_lock for the domain. Is there not a problem with devices coming and
> going in-between the two calls?

Yes, I need to think about this more. I bet there are plenty more issues
like this. For example I don't think I currently prevent the parent
domain from disappearing while auxiliary domains are attached.

> >  static struct iommu_ops arm_smmu_ops = {
> >  	.capable		= arm_smmu_capable,
> >  	.domain_alloc		= arm_smmu_domain_alloc,
> > @@ -2539,6 +2772,13 @@ static struct iommu_ops arm_smmu_ops = {
> >  	.of_xlate		= arm_smmu_of_xlate,
> >  	.get_resv_regions	= arm_smmu_get_resv_regions,
> >  	.put_resv_regions	= arm_smmu_put_resv_regions,
> > +	.dev_has_feat		= arm_smmu_dev_has_feature,
> > +	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
> > +	.dev_enable_feat	= arm_smmu_dev_enable_feature,
> > +	.dev_disable_feat	= arm_smmu_dev_disable_feature,
> 
> Why can't we use the existing ->capable and ->dev_{get,set}_attr callbacks
> for this?

->capable isn't very useful because it applies to all SMMUs in the
system. The existing ->{get,set}_attr callbacks apply to an
iommu_domain. I think the main reason for doing it on endpoints was that
it would be tedious to keep track of capabilities when attaching and
detaching devices to a domain, especially for drivers that allow
multiple IOMMUs per domain [1]. There were more discussions, and in the
end we agreed on this API for device attributes [2].

Thanks,
Jean

[1] https://lore.kernel.org/lkml/aa1ff748-c2ec-acc0-f1d9-cdff2b131e58@linux.intel.com/
[2] https://lore.kernel.org/linux-iommu/20181207102926.GM16835@8bytes.org/

