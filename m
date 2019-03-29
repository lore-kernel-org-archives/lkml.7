Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BB3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4482184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbfC2OvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:51:05 -0400
Received: from 8bytes.org ([81.169.241.247]:59760 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729670AbfC2OvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:51:03 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A7DB7303; Fri, 29 Mar 2019 15:51:01 +0100 (CET)
Date:   Fri, 29 Mar 2019 15:51:01 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Gary R Hook <ghook@amd.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: Reserve exclusion range in iova-domain
Message-ID: <20190329145101.GA27670@8bytes.org>
References: <20190328104459.18589-1-joro@8bytes.org>
 <3850c381-30d6-b2a3-d976-66939d8e612a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3850c381-30d6-b2a3-d976-66939d8e612a@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gary,

On Thu, Mar 28, 2019 at 02:52:19PM +0000, Gary R Hook wrote:
> On 3/28/19 5:44 AM, Joerg Roedel wrote:
> > +		if (entry->prot & (1 << 2))
> 
> Could we add #define IOMMU_WRITE_EXCL (1 << 2) to amd_iommu_types.h?

Yes, I replace that magic number with a descriptive name.

> The problem I see here is that if, for some untold reason, there is more 
> than one exclusion range emitted, where only the last one wins in the 
> hardware, we'd still end up with more than one range reserved in the 
> IOVA tree. Clearly, this is extremely unlikely, but wouldn't we want to 
> protect against that sort of misuse/mistake?
> 
> I could be missing something.

No, you are not, this could still be a problem. Until now it isn't,
because this week was the first time I have every seen an AMD IOMMU
system making use of exclusion ranges, and it doesn't have this problem.

But this problem has been in the code even before this patch and needs
to be addressed separatly. I think it is the best option to cancel IOMMU
initialization when the IVRS table defines conflicting exclusion ranges
for a single IOMMU instance.

Regards,

	Joerg

