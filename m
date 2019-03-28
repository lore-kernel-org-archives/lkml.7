Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA22C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247F020811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="XnS5OrMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfC1QJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:09:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56212 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfC1QJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:09:08 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AAE451EC0943;
        Thu, 28 Mar 2019 17:09:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553789346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+y/WQl1AN5ugxozXtmcaMpd0g3vwCI/9eCc6x0NjlTo=;
        b=XnS5OrMFh++P6oP2/5S0cxjm5cAgJ+wUAT6MBMxK0xCaF6unNoCDnngZaoWrHRbvpiyGUJ
        T5GFXo/wEoiMxkQrRo/KBSfjm/ZYtqw2hZ2sPAW1In5zYUYvw0kXYNaIzLLCFI7cGcZUjK
        eyBX33Wcfxj7RRwx+XV1Cy/ZQovwUBo=
Date:   Thu, 28 Mar 2019 17:09:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.co>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-kernel@lists.codethink.co.uk
Subject: Re: [PATCH] x86/asm: add __user on copy_user_handle_tail() pointers
Message-ID: <20190328160908.GQ22720@zn.tnic>
References: <20190228185027.2480-1-ben.dooks@codethink.co.uk>
 <20190328072421.GA22720@zn.tnic>
 <CAHk-=whjmxbtceHNbFycT5t=C56B+huPBewWbV5waaY7i09RBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whjmxbtceHNbFycT5t=C56B+huPBewWbV5waaY7i09RBQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 08:48:33AM -0700, Linus Torvalds wrote:
> Well, it does that because the x86 version of copy_user_generic() can
> work in either direction, so it works when either the source or
> destination (or both) are user pointers, but they don't _have_ to be.
> 
> So the "userness" of a pointer in that context is a bit ambiguous, and
> so we've picked the pointers to be just plain "void *".

Yeah, I had a suspicion the reasoning would be something along those
lines but couldn't find any threads discussing this quickly.

> That said, arguably we should have gone the other way and just made
> them both "__user" pointers, and do the cast the other way around.
> 
> But there's no absolutely right answer here, and nobody should ever
> use copy_user_generic() directly (ie it is very much meant to be only
> used as a internal helper for the cases that get the pointer
> annotations right).
> 
> I do think Ben's patch is probably the right thing to do.
> 
> And we could do the same thing to copy_user_generic(), but that would
> require switching the casts around in the callers, so may not be worth
> the noise.

Ok, Ben can you please add Linus' reasoning for this to the commit
message so that it is clear why it is done this way and we can find it
with git archeology?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
