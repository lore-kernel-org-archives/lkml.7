Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026EFC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A9021556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="h0neVSvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbfLKR3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:29:52 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55098 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfLKR3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:29:52 -0500
Received: from zn.tnic (p200300EC2F094900329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:4900:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F213C1EC0591;
        Wed, 11 Dec 2019 18:29:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576085391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8aesE0e4I0F9DuRAYP1dhgNCcsnczB3N1jlspP6j4Fw=;
        b=h0neVSvpKg6qKZv3VUOUWlhz3b8IiUkJ7c4PBVtdMV1q6zWbDKm8oBx3jE/rFSCGylDK0z
        7AF9lYcQrMAycZwXZ2BnuKv7hjeStQD+hSRmgdx2C++fDuXNwbPPIOiXtsmtuPitQ5tTR0
        OWzG38FrhhK3FLtTb1dr0+sH2MPKl/g=
Date:   Wed, 11 Dec 2019 18:29:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20191211172945.GE14821@zn.tnic>
References: <20191211170632.GD14821@zn.tnic>
 <BC48F4AD-8330-4ED6-8BE8-254C835506A5@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BC48F4AD-8330-4ED6-8BE8-254C835506A5@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 09:22:30AM -0800, Andy Lutomirski wrote:
> Could we spare a few extra bytes to make this more readable?  I can never keep track of which number is the oops count, which is the cpu, and which is the error code.  How about:
> 
> OOPS 1: general protection blah blah blah (CPU 0)
> 
> and put in the next couple lines “#GP(0)”.

Well, right now it is:

[    2.470492] general protection fault, probably for non-canonical address 0xdfff000000000001: 0000 [#1] PREEMPT SMP
[    2.471615] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc1+ #6

and the CPU is on the second line, the error code is before the number -
[#1] - in that case.

If we pull the number in front, we can do:

[    2.470492] [#1] general protection fault, probably for non-canonical address 0xdfff000000000001: 0000 PREEMPT SMP
[    2.471615] [#1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc1+ #6

and this way you know that the error code is there, after the first
line's description.

I guess we can do:

[    2.470492] [#1] general protection fault, probably for non-canonical address 0xdfff000000000001 Error Code: 0000 PREEMPT SMP

to make it even more explicit...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
