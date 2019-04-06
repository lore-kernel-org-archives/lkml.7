Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE012C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 13:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C34A20870
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 13:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554558899;
	bh=jSFrrAEs1h8h/8E9ud8jE/CZdvDayVE1sUrDDxcZk/0=;
	h=References:In-Reply-To:From:Date:Subject:Cc:To:List-ID:From;
	b=FnNGhM1SbCi1UlUKHkQRUIn9/dtdGjPpDl8hDoUTGcmTyLkriLg3g4ZStYTrzj55R
	 dV0udI9tOlNSoTuJGICWubxDT6eQ6Ju17YTEX6HhqcmiT+XDN85YKNQOREx8Mq4z9T
	 aqeeSpa3weElqbSyirpqCrxFysfJQEeEv4gNhaw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfDFNy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 09:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbfDFNy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 09:54:56 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E92702146F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2019 13:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554558896;
        bh=jSFrrAEs1h8h/8E9ud8jE/CZdvDayVE1sUrDDxcZk/0=;
        h=References:In-Reply-To:From:Date:Subject:Cc:From;
        b=uJ/r2afxYA93aOnSJScm/XZHBAU+yAB8KFaldiwhUp9U3gGwtoobyHKl/oHpkvOK5
         F3B8ylG9R8mDA9H9NLbVF7Yrel0fW7SwLdZhVsnNYwt3PkxW0diGz5JMgV+Fqb9gcg
         rHSc/ENUhrt17qVtCRxn8k0eNHdpkQcf25IVq6+c=
Received: by mail-wr1-f45.google.com with SMTP id s15so11091627wra.12
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 06:54:55 -0700 (PDT)
X-Gm-Message-State: APjAAAWW9OhLFB1Ghmw8JIqPxP50xPXiE8j+9K2+dXHBVMR+SdfTLOwh
        FxpxzSfQe+XsfD6xtnUJqGq/GHyeDH4FO9RbGnftwQ==
X-Received: by 2002:adf:eb84:: with SMTP id t4mt4592456wrn.43.1554558894492;
 Sat, 06 Apr 2019 06:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <5ca84952.hpEqUp6kap0tafzR%lkp@intel.com>
In-Reply-To: <5ca84952.hpEqUp6kap0tafzR%lkp@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 6 Apr 2019 06:54:43 -0700
X-Gmail-Original-Message-ID: <CALCETrX_ys9dJZOkN7QBjWz9Y1iukQDaJaASPAkGtWvwNkOESw@mail.gmail.com>
Message-ID: <CALCETrX_ys9dJZOkN7QBjWz9Y1iukQDaJaASPAkGtWvwNkOESw@mail.gmail.com>
Subject: Re: 8b275b3754 ("x86/irq/64: Remap the IRQ stack with guard pages"):
 BUG: unable to handle kernel paging request at ffffb659000a1000
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 11:38 PM kernel test robot <lkp@intel.com> wrote:
>
> Greetings,
>
> 0day kernel testing robot got the below dmesg and the first bad commit is
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/stackguards
>
> commit 8b275b3754465d502d393f8ae8dd355b7067e73f
> Author:     Andy Lutomirski <luto@kernel.org>
> AuthorDate: Fri Jul 13 19:01:23 2018 -0700
> Commit:     Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Fri Apr 5 17:04:10 2019 +0200
>
>     x86/irq/64: Remap the IRQ stack with guard pages
>
>     The IRQ stack lives in percpu space, so an IRQ handler that overflows it
>     will overwrite other data structures.
>
>     Use vmap() to remap the IRQ stack so that it will have the usual guard
>     pages that vmap/vmalloc allocations have. With this the kernel will panic
>     immediately on an IRQ stack overflow.
>
>     [ tglx: Move the map code to a proper place and invoke it only when a CPU
>             is about to be brought online. No point in installing the map at
>             early boot for all possible CPUs. Fail the CPU bringup if the vmap
>             fails as done for all other preparatory stages in cpu hotplug. ]
>
>     Signed-off-by: Andy Lutomirski <luto@kernel.org>
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

I haven't spotted the actual bug yet, but the faulting instruction is:

  2a:    65 8b 35 09 ca 75 63     mov    %gs:*0x6375ca09(%rip),%esi
    # 0x6375ca3a        <-- trapping instruction

This seems to be faulting just above the top of the stack (the thing
in RSP), so I suspect that there is some path that is shoving the
remapped value into GSBASE, which is wrong.

Also, FWIW, there was some reason that I initialized all the virtual
mappings for all possible CPUs early.  I don't remember what it was,
and it may not have been a good reason, but I put at least some
nonzero amount of thought into it :)

--Andy
