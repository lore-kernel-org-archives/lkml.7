Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7E4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050E620661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfCHSML convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:12:11 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33157 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfCHSML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:12:11 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h2JyX-0001Cv-54; Fri, 08 Mar 2019 19:12:05 +0100
Date:   Fri, 8 Mar 2019 19:12:05 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 05/22] x86/fpu: Remove fpu->initialized usage in
 copy_fpstate_to_sigframe()
Message-ID: <20190308181204.t5qf3pvg42235k4t@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-6-bigeasy@linutronix.de>
 <20190116193603.GK15409@zn.tnic>
 <20190116224037.xkfnevzkwrck5dtt@linutronix.de>
 <20190117122253.GC5023@zn.tnic>
 <20190118211401.4komqsnvuof7563p@linutronix.de>
 <33f0e144-1eec-b1a1-8858-58f20d5e477d@intel.com>
 <20190121112117.GA32538@redhat.com>
 <20190205111757.oieqgdcdnctoegav@linutronix.de>
 <20190226163821.GC21443@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190226163821.GC21443@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-26 17:38:22 [+0100], Oleg Nesterov wrote:
> Hi Sebastian,
Hi Oleg,

> Sorry, I just noticed your email...

no worries.

> > So I assumed that while SIGUSR1 is handled SIGUSR2 will wait until the
> > current signal is handled. So no interruption. But then SIGSEGV is
> > probably the exception which will interrupt SIGUSR1. So we would need a
> > third one…
> 
> I guess you do not need my answer, but just in case.
> 
> SIGSEGV is not an exception. A SIGUSR1 handler can be interrupted by any other
> signal which is not included in sigaction->sa_mask. Even SIGUSR1 can interrupt
> the handler if SA_NODEFER was used.

okay, understood. My understanding was that since signal sending is not
very deterministic and as such you can't reliably control if one signal
arrived before the other finished it should not matter.
But well, this all is gone now…

Thank you for the explanation.

> Oleg.

Sebastian
