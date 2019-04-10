Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CE7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD862082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="StdwBHOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387780AbfDJQVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:21:02 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44618 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbfDJQVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:21:01 -0400
Received: by mail-vs1-f67.google.com with SMTP id j184so1692621vsd.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 09:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nCrI0/fcnK3AyC9MRRK5XJmCh4ej7uxa3ZgKLtftzrs=;
        b=StdwBHOSdMNheyWbSlfmHxAnCuSAEhoKVJtHk32Ru/Lgp6w0qJkw7b2blFz86puXwp
         d7SYF54B2JBWD4Bl9EywpB8Ht1q5rJblH9PVrdrTwWtKTk+Pj0/S2uZCyBIPaiNG+ZzW
         i0u4ChbrDGt4yndCLwOh/GoFHqycRW8h0vpoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nCrI0/fcnK3AyC9MRRK5XJmCh4ej7uxa3ZgKLtftzrs=;
        b=aA783VnZdny0dCSJ2oL+7RiCJUmkcmCT+0b1mxcXHpCReZ4/EC8F4BN9uVCD3+J3vC
         HcL8YFDXwN5PfTy0aN1tRFvCPtWRwm3XshJro8Sx5LLDcW5x5XUw2feqjk/Qx3KttPrk
         EpryamDpFRMa7JuZQsH0ojDQ1IMJ/A1uAXPr31ahoC6LzF/FIFD8yQnySimvg9EAmuJi
         ximlTkyxObxqwhkrzB7yYYvXjkBas53Ia4Pnkkc/tLgXL0tyLnB/aml8vGe9OkLwBlGg
         cjzE9l8hujSbJiXmInQaqrwaH0ASrbnE7rMhmc0tu7X7xep448qXd2P+PqP5c53+/U/N
         RgBw==
X-Gm-Message-State: APjAAAUdrX69VQVDq6B5veUPix1QCf1n9/PqS2bETx/LuxerjHfXee7S
        cGOBdwV+8rMgpsqjdrRjBd/oGIVeCqg=
X-Google-Smtp-Source: APXvYqycVtW84FHpxioCCEnoVWW+XhnycGz0PXuHj88S2PSUFG7gdxGHvI3qg3Kg0heUAkZytgIHCw==
X-Received: by 2002:a67:fe95:: with SMTP id b21mr25458018vsr.109.1554913259820;
        Wed, 10 Apr 2019 09:20:59 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id t128sm27893458vka.36.2019.04.10.09.20.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:20:58 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id t78so1729622vsc.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 09:20:57 -0700 (PDT)
X-Received: by 2002:a67:f04e:: with SMTP id q14mr24976116vsm.133.1554913257394;
 Wed, 10 Apr 2019 09:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190410112103.15170-1-elena.reshetova@intel.com>
 <20190410112103.15170-2-elena.reshetova@intel.com> <20190410114259.GB9293@gmail.com>
 <CALCETrVme9=aVpSOhtkuVtwDy06pxB=6C9fkqRVoUF_fx0LrOQ@mail.gmail.com>
In-Reply-To: <CALCETrVme9=aVpSOhtkuVtwDy06pxB=6C9fkqRVoUF_fx0LrOQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 09:20:46 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+iPwqp6ReGh6FEGNWtsv3AT73XgJzVOoMinemSZNfUaQ@mail.gmail.com>
Message-ID: <CAGXu5j+iPwqp6ReGh6FEGNWtsv3AT73XgJzVOoMinemSZNfUaQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/entry/64: randomize kernel stack offset upon syscall
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 7:49 AM Andy Lutomirski <luto@kernel.org> wrote:
> And build it like this, it fails:
>
> $ gcc -o ingo -g ingo.c -pie
> /usr/bin/ld: /tmp/ccofYU9N.o: relocation R_X86_64_32 against `.rodata'
> can not be used when making a PIE object; recompile with -fPIC
> /usr/bin/ld: final link failed: nonrepresentable section on output
> collect2: error: ld returned 1 exit status
>
> Which I assume means that -pie requires -fPIC, and your toolchain is
> screwed up and is defaulting to useless options.  I'm guessing you
> should file a bug against your distro gcc package.  For me, it works
> if I remove -pie.

I think you need both -fPIE (object creation) and -pie (linking).

-- 
Kees Cook
