Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100C9C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44BC20661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZStjiC91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfCERbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:31:39 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38738 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfCERbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:31:38 -0500
Received: from zn.tnic (p200300EC2BCD6B0038F240D7E20AD2C8.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:6b00:38f2:40d7:e20a:d2c8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 78EAA1EC08EF;
        Tue,  5 Mar 2019 18:31:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551807096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=12xV4AtewluQmMXfUFGYit00bMr6sAztmgDzL+S33LI=;
        b=ZStjiC91KVFYJNXPhbEMC1pNO98Lyvi5++6OwQtiHEmd63KdzO508wrpbQxf9g+ZUOrnPM
        A32AkvGO8mjtW4pydtzxpM9QHb3RZAw5Ka0xmi/sOofikYjEyP29sOlpkffvepiHDRYUoz
        y4EuArTt2xXYQg9nksItpGci607iOrc=
Date:   Tue, 5 Mar 2019 18:31:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: Re: [PATCH] x86: Deprecate a.out support
Message-ID: <20190305173134.GE8256@zn.tnic>
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
 <20190305091904.GB8256@zn.tnic>
 <20190305122218.GD13380@bombadil.infradead.org>
 <20190305134347.4be2449c@alans-desktop>
 <20190305145717.GD8256@zn.tnic>
 <CAHk-=wi2E4kugAW7BQwNSVwYHOr=B_9EgzBRMpQ2+1dxAqydDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi2E4kugAW7BQwNSVwYHOr=B_9EgzBRMpQ2+1dxAqydDg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 08:22:21AM -0800, Linus Torvalds wrote:
> Because I think all the known *bugs* we had were with the core dumping
> code, weren't they?

Well, I'm aware of only this one I fixed but who knows what else has
bitrotten out there through the years...

> Removing it looks trivial. Untested patch attached.
> 
> Then I'd be much happier with your "let's deprecate a.out entirely" as
> a second patch, because I think it's a unrelated issue and much more
> likely to have somebody pipe up and say "hey, I have this sequence
> that generates executables dynamically, and I use a.out because it's
> much simpler than ELF, and now it's broken". Or something.

Hohumm, yap, it all makes sense to me. That's definitely the safer
approach without us having to revert patches later.

So how do you wanna handle this?

I guess the easiest would be if you apply your patch directly now and
add the a.out phase-out strategy we're going for in its commit message
so that people are aware of what we're doing.

This will allow for other arch maintainers to delete
arch/*/include/asm/a.out-core.h, Jann mentions in the other mail, after
-rc1 is cut.

And then I'll carry any other patches through the tip tree ontop of -rc1
too.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
