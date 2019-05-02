Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26819C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19E22085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556801812;
	bh=yj300TW+fJqT6K6BSGF2jtEG/Xt4a4FDcEA/4LmZcjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z3oSTyDSMhhEsGhgjYSd3eY7K7dhQSnNXoSc+4r43On+dLKi4TEG90FBLaUaJwNmE
	 dSz6M1ilFOehlTwuzfUZ6SRCBmsYdhfNzCAN9gzqlqe4qj6XzVTTvK/HNMJAMElj/W
	 bbYMl+NHq0dHpYmnoc5nwcgNc8Ghwrnw1vpsMHy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfEBM4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 08:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfEBM4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:56:50 -0400
Received: from localhost (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39FB420449;
        Thu,  2 May 2019 12:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556801809;
        bh=yj300TW+fJqT6K6BSGF2jtEG/Xt4a4FDcEA/4LmZcjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N1CNu64DdNDI6n6Pd4zvz/PjlpDiFGriUxmGgT0/aEEIlVYPNO5MpTGqG7iTelmKQ
         JozEqiBnuNmR0hNLn0yOAQTnPD5zKtk6yBqYPUuJl8FJoyUq8mFmzKss3kpaJ/vgJM
         2NV/TrbxUU0gmrBBPMtprJNCOepEvFx6dTFGe1Ek=
Date:   Thu, 2 May 2019 08:50:01 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        yuzenghui@huawei.com, christoffer.dall@arm.com,
        marc.zyngier@arm.com, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH AUTOSEL 5.0 29/98] KVM: arm/arm64: Enforce PTE mappings
 at stage2 when needed
Message-ID: <20190502125001.GB11584@sasha-vm>
References: <20190422194205.10404-1-sashal@kernel.org>
 <20190422194205.10404-29-sashal@kernel.org>
 <e166bc0d-5184-6dda-15ef-2f24d2e42203@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e166bc0d-5184-6dda-15ef-2f24d2e42203@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 10:27:26AM +0100, Suzuki K Poulose wrote:
>Hi Sasha,
>
>On 04/22/2019 08:40 PM, Sasha Levin wrote:
>>From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>>[ Upstream commit a80868f398554842b14d07060012c06efb57c456 ]
>>
>>commit 6794ad5443a2118 ("KVM: arm/arm64: Fix unintended stage 2 PMD mappings")
>>made the checks to skip huge mappings, stricter. However it introduced
>>a bug where we still use huge mappings, ignoring the flag to
>>use PTE mappings, by not reseting the vma_pagesize to PAGE_SIZE.
>>
>>Also, the checks do not cover the PUD huge pages, that was
>>under review during the same period. This patch fixes both
>>the issues.
>>
>>Fixes : 6794ad5443a2118 ("KVM: arm/arm64: Fix unintended stage 2 PMD mappings")
>>Reported-by: Zenghui Yu <yuzenghui@huawei.com>
>>Cc: Zenghui Yu <yuzenghui@huawei.com>
>>Cc: Christoffer Dall <christoffer.dall@arm.com>
>>Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
>
>Please be aware that we need a follow up fix for this patch to fix the
>problem for THP backed memory.
>
>http://lists.infradead.org/pipermail/linux-arm-kernel/2019-April/645324.html
>
>
>It should appear upstream soon.

Since it's not upstream yet, I'll drop this patch for now and queue it
for a later release.

--
Thanks,
Sasha
