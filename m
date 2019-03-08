Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E35C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A9F20857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfCHSx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:53:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfCHSx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:53:29 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E69B3092664;
        Fri,  8 Mar 2019 18:53:29 +0000 (UTC)
Received: from treble (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74CD72635C;
        Fri,  8 Mar 2019 18:53:24 +0000 (UTC)
Date:   Fri, 8 Mar 2019 12:53:21 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 03/20] x86/uaccess: Move copy_user_handle_tail into asm
Message-ID: <20190308185321.jukfavqk6pl3ifev@treble>
References: <20190307114511.870090179@infradead.org>
 <20190307115159.349746915@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190307115159.349746915@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 08 Mar 2019 18:53:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 12:45:14PM +0100, Peter Zijlstra wrote:
>  /*
> + * Try to copy last bytes and clear the rest if needed.
> + * Since protection fault in copy_from/to_user is not a normal situation,
> + * it is not necessary to optimize tail handling.
> + *
> + * Input:
> + * rdi destination
> + * rsi source
> + * rdx count
> + *
> + * Output:
> + * eax uncopied bytes or 0 if successful.
> + */
> +ALIGN;
> +copy_user_handle_tail:
> +	movl %edx,%ecx
> +1:	rep movsb
> +2:	mov %ecx,%eax
> +	ASM_CLAC
> +	ret
> +
> +	_ASM_EXTABLE_UA(1b, 2b)
> +ENDPROC(copy_user_handle_tail)

This is an unstructured piece of code rather than a callable function,
END would probably be more appropriate.  Or maybe it should just be a
local label (.Lcopy_user_handle_tail) because I don't think the
alignment and ELF symbol size are even needed.

-- 
Josh
