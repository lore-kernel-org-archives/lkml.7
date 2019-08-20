Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9070DC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C00A22DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566302937;
	bh=ADbik8CK8iQ7jdhrR0Rax0t1bMR+xklkh8X3NNS9eXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tfDKBTlV2uWTbQNWIu2jTXtcbSVl1a7qFT1b/zqB34xidXpUFo5aOS41NvAh2jgUv
	 yY/Gipajjwuiq1fmsI2LJ9rrnl2K02ulTEUCdV4BwDcbbgfkuHq+izu2fChfR86aFx
	 3BJXbI/vdsMULbJh/6aYLC1joLCAGsdFVeb1fqp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbfHTMI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:08:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbfHTMI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:08:56 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FAE32082F;
        Tue, 20 Aug 2019 12:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566302935;
        bh=ADbik8CK8iQ7jdhrR0Rax0t1bMR+xklkh8X3NNS9eXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f+T4sZhl38XkG0uVXUKABIvfkkblopckcHuZwjY1K13rm3d1n0Ouxe26jVTbPkj7v
         mYLztxQe2zMdn5Ggs4BhJF1IFaIHV/UDnmdGHmC4Xs3wIx7Jg7GvX3t8lfV1ZvD/1E
         yVbNjI5zzdB+0bxIdWot/nWuC696XIdLWpFzCk1Y=
Date:   Tue, 20 Aug 2019 13:08:49 +0100
From:   Will Deacon <will@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Hanna Hawa <hannah@marvell.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 1/4] iommu/arm-smmu: Introduce wrapper for writeq/readq
Message-ID: <20190820120848.2m6gytilrpil4stu@willie-the-truck>
References: <20190711150242.25290-1-gregory.clement@bootlin.com>
 <20190711150242.25290-2-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711150242.25290-2-gregory.clement@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gregory, Hanna,

On Thu, Jul 11, 2019 at 05:02:39PM +0200, Gregory CLEMENT wrote:
> From: Hanna Hawa <hannah@marvell.com>
> 
> This patch introduces the smmu_writeq_relaxed/smmu_readq_relaxed
> helpers, as preparation to add specific Marvell work-around for
> accessing 64 bits width registers of ARM SMMU.
> 
> Signed-off-by: Hanna Hawa <hannah@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  drivers/iommu/arm-smmu.c | 36 +++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)

Sorry for the delay in replying to this -- Robin's been reworking the driver
so that implementation quirks can be specified more cleanly. Please can you
take a look at:

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/refactoring

and try to respin your patches on top of that?

Thanks,

Will
