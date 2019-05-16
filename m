Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FFEC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4DF20815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbfEPQxs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:53:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbfEPQxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:53:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3CD1D309267B;
        Thu, 16 May 2019 16:53:48 +0000 (UTC)
Received: from x1.home (ovpn-117-92.phx2.redhat.com [10.3.117.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45FE760E39;
        Thu, 16 May 2019 16:53:45 +0000 (UTC)
Date:   Thu, 16 May 2019 10:53:44 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, eric.auger.pro@gmail.com,
        joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org,
        lorenzo.pieralisi@arm.com, will.deacon@arm.com,
        hanjun.guo@linaro.org, sudeep.holla@arm.com,
        shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v3 6/7] iommu: Introduce IOMMU_RESV_DIRECT_RELAXABLE
 reserved memory regions
Message-ID: <20190516105344.5add5520@x1.home>
In-Reply-To: <57db1955-9d19-7c0b-eca3-37cc0d7d745b@redhat.com>
References: <20190516100817.12076-1-eric.auger@redhat.com>
        <20190516100817.12076-7-eric.auger@redhat.com>
        <ad8a99fa-b98a-14d3-12be-74df0e6eb8f8@arm.com>
        <57db1955-9d19-7c0b-eca3-37cc0d7d745b@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 16 May 2019 16:53:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2019 15:23:17 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Robin,
> On 5/16/19 2:46 PM, Robin Murphy wrote:
> >> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> >> index ba91666998fb..14a521f85f14 100644
> >> --- a/include/linux/iommu.h
> >> +++ b/include/linux/iommu.h
> >> @@ -135,6 +135,12 @@ enum iommu_attr {
> >>   enum iommu_resv_type {
> >>       /* Memory regions which must be mapped 1:1 at all times */
> >>       IOMMU_RESV_DIRECT,
> >> +    /*
> >> +     * Memory regions which are advertised to be 1:1 but are
> >> +     * commonly considered relaxable in some conditions,
> >> +     * for instance in device assignment use case (USB, Graphics)
> >> +     */
> >> +    IOMMU_RESV_DIRECT_RELAXABLE,  
> > 
> > What do you think of s/RELAXABLE/BOOT/ ? My understanding is that these
> > regions are only considered relevant until Linux has taken full control
> > of the endpoint, and having a slightly more well-defined scope than
> > "some conditions" might be nice.  
> That's not my current understanding. I think those RMRRs may be used
> post-boot (especially the IGD stolen memory covered by RMRR). I
> understand this depends on the video mode or FW in use by the IGD. But I
> am definitively not an expert here.

Nor am I, but generally the distinction I'm trying to achieve is
whether the reserved region is necessary for the device operation or
for the system operation.  If we deny the IGD device its mapping to
stolen memory, then maybe the IGD device doesn't work, no big deal.  If
we deny USB its RMRR, then we assume we're only cutting off PS/2
emulation that we expect isn't used at this point anyway.  Both of these
are choices in how the driver wants to use the device.  On the other
hand if we have a system where management firmware has backdoors to
devices for system health monitoring, then declining to honor the RMRR
has larger implications.  Thanks,

Alex
