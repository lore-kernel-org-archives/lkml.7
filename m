Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53D2C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 18:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CB3213F2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 18:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NcwhLPxh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F6oo4CC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfDFSoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 14:44:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51518 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfDFSoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 14:44:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4F14460CF0; Sat,  6 Apr 2019 18:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554576285;
        bh=J1go3pWxpT9gF/WJht0j3+DDCFCuSZHVJPHd7mds+tk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NcwhLPxhnG6oOTHQXEh10d+UhN0rL4l6V4dfouUWYHYsfUTOxiAHZ4CW/2gf9d5b5
         fjTB7faY54THkJWdrG2fsgvkuFeOhtgbSPz1iDjkHxRkq5Xu1WYJg+lB52pvnTTVJr
         F15q/aljGiC313m3HyWcff9ZsYfAA6hdGQS/QSPI=
Received: from [10.79.167.84] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 20ED060A42;
        Sat,  6 Apr 2019 18:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554576284;
        bh=J1go3pWxpT9gF/WJht0j3+DDCFCuSZHVJPHd7mds+tk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=F6oo4CC058WnIIK8qPqi4mOrE/K4O3EwhVp0fSl2HZo434ENw+NXa1GK/tDrrxIDq
         2BQTQcPiw8+/2nEEE7ABYfyV25YwQAzwrmRW5a7YueBiJ0BlXKkbxuZmT+V8KTdRyz
         VPvY35Q/Ne4TnlnkDB3ZoafC8repn+YPF6vArgQs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20ED060A42
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2] arm: mm: Remove duplicate header
To:     Souptick Joarder <jrdr.linux@gmail.com>, linux@armlinux.org.uk,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        anders.roxell@linaro.org, mhocko@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1554556406-9290-1-git-send-email-jrdr.linux@gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <75a808a0-bc16-b412-affb-c92d9c08b920@codeaurora.org>
Date:   Sun, 7 Apr 2019 00:14:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554556406-9290-1-git-send-email-jrdr.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/2019 6:43 PM, Souptick Joarder wrote:
> Remove duplicate header which is included twice.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
> v2: Added Acked-by tag.
>
>   arch/arm/mm/mmu.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> index f3ce341..a64a3c5 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -23,7 +23,6 @@
>   #include <asm/sections.h>
>   #include <asm/cachetype.h>
>   #include <asm/fixmap.h>
> -#include <asm/sections.h>
>   #include <asm/setup.h>
>   #include <asm/smp_plat.h>
>   #include <asm/tlb.h>
