Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1E9C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B283C2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfLRAxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:53:19 -0500
Received: from muru.com ([72.249.23.125]:49090 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfLRAxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:53:19 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D0B1A807E;
        Wed, 18 Dec 2019 00:53:58 +0000 (UTC)
Date:   Tue, 17 Dec 2019 16:53:16 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ARM: OMAP2+: Introduce check for OP-TEE in
 omap_secure_init()
Message-ID: <20191218005316.GG35479@atomide.com>
References: <20191217234745.4434-1-afd@ti.com>
 <20191217234745.4434-3-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217234745.4434-3-afd@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew F. Davis <afd@ti.com> [191217 23:48]:
> --- a/arch/arm/mach-omap2/omap-secure.c
> +++ b/arch/arm/mach-omap2/omap-secure.c
> @@ -20,6 +21,18 @@
>  
>  static phys_addr_t omap_secure_memblock_base;
>  
> +bool optee_available;

The above can be static bool optee_available?

> --- a/arch/arm/mach-omap2/omap-secure.h
> +++ b/arch/arm/mach-omap2/omap-secure.h
> @@ -10,6 +10,8 @@
>  #ifndef OMAP_ARCH_OMAP_SECURE_H
>  #define OMAP_ARCH_OMAP_SECURE_H
>  
> +#include <linux/types.h>
> +
>  /* Monitor error code */
>  #define  API_HAL_RET_VALUE_NS2S_CONVERSION_ERROR	0xFFFFFFFE
>  #define  API_HAL_RET_VALUE_SERVICE_UNKNWON		0xFFFFFFFF
> @@ -72,6 +74,7 @@ extern u32 rx51_secure_dispatcher(u32 idx, u32 process, u32 flag, u32 nargs,
>  extern u32 rx51_secure_update_aux_cr(u32 set_bits, u32 clear_bits);
>  extern u32 rx51_secure_rng_call(u32 ptr, u32 count, u32 flag);
>  
> +extern bool optee_available;
>  void omap_secure_init(void);

And then this change should not be needed, right?

Otherwise series looks OK to me, thanks for updating it.

Regards,

Tony
