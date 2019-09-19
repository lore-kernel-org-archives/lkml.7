Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C3DC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AB721907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TgF8fD+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390439AbfISMzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 08:55:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37362 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389212AbfISMzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 08:55:44 -0400
Received: from nazgul.tnic (unknown [193.86.95.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C9A5B1EC04BC;
        Thu, 19 Sep 2019 14:55:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1568897742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8r+UmcwsFhZ9VWdz0aPZcHPp1vQPeZJ3k2MKS/v1A2U=;
        b=TgF8fD+cZ9m2VONduQeIPB8NafkJ6pETyTk6/R9hI9AlhUwkgTKntCCiji3BLDRgIsz/Zv
        Gtb/mvJADXZMHv2kwU7hjT1oDfVa7rA7osXuAyJvXcUGjkcnA/L/KIZJGk8gNXA5H3E6kk
        3MikCL7sJd/slsJOLVUgFiPYcua6+C4=
Date:   Thu, 19 Sep 2019 14:55:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86-ml <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Improve memset
Message-ID: <20190919125542.GB18148@nazgul.tnic>
References: <20190913072237.GA12381@zn.tnic>
 <20190917201021.evoxxj7vkcb45rpg@treble>
 <CAHk-=wjDiDOcz2GHC88rV8gySCMZZko8PFW-ywJDkeY5n+je9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjDiDOcz2GHC88rV8gySCMZZko8PFW-ywJDkeY5n+je9Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 01:45:20PM -0700, Linus Torvalds wrote:
> That sounds better, but I'm a bit nervous about the whole thing
> because who knows when the alternatives code itself internally uses
> memset() and then we have a nasty little chicken-and-egg problem.

You mean memcpy()...?

> Also, for it to make sense to inline rep stosb, I think we also need
> to just make the calling conventions for the alternative calls be that
> they _don't_ clobber other registers than the usual rep ones
> (cx/di/si). Otherwise one big code generation advantage of inlining
> the thing just goes away.

Yah, that is tricky and I have no smart idea how. The ABI puts the
operands in rdi,rsi,rdx, ... while REP; STOSB wants them in rax,rcx,rdi.
And if it were only that, then we could probably accept the 2 movs and
a push but then the old functions clobber three more: "rdx", "r8", "r9".

I could try to rewrite the old functions to see if I can save some regs...

> On the whole I get the feeling that this is all painful complexity and
> we shouldn't do it. At least not without some hard performance numbers
> for some huge improvement, which I don't think we've seen.

Yap, it is starting to become hairy.

> Because I find the thing fascinating conceptually, but am not at all
> convinced I want to deal with the pain in practice ;)

I hear ya.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
