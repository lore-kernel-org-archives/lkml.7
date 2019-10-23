Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE46BCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA662086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571848045;
	bh=do5PkS+eCKNocSWak3vYJW2/3BSNU4s/TcZDTpcE/uE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1hjIji147UD2HCI/pvLvWXzNOVpuCZFQXI2MoiALxi1Ihir/x7VQHc3zDhGx8ha6H
	 RCqMT5N6QsdEMopeKQwLlHPmL80pl2b5fpri7yFBS4G7+O4W2x8oHPud8LHKenyDVt
	 2gC8w4GGNqdfQ0PiWlpJU5syW+4OzUWJNJUphpfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407279AbfJWQ1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389149AbfJWQ1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:27:24 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3C882084C;
        Wed, 23 Oct 2019 16:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571848043;
        bh=do5PkS+eCKNocSWak3vYJW2/3BSNU4s/TcZDTpcE/uE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1DPwNU5sp8U4oU2roN7ycpMthYFFZWGa9uGNfK5JqrAHZRUmADqgzKgjwm8KmNIV7
         M/hqEg5VoO1HYCLa8snLPXvTJxivHw1rMSuA5n+AJBZSwt6NNLwy1FGgkzEtmOMIxB
         BrT556CQ+lASBf9qVwuralKGxRkHukTJkktgejVQ=
Date:   Wed, 23 Oct 2019 17:27:17 +0100
From:   Will Deacon <will@kernel.org>
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Yu-Huan Hsu <YHsu@nvidia.com>,
        Sachin Nikam <Snikam@nvidia.com>,
        Pritesh Raithatha <praithatha@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        Alexander Van Brunt <avanbrunt@nvidia.com>,
        "thomasz@nvidia.com" <thomasz@nvidia.com>,
        "olof@lixom.net" <olof@lixom.net>,
        Juha Tukkinen <jtukkinen@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v3 0/7] Nvidia Arm SMMUv2 Implementation
Message-ID: <20191023162716.GA27010@willie-the-truck>
References: <1571441492-21919-1-git-send-email-vdumpa@nvidia.com>
 <6d9e6425-fa69-9b76-b477-1fe50c459ca5@arm.com>
 <BYAPR12MB2710879535971E290E8B25D3B3680@BYAPR12MB2710.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR12MB2710879535971E290E8B25D3B3680@BYAPR12MB2710.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 11:48:55PM +0000, Krishna Reddy wrote:
> >>Apologies for crossed wires, but I had a series getting rid of
> >>arm_smmu_flush_ops which was also meant to end up making things a bit
> >>easier for you:
> 
> I was looking to rebase on top of your changes first.  Then I read Will's
> reply that said your work is queued for 5.5.

D'oh, sorry, I completely forgot to push that branch out. Now done:

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/updates

Will
