Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6C2ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 00:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7542C21848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 00:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571100587;
	bh=CgE11hawVJ9EsRwk+NsDx1KZAHE6/9MksHlbAGE28k8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yd48AwQWyCJfrE/DWo/ODDmOzyEzkNk1pBHMwI0Tww/keazgxSbaPEJqpIsnUIkwl
	 tETXm9kDAWmk2BXC/oeH+2brAdJ85Sh5Bv5/tEtqnye48rgwRpEjcQv3SJzDjtKBS0
	 on8tBkAJU3rBw6eBXZdJzotYmhnNf7c7NCeoLlL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfJOAtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 20:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbfJOAtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 20:49:42 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DD572089C;
        Tue, 15 Oct 2019 00:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571100581;
        bh=CgE11hawVJ9EsRwk+NsDx1KZAHE6/9MksHlbAGE28k8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tsYGr7MgAutV7j+jrOeyibptBcDd1dF/Y656vQVg0tVCcG0ebxJZn9flLkyt2T7zS
         nT4VUAky3qihI4XTR/iN1Zauma1Bq85/KOQ4WSkwqD1FZJa5r5I6UwqV2E9dQjdbmV
         XG9iml9waMLUfmDaQCUb/3g5j36LxT4pMaC15U5Y=
Date:   Tue, 15 Oct 2019 01:49:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Poison initmem while freeing with
 free_reserved_area()
Message-ID: <20191015004937.3khj7obh3la5qwdu@willie-the-truck>
References: <1570163038-32067-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570163038-32067-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 09:53:58AM +0530, Anshuman Khandual wrote:
> Platform implementation for free_initmem() should poison the memory while
> freeing it up. Hence pass across POISON_FREE_INITMEM while calling into
> free_reserved_area(). The same is being followed in the generic fallback
> for free_initmem() and some other platforms overriding it.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 45c00a54909c..ea7d38011e83 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -571,7 +571,7 @@ void free_initmem(void)
>  {
>  	free_reserved_area(lm_alias(__init_begin),
>  			   lm_alias(__init_end),
> -			   0, "unused kernel");
> +			   POISON_FREE_INITMEM, "unused kernel");

Acked-by: Will Deacon <will@kernel.org>

Will
