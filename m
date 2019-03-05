Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4DDC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0270F20848
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="I+Ef0zg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbfCESSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:18:10 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46376 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfCESSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:18:08 -0500
Received: from zn.tnic (p200300EC2BCD6B00ECFD1928E9AB0C1D.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:6b00:ecfd:1928:e9ab:c1d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C0A91EC014B;
        Tue,  5 Mar 2019 19:18:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551809885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zSTufVaUCZI5YOnwsLc4xAHOFWxe5Am/nC0+VF8ZJDw=;
        b=I+Ef0zg6AYvh7HiH9FNlmTq/5+6zqnWoBmW8rGMIA3/ujnurhJDKrY9sfAxajzzKrGgudJ
        dUNYdGDavT7f3UmdEp0DiYVcovDE06ycrPDjizgfEUsX/dS9X/Hia1keUuyytII+F8YpAI
        Vm8DiUKIS4V0PQEON/i+ev0/eO3yhoM=
Date:   Tue, 5 Mar 2019 19:18:08 +0100
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
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-alpha@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH] x86: Deprecate a.out support
Message-ID: <20190305181808.GH8256@zn.tnic>
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
 <20190305091904.GB8256@zn.tnic>
 <20190305122218.GD13380@bombadil.infradead.org>
 <20190305134347.4be2449c@alans-desktop>
 <20190305145717.GD8256@zn.tnic>
 <CAHk-=wi2E4kugAW7BQwNSVwYHOr=B_9EgzBRMpQ2+1dxAqydDg@mail.gmail.com>
 <20190305173134.GE8256@zn.tnic>
 <CAHk-=wg0bY=RFhD4NW9x++fC0bME=_-9xM3kexGGM3gefHQTyQ@mail.gmail.com>
 <20190305181138.GG8256@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190305181138.GG8256@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 07:11:38PM +0100, Borislav Petkov wrote:
> I guess you could Cc arch maintainers with the a.out-core.h removal
> patch to see if anyone screams.

And they're like two for which we need confirmation:

$ git ls-files | grep a.out-core.h
arch/alpha/include/asm/a.out-core.h
arch/m68k/include/asm/a.out-core.h
arch/um/include/asm/a.out-core.h
arch/x86/include/asm/a.out-core.h

um and x86 are clear.

Adding alpha and m68k MLs to Cc.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
