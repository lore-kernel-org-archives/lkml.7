Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518BCC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 10:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE1720CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 10:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="eQO/NvmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbfIMKmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 06:42:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36026 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387512AbfIMKmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 06:42:38 -0400
Received: from zn.tnic (p200300EC2F0DC5002486B65DCA157D7D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c500:2486:b65d:ca15:7d7d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 864081EC03F6;
        Fri, 13 Sep 2019 12:42:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1568371357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FEUAuFNSQvuR3RsMDZaXz3ghisFRlkD0kcIhhXnO+ck=;
        b=eQO/NvmPRsgbqCkVgxDJkL4GAGLwYSoDvWhoSjR7MI0JpLM/lQCrFY+fodwwbDgDFnEWyw
        bGsO2U0Nq/uQMt8dFLsSvW6VzIW4sCyPx2as8f9PE6JwePHv69COCsaCzuLQTDDFpdatzI
        PVgL6AGZXmv63vTAeDNzUhiZOtAGcLY=
Date:   Fri, 13 Sep 2019 12:42:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Rasmus Villemoes <mail@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Improve memset
Message-ID: <20190913104232.GA4190@zn.tnic>
References: <20190913072237.GA12381@zn.tnic>
 <CAHk-=wismo3SQvvKXg8j0W-eC+5Q-ctcYfr1QV3K-i90w5caBA@mail.gmail.com>
 <9dc9f1e6-5d19-167c-793d-2f4a5ebee097@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9dc9f1e6-5d19-167c-793d-2f4a5ebee097@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 11:18:00AM +0200, Rasmus Villemoes wrote:
> Something like
> 
> 	if (__builtin_constant_p(c) && __builtin_constant_p(n) && n <= 32)
> 		return __builtin_memset(dest, c, n);
> 
> might be enough? Of course it would be sad if 32 was so high that this
> turned into a memset() call, but there's -mmemset-strategy= if one wants
> complete control. Though that's of course build-time, so can't consider
> differences between cpu models.

Yah, that seems to turn this:

        memset(&tr, 0, sizeof(tr));
        tr.b            = b;

where sizeof(tr) < 32 into:

# ./arch/x86/include/asm/string_64.h:29:                return __builtin_memset(dest, c, n);
        movq    $0, 16(%rsp)    #, MEM[(void *)&tr + 8B]
        movq    $0, 24(%rsp)    #, MEM[(void *)&tr + 8B]
# arch/x86/kernel/cpu/mce/amd.c:1070:   tr.b            = b;
        movq    %rbx, 8(%rsp)   # b, tr.b

which is 2 u64 moves and the assignment of b at offset 8.

Question is, where we should put the size cap? I'm thinking 32 or 64
bytes...

Linus, got any suggestions?

Or should we talk to Intel hw folks about it...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
