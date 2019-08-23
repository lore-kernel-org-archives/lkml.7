Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE48C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4C122CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390737AbfHWIXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:23:09 -0400
Received: from 8bytes.org ([81.169.241.247]:51028 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730759AbfHWIXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:23:08 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4823A1C7; Fri, 23 Aug 2019 10:23:07 +0200 (CEST)
Date:   Fri, 23 Aug 2019 10:23:07 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/vt-d: remove global page flush support
Message-ID: <20190823082307.GF30332@8bytes.org>
References: <1566336068-39416-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566336068-39416-1-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On Tue, Aug 20, 2019 at 02:21:08PM -0700, Jacob Pan wrote:
> Global pages support is removed from VT-d spec 3.0. Since global pages G
> flag only affects first-level paging structures and because DMA request
> with PASID are only supported by VT-d spec. 3.0 and onward, we can
> safely remove global pages support.
> 
> For kernel shared virtual address IOTLB invalidation, PASID
> granularity and page selective within PASID will be used. There is
> no global granularity supported. Without this fix, IOTLB invalidation
> will cause invalid descriptor error in the queued invalidation (QI)
> interface.
> 
> Reported-by:   Sanjay K Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel-svm.c   | 36 +++++++++++++++---------------------
>  include/linux/intel-iommu.h |  3 ---
>  2 files changed, 15 insertions(+), 24 deletions(-)

Does not cleanly apply to v5.3-rc5, can you please rebase it and
re-send? Also, is this v5.3 stuff (in that case please add a Fixes tag)
or can it wait for v5.4?

Regards,

	Joerg
