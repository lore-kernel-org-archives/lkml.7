Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EF0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8EC42064A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfDDPAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:00:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33732 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbfDDPAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:00:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 809B9169E;
        Thu,  4 Apr 2019 08:00:16 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F8753F59C;
        Thu,  4 Apr 2019 08:00:14 -0700 (PDT)
Date:   Thu, 4 Apr 2019 16:00:05 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>, evgreen@chromium.org,
        tfiga@chromium.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] iommu/arm-smmu: Break insecure users by disabling
 bypass by default
Message-ID: <20190404145957.GA25912@fuggles.cambridge.arm.com>
References: <20190301192017.39770-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301192017.39770-1-dianders@chromium.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 11:20:17AM -0800, Douglas Anderson wrote:
> If you're bisecting why your peripherals stopped working, it's
> probably this CL.  Specifically if you see this in your dmesg:
>   Unexpected global fault, this could be serious
> ...then it's almost certainly this CL.
> 
> Running your IOMMU-enabled peripherals with the IOMMU in bypass mode
> is insecure and effectively disables the protection they provide.
> There are few reasons to allow unmatched stream bypass, and even fewer
> good ones.
> 
> This patch starts the transition over to make it much harder to run
> your system insecurely.  Expected steps:
> 
> 1. By default disable bypass (so anyone insecure will notice) but make
>    it easy for someone to re-enable bypass with just a KConfig change.
>    That's this patch.
> 
> 2. After people have had a little time to come to grips with the fact
>    that they need to set their IOMMUs properly and have had time to
>    dig into how to do this, the KConfig will be eliminated and bypass
>    will simply be disabled.  Folks who are truly upset and still
>    haven't fixed their system can either figure out how to add
>    'arm-smmu.disable_bypass=n' to their command line or revert the
>    patch in their own private kernel.  Of course these folks will be
>    less secure.
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v2:
> - Flipped default to 'yes' and changed comments a lot.
> 
>  drivers/iommu/Kconfig    | 25 +++++++++++++++++++++++++
>  drivers/iommu/arm-smmu.c |  3 ++-
>  2 files changed, 27 insertions(+), 1 deletion(-)

Cheers, I'll pick this one up for 5.2.

Will
