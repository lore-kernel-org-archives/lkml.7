Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07942C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B322089F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574328701;
	bh=vIsuKzuMW4Q4rnEMzC2w6P27Z3ju+wMUZeIc5ypb09A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L0zj/o/pk/D/774wPA/41QEtiyLscXO05ze9vFlFQNwhlcJUN59t4aqD1tDGYi3kN
	 yBSPDcJpW6Q9f2jPXmD0OKSSMO54nomR5nvvVDhnrW+48T4Jq8/cIiOrvqkqh6xzPp
	 ccqu5odzmoO8fw5EWYdbI66jwZ2ZRdZRMpR5P22M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfKUJbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:31:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:39982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfKUJbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:31:40 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76E3020715;
        Thu, 21 Nov 2019 09:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574328699;
        bh=vIsuKzuMW4Q4rnEMzC2w6P27Z3ju+wMUZeIc5ypb09A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uiBKwL661F32mBEBUE5yu/lpelJD2VnpgtV2wuN+UxOtfBGp8fyVzgjOZnM47FVyr
         +QGjlvx4+cm4aegm6cjemyq84guFlNnjgDIRT+LHESS83yqJ81tUHuZezmtmwR4ghU
         4N0Z3fySZ/x9ZPnViQ+sFIjeLLHlmyGZtFgbH2og=
Date:   Thu, 21 Nov 2019 09:31:34 +0000
From:   Will Deacon <will@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>
Subject: Re: linux-next: manual merge of the arm64 tree with the amr64-fixes
 tree
Message-ID: <20191121093134.GA1091@willie-the-truck>
References: <20191121082446.28964cd4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121082446.28964cd4@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 08:24:46AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm64 tree got a conflict in:
> 
>   arch/arm64/include/asm/asm-uaccess.h
> 
> between commit:
> 
>   e50be648aaa3 ("arm64: uaccess: Remove uaccess_*_not_uao asm macros")
> 
> from the amr64-fixes tree and commit:
> 
>   582f95835a8f ("arm64: entry: convert el0_sync to C")
> 
> from the arm64 tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc arch/arm64/include/asm/asm-uaccess.h
> index c764cc8fb3b6,a70575edae8e..000000000000
> --- a/arch/arm64/include/asm/asm-uaccess.h
> +++ b/arch/arm64/include/asm/asm-uaccess.h
> @@@ -57,13 -57,21 +57,4 @@@ alternative_else_nop_endi
>   	.macro	uaccess_ttbr0_enable, tmp1, tmp2, tmp3
>   	.endm
>   #endif
> --
> --/*
> -  * Remove the address tag from a virtual address, if present.
>  - * These macros are no-ops when UAO is present.
> -- */
> - 	.macro	untagged_addr, dst, addr
> - 	sbfx	\dst, \addr, #0, #56
> - 	and	\dst, \dst, \addr
>  -	.macro	uaccess_disable_not_uao, tmp1, tmp2
>  -	uaccess_ttbr0_disable \tmp1, \tmp2
>  -alternative_if ARM64_ALT_PAN_NOT_UAO
>  -	SET_PSTATE_PAN(1)
>  -alternative_else_nop_endif
> --	.endm
> --
>  -	.macro	uaccess_enable_not_uao, tmp1, tmp2, tmp3
>  -	uaccess_ttbr0_enable \tmp1, \tmp2, \tmp3
>  -alternative_if ARM64_ALT_PAN_NOT_UAO
>  -	SET_PSTATE_PAN(0)
>  -alternative_else_nop_endif
>  -	.endm

Yup, that's fine. Delete both of the uaccess macros (good riddance!).

Cheers,

Will
