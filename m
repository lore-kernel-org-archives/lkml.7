Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCA1C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730E120C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389075AbfB1PSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:18:37 -0500
Received: from foss.arm.com ([217.140.101.70]:49894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388372AbfB1PS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:18:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12A1BA78;
        Thu, 28 Feb 2019 07:18:26 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 258143F720;
        Thu, 28 Feb 2019 07:18:25 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:18:22 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        marc.zyngier@arm.com
Subject: Re: [PATCH AUTOSEL 4.19 47/64] arm64: ptdump: Don't iterate kernel
 page tables using PTRS_PER_PXX
Message-ID: <20190228151822.GB8571@fuggles.cambridge.arm.com>
References: <20190228151105.11277-1-sashal@kernel.org>
 <20190228151105.11277-47-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228151105.11277-47-sashal@kernel.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:10:48AM -0500, Sasha Levin wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> [ Upstream commit d23c808c6fc6132e812690648e14c0d6b0cbe273 ]
> 
> When 52-bit virtual addressing is enabled for userspace
> (CONFIG_ARM64_USER_VA_BITS_52=y), the kernel continues to utilise 48-bit
> virtual addressing in TTBR1. Consequently, PTRS_PER_PGD reflects the
> larger page table size for userspace and the pgd pointer for kernel page
> tables is offset before being written to TTBR1.
> 
> This means that we can't use PTRS_PER_PGD to iterate over kernel page
> tables unless we apply the same offset, which is fiddly to get right and
> leads to some non-idiomatic walking code. Instead, just follow the usual
> pattern when walking page tables by using a while loop driven by
> pXd_offset() and pXd_addr_end().
> 
> Reported-by: Qian Cai <cai@lca.pw>
> Tested-by: Qian Cai <cai@lca.pw>
> Acked-by: Steve Capper <steve.capper@arm.com>
> Tested-by: Steve Capper <steve.capper@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/arm64/mm/dump.c | 59 ++++++++++++++++++++++----------------------
>  1 file changed, 29 insertions(+), 30 deletions(-)

This isn't needed for any released kernels. In future, is there a tag I can
use to prevent a patch from being picked up by the AUTOSEL bot? That way you
can distinguish "I forgot to cc stable" from "I deliberately didn't cc
stable".

Will
