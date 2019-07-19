Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045FCC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 15:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3142184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 15:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfGSPXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 11:23:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfGSPXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 11:23:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 77B7F30C1353;
        Fri, 19 Jul 2019 15:23:05 +0000 (UTC)
Received: from x1.home (ovpn-116-35.phx2.redhat.com [10.3.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 833C8101E253;
        Fri, 19 Jul 2019 15:23:04 +0000 (UTC)
Date:   Fri, 19 Jul 2019 09:23:03 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, kevin.tian@intel.com,
        ashok.raj@intel.com, dima@arista.com, tmurphy@arista.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        jacob.jun.pan@intel.com
Subject: Re: [PATCH v4 12/15] iommu/vt-d: Cleanup get_valid_domain_for_dev()
Message-ID: <20190719092303.751659a0@x1.home>
In-Reply-To: <9957afdd-4075-e7ee-e1e6-97acb870e17a@linux.intel.com>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
        <20190525054136.27810-13-baolu.lu@linux.intel.com>
        <20190717211226.5ffbf524@x1.home>
        <9957afdd-4075-e7ee-e1e6-97acb870e17a@linux.intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 19 Jul 2019 15:23:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2019 17:04:26 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi Alex,
> 
> On 7/18/19 11:12 AM, Alex Williamson wrote:
> > On Sat, 25 May 2019 13:41:33 +0800
> > Lu Baolu <baolu.lu@linux.intel.com> wrote:
> >   
> >> Previously, get_valid_domain_for_dev() is used to retrieve the
> >> DMA domain which has been attached to the device or allocate one
> >> if no domain has been attached yet. As we have delegated the DMA
> >> domain management to upper layer, this function is used purely to
> >> allocate a private DMA domain if the default domain doesn't work
> >> for ths device. Cleanup the code for readability.
> >>
> >> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> >> ---
> >>   drivers/iommu/intel-iommu.c | 18 ++++++++----------
> >>   include/linux/intel-iommu.h |  1 -
> >>   2 files changed, 8 insertions(+), 11 deletions(-)  
> > 
> > System fails to boot bisected to this commit:  
> 
> Is this the same issue as this https://lkml.org/lkml/2019/7/18/840?

Yes, the above link is after bisecting with all the bugs and fixes
squashed together to avoid landing in local bugs.  Thanks,

Alex
