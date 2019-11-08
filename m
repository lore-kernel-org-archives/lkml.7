Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DFEC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C501D21924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573210996;
	bh=J/Gsm5N/mj+ik5tmWzF15ve/593DRKXBLK4N9zKCikI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oa5w4zCicV2OgE2bdl6n+8aSVCzDrXbvqe57H8szaftSxT9fyYO+T37aO1iBbs0G1
	 FBNrRln2s41P0Z0lK5lSjG/yEUOgY+F57EHVVnQjUBxkjwPJKMQXM6LRHBY7bCzXIW
	 GmwQyp6PZlVToPA7OxGmaDLRWuodfx/2d7CEKC1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731752AbfKHLDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:03:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:39474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfKHLDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:03:15 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C72EF206BA;
        Fri,  8 Nov 2019 11:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573210994;
        bh=J/Gsm5N/mj+ik5tmWzF15ve/593DRKXBLK4N9zKCikI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GPUpB2qieVF3EyX+Obw28FlE6xo23nwE/xykonNN3EZtnaxcpvEFeX+8ufsaXb5th
         +ksXQteLE30PzN2sUWXuJdcrvuV/YqSRLbHtKk9h1qsPcUG586CeeZJJMYvyQclJah
         tyoRDGyrsSCcnNRNjplrIRLCVouz6GYQbwN+T1LQ=
Date:   Fri, 8 Nov 2019 11:03:10 +0000
From:   Will Deacon <will@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 5/7] iommu/arm-smmu-v3: Allow building as a module
Message-ID: <20191108110310.GC19153@willie-the-truck>
References: <20191030145112.19738-1-will@kernel.org>
 <20191030145112.19738-6-will@kernel.org>
 <20191030193148.GA8432@8bytes.org>
 <20191031154247.GB28061@willie-the-truck>
 <20191105121508.GA3479@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105121508.GA3479@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On Tue, Nov 05, 2019 at 01:15:08PM +0100, Joerg Roedel wrote:
> On Thu, Oct 31, 2019 at 03:42:47PM +0000, Will Deacon wrote:
> > Generally, I think unloading the IOMMU driver module while there are
> > active users is a pretty bad idea, much like unbinding the driver via
> > /sys in the same situation would also be fairly daft. However, I *think*
> > the code in __device_release_driver() tries to deal with this by
> > iterating over the active consumers and ->remove()ing them first.
> > 
> > I'm without hardware access at the moment, so I haven't been able to
> > test this myself. We could nobble the module_exit() hook, but there's
> > still the "force unload" option depending on the .config.
> 
> Okay, but besides the force-unload case, can we prevent accidential
> unloading by taking a reference to the module in add_device() and release
> it in remove_device()?

That's probably a sensible starting point, yes. In conjunction with the
patch from Jean-Philippe to introduce bus_unset_iommu(), we might have
a fighting chance of getting this to work.

I'll spin a v2.

Thanks!

Will
