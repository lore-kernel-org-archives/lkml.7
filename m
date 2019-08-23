Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B96C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 23:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3174521655
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 23:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfHWXoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 19:44:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36780 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfHWXoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 19:44:22 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i1JEB-0002eX-EZ; Sat, 24 Aug 2019 01:44:19 +0200
Date:   Sat, 24 Aug 2019 01:44:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sebastian Mayr <me@sam.st>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] uprobes/x86: fix detection of 32-bit user mode
In-Reply-To: <alpine.DEB.2.21.1908232343470.1939@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1908240142000.1939@nanos.tec.linutronix.de>
References: <20190728152617.7308-1-me@sam.st> <alpine.DEB.2.21.1908232343470.1939@nanos.tec.linutronix.de>
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

On Sat, 24 Aug 2019, Thomas Gleixner wrote:
> On Sun, 28 Jul 2019, Sebastian Mayr wrote:
> 
> > -static inline int sizeof_long(void)
> > +static inline int sizeof_long(struct pt_regs *regs)
> >  {
> > -	return in_ia32_syscall() ? 4 : 8;
> 
>   This wants a comment.
> 
> > +	return user_64bit_mode(regs) ? 8 : 4;

The more simpler one liner is to check

    test_thread_flag(TIF_IA32)

which is only true for IA32 and independent of syscalls, exceptions ...

Thanks,

	tglx
