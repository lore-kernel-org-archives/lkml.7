Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E74C388F3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA77F21855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="QNZozDsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbfI3MCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 08:02:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33490 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbfI3MCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 08:02:40 -0400
Received: from zn.tnic (p200300EC2F058B00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:8b00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 674001EC0982;
        Mon, 30 Sep 2019 14:02:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569844959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=z8Yg6ftuAQDzPA2SaaFMykYUOSauRfhRnUdQbELiNUI=;
        b=QNZozDsdR2FQNDcAJ7Y1H989J4CPiP1AZ6LLObli8tUkoL7usoyC7vYbNNoCM4XUDvUZHb
        Pr6oCBeRipdD7O0F7+LltNWKJJYcJ3koDbDRnlZCtPtfrRf7n9M/EuNgfJAfYPrgq4uPLZ
        gf0q5/2bRRC/dT8SaMg5aVgkaFXJ2Hg=
Date:   Mon, 30 Sep 2019 14:02:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     jun.zhang@intel.com
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        bo.he@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/PAT: priority the PAT warn to error to highlight the
 developer
Message-ID: <20190930120211.GE29694@zn.tnic>
References: <20190929072032.14195-1-jun.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190929072032.14195-1-jun.zhang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 03:20:31PM +0800, jun.zhang@intel.com wrote:
> From: zhang jun <jun.zhang@intel.com>
> 
> Documentation/x86/pat.txt says:
> set_memory_uc() or set_memory_wc() must use together with set_memory_wb()

I had to open that file to see what it actually says - btw, the filename
is pat.rst now - and you're very heavily paraphrasing what is there. So
try again explaining what the requirement is.

> if break the PAT attribute, there are tons of warning like:
> [   45.846872] x86/PAT: NDK MediaCodec_:3753 map pfn RAM range req

That's some android NDK thing, it seems: "The Android NDK is a toolset
that lets you implement parts of your app in native code,... " lemme
guess, they have a kernel module?

> write-combining for [mem 0x1e7a80000-0x1e7a87fff], got write-back
> and in the extremely case, we see kernel panic unexpected like:
> list_del corruption. prev->next should be ffff88806dbe69c0,
> but was ffff888036f048c0

This is not really helpful. You need to explain what exactly you're
doing - not shortening the error messages.

> so it's better to priority the warn to error to highlight to
> remind the developer.

Whut?

From reading what is trying hard to be a sentence, I can only guess what
you're trying to say here. And it doesn't make it clear why is pr_warn()
not enough and it has to be pr_err().

> Signed-off-by: zhang jun <jun.zhang@intel.com>
> Signed-off-by: he, bo <bo.he@intel.com>

And this SOB chain is wrong.

> ---
>  arch/x86/mm/pat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
> index d9fbd4f69920..43a4dfdcedc8 100644
> --- a/arch/x86/mm/pat.c
> +++ b/arch/x86/mm/pat.c
> @@ -897,7 +897,7 @@ static int reserve_pfn_range(u64 paddr, unsigned long size, pgprot_t *vma_prot,
>  
>  		pcm = lookup_memtype(paddr);
>  		if (want_pcm != pcm) {
> -			pr_warn("x86/PAT: %s:%d map pfn RAM range req %s for [mem %#010Lx-%#010Lx], got %s\n",
> +			pr_err("x86/PAT: %s:%d map pfn RAM range req %s for [mem %#010Lx-%#010Lx], got %s!!!\n",

Three "!!!" would make this more urgent, huh?

How about you make the error message more informative and user-friendly,
instead?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
