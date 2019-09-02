Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4394EC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA1A2168B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbfIBIiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:38:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:25522 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729756AbfIBIiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:38:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 01:38:02 -0700
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="184442382"
Received: from jkrzyszt-desk.ger.corp.intel.com ([172.22.244.17])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 01:38:00 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?TWljaGHFgg==?= Wajdeczko <michal.wajdeczko@intel.com>,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: Re: [RFC PATCH] iommu/vt-d: Fix IOMMU field not populated on device hot re-plug
Date:   Mon, 02 Sep 2019 10:37:41 +0200
Message-ID: <1769080.0GM3UzqXcv@jkrzyszt-desk.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <ccb1434d-281c-abae-0726-7fd924041315@linux.intel.com>
References: <20190822142922.31526-1-janusz.krzysztofik@linux.intel.com> <3255251.C7nBVfOIaa@jkrzyszt-desk.ger.corp.intel.com> <ccb1434d-281c-abae-0726-7fd924041315@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On Thursday, August 29, 2019 11:08:18 AM CEST Lu Baolu wrote:
> Hi,
> 
> On 8/29/19 3:58 PM, Janusz Krzysztofik wrote:
> > Hi Baolu,
> > 
> > On Thursday, August 29, 2019 3:43:31 AM CEST Lu Baolu wrote:
> >> Hi Janusz,
> >>
> >> On 8/28/19 10:17 PM, Janusz Krzysztofik wrote:
> >>>> We should avoid kernel panic when a intel_unmap() is called against
> >>>> a non-existent domain.
> >>> Does that mean you suggest to replace
> >>> 	BUG_ON(!domain);
> >>> with something like
> >>> 	if (WARN_ON(!domain))
> >>> 		return;
> >>> and to not care of orphaned mappings left allocated?  Is there a way to
> > inform
> >>> users that their active DMA mappings are no longer valid and they
> > shouldn't
> >>> call dma_unmap_*()?
> >>>
> >>>> But we shouldn't expect the IOMMU driver not
> >>>> cleaning up the domain info when a device remove notification comes and
> >>>> wait until all file descriptors being closed, right?
> >>> Shouldn't then the IOMMU driver take care of cleaning up resources still
> >>> allocated on device remove before it invalidates and forgets their
> > pointers?
> >>>
> >>
> >> You are right. We need to wait until all allocated resources (iova and
> >> mappings) to be released.
> >>
> >> How about registering a callback for BUS_NOTIFY_UNBOUND_DRIVER, and
> >> removing the domain info when the driver detachment completes?
> > 
> > Device core calls BUS_NOTIFY_UNBOUND_DRIVER on each driver unbind, 
regardless
> > of a device being removed or not.  As long as the device is not unplugged 
and
> > the BUS_NOTIFY_REMOVED_DEVICE notification not generated, an unbound 
driver is
> > not a problem here.
> > Morever, BUS_NOTIFY_UNBOUND_DRIVER  is called even before
> > BUS_NOTIFY_REMOVED_DEVICE so that wouldn't help anyway.
> > Last but not least, bus events are independent of the IOMMU driver use via
> > DMA-API it exposes.
> 
> Fair enough.
> 
> > 
> > If keeping data for unplugged devices and reusing it on device re-plug is 
not
> > acceptable then maybe the IOMMU driver should perform reference counting 
of
> > its internal resources occupied by DMA-API users and perform cleanups on 
last
> > release?
> 
> I am not saying that keeping data is not acceptable. I just want to
> check whether there are any other solutions.

Then reverting 458b7c8e0dde and applying this patch still resolves the issue 
for me.  No errors appear when mappings are unmapped on device close after the 
device has been removed, and domain info preserved on device removal is 
successfully reused on device re-plug.

Is there anything else I can do to help?

Thanks,
Janusz

> 
> Best regards,
> Baolu
> 




