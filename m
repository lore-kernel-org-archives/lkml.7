Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8C9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C676320700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E4i6LOiB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AYTlB8f2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfC1GrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:47:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59582 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfC1GrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:47:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4580C60736; Thu, 28 Mar 2019 06:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553755634;
        bh=ha8ZbQs3/XQetsGJVbDBdtRJLQi3TTyHL0HuOiiDjuE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=E4i6LOiB5YfB+lmGZxTcLJZ3Vs0Jz7XfAo9MNrlfItjEF8OkhLC+7oR5ppMFHcdo8
         vW2VTYmmxOIH31bOVIuiVkhYPh5rmuBuZKJM6dpnu2UjE/CfqU1Bxpqs9DDHRZGXKJ
         Ox6MuElZx59p2GuX93fWaxWOZMERiRHqpsztHO3Q=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 42CE560237;
        Thu, 28 Mar 2019 06:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553755633;
        bh=ha8ZbQs3/XQetsGJVbDBdtRJLQi3TTyHL0HuOiiDjuE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AYTlB8f2INhLUnnOeYm/5Sfdu8zKrrxEYvNbjxrVoNzfOseeHTT6Ljuu9KR/2xzi4
         vC/umDDeAJCLuVdpFMQbQzTeTh4+137uU8zJDIdFxro+g0DifeQ0hZbAg8ibaVjEQS
         w4yFFCtbk60dfu5c4CnYfN7W02HHjIITO2eOkiRk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 42CE560237
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] arm:mm/mmu.c : Remove duplicate header
To:     jagdsh.linux@gmail.com, linux@armlinux.org.uk,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        paul.burton@mips.com, anders.roxell@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1553340864-29200-1-git-send-email-jagdsh.linux@gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <a714d1fe-8c91-7e96-40d8-58ff57a05493@codeaurora.org>
Date:   Thu, 28 Mar 2019 12:17:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553340864-29200-1-git-send-email-jagdsh.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/23/2019 5:04 PM, jagdsh.linux@gmail.com wrote:
> From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
>
> Remove duplicate headers which are included twice.
>
> Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh
> ---
>   arch/arm/mm/mmu.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index f3ce341..a7863a5 100644
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
> @@ -36,7 +35,6 @@
>   #include <asm/mach/arch.h>
>   #include <asm/mach/map.h>
>   #include <asm/mach/pci.h>
> -#include <asm/fixmap.h>
>   
>   #include "fault.h"
>   #include "mm.h"
