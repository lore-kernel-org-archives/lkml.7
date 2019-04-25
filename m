Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E531DC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79966206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbfDYSEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:04:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:59440 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387483AbfDYSEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:04:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 11:04:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,394,1549958400"; 
   d="scan'208";a="134372445"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga007.jf.intel.com with ESMTP; 25 Apr 2019 11:04:37 -0700
Date:   Thu, 25 Apr 2019 11:07:20 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Auger Eric <eric.auger@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Yi L <yi.l.liu@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 02/19] iommu: introduce device fault data
Message-ID: <20190425110720.07d7d317@jacob-builder>
In-Reply-To: <a2880e11-90fe-36d4-01ad-bf3c346c6d7f@arm.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1556062279-64135-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <f444a689-4941-524e-1d4b-c090390d5b5d@arm.com>
        <220a581e-0ee8-70e2-796b-b434594e4825@redhat.com>
        <a2880e11-90fe-36d4-01ad-bf3c346c6d7f@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 15:33:17 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 25/04/2019 14:21, Auger Eric wrote:
>   We could add a
> >> IOMMU_FAULT_PAGE_REQUEST_PERM_VALID bit instead, but I still find
> >> it weird to denote the validity of a bitfield using a separate bit.
> >>
> >> Given that three different series now rely on this, how about we
> >> send the fault patches separately for v5.2?  
> 
> Sorry I meant v5.3 - after the merge window
> 
> >> I pushed the recoverable fault
> >> support applied on top of this, with the PERM_READ bit and cleaned
> >> up kernel doc, to git://linux-arm.org/linux-jpb.git sva/api  
> > 
Sounds good to me. We need th READ perm. I will pick the fault reporting
patches from this tree for my next rev. My plan is to add PRQ support
for vSVA after the current series.
> > my only concern is is it likely to be upstreamed without any actual
> > user? In the positive, of course, I don't have any objection.  
> 
> Possibly, I don't think my I/O page fault stuff for SVA is likely to
> get in v5.3, it depends on one or two more patch sets. But your
> nested work and Jacob's one may be in good shape for next version? I
> find it difficult to keep track of the same patches in three
> different series.
Same here, hard to track especially for minor tweaks. I am working
towards the next version for vSVA page fault. Then I will look into
converting VT-d native IO page fault to yours.

Thanks,

Jacob
