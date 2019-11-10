Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B9CC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 22:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B358C2075C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 22:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573425335;
	bh=zSPqudhiPKJw565M1oGzVTfCFsnPjdMatxo8OjKlnCM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ozlEVlaN4iLfa8VGfh8/N66Cw6hPFzZFmu4soKnmpW8UEDkz5I8A+LeVKVPtXA0XZ
	 LT9ImRZCXrMTqQzVsVIaW4Vcs15zCC51kUA8294ZwnAyh9o0D0RWsOrV2r+R47LN1u
	 SGi8bH8Dae+QdMLOiX/qEP5PEpt7FyMgL0VL8X7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfKJWfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 17:35:34 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43898 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfKJWfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 17:35:34 -0500
Received: by mail-lj1-f193.google.com with SMTP id y23so11663660ljh.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 14:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+NBVMvAeSjvjjX1c0c+htPmEjTBHiy+YFhFok5r1cTA=;
        b=MM8GecQS9398VBncpNfj2q30ym0v7Wd61Hikdfm/vCnzORHKlwKdao3VidtKG5V5T4
         J+el26ZulK3mESVoyXcPjV8Qd3QdsikjbXc+H3+u1R2+Hc/HUkIytR0o+SIDGXmnJ3rl
         veUNtlt/IAoEx8JGzCoA131B1WO66X6wpkocI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+NBVMvAeSjvjjX1c0c+htPmEjTBHiy+YFhFok5r1cTA=;
        b=TbZ9FDCrs0UvG1+DxUnXPVRP9CwUqpsZlKnr3H1ZEnW3W71bpm8rkeG+qIXVREQRdk
         61tAjWR1DWZQRRs8iCBE0XFz1zX0vX2AI0+U3uenuhM9nxVxpVWEUgya5FuJBgJcZnvw
         HxoQSNI42pUIfX13OG4LE6TxIh4EmnxI5IPO49jdgVlIhcI13Aq4b6a5U9x3sLHtxqtn
         jSzserYRnEOVEkp7hjr6uAHknlfAsa5JazphXDc8ECjlAQ6ZOwdfOc65QC20LMqkXLcV
         LGlZOuOKWmfyoer2lqQP8fuT9mzJzC/eNIN7OvxjQmFSsKAkBumywFI1N45/sked+1ez
         wySA==
X-Gm-Message-State: APjAAAUr8stCtVmCKdoc1msNmveq15lS0pp5rG/iTuIbRaMpw5kpn3Pl
        GlKqRtP8RS1kCpp2ddT7nJkqTQwjGdg=
X-Google-Smtp-Source: APXvYqwHGepIzIn2/ocJSWNiAnX4z7uqNK7eZevLD/40MmT9GJsOl8P8PC2XaBnm3bIVPGZrS341ow==
X-Received: by 2002:a2e:b4da:: with SMTP id r26mr18157ljm.153.1573425331558;
        Sun, 10 Nov 2019 14:35:31 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id x18sm5896429ljc.39.2019.11.10.14.35.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2019 14:35:30 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id n5so11684971ljc.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 14:35:29 -0800 (PST)
X-Received: by 2002:a2e:8809:: with SMTP id x9mr13989546ljh.82.1573425329687;
 Sun, 10 Nov 2019 14:35:29 -0800 (PST)
MIME-Version: 1.0
References: <157338131323.14789.2179255265964358886.tglx@nanos.tec.linutronix.de>
 <698b03300532f80dfbd30fa35446a33e58ae0c89.camel@perches.com>
In-Reply-To: <698b03300532f80dfbd30fa35446a33e58ae0c89.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Nov 2019 14:35:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiwhMFo6GFUAg3CZJMix4TJo59NBaSDciQxW23RHR8Zbg@mail.gmail.com>
Message-ID: <CAHk-=wiwhMFo6GFUAg3CZJMix4TJo59NBaSDciQxW23RHR8Zbg@mail.gmail.com>
Subject: Re: [GIT pull] core/urgent for v5.4-rc7
To:     Joe Perches <joe@perches.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jslaby@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 2:01 PM Joe Perches <joe@perches.com> wrote:
>
> trivia:
>
> This idiom '!!(logical test)' is odd and redundant.
> Logical test result is already 0 or 1, no !! is unnecessary.

You are of course correct.

I have to say, I personally have always disliked the idiomatic C "!!"
pattern. I don't think it reads well, although that's probably "C
cultural" - once you are used to the pattern, you don't think of it as
anything else.

Personally, I prefer "x != 0" over "!!x" since it reads much better to
a human, and is equally legible whether you're used to the !! pattern
or not.

C is not perl, the Obfuscated C contest not-withstanding.

And since modern C has bool, if you really want to use a cast-to-bool
instead of "x != 0", I think doing exactly that is preferable to "!!".

So I think both "x != 0" and "(bool)x" are preferable to "!!x", and
would also have made it obvious how odd and redundant the test was in
this case.

But "!!x" is shorter, of course. And it you learnt C with that pattern
it looks obvious.

                Linus
