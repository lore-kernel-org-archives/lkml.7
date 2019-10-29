Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A410CA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C8F20874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572356204;
	bh=hqFAc7xsziLWsBPWZq0srOVOjk5w2lCAS39jmUgm6gA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aic8pLpD4pRd+xxAJbkqg6ISqUqu63e6QC6uo9g/Nl7cdlf5fBb+f9H7To931j4d1
	 Ek9qEk35LR5/8FYQf+GAm3SKI+aHnc4/VrUgm2Z8HSVs6Nb/jqfxU8y4o8XEjNjgT+
	 BcaQ2sUxKZuHaCFJjCUCCcS8hszzFzcVZ57slmWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388736AbfJ2Ngm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:36:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388602AbfJ2Ngl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:36:41 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B2EC2086A;
        Tue, 29 Oct 2019 13:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572356201;
        bh=hqFAc7xsziLWsBPWZq0srOVOjk5w2lCAS39jmUgm6gA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y9476nuo8bL5TAGLC1+v92LCKfTum9lzcCJ0X92LJuxjup0fFTLFO7wB0Bhntyo6J
         lJGsUV1gi36/3Xq8xAArCCWPjXmpbVXjjfro7Emn4fZWKX1aHQioTrmWa44hJUOJhu
         24Z4tAxVgNRAoyf+ND9k9NbTBj7XRuBb4VsRh5do=
Date:   Tue, 29 Oct 2019 13:36:36 +0000
From:   Will Deacon <will@kernel.org>
To:     Xiang Zheng <zhengxiang9@huawei.com>
Cc:     catalin.marinas@arm.com, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH v2] arm64: print additional fault message when executing
 non-exec memory
Message-ID: <20191029133635.GA12800@willie-the-truck>
References: <20191029124131.32028-1-zhengxiang9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029124131.32028-1-zhengxiang9@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 08:41:31PM +0800, Xiang Zheng wrote:
> When attempting to executing non-executable memory, the fault message
> shows:
> 
>   Unable to handle kernel read from unreadable memory at virtual address
>   ffff802dac469000
> 
> This may confuse someone, so add a new fault message for instruction
> abort.
> 
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> ---
>  arch/arm64/mm/fault.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 9fc6db0bcbad..9adec86d0f8a 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -318,6 +318,8 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
>  	if (is_el1_permission_fault(addr, esr, regs)) {
>  		if (esr & ESR_ELx_WNR)
>  			msg = "write to read-only memory";
> +		else if (is_el1_instruction_abort(esr))
> +			msg = "execute from non-executable memory";
>  		else
>  			msg = "read from unreadable memory";
>  	} else if (addr < PAGE_SIZE) {

Acked-by: Will Deacon <will@kernel.org>

Will
