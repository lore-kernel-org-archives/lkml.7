Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE00C46478
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8307E218A4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfGDIUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:20:04 -0400
Received: from 8bytes.org ([81.169.241.247]:34084 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfGDIUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:20:04 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 49E032FB; Thu,  4 Jul 2019 10:20:03 +0200 (CEST)
Date:   Thu, 4 Jul 2019 10:20:01 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
        aarch64-laptops@lists.linaro.org,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Joe Perches <joe@perches.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu: add support for drivers that manage iommu
 explicitly
Message-ID: <20190704082001.GD6546@8bytes.org>
References: <20190702202631.32148-1-robdclark@gmail.com>
 <20190702202631.32148-2-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702202631.32148-2-robdclark@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Jul 02, 2019 at 01:26:18PM -0700, Rob Clark wrote:
> 1) In some cases the bootloader takes the iommu out of bypass and
>    enables the display.  This is in particular a problem on the aarch64
>    laptops that exist these days, and modern snapdragon android devices.
>    (Older devices also enabled the display in bootloader but did not
>    take the iommu out of bypass.)  Attaching a DMA or IDENTITY domain
>    while scanout is active, before the driver has a chance to intervene,
>    makes things go *boom*

Just to make sure I get this right: The bootloader inializes the SMMU
and creates non-identity mappings for the GPU? And when the SMMU driver
in Linux takes over this breaks display output.

> +	/*
> +	 * If driver is going to manage iommu directly, then avoid
> +	 * attaching any non driver managed domain.  There could
> +	 * be already active dma underway (ie. scanout in case of
> +	 * bootloader enabled display), and interfering with that
> +	 * will make things go *boom*
> +	 */
> +	if ((domain->type != IOMMU_DOMAIN_UNMANAGED) &&
> +	    dev->driver && dev->driver->driver_manages_iommu)
> +		return 0;
> +

When the default domain is attached, there is usually no driver attached
yet. I think this needs to be communicated by the firmware to Linux and
the code should check against that.

> -	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
> +	bool suppress_bind_attrs:1;	/* disables bind/unbind via sysfs */
> +	bool driver_manages_iommu:1;	/* driver manages IOMMU explicitly */

How does this field get set?



	Joerg
