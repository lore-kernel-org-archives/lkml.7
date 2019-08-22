Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7160CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456102082F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbfHVOaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:30:30 -0400
Received: from foss.arm.com ([217.140.110.172]:46912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732789AbfHVOa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:30:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F453337;
        Thu, 22 Aug 2019 07:30:29 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5672B3F706;
        Thu, 22 Aug 2019 07:30:26 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] iommu/arm-smmu: Introduce wrapper for writeq/readq
To:     Will Deacon <will@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?Q?Miqu=c3=a8l_Raynal?= <miquel.raynal@bootlin.com>,
        Hanna Hawa <hannah@marvell.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
References: <20190711150242.25290-1-gregory.clement@bootlin.com>
 <20190711150242.25290-2-gregory.clement@bootlin.com>
 <20190820120848.2m6gytilrpil4stu@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4ef6512d-701f-4fe8-8173-5f659dab0d32@arm.com>
Date:   Thu, 22 Aug 2019 15:30:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190820120848.2m6gytilrpil4stu@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2019 13:08, Will Deacon wrote:
> Hi Gregory, Hanna,
> 
> On Thu, Jul 11, 2019 at 05:02:39PM +0200, Gregory CLEMENT wrote:
>> From: Hanna Hawa <hannah@marvell.com>
>>
>> This patch introduces the smmu_writeq_relaxed/smmu_readq_relaxed
>> helpers, as preparation to add specific Marvell work-around for
>> accessing 64 bits width registers of ARM SMMU.
>>
>> Signed-off-by: Hanna Hawa <hannah@marvell.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>   drivers/iommu/arm-smmu.c | 36 +++++++++++++++++++++++++++---------
>>   1 file changed, 27 insertions(+), 9 deletions(-)
> 
> Sorry for the delay in replying to this -- Robin's been reworking the driver
> so that implementation quirks can be specified more cleanly. Please can you
> take a look at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/refactoring
> 
> and try to respin your patches on top of that?

Right, the arm_smmu_impl design was specifically anticipating this quirk 
as well - it should just be a case of a cfg_probe hook to hide the 
features which can't work, plus {read,write}_reg64 hooks to override any 
remaining 64-bit accesses with the explicit hi_lo_* variants, munged 
together (either statically or dynamically) with the standard MMU-500 hooks.

Robin.
