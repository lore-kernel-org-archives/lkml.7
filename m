Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D904C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A272339F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388402AbfHVUQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:16:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730203AbfHVUQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:16:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA897307D915;
        Thu, 22 Aug 2019 20:16:23 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 89EE05DC1E;
        Thu, 22 Aug 2019 20:16:22 +0000 (UTC)
Date:   Thu, 22 Aug 2019 15:16:20 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry.kdev@gmail.com, raph.gault+kdev@gmail.com
Subject: Re: [RFC v4 13/18] arm64: sleep: Prevent stack frame warnings from
 objtool
Message-ID: <20190822201620.z7eto2cfjo4uaozb@treble>
References: <20190816122403.14994-1-raphael.gault@arm.com>
 <20190816122403.14994-14-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190816122403.14994-14-raphael.gault@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 22 Aug 2019 20:16:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 01:23:58PM +0100, Raphael Gault wrote:
> This code doesn't respect the Arm PCS but it is intended this
> way. Adapting it to respect the PCS would result in altering the
> behaviour.
> 
> In order to suppress objtool's warnings, we setup a stack frame
> for __cpu_suspend_enter and annotate cpu_resume and _cpu_resume
> as having non-standard stack frames.
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> ---
>  arch/arm64/kernel/sleep.S | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
> index f5b04dd8a710..55c7c099d32c 100644
> --- a/arch/arm64/kernel/sleep.S
> +++ b/arch/arm64/kernel/sleep.S
> @@ -1,5 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #include <linux/errno.h>
> +#include <linux/frame.h>
>  #include <linux/linkage.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/assembler.h>
> @@ -90,6 +91,7 @@ ENTRY(__cpu_suspend_enter)
>  	str	x0, [x1]
>  	add	x0, x0, #SLEEP_STACK_DATA_SYSTEM_REGS
>  	stp	x29, lr, [sp, #-16]!
> +	mov	x29, sp
>  	bl	cpu_do_suspend
>  	ldp	x29, lr, [sp], #16
>  	mov	x0, #1
> @@ -146,3 +148,6 @@ ENTRY(_cpu_resume)
>  	mov	x0, #0
>  	ret
>  ENDPROC(_cpu_resume)
> +
> +	asm_stack_frame_non_standard cpu_resume
> +	asm_stack_frame_non_standard _cpu_resume

We usually put these annotations immediately after the functions they're
annotating.  And they should resemble the C macros like

  STACK_FRAME_NON_STANDARD(cpu_resume)

-- 
Josh
