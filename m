Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7705C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902202086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554091438;
	bh=gsDcDe8UeQdyjaf7uTDstCo3FgUEFlfsUSK/VYZkM90=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eJUK06QP+bNcIAgRTWdcJoPxq/TVBjbPMURAFQSr8PW2jpboDYDB1je7+nKZhZF98
	 L6tRRO1bqVDYrQUdPVVHsFXhzadRw9KWNZlLZmC0JxXdEiOIbtrz/iTPK6LPkfTCS7
	 s8e3h5RwtocvwYjaCbaoDB6mfYILhTH99sbkWf3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfDAED5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:03:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbfDAED4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:03:56 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAAFF2086C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 04:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554091436;
        bh=gsDcDe8UeQdyjaf7uTDstCo3FgUEFlfsUSK/VYZkM90=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vtcz/v/PXZ4RW+uUUzBcQqwlwtoPBbc4HdiHUkxvx7QVW7BrvAksJWymN+RTRTsGd
         KELBGB0HplCZ78s6slSAtMn9+5HxlxL00AMTOspwB/osJuvyOzrhWXaOW2C218rciM
         S9bQlnOICNp397uQ/hpspmvtXFC0Vz1EtYQWN1dU=
Received: by mail-wm1-f52.google.com with SMTP id n25so9531940wmk.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 21:03:55 -0700 (PDT)
X-Gm-Message-State: APjAAAU5wbg8ggjrUXUiqDc83NnxA3wAdTclLknmYlJNi4936/Ln15hS
        kH4TUshjXw4MaPrX0JJMiJxcRRet+aBkoQtaJ/Mm/w==
X-Google-Smtp-Source: APXvYqyUBemocEg68njR1MrI39/UJeSzHek+lEPys3gTASPxIIhv6vKeLsGgV0P2FPw3Jl1BHW0Utd5yK+m+PGYt20A=
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr2681903wmh.32.1554091434311;
 Sun, 31 Mar 2019 21:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190331214020.836098943@linutronix.de>
In-Reply-To: <20190331214020.836098943@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 31 Mar 2019 21:03:42 -0700
X-Gmail-Original-Message-ID: <CALCETrX1ZtZE2JUgXD55vZgwxpO2pTiUJb_GKDXAJJd4VTyGSw@mail.gmail.com>
Message-ID: <CALCETrX1ZtZE2JUgXD55vZgwxpO2pTiUJb_GKDXAJJd4VTyGSw@mail.gmail.com>
Subject: Re: [patch 00/14] x86/exceptions: Add guard patches to IST stacks
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 3:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Hi!
>
> While looking for something different I stumbled over the comment in struct
> cpu_entry_area:
>
>          * Exception stacks used for IST entries.
>          *
>          * In the future, this should have a separate slot for each stack
>          * with guard pages between them.
>
> As usual with such comments they are added in good faith and then
> forgotten. Looking what it takes to fix that let me stumble over some other
> leftovers like orig_ist[], now unused macros, useless defines and a bunch
> of assumptions about the exception stacks being a big lump. Aside of that I
> found a too broad check of the exception stack in the x86/64 stack overflow
> detector.
>
> The following series cleans that up and gradually prepares for guard pages
> between the IST stacks.

Thanks!  I'll review this over the next couple days.

Meanwhile, if you're inspired, I have a WIP series to do the same
thing to the IRQ stacks here:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=x86/guard_pages

Want to take a look or pick it up if you want to keep working on this?
