Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39AEC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB41D2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfDLR1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:27:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38157 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfDLR1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:27:35 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hEzxa-0001I0-Fi; Fri, 12 Apr 2019 19:27:30 +0200
Date:   Fri, 12 Apr 2019 19:27:30 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 24/27] x86/fpu: Add a fastpath to __fpu__restore_sig()
Message-ID: <20190412172730.ru6bukxcepwbiklp@linutronix.de>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
 <20190403164156.19645-25-bigeasy@linutronix.de>
 <20190412171759.GH19808@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190412171759.GH19808@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-12 19:17:59 [+0200], Borislav Petkov wrote:
> > @@ -327,7 +327,19 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
> >  		if (ret)
> >  			goto err_out;
> >  		envp = &env;
> > +	} else {
> 
> I've added here:

I would suggest to add it in the last patch once we have the complete
fast path. The other one extended (in case you want to add a comment
there, too).

> +               /*
/**

> +                * Attempt to restore the FPU registers directly from user
> +                * memory. For that to succeed, the user accesses cannot cause

I would say "user access" because it is always a single instruction.

> +                * page faults. If they do, fall back to the slow path below,
> +                * going through the kernel buffer.

"with the enabled page fault handler".

> +                */
> 
> so that it is clear what's happening.
> 
> This function is doing gazillion things again ;-\

It is the old code with disabled page fault handler. But I understand.

Sebastian
