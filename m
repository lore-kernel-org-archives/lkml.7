Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38361C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FD121852
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbfHZM7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:59:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:38579 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730592AbfHZM7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:59:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 05:59:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="209354171"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga002.fm.intel.com with ESMTP; 26 Aug 2019 05:59:17 -0700
Date:   Mon, 26 Aug 2019 06:03:06 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: remove global page flush support
Message-ID: <20190826060306.6ed6faca@jacob-builder>
In-Reply-To: <20190823082307.GF30332@8bytes.org>
References: <1566336068-39416-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <20190823082307.GF30332@8bytes.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2019 10:23:07 +0200
Joerg Roedel <joro@8bytes.org> wrote:

> Hi Jacob,
> 
> On Tue, Aug 20, 2019 at 02:21:08PM -0700, Jacob Pan wrote:
> > Global pages support is removed from VT-d spec 3.0. Since global
> > pages G flag only affects first-level paging structures and because
> > DMA request with PASID are only supported by VT-d spec. 3.0 and
> > onward, we can safely remove global pages support.
> > 
> > For kernel shared virtual address IOTLB invalidation, PASID
> > granularity and page selective within PASID will be used. There is
> > no global granularity supported. Without this fix, IOTLB
> > invalidation will cause invalid descriptor error in the queued
> > invalidation (QI) interface.
> > 
> > Reported-by:   Sanjay K Kumar <sanjay.k.kumar@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel-svm.c   | 36
> > +++++++++++++++--------------------- include/linux/intel-iommu.h |
> > 3 --- 2 files changed, 15 insertions(+), 24 deletions(-)  
> 
> Does not cleanly apply to v5.3-rc5, can you please rebase it and
> re-send? Also, is this v5.3 stuff (in that case please add a Fixes
> tag) or can it wait for v5.4?
> 
I will rebase and send out again later today. Since it fixes fault in
HW and in QEMU vIOMMU that is in development, it would be great to be
included in v5.3. I will add a fixes tag.

Thanks,

Jacob

> Regards,
> 
> 	Joerg

[Jacob Pan]
