Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382ABC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1501B206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbfHZIPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 04:15:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:1488 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbfHZIPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 04:15:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 01:15:34 -0700
X-IronPort-AV: E=Sophos;i="5.64,431,1559545200"; 
   d="scan'208";a="174133517"
Received: from jkrzyszt-desk.ger.corp.intel.com ([172.22.244.17])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 01:15:31 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?TWljaGHFgg==?= Wajdeczko <michal.wajdeczko@intel.com>
Subject: Re: [RFC PATCH] iommu/vt-d: Fix IOMMU field not populated on device hot re-plug
Date:   Mon, 26 Aug 2019 10:15:21 +0200
Message-ID: <7536805.yzB8ZXLclH@jkrzyszt-desk.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <00f1a3a7-7ff6-e9a0-d9de-a177af6fd64b@linux.intel.com>
References: <20190822142922.31526-1-janusz.krzysztofik@linux.intel.com> <00f1a3a7-7ff6-e9a0-d9de-a177af6fd64b@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu,

On Friday, August 23, 2019 3:51:11 AM CEST Lu Baolu wrote:
> Hi,
> 
> On 8/22/19 10:29 PM, Janusz Krzysztofik wrote:
> > When a perfectly working i915 device is hot unplugged (via sysfs) and
> > hot re-plugged again, its dev->archdata.iommu field is not populated
> > again with an IOMMU pointer.  As a result, the device probe fails on
> > DMA mapping error during scratch page setup.
> > 
> > It looks like that happens because devices are not detached from their
> > MMUIO bus before they are removed on device unplug.  Then, when an
> > already registered device/IOMMU association is identified by the
> > reinstantiated device's bus and function IDs on IOMMU bus re-attach
> > attempt, the device's archdata is not populated with IOMMU information
> > and the bad happens.
> > 
> > I'm not sure if this is a proper fix but it works for me so at least it
> > confirms correctness of my analysis results, I believe.  So far I
> > haven't been able to identify a good place where the possibly missing
> > IOMMU bus detach on device unplug operation could be added.
> 
> Which kernel version are you testing with? Does it contain below commit?
> 
> commit 458b7c8e0dde12d140e3472b80919cbb9ae793f4
> Author: Lu Baolu <baolu.lu@linux.intel.com>
> Date:   Thu Aug 1 11:14:58 2019 +0800

I was using an internal branch based on drm-tip which didn't contain this 
commit yet.  Fortunately it has been already merged into drm-tip over last 
weekend and has effectively fixed the issue.

Thanks,
Janusz

>      iommu/vt-d: Detach domain when move device out of group
> 
>      When removing a device from an iommu group, the domain should
>      be detached from the device. Otherwise, the stale domain info
>      will still be cached by the driver and the driver will refuse
>      to attach any domain to the device again.
> 
>      Cc: Ashok Raj <ashok.raj@intel.com>
>      Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>      Cc: Kevin Tian <kevin.tian@intel.com>
>      Fixes: b7297783c2bb6 ("iommu/vt-d: Remove duplicated code for 
> device hotplug")
>      Reported-and-tested-by: Vlad Buslov <vladbu@mellanox.com>
>      Suggested-by: Robin Murphy <robin.murphy@arm.com>
>      Link: https://lkml.org/lkml/2019/7/26/1133
>      Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>      Signed-off-by: Joerg Roedel <jroedel@suse.de>
> 
> Best regards,
> Lu Baolu
> 
> > 
> > Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> > ---
> >   drivers/iommu/intel-iommu.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 12d094d08c0a..7cdcd0595408 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -2477,6 +2477,9 @@ static struct dmar_domain 
*dmar_insert_one_dev_info(struct intel_iommu *iommu,
> >   		if (info2) {
> >   			found      = info2->domain;
> >   			info2->dev = dev;
> > +
> > +			if (dev && !dev->archdata.iommu)
> > +				dev->archdata.iommu = info2;
> >   		}
> >   	}
> >   
> > 
> 




