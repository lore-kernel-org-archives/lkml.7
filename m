Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1F2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60AC12184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551372620;
	bh=Vh8L6gwhuROEB9QufXXrQ6XmpuPT92PVCVh0mUQZ0Sc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BfmH5XSniSbpvwgpQ8QRI75w8HNVHn2aDG92t+8n7eGE9X1RmadydV/EzA0vB0ePK
	 tis5ekbdWFdMW3ODs1MHFjpLhN7tj18osfxKpDbLYE0n8aAJFKYiuxyA4jk3wMKlUx
	 xNl/YxlY7PYjKubLF2vTCdlOeHcctAATzUE1hUco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733183AbfB1QuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:50:18 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35688 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbfB1QuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:50:18 -0500
Received: by mail-lf1-f68.google.com with SMTP id m73so10213284lfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 08:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3piHqZNEcy9SKWLEwBV/mKkW8cAFlGizlOArQiazQDo=;
        b=KIW7QzHN+HY8Jbx2K5sP+q/zoQeDeSZRCuE+HK+eNScSNhobsuoZ/pD4HIc+NS3xHX
         tGyHcpuJYwQ4pwRDiNV8V2MVug2HPxnzTHsvBkH59+TJIlafXOIzvHyR9r2K7uQG6CYa
         HSTo+/U2VMHZBqebtKRCazaLovlkPjEaqVGlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3piHqZNEcy9SKWLEwBV/mKkW8cAFlGizlOArQiazQDo=;
        b=lfPG4zECMDujGOHDJTUCSPvJ3ViHs54WBchSZyjwqxs4rbLD1/tsTv0wTi5HBILnCO
         BSVVQG4bfqVPNTvH62OACJ4HeyjV0v9zXzQAEo2HtWrl4f/pDPiZS1s0Cm/kRYr50/5D
         HC6eLDi8hQ5T/RUOdGFU95hXNwWSO2vE6YwQ5JpXWHYWeALryrL7pD9GvJQzxamK55gx
         FU/4PyZajLSgJDOuLtL29iVpLbhJk1IPgO9CjUhuFKiGGFBTRjRrDPJnSYaE8ws9ZuNH
         BEIAU01JYKf1tpiyd7e0/r10uI46Q3MkDaElp/XfcLSImNA2q+pOKZnqUa2AVEOl8e25
         A68Q==
X-Gm-Message-State: APjAAAUQ0L2Kb1YM0e6bg2SGZOd/jZmN1eaal7bwMXW76r5GxJ4Btj11
        u1h07os9jX/fen3a/6Df5xPO58ZrHKU=
X-Google-Smtp-Source: APXvYqyZuf0tK4/uXPMJxU74HR1blYTCKvt1G+uTyNWcLW41p+ldjogjHK+jTPrqMUYMIE4Qm6Cx3Q==
X-Received: by 2002:a19:48c3:: with SMTP id v186mr270618lfa.40.1551372615324;
        Thu, 28 Feb 2019 08:50:15 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id o67sm4762313lfe.40.2019.02.28.08.50.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 08:50:14 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id j1so15756311lfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 08:50:14 -0800 (PST)
X-Received: by 2002:a19:3f44:: with SMTP id m65mr248529lfa.136.1551372613604;
 Thu, 28 Feb 2019 08:50:13 -0800 (PST)
MIME-Version: 1.0
References: <20190228145450.289603901@infradead.org> <20190228150152.540038736@infradead.org>
In-Reply-To: <20190228150152.540038736@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Feb 2019 08:49:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgsSXxL5c2Lbmbai=bcCgN0G=jPO+gWhQ3a+wx-LTaFkQ@mail.gmail.com>
Message-ID: <CAHk-=wgsSXxL5c2Lbmbai=bcCgN0G=jPO+gWhQ3a+wx-LTaFkQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] i915,uaccess: Fix redundant CLAC
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 7:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> drivers/gpu/drm/i915/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x3c: redundant UACCESS disable
> drivers/gpu/drm/i915/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x66: redundant UACCESS disable
>
> AKA. you don't need user_access_end() if user_access_begin() fails.

NOOO!

This is complete garbage, and will end up running with AC set forever after.

PeterZ, you need to remove that "redundant UACCESS disable" check, or
make it a whole lot smarter. Because as it is, it's horribly horribly
wrong.

We absolutely _have_ to have that "user_access_end()" there.

Yes, it is redundant (but harmlessly so) if no fault occurs.

But if a fault occurs, that "user_access_end()" is what clears AC on
the faulting path. That's absolutely required, because we don't clear
it on return from exception (and we shouldn't - one common pattern for
user space exceptions is "try to do a big access, if that fails go
back to using small accesses until it fails again").

Your reachability clearly doesn't take exception handling into account.

That patch must die, and your incorrect reachability model must be fixed.

Right now the objtool rules seem to be worse than not using objtool,
if it causes these kinds of false positives.

              Linus
