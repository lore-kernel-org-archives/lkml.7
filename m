Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1E1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 01:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A78C2168B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 01:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566784006;
	bh=908BLhrgzStt5JDtjKRzMzwSXV0hF3UqbD2KRQCs5ek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TuGlzlb4xmQ+4CcarBQCn4tG+c5U4mPo3wDq8VE3OPNTQQyLcUu0Zds9Hj8lNzySE
	 74mO0NXfT236vckVB8QVRxYRcQOzocEFVHV5NzaVxUOfRwZmhzr3AGwiMNIMPdcZVK
	 tw0QdQl42ljBcHNYpzS9irqUt15DmSKvXS3Kc1GU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfHZBqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 21:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbfHZBqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 21:46:44 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CE1E2070B;
        Mon, 26 Aug 2019 01:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566784003;
        bh=908BLhrgzStt5JDtjKRzMzwSXV0hF3UqbD2KRQCs5ek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xIyWsTaFBaHCVXBD8nVIEpvVc1vypGIzIlsL9pjv4GAgOUNgm4QlBkc2ky9JBHABE
         ChipW5u2tAxSdSekDn88oFnVTTCm2h8ldOUr5hpPgAqt28xezoQIGfh/kofHUN7gLy
         GY4fSQQa4cAzmB64Yzh9oZUU+bxscLVNP8X00HyY=
Date:   Mon, 26 Aug 2019 10:46:38 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] kallsyms: Don't let kallsyms_lookup_size_offset() fail
 on retrieving the first symbol
Message-Id: <20190826104638.9098e6fe940ffe19d24959a2@kernel.org>
In-Reply-To: <20190824131231.26399-1-maz@kernel.org>
References: <20190824131231.26399-1-maz@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Aug 2019 14:12:31 +0100
Marc Zyngier <maz@kernel.org> wrote:

> An arm64 kernel configured with
> 
>   CONFIG_KPROBES=y
>   CONFIG_KALLSYMS=y
>   # CONFIG_KALLSYMS_ALL is not set
>   CONFIG_KALLSYMS_BASE_RELATIVE=y
> 
> reports the following kprobe failure:
> 
>   [    0.032677] kprobes: failed to populate blacklist: -22
>   [    0.033376] Please take care of using kprobes.
> 
> It appears that kprobe fails to retrieve the symbol at address
> 0xffff000010081000, despite this symbol being in System.map:
> 
>   ffff000010081000 T __exception_text_start
> 
> This symbol is part of the first group of aliases in the
> kallsyms_offsets array (symbol names generated using ugly hacks in
> scripts/kallsyms.c):
> 
>   kallsyms_offsets:
>           .long   0x1000 // do_undefinstr
>           .long   0x1000 // efi_header_end
>           .long   0x1000 // _stext
>           .long   0x1000 // __exception_text_start
>           .long   0x12b0 // do_cp15instr
> 
> Looking at the implementation of get_symbol_pos(), it returns the
> lowest index for aliasing symbols. In this case, it return 0.
> 
> But kallsyms_lookup_size_offset() considers 0 as a failure, which
> is obviously wrong (there is definitely a valid symbol living there).
> In turn, the kprobe blacklisting stops abruptly, hence the original
> error.
> 
> A CONFIG_KALLSYMS_ALL kernel wouldn't fail as there is always
> some random symbols at the beginning of this array, which are never
> looked up via kallsyms_lookup_size_offset.
> 
> Fix it by considering that get_symbol_pos() is always successful
> (which is consistent with the other uses of this function).

Thank you for fixing this issue!
This looks good to me :)

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Fixes: ffc5089196446 ("[PATCH] Create kallsyms_lookup_size_offset()")
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  kernel/kallsyms.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 95a260f9214b..136ce049c4ad 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -263,8 +263,10 @@ int kallsyms_lookup_size_offset(unsigned long addr, unsigned long *symbolsize,
>  {
>  	char namebuf[KSYM_NAME_LEN];
>  
> -	if (is_ksym_addr(addr))
> -		return !!get_symbol_pos(addr, symbolsize, offset);
> +	if (is_ksym_addr(addr)) {
> +		get_symbol_pos(addr, symbolsize, offset);
> +		return 1;
> +	}
>  	return !!module_address_lookup(addr, symbolsize, offset, NULL, namebuf) ||
>  	       !!__bpf_address_lookup(addr, symbolsize, offset, namebuf);
>  }
> -- 
> 2.20.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
