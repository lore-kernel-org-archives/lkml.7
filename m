Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EC8C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1687C20828
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552324583;
	bh=XyRiSbakFGkwfOutv9gt2AJ+tOM59q+juMy/UfRF3kU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KLGJoFwp4n13F7iKJkqjdaCSRLEyNHTYKaRDZOfFQRaEnCDjGThqaobCmNWNtcvGA
	 J8wYNAHKoFzQCqA6OUdfcAK0PSy+tZX2kgvhI1UJhEKtzLvsRkPOEcryFBuEtvaoNN
	 iNt7ZAtNNo7JqDGzzc+CljpkmUICLT7vjB6Wd/Ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfCKRQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:16:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbfCKRQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:16:21 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F4BC205F4;
        Mon, 11 Mar 2019 17:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552324580;
        bh=XyRiSbakFGkwfOutv9gt2AJ+tOM59q+juMy/UfRF3kU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tqRDducpQ4e6nym3NkdKSMRpNLwWa5wcqtuiPKmLHxE4xJfvXL2f9WWnPtQ2/Qrmv
         WUio5cZk4a1zWCuTBBQaOhMBZMemPZ8IkdNL88sPR4JmbCpvlX8CwZ9iho2tkwEEvA
         vP7MwW0jiQ/ecb6+OmOJXKYeWljw8aZHLtaZbxEo=
Date:   Mon, 11 Mar 2019 13:16:19 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        marc.zyngier@arm.com
Subject: Re: [PATCH AUTOSEL 4.19 47/64] arm64: ptdump: Don't iterate kernel
 page tables using PTRS_PER_PXX
Message-ID: <20190311171619.GE158926@sasha-vm>
References: <20190228151105.11277-1-sashal@kernel.org>
 <20190228151105.11277-47-sashal@kernel.org>
 <20190228151822.GB8571@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190228151822.GB8571@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 03:18:22PM +0000, Will Deacon wrote:
>On Thu, Feb 28, 2019 at 10:10:48AM -0500, Sasha Levin wrote:
>> From: Will Deacon <will.deacon@arm.com>
>>
>> [ Upstream commit d23c808c6fc6132e812690648e14c0d6b0cbe273 ]
>>
>> When 52-bit virtual addressing is enabled for userspace
>> (CONFIG_ARM64_USER_VA_BITS_52=y), the kernel continues to utilise 48-bit
>> virtual addressing in TTBR1. Consequently, PTRS_PER_PGD reflects the
>> larger page table size for userspace and the pgd pointer for kernel page
>> tables is offset before being written to TTBR1.
>>
>> This means that we can't use PTRS_PER_PGD to iterate over kernel page
>> tables unless we apply the same offset, which is fiddly to get right and
>> leads to some non-idiomatic walking code. Instead, just follow the usual
>> pattern when walking page tables by using a while loop driven by
>> pXd_offset() and pXd_addr_end().
>>
>> Reported-by: Qian Cai <cai@lca.pw>
>> Tested-by: Qian Cai <cai@lca.pw>
>> Acked-by: Steve Capper <steve.capper@arm.com>
>> Tested-by: Steve Capper <steve.capper@arm.com>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  arch/arm64/mm/dump.c | 59 ++++++++++++++++++++++----------------------
>>  1 file changed, 29 insertions(+), 30 deletions(-)
>
>This isn't needed for any released kernels. In future, is there a tag I can
>use to prevent a patch from being picked up by the AUTOSEL bot? That way you
>can distinguish "I forgot to cc stable" from "I deliberately didn't cc
>stable".

I've dropped it, thanks!

Generally the bot will look into a Fixes: tag, and if the commit pointed
to it is not in the tree then the patch won't be picked up.

--
Thanks,
Sasha
