Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81132C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A0E2071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574434533;
	bh=XOsOV9WkivuaeQlatqG9K65/WMEeHRXOyL4xo8IcPpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kaZKu7qPLwbGt1hFQdAx9+xxHEuFDS05RsLiC27qAw6qmH/IdFm1nEsrdJQMDOmL9
	 ST0SXxFXs2L5PjLg7fEWCBhNBsz6GSu95gd7ZiQlSYbO3Do9z0jZHeBGHiXxZHnGXV
	 YT9xlO+2sTRSdA7xSv839lMf9G0ef1gJ4vpgGXBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfKVOzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:55:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:57418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfKVOzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:55:32 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE37B20706;
        Fri, 22 Nov 2019 14:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574434531;
        bh=XOsOV9WkivuaeQlatqG9K65/WMEeHRXOyL4xo8IcPpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UUV4P74DMtdUhh5dLo+8J6XDQrkFbgWnHgGVI8Qh0lqhVyZhUhIE2KDoFKzp9Te/V
         00SB/F9IO80kPR00/dI6pWe1by5Ffl8v3/99P6KUDshmetNxVH7ySsMxi54MnhiBBg
         J7VFwSyYhVFmpFIYdUMS/pfI4kvoZbrKa8DZGxM0=
Date:   Fri, 22 Nov 2019 14:55:25 +0000
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, iommu@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Robin Murphy <robin.murphy@arm.com>, ard.biesheuvel@linaro.org
Subject: Re: [PATCH] of: property: Add device link support for "iommu-map"
Message-ID: <20191122145525.GA14153@willie-the-truck>
References: <20191120190028.4722-1-will@kernel.org>
 <CAL_JsqJm+6Cg4JfG1EzRMJ2hyPV1O8WbitjGC=XMvZRDD+=OGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJm+6Cg4JfG1EzRMJ2hyPV1O8WbitjGC=XMvZRDD+=OGw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Ard]

Hi Rob,

On Fri, Nov 22, 2019 at 08:47:46AM -0600, Rob Herring wrote:
> On Wed, Nov 20, 2019 at 1:00 PM Will Deacon <will@kernel.org> wrote:
> >
> > Commit 8e12257dead7 ("of: property: Add device link support for iommus,
> > mboxes and io-channels") added device link support for IOMMU linkages
> > described using the "iommus" property. For PCI devices, this property
> > is not present and instead the "iommu-map" property is used on the host
> > bridge node to map the endpoint RequesterIDs to their corresponding
> > IOMMU instance.
> >
> > Add support for "iommu-map" to the device link supplier bindings so that
> > probing of PCI devices can be deferred until after the IOMMU is
> > available.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Saravana Kannan <saravanak@google.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >
> > Applies against driver-core/driver-core-next.
> > Tested on AMD Seattle (arm64).
> 
> Guess that answers my question whether anyone uses Seattle with DT.
> Seattle uses the old SMMU binding, and there's not even an IOMMU
> associated with the PCI host. I raise this mainly because the dts
> files for Seattle either need some love or perhaps should be removed.

I'm using the new DT bindings on my Seattle, thanks to the firmware fairy
(Ard) visiting my flat with a dediprog. The patches I've posted to enable
modular builds of the arm-smmu driver require that the old binding is
disabled [1].

> No issues with the patch itself though. I'll queue it after rc1.

Thanks, although I think Greg has already queued it [2] due to the
dependencies on other patches in his tree.

Will

[1] https://lore.kernel.org/lkml/20191121114918.2293-14-will@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=driver-core-next&id=e149573b2f84d0517648dafc0db625afa681ed54
