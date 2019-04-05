Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9152BC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50EC22186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="txgrx4Ii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbfDEQAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:00:11 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46153 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfDEQAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:00:11 -0400
Received: by mail-yw1-f68.google.com with SMTP id v127so2461187ywe.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 09:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iXRxs5zC7dqjmusKprV/uE/kOhftjFlIGZS3JmsYIYE=;
        b=txgrx4Iib8PAxGCDruzFr+gfprAna5zH5Mpk6lV14NR+aatPOfNfzLUHTd/nyzijCz
         iCcD+AYBPTTKHSYLAXpBndFYdsdTYY5o6+aAWWSREcUd1T3dZ28uD7YjWue610FGvl93
         CtTIfAIvXZe4y986Ob4trEHUmh0oDIO7lC1ar2qPA2Eg771KG77A9zThfnJSOe0+5doT
         Z0HGR0oES2kLSw5lAelVN7EZK3oYGKXD60Xst9dOg1YQdvp/gYcDAj4ZjEh9b1cv60ig
         gL00b5EyBE7/08rqgbbVgWyPXlqdQOoch2BG9Oh9XzbjUx01z8sOD62yE1xIZtgo8DBA
         ICvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iXRxs5zC7dqjmusKprV/uE/kOhftjFlIGZS3JmsYIYE=;
        b=BQyQpbDht+hQLhGKdxNL4fAK9QjAtS952Z3hr9iD9v4wlkCW4qiP7f2tbinssL6xfg
         63yzzNaNmXz0CyJ3GgY740E9H/Z2TLG6HNozDORhpREF6JthyEPP9D5SCoIkxwoQzxUq
         Rrs+LTbjlwSnCGr6FTK8jyU3kGeovTf0kwHK/yfL3FpkLUJ4iyREiuqo2u6VT2p9NjJb
         ipf1EtNLWrf0gnbTTWEQWzUCuqXaOAb2EBgiWO/kHB0uqADrhe1VY1ofHAyOav20V87s
         GB1mJNkRh1c3tGxP8Lrz43l4D4zfCTP9jgIKXYswmzRcqT5Ty1F27CQk2K1sPSY36Mp0
         nm+Q==
X-Gm-Message-State: APjAAAXKEKO8ZkmXZHtUVVY4LdeACgJ4lSc42KebWICeHj1e9mOAb3wE
        tKH7ot35NSy9KYs6ktXAPgWu/g==
X-Google-Smtp-Source: APXvYqwY0UBeH1wHfSJYEM+VGJEt9iKCn/vXe3pXLODpTau/122jwwA2Dk5MI6Hfqn7D958ewAS4cA==
X-Received: by 2002:a81:9245:: with SMTP id j66mr10566133ywg.239.1554480010453;
        Fri, 05 Apr 2019 09:00:10 -0700 (PDT)
Received: from cisco ([2601:282:901:dd7b:38ae:7ccc:265c:2d2c])
        by smtp.gmail.com with ESMTPSA id b131sm9355229ywb.103.2019.04.05.09.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 09:00:09 -0700 (PDT)
Date:   Fri, 5 Apr 2019 10:00:02 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Khalid Aziz <khalid.aziz@oracle.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] x86/entry: re-enable interrupts before exiting
Message-ID: <20190405160002.GB12463@cisco>
References: <20190405153525.29587-1-tycho@tycho.ws>
 <20190405155833.bnp5lfa5u33zhznk@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405155833.bnp5lfa5u33zhznk@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 10:58:33AM -0500, Josh Poimboeuf wrote:
> On Fri, Apr 05, 2019 at 09:35:24AM -0600, Tycho Andersen wrote:
> > If the kernel oopses in an interrupt, nothing re-enables interrupts:
> > 
> > Aug 23 19:30:27 xpfo kernel: [   38.302714] BUG: sleeping function called from invalid context at
> > ./include/linux/percpu-rwsem.h:33
> > Aug 23 19:30:27 xpfo kernel: [   38.303837] in_atomic(): 0, irqs_disabled(): 1, pid: 1970, name:
> > lkdtm_xpfo_test
> > Aug 23 19:30:27 xpfo kernel: [   38.304758] CPU: 3 PID: 1970 Comm: lkdtm_xpfo_test Tainted: G      D
> > 4.13.0-rc5+ #228
> > Aug 23 19:30:27 xpfo kernel: [   38.305813] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > 1.10.1-1ubuntu1 04/01/2014
> > Aug 23 19:30:27 xpfo kernel: [   38.306926] Call Trace:
> > Aug 23 19:30:27 xpfo kernel: [   38.307243]  dump_stack+0x63/0x8b
> > Aug 23 19:30:27 xpfo kernel: [   38.307665]  ___might_sleep+0xec/0x110
> > Aug 23 19:30:27 xpfo kernel: [   38.308139]  __might_sleep+0x45/0x80
> > Aug 23 19:30:27 xpfo kernel: [   38.308593]  exit_signals+0x21/0x1c0
> > Aug 23 19:30:27 xpfo kernel: [   38.309046]  ? blocking_notifier_call_chain+0x11/0x20
> > Aug 23 19:30:27 xpfo kernel: [   38.309677]  do_exit+0x98/0xbf0
> > Aug 23 19:30:27 xpfo kernel: [   38.310078]  ? smp_reader+0x27/0x40 [lkdtm]
> > Aug 23 19:30:27 xpfo kernel: [   38.310604]  ? kthread+0x10f/0x150
> > Aug 23 19:30:27 xpfo kernel: [   38.311045]  ? read_user_with_flags+0x60/0x60 [lkdtm]
> > Aug 23 19:30:27 xpfo kernel: [   38.311680]  rewind_stack_do_exit+0x17/0x20
> > 
> > do_exit() expects to be called in a well-defined environment, so let's
> > re-enable interrupts after unwinding the stack, in case they were disabled.
> > 
> > Note that if any spinlocks are held, etc. we'll also get the above warning,
> > so this isn't a silver bullet. So, let's add a C helper in case someone
> > wants to add fancier lock busting or if we've forgotten to unwind something
> > else.
> > 
> > I've had to add back in the hack that Josh removed in 8c1f75587a18
> > ("x86/entry/64: Add unwind hint annotations") with the loop after the call,
> > because for whatever reason without that I get a warning:
> > 
> >   AS      arch/x86/entry/entry_64.o
> > arch/x86/entry/entry_64.o: warning: objtool: .entry.text: unexpected end of section
> > 
> > It seems to actually work fine for me though, since the new helper is also
> > __noreturn. Perhaps there's a better way to do this?
> 
> Unfortunately, objtool doesn't have a way to detect noreturn functions
> in other objects, so they're hard-coded in a list.  You can add
> __finish_rewind_stack_do_exit to the global_noreturns array in
> tools/objtool/check.c.

Awesome, this is the magic I was missing. Thanks!

Tycho
