Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F7ACA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B3C2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="Pi2yVSa8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390089AbfJWH7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 03:59:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34872 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfJWH7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:59:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id v6so1629997wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 00:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3njbiGHSzil4qlxps6YC5vR5NByVfbJQ5yuqYlO5+xU=;
        b=Pi2yVSa8qbQdjXUCnVixFddJ0xwrTm1AXVQ6x46gXfOtHnY9K8IbFy6ZH9LsyRXwFp
         THlVYGswPC8EsmEwbd+3prKFlby/wk13dLCVe0jxTX40QAGLoL1+xkhW9EWf7THCFEbi
         tV7K9wWwoB44sA7oy9YtOEaqsl4oSRifSLfOg29VlbmAPNHkbKyfLd8dvEoKRA1IUILA
         VM65DUlCayCEGYCqSLq8rywdVtyGo6HVffgFlaPT4qELkmm+BUys6mNGxk6SDJa7G6tm
         cNQbRkwlBSP+H+UM56GpoXQv5Qp/hMUOY8nL6ZzGCro9/HlcqCiXID/XtjqCUPZ0XmXs
         dzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3njbiGHSzil4qlxps6YC5vR5NByVfbJQ5yuqYlO5+xU=;
        b=YNwhkIpFnIcK/2pZqAYRPtwpEOV0p6QGd/bg4SWIP1sKhOOplabdzJ5RNUIHhelneX
         2LWYERqFGDx6/PtT7dXJvb5G6rbZ7vT91Nq9VxlpFTQVOb0P/pLT224oQF4seTwHnKZA
         sCfmPjkVmU7ubPKFJ6E2Czptue7bFgsANkUJmBlYh+/ONoU/ghI3HSXKN75q1bGCq5pf
         1P8KckvxHgqGmOx+SXDgbD9E+E/yOBnXNteH2kowL3+LlBQzIEMk0o+cizRJNVmVZpX0
         mMh23R9D2Xj8SPHOidWqaMI+4xDXg5I9Tn09YEEoFdNn2HxTflBn42uV8P/YTCiPTb2K
         ia/Q==
X-Gm-Message-State: APjAAAVeA13d1ObPSH+Amadt+jViByQfChVFssu1PfhaH43X/a+thUqT
        fUZhxoX/kpyMs8D0iZ4DZ8vltqZYAs/KLQ==
X-Google-Smtp-Source: APXvYqz5IiOUijHK1boUMLGccRWZbbd8WQBmx80G/pFjnFHnn7bHvtJA43cytaMTJ+2x1fnlnu6PeQ==
X-Received: by 2002:a1c:a90f:: with SMTP id s15mr6472842wme.100.1571817588666;
        Wed, 23 Oct 2019 00:59:48 -0700 (PDT)
Received: from [66.102.1.108] ([149.199.62.130])
        by smtp.gmail.com with ESMTPSA id w22sm18150550wmc.16.2019.10.23.00.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 00:59:47 -0700 (PDT)
Subject: Re: [PATCH] arch: microblaze: support for reserved-memory entries in
 DT
To:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20191022081929.10602-1-alvaro.gamez@hazent.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <64db9f22-2e24-23f8-bf64-c4a972fa50c1@monstr.eu>
Date:   Wed, 23 Oct 2019 09:59:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191022081929.10602-1-alvaro.gamez@hazent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 22. 10. 19 10:19, Alvaro Gamez Machado wrote:
> Signed-off-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>

please put there reasonable description to commit message.

> ---
>  arch/microblaze/mm/init.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
> index a015a951c8b7..928c5c2816e4 100644
> --- a/arch/microblaze/mm/init.c
> +++ b/arch/microblaze/mm/init.c
> @@ -17,6 +17,8 @@
>  #include <linux/slab.h>
>  #include <linux/swap.h>
>  #include <linux/export.h>
> +#include <linux/of_fdt.h>
> +#include <linux/of.h>

of_fdt.h should be enough.

>  
>  #include <asm/page.h>
>  #include <asm/mmu_context.h>
> @@ -188,6 +190,9 @@ void __init setup_memory(void)
>  
>  void __init mem_init(void)
>  {
> +	early_init_fdt_reserve_self();
> +	early_init_fdt_scan_reserved_mem();
> +
>  	high_memory = (void *)__va(memory_start + lowmem_size - 1);
>  
>  	/* this will put all memory onto the freelists */
> 


Also I have looked at others arch and take a look at

1b10cb21d888c021bedbe678f7c26aee1bf04ffa
ARC: add support for reserved memory defined by device tree

where they also enable OF_RESERVED_MEM to call fdt_init_reserve_mem()

The same here
4e7c84ec045921dacc78d36295e2e61390249665
 xtensa: support reserved-memory DT node

and here
9bf14b7c540ae9ca7747af3a0c0d8470ef77b6ce
arm64: add support for reserved memory defined by device tree


Please note this in commit message.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

