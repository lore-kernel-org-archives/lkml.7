Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A9ACA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDCD21744
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390796AbfJ1QG1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:06:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:58743 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730627AbfJ1QG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:06:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 09:06:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,240,1569308400"; 
   d="scan'208";a="210903910"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga001.fm.intel.com with ESMTP; 28 Oct 2019 09:06:26 -0700
Date:   Mon, 28 Oct 2019 09:10:49 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v7 11/11] iommu/vt-d: Add svm/sva invalidate function
Message-ID: <20191028091049.04f2d83f@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D5DB7D9@SHSMSX104.ccr.corp.intel.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1571946904-86776-12-git-send-email-jacob.jun.pan@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D5CDE06@SHSMSX104.ccr.corp.intel.com>
        <5e9d2372-a8b5-9a26-1438-c1a608bfad6d@linux.intel.com>
        <d0375121-7893-bb06-45f3-209a0cff12de@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D5DB7D9@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019 06:06:33 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > >>> +    /* PASID based dev TLBs, only support all PASIDs or single
> > >>> PASID */
> > >>> +    {1, 1, 0},  
> > >>
> > >> I forgot previous discussion. is it necessary to pass down dev
> > >> TLB invalidation
> > >> requests? Can it be handled by host iOMMU driver automatically?  
> > >
> > > On host SVA, when a memory is unmapped, driver callback will
> > > invalidate dev IOTLB explicitly. So I guess we need to pass down
> > > it for guest case. This is also required for guest iova over 1st
> > > level usage as far as can see.
> > >  
> > 
> > Sorry, I confused guest vIOVA and guest vSVA. For guest vIOVA, no
> > device TLB invalidation pass down. But currently for guest vSVA,
> > device TLB invalidation is passed down. Perhaps we can avoid
> > passing down dev TLB flush just like what we are doing for guest
> > IOVA. 
> 
> I think dev TLB is fully handled within IOMMU driver today. It doesn't
> require device driver to explicit toggle. With this then we can fully
> virtualize guest dev TLB invalidation request to save one syscall,
> since the host is supposed to flush dev TLB when serving the earlier
> IOTLB invalidation pass-down.

In the previous discussions, we thought about making IOTLB flush
inclusive, where IOTLB flush would always include device TLB flush. But
we thought such behavior cannot be assumed for all VMMs, some may still
do explicit dev TLB flush. So for completeness, we included dev TLB
here.
