Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794CBCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4C421479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="cs2hdJYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfJ2KNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 06:13:11 -0400
Received: from ozlabs.org ([203.11.71.1]:46905 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728641AbfJ2KNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 06:13:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 472S8M3QkSz9sP3;
        Tue, 29 Oct 2019 21:13:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1572343987;
        bh=uI8deBIoQAH9dUj+VilXBuXzEDBg9aiumzk3Bni0Y5s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cs2hdJYzsR8uXUBkRv/tii8mwkG/u3ntLr9XeIv/GVCulY5K0myfhD63CT1ARYAm3
         leqp1px0zmE8Z1tGttSZCGrJyVj7LG5pa14zT16FkVfXVKQL7SQdgNC+AS32l2M8C3
         W+e5YDcEY72Dss36tAHgvk5I9WnH8gSrUBbD4aC/KUmuTC52fWaXogDrOKaW2moXUj
         MYpc90/cBzm/B48Y79HGAhDoch3Ws3Z4CQebyUJAsgFOX2AhpOLmVQahjn/bbKTZUN
         2oZYGaqyA1ZhciSOcD91Fxp+gw5pD1EG4WprDTBTEz/0KfCDRwdH1ZzMF+efT7gZli
         BVWizJI5ZFyrQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Qian Cai <cai@lca.pw>
Cc:     peterz@infradead.org, paulmck@linux.ibm.com, npiggin@gmail.com,
        benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: Re: [PATCH] powerpc/powernv/smp: fix a warning at CPU hotplug
In-Reply-To: <1572295467-14686-1-git-send-email-cai@lca.pw>
References: <1572295467-14686-1-git-send-email-cai@lca.pw>
Date:   Tue, 29 Oct 2019 21:13:02 +1100
Message-ID: <875zk7hnbl.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai <cai@lca.pw> writes:
> The commit e78a7614f387 ("idle: Prevent late-arriving interrupts from
> disrupting offline") introduced a warning on powerpc with CPU hotplug,
>
> WARNING: CPU: 1 PID: 0 at arch/powerpc/platforms/powernv/smp.c:160
> pnv_smp_cpu_kill_self+0x5c/0x330
> Call Trace:
>  cpu_die+0x48/0x64
>  arch_cpu_idle_dead+0x30/0x50
>  do_idle+0x2e4/0x460
>  cpu_startup_entry+0x3c/0x40
>  start_secondary+0x7a8/0xa80
>  start_secondary_resume+0x10/0x14
>
> because it calls local_irq_disable() before arch_cpu_idle_dead().
>
> Fixes: e78a7614f387 ("idle: Prevent late-arriving interrupts from disrupting offline")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/powerpc/platforms/powernv/smp.c | 1 -
>  1 file changed, 1 deletion(-)

Thanks.

But Nick already sent a fix for this, I just need to review/test it and
get it merged, see:
  https://patchwork.ozlabs.org/patch/1181275/


cheers

> diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
> index fbd6e6b7bbf2..51f4e07b9168 100644
> --- a/arch/powerpc/platforms/powernv/smp.c
> +++ b/arch/powerpc/platforms/powernv/smp.c
> @@ -157,7 +157,6 @@ static void pnv_smp_cpu_kill_self(void)
>  	 * This hard disables local interurpts, ensuring we have no lazy
>  	 * irqs pending.
>  	 */
> -	WARN_ON(irqs_disabled());
>  	hard_irq_disable();
>  	WARN_ON(lazy_irq_pending());
>  
> -- 
> 1.8.3.1
