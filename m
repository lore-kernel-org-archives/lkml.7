Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC954C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953522084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570201155;
	bh=qygk6kuolBy5BE+vN0iXiRBRAGyd2GOtM73uWd/QIVo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bK55ILh5EdLKsXLdskxkrSwRBHrD1lrb4UBN0bB7AA8hwPI9RQF+PPLIHoB5QlXqq
	 zfZ3vqbUUNxVk1XzcaurDw3ksf9HQl/b1eSI/R6TdNeAx0qjhdLFXRjOrMl08oyWAm
	 ZfoHDwQ+vxexhDITYPiNzMbmc9KNwiR5hHxaOASo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389545AbfJDO7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389131AbfJDO7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:59:14 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D9DD222C2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2019 14:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570201153;
        bh=qygk6kuolBy5BE+vN0iXiRBRAGyd2GOtM73uWd/QIVo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DFpBrok+h7gMPfvyWty9YFwtn8fH5NTETRQm2W4h+BRXGah0gjMkQDB3n1qaNZDqx
         6iHyg/6Rx+49eWX8VBlUPrq86xlgX9F4Ha2Q7eAM5ODiEC3CU8N5jbkAfz2RIYlKoY
         7v4HZKARI3/Tmyzcyn8AMZ3/pFW5qPrRomXCudr4=
Received: by mail-wr1-f43.google.com with SMTP id o18so7568334wrv.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 07:59:13 -0700 (PDT)
X-Gm-Message-State: APjAAAWwgVPWqpJWHDtnXVsNk/4VxrFKRt89olbkEETgpOkxUw65M4d/
        3mXEkIYe3aKTF3HQdOT4iR3ibRqUPAtdtZlZTm1Y0Q==
X-Google-Smtp-Source: APXvYqyR1oyfXpThmTQM82K3hhMMmFj8lDVsQsVum01xJbSYIYJ0nmdc3wjAb8UpQVAiZpTXcLpZZIqWo975x1RVkM4=
X-Received: by 2002:adf:cc0a:: with SMTP id x10mr8206649wrh.195.1570201151831;
 Fri, 04 Oct 2019 07:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191004134501.30651-1-changbin.du@gmail.com>
In-Reply-To: <20191004134501.30651-1-changbin.du@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 4 Oct 2019 07:59:00 -0700
X-Gmail-Original-Message-ID: <CALCETrWEhNCWDz7OVpbYJceJ5eShsWWhuyuAQQSzAdKncUo7zA@mail.gmail.com>
Message-ID: <CALCETrWEhNCWDz7OVpbYJceJ5eShsWWhuyuAQQSzAdKncUo7zA@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: determine whether the fault address is canonical
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 6:45 AM Changbin Du <changbin.du@gmail.com> wrote:
>
> We know the answer, so don't ask the user.
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  arch/x86/mm/extable.c     |  5 ++++-
>  arch/x86/mm/mm_internal.h | 11 +++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
> index 4d75bc656f97..5196e586756f 100644
> --- a/arch/x86/mm/extable.c
> +++ b/arch/x86/mm/extable.c
> @@ -8,6 +8,8 @@
>  #include <asm/traps.h>
>  #include <asm/kdebug.h>
>
> +#include "mm_internal.h"
> +
>  typedef bool (*ex_handler_t)(const struct exception_table_entry *,
>                             struct pt_regs *, int, unsigned long,
>                             unsigned long);
> @@ -123,7 +125,8 @@ __visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
>                                   unsigned long error_code,
>                                   unsigned long fault_addr)
>  {
> -       WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
> +       WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault at %s address in user access.",
> +                 is_canonical_addr(fault_addr) ? "canonical" : "non-canonical");

Unless the hardware behaves rather differently from the way I think it
does, fault_addr is garbage for anything other than #PF and sometimes
for #DF.  (And maybe the virtualization faults?)  I don't believe that
#GP fills in CR2.
