Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B46C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1489B2189D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbfH0JgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:36:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:43426 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbfH0JgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:36:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 02:36:02 -0700
X-IronPort-AV: E=Sophos;i="5.64,436,1559545200"; 
   d="scan'208";a="355716470"
Received: from jkrzyszt-desk.igk.intel.com (HELO jkrzyszt-desk.ger.corp.intel.com) ([172.22.244.17])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 02:36:01 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?TWljaGHFgg==?= Wajdeczko <michal.wajdeczko@intel.com>
Subject: Re: [RFC PATCH] iommu/vt-d: Fix IOMMU field not populated on device hot re-plug
Date:   Tue, 27 Aug 2019 11:35:47 +0200
Message-ID: <29020717.Hl6jQjRASr@jkrzyszt-desk.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <790a4a20-7517-fe54-177d-850b9beeb88e@linux.intel.com>
References: <20190822142922.31526-1-janusz.krzysztofik@linux.intel.com> <7536805.yzB8ZXLclH@jkrzyszt-desk.ger.corp.intel.com> <790a4a20-7517-fe54-177d-850b9beeb88e@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu,

On Monday, August 26, 2019 10:29:12 AM CEST Lu Baolu wrote:
> Hi Janusz,
> 
> On 8/26/19 4:15 PM, Janusz Krzysztofik wrote:
> > Hi Lu,
> > 
> > On Friday, August 23, 2019 3:51:11 AM CEST Lu Baolu wrote:
> >> Hi,
> >>
> >> On 8/22/19 10:29 PM, Janusz Krzysztofik wrote:
> >>> When a perfectly working i915 device is hot unplugged (via sysfs) and
> >>> hot re-plugged again, its dev->archdata.iommu field is not populated
> >>> again with an IOMMU pointer.  As a result, the device probe fails on
> >>> DMA mapping error during scratch page setup.
> >>>
> >>> It looks like that happens because devices are not detached from their
> >>> MMUIO bus before they are removed on device unplug.  Then, when an
> >>> already registered device/IOMMU association is identified by the
> >>> reinstantiated device's bus and function IDs on IOMMU bus re-attach
> >>> attempt, the device's archdata is not populated with IOMMU information
> >>> and the bad happens.
> >>>
> >>> I'm not sure if this is a proper fix but it works for me so at least it
> >>> confirms correctness of my analysis results, I believe.  So far I
> >>> haven't been able to identify a good place where the possibly missing
> >>> IOMMU bus detach on device unplug operation could be added.
> >>
> >> Which kernel version are you testing with? Does it contain below commit?
> >>
> >> commit 458b7c8e0dde12d140e3472b80919cbb9ae793f4
> >> Author: Lu Baolu <baolu.lu@linux.intel.com>
> >> Date:   Thu Aug 1 11:14:58 2019 +0800
> > 
> > I was using an internal branch based on drm-tip which didn't contain this
> > commit yet.  Fortunately it has been already merged into drm-tip over last
> > weekend and has effectively fixed the issue.
> 
> Thanks for testing this.

My testing appeared not sufficiently exhaustive. The fix indeed resolved my 
initially discovered issue of not being able to rebind the i915 driver to a 
re-plugged device, however it brought another, probably more serious problem 
to light.

When an open i915 device is hot unplugged, IOMMU bus notifier now cleans up 
IOMMU info for the device on PCI device remove while the i915 driver is still 
not released, kept by open file descriptors.  Then, on last device close, 
cleanup attempts lead to kernel panic raised from intel_unmap() on unresolved 
IOMMU domain.

With commit 458b7c8e0dde reverted and my fix applied, both late device close 
and device re-plug work for me.  However, I can realize that's probably still 
not a complete solution, possibly missing some protection against reuse of a 
removed device other than for cleanup.  If you think that's the right way to 
go, I can work more on that.

I've had a look at other drivers and found AMD is using somehow similar 
approach.  On the other hand, looking at the IOMMU common code I couldn't 
identify any arrangement that would support deferred device cleanup.

If that approach is not acceptable for Intel IOMMU, please suggest a way you'd 
like to have it resolved and I can try to implement it.

Thanks,
Janusz

> Best regards,
> Lu Baolu
> 




