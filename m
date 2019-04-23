Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0378C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9476218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfDWUiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:38:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbfDWUiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:38:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 342CAC0703A7;
        Tue, 23 Apr 2019 20:38:04 +0000 (UTC)
Received: from treble (ovpn-123-99.rdu2.redhat.com [10.10.123.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6739D5C1B5;
        Tue, 23 Apr 2019 20:38:02 +0000 (UTC)
Date:   Tue, 23 Apr 2019 15:37:54 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry@arm.com
Subject: Re: [RFC 5/6] arm64: sleep: Add stack frame setup for
 __cpu_supsend_enter
Message-ID: <20190423203754.mdtjssru2h2rzqou@treble>
References: <20190409135243.12424-1-raphael.gault@arm.com>
 <20190409135243.12424-6-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190409135243.12424-6-raphael.gault@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 23 Apr 2019 20:38:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In $SUBJECT, s/supsend/suspend/.

On Tue, Apr 09, 2019 at 02:52:42PM +0100, Raphael Gault wrote:
> Annotate cpu_resume and _cpu_resume to silence objtool warning
> about non-standard stack frame.
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> ---
>  arch/arm64/kernel/sleep.S | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
> index 3e53ffa07994..eb434525fe82 100644
> --- a/arch/arm64/kernel/sleep.S
> +++ b/arch/arm64/kernel/sleep.S
> @@ -90,6 +90,7 @@ ENTRY(__cpu_suspend_enter)
>  	str	x0, [x1]
>  	add	x0, x0, #SLEEP_STACK_DATA_SYSTEM_REGS
>  	stp	x29, lr, [sp, #-16]!
> +	mov	x29, sp

Why is it changing the actual code?  The patch description indicates
that it's only adding annotations.

>  	bl	cpu_do_suspend
>  	ldp	x29, lr, [sp], #16
>  	mov	x0, #1
> @@ -146,3 +147,6 @@ ENTRY(_cpu_resume)
>  	mov	x0, #0
>  	ret
>  ENDPROC(_cpu_resume)
> +
> +	asm_stack_frame_non_standard cpu_resume
> +	asm_stack_frame_non_standard _cpu_resume
> -- 
> 2.17.1
> 

-- 
Josh
