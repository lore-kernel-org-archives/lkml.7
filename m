Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95F7C32753
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C043E20842
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565716246;
	bh=3HAujAOVhRvVLw9Wr49q0ihG1ZR2YhR/IpIuwrI01jM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AiGoCiWH5oK3o051FCajq/CudJe1ojKN2AXfmnpvbnbJIHI/QP2sGPTgDamE8K/1I
	 cI7KvZLRE1fsAb08FZifXiDXjEVPCpt8pdooOGFE55BWCxjxrJlzU4cHW3llI9b+Z+
	 hWokKec1s+MLC4ui3bZlAwR7HUWxCvCUIxVIo+s4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfHMRKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 13:10:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfHMRKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 13:10:45 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCE5E20679;
        Tue, 13 Aug 2019 17:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565716244;
        bh=3HAujAOVhRvVLw9Wr49q0ihG1ZR2YhR/IpIuwrI01jM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VSoIwMBNPftQwtRHK78noD6VrYTtEw2/zdtVMnZa+W21+JNwBjt4M/+CUmJoAKYgm
         vxnL6pOXtRJd3CWe1kfjMMNi8OVv8A4+2H2XXoExvno/NOG8KwCkt3EU/SRc/RJnOy
         8Wu9Xp1qau4NNWdG7KQeXOPxv1afsB4fLI53LFeo=
Date:   Tue, 13 Aug 2019 18:10:40 +0100
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        jean-philippe@linaro.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: add nr_ats_masters to avoid
 unnecessary operations
Message-ID: <20190813171039.y64wslo4dzgyis3e@willie-the-truck>
References: <20190801122040.26024-1-thunder.leizhen@huawei.com>
 <b5866f7a-013a-5900-6fce-268052f2ba0a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5866f7a-013a-5900-6fce-268052f2ba0a@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 11:42:17AM +0100, John Garry wrote:
> On 01/08/2019 13:20, Zhen Lei wrote:
> > When (smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS) is true, even if a
> > smmu domain does not contain any ats master, the operations of
> > arm_smmu_atc_inv_to_cmd() and lock protection in arm_smmu_atc_inv_domain()
> > are always executed. This will impact performance, especially in
> > multi-core and stress scenarios. For my FIO test scenario, about 8%
> > performance reduced.
> > 
> > In fact, we can use a atomic member to record how many ats masters the
> > smmu contains. And check that without traverse the list and check all
> > masters one by one in the lock protection.
> > 
> 
> Hi Will, Robin, Jean-Philippe,
> 
> Can you kindly check this issue? We have seen a signifigant performance
> regression here.

Sorry, John: Robin and Jean-Philippe are off at the moment and I've been
swamped dealing with the arm64 queue. I'll try to get to this tomorrow.

Will
