Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B1DC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9603423426
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfH3Rpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 13:45:43 -0400
Received: from foss.arm.com ([217.140.110.172]:35696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbfH3Rpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 13:45:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 170BF337;
        Fri, 30 Aug 2019 10:45:42 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 719A83F718;
        Fri, 30 Aug 2019 10:45:37 -0700 (PDT)
Subject: Re: [PATCH 6/7] arm64: tegra: Add DT node for T194 SMMU
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     Sachin Nikam <Snikam@nvidia.com>,
        "Thomas Zeng (SW-TEGRA)" <thomasz@nvidia.com>,
        Juha Tukkinen <jtukkinen@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Pritesh Raithatha <praithatha@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Timo Alho <talho@nvidia.com>, Yu-Huan Hsu <YHsu@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Alexander Van Brunt <avanbrunt@nvidia.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>
References: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
 <1567118827-26358-7-git-send-email-vdumpa@nvidia.com>
 <b834ceb2-b296-0a52-c913-5a8923466cf2@arm.com>
 <BYAPR12MB2710BDF98FA472A77D106814B3BD0@BYAPR12MB2710.namprd12.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <da30773d-5831-7cc6-4d82-b304d9b8a29b@arm.com>
Date:   Fri, 30 Aug 2019 18:45:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB2710BDF98FA472A77D106814B3BD0@BYAPR12MB2710.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2019 18:25, Krishna Reddy wrote:
>>> +		#global-interrupts = <1>;
> 
>> Shouldn't that be 3?
> 
> Interrupt line is shared between global and all context faults for each SMMU instance.
> Nvidia implementation checks for both Global and context faults on each interrupt to an SMMU instance.
> It can be either 1 or 3.  If we make it 3, we need to add two more irq entries in node for context faults.

The number of global interrupts has never been related to the number of 
context interrupts :/

> In the future, we can update arm-smmu.c to support shared interrupt line between global and all context faults.

Clearly you have one combined interrupt output per SMMU - describing 
those as one global interrupt and the first two context bank interrupts 
respectively makes far less sense than calling them 3 global interrupts, 
not least because the latter is strictly true. Yes, the binding prevents 
us from describing the context bank interrupts for more than one 
instance, but at that point the fact that it *is* the combined output 
saves us - because the driver is aware of this specific integration it 
knows it can just register the "secondary" global interrupts as 
"secondary" context interrupts too. If we had separate IRQ lines per 
context bank per instance, then we'd have a really big problem and might 
have to redefine the binding, but as it is it happens to work out pretty 
neatly.

Robin.
