Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC6BC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E582054F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="reW1jpsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbfLKRGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:06:44 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51522 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729512AbfLKRGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:06:43 -0500
Received: from zn.tnic (p200300EC2F094900329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:4900:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 022811EC0CEB;
        Wed, 11 Dec 2019 18:06:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576084001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EJEZLGG0R25FiEGZ36o3yiaHw5c4zLdXmBC4Wq4ADFM=;
        b=reW1jpsjlES6c+Bl0PEbIBWykItTEDAgfN6LLTsfq+gGetkDi/hxFZaW0e0bhziNqP3w/C
        x9nwcMSiikHCjnjZNNcGWXhQ2g7KPKYYHvKrRTcE7fQBJ7Gk7WSTUp4DWqROdBoStakl7B
        dJA9PnfPHqjZM1BjJU0ibNNA5e5WTDg=
Date:   Wed, 11 Dec 2019 18:06:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v6 2/4] x86/traps: Print address on #GP
Message-ID: <20191211170632.GD14821@zn.tnic>
References: <20191209143120.60100-1-jannh@google.com>
 <20191209143120.60100-2-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191209143120.60100-2-jannh@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 03:31:18PM +0100, Jann Horn wrote:
>     I have already sent a patch to syzkaller that relaxes their parsing of GPF
>     messages (https://github.com/google/syzkaller/commit/432c7650) such that
>     changes like the one in this patch don't break it.
>     That patch has already made its way into syzbot's syzkaller instances
>     according to <https://syzkaller.appspot.com/upstream>.

Ok, cool.

I still think we should do the oops number marking, though, as it has
more benefits than just syzkaller scanning for it. The first oops has always
been of crucial importance so having the number in there:

[    2.542218] [1] general protection fault while derefing a non-canonical address 0xdfff000000000001: 0000 [#1] PREEMPT SMP
	 	^

would make eyeballing oopses even easier. Basically the same reason why
you're doing this enhancement. :)

So let me know if you don't have time to do it or you don't care about
it etc, and I'll have a look. Independent of those patches, of course -
those look good so far.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
