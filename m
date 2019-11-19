Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6DCC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CEB222B6
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfKSR14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 12:27:56 -0500
Received: from mga14.intel.com ([192.55.52.115]:15490 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728060AbfKSR14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 12:27:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 09:27:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,218,1571727600"; 
   d="scan'208";a="289673313"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 19 Nov 2019 09:27:55 -0800
Date:   Tue, 19 Nov 2019 09:32:31 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 02/10] iommu/vt-d: Fix CPU and IOMMU SVM feature
 matching checks
Message-ID: <20191119093231.65fb3b3f@jacob-builder>
In-Reply-To: <3634dee5-3f9f-4618-951e-8bb5e4988223@redhat.com>
References: <1574106153-45867-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1574106153-45867-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <26d1e79b-3a16-0a8f-895e-e2c41c8d3b28@redhat.com>
        <20191118134719.6835981b@jacob-builder>
        <3634dee5-3f9f-4618-951e-8bb5e4988223@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2019 09:02:26 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 11/18/19 10:47 PM, Jacob Pan wrote:
> > On Mon, 18 Nov 2019 21:33:34 +0100
> > Auger Eric <eric.auger@redhat.com> wrote:
> >   
> >> Hi Jacob,
> >>
> >> On 11/18/19 8:42 PM, Jacob Pan wrote:  
> >>> The current code checks CPU and IOMMU feature set for SVM support
> >>> but the result is never stored nor used. Therefore, SVM can still
> >>> be used even when these checks failed.    
> >> "SVM can still be used even when these checks failed". What were
> >> the consequences if it happened? Does it fix this cleanly now.  
> >>>  
> > The consequence is DMA cannot reach above 48-bit virtual address
> > range when CPU does 5-level and IOMMU can only do 4-level. With is
> > fix, svm_bind_mm will fail in the first place to prevent SVM use by
> > DMA.  
> OK thank you for the clarification. Maybe this latter can be added in
> the commit message
> >
Yes, will do.   
>  [...]  
> >> nit: is it really an error or just a warning?  
> > I think it is an error in that there is an illegal configuration.
> > It is mostly for vIOMMU, we expect native HW should have these
> > features matched.  
> 
> OK
> 
> Thanks
> 
> Eric
> >   
>  [...]  
> >> Besides,
> >> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> >>
> >> Thanks
> >>
> >> Eric
> >>  
> > 
> > [Jacob Pan]
> >   
> 

[Jacob Pan]
