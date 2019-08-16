Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B339C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772F42133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfHPUKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:10:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43105 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfHPUKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:10:44 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyiYG-0008Bd-PY; Fri, 16 Aug 2019 22:10:20 +0200
Date:   Fri, 16 Aug 2019 22:10:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCHv6 23/36] x86/vdso: Allocate timens vdso
In-Reply-To: <b719199a-ed91-610b-38bc-015a0749f600@kernel.org>
Message-ID: <alpine.DEB.2.21.1908162208190.1923@nanos.tec.linutronix.de>
References: <20190815163836.2927-1-dima@arista.com> <20190815163836.2927-24-dima@arista.com> <b719199a-ed91-610b-38bc-015a0749f600@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019, Andy Lutomirski wrote:
> On 8/15/19 9:38 AM, Dmitry Safonov wrote:
> > As it has been discussed on timens RFC, adding a new conditional branch
> > `if (inside_time_ns)` on VDSO for all processes is undesirable.
> > It will add a penalty for everybody as branch predictor may mispredict
> > the jump. Also there are instruction cache lines wasted on cmp/jmp.
> > 
> > Those effects of introducing time namespace are very much unwanted
> > having in mind how much work have been spent on micro-optimisation
> > vdso code.
> > 
> > The propose is to allocate a second vdso code with dynamically
> > patched out (disabled by static_branch) timens code on boot time.
> > 
> > Allocate another vdso and copy original code.
> 
> 
> I'm unconvinced that any of this magic is wise.  I think you should make a
> special timens vvar page that causes the normal fastpath to fail (using a
> special vclock mode, a special seq value, or a special "last" value) and then
> make the failure path detect that timens is in use and use the timens path.

My initial suggestion still stands. Do that at compile time. It really does
not matter whether we have another 2 or 3 variants of vdso binaries.

Use it and be done with it. No special magic, just straight forward
decisions to use a timens capable VDSO or not.

Thanks,

	tglx
