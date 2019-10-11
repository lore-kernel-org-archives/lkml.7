Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6283FC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443D52089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfJKJQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 05:16:45 -0400
Received: from foss.arm.com ([217.140.110.172]:54162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbfJKJQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:16:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2597A337;
        Fri, 11 Oct 2019 02:16:44 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6239F3F703;
        Fri, 11 Oct 2019 02:16:42 -0700 (PDT)
Subject: Re: [PATCH 0/2] iommu/arm-smmu: Add an optional "input-address-size"
 property
To:     Nicolin Chen <nicoleotsuka@gmail.com>, joro@8bytes.org,
        robh+dt@kernel.org, mark.rutland@arm.com, will@kernel.org
Cc:     vdumpa@nvidia.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20191011034609.13319-1-nicoleotsuka@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e99e07c2-88c6-e4d8-af80-c46d36bc6cd0@arm.com>
Date:   Fri, 11 Oct 2019 10:16:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191011034609.13319-1-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-11 4:46 am, Nicolin Chen wrote:
> This series of patches add an optional DT property to allow an SoC to
> specify how many bits being physically connected to its SMMU instance,
> depending on the SoC design.

This has come up before, and it doesn't work in general because a single 
SMMU instance can have many master interfaces, with potentially 
different sizes of address bus wired up to each. It's also a 
conceptually-wrong approach anyway, since this isn't a property of the 
SMMU; it's a property of the interconnect(s) upstream of the SMMU.

IIRC you were working on Tegra - if so, Thierry already has a plan, see 
this thread: 
https://lore.kernel.org/linux-arm-kernel/20190930133510.GA1904140@ulmo/

Robin.

> 
> Nicolin Chen (2):
>    dt-bindings: arm-smmu: Add an optional "input-address-size" property
>    iommu/arm-smmu: Read optional "input-address-size" property
> 
>   Documentation/devicetree/bindings/iommu/arm,smmu.txt |  7 +++++++
>   drivers/iommu/arm-smmu.c                             | 10 ++++++++--
>   2 files changed, 15 insertions(+), 2 deletions(-)
> 
