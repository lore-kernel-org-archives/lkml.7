Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0937CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD892064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392010AbfJWVHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:07:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:60528 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391902AbfJWVHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:07:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 14:07:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="191964696"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008.jf.intel.com with ESMTP; 23 Oct 2019 14:07:05 -0700
Date:   Wed, 23 Oct 2019 14:11:26 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v6 01/10] iommu/vt-d: Enlightened PASID allocation
Message-ID: <20191023141126.38bc1644@jacob-builder>
In-Reply-To: <20191023105523.75895d76@jacob-builder>
References: <1571788403-42095-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1571788403-42095-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20191023004503.GB100970@otc-nc-03>
        <f17d8df6-d77a-32b9-104c-1ae246c7a117@linux.intel.com>
        <20191023105523.75895d76@jacob-builder>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019 10:55:23 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> > > Do you have to check this everytime? every dmar_readq is going to
> > > trap to the other side ...    
> > 
> > Yes. We don't need to check it every time. Check once and save the
> > result during boot is enough.
> > 
> > How about below incremental change?
> >   
> Below is good but I was thinking to include vccap in struct
> intel_iommu{} where cap and ecaps reside. i.e.
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 14b87ae2916a..e2cf25c9c956 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -528,6 +528,7 @@ struct intel_iommu {
>         u64             reg_size; /* size of hw register set */
>         u64             cap;
>         u64             ecap;
> +       u64             vccap;
> 
> Also, we can use a static branch here.
> 
On a second thought, we cannot use static(branch) here in that we
cannot assume there is only one vIOMMU all the time. Have to cache the
vccap per iommu.

> > diff --git a/drivers/iommu/intel-pasid.c
> > b/drivers/iommu/intel-pasid.c index ff7e877b7a4d..c15d9d7e1e73
> > 100644 --- a/drivers/iommu/intel-pasid.c
> > +++ b/drivers/iommu/intel-pasid.c
> > @@ -29,22 +29,29 @@ u32 intel_pasid_max_id = PASID_MAX;
> > 
[Jacob Pan]
