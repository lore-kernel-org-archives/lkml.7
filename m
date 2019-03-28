Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B83FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4C920811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553788135;
	bh=PSGYSOTFtZTq5rFyHmTQ179YhVGXpRo3uSmx26LapDM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DB2SjeNr0ozn9M70+onMm5os7oqy8AWuw54enMwVnloJINFYN4mGDxoZkTyuCAwdX
	 ZsFfkBksmHzkn0Gzth1E3OhRygECuRMmrOXOoANhDXH/lRdO9tfizRlE+NE1QbarS9
	 +miI/MovmzUOf7U55HYG1c9KwRc2Or4v2ae8jbuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfC1Psy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:48:54 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33973 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1Psx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:48:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id j89so18128695ljb.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 08:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vo++b97MtjKW6Z2ai3nHuw6ipPYXtam+djLDtD4oqbs=;
        b=CwCFxbkSM/vTcw8s9X4OQEk4bUDgHzdCzk9zUTTFGu5l+1y2uvKsLOUfOE18QOkKH3
         wblMOBuhkzua26OvZxWU/7bRTbidTstDyKOeFD1X1lyu8HWJA1zrGBNQhCdBvaGxu0CG
         Ian+hlP3NM/TWmnoejTNM0pf5KoRNseIgUbmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vo++b97MtjKW6Z2ai3nHuw6ipPYXtam+djLDtD4oqbs=;
        b=W4JPqGLCLuJ/1eNFs0DMEMvFejVGeNPyCUUwJ4u14BY3lYZHubvwSa/RBgsRFOprwd
         sL6tNXSIZ9i5hWrueyyoODgwPEcMw8yA5miDUwG2Glg4CfgrWmbS9eJ2g+8LRwi1pBvT
         YbkSjlGoJqd0lkLKhmC22zM9Lq+hSzUr/3zRuGHD/3vAY60YCIXQQIvnVfBE9EB1N8oU
         +zF+wgD9gjD0QtfjZ9VW5zQ4FOFSN9DTUQr3C2ZHpej4RgCNQff5qfyYvsTXd8d0Z/Ke
         wd4cpBqnkdJm4NPxm1fNDK5B5I3IAel5fWJ2DYjvcXq9+lFkR/m26LonX5Iss5H2s8ni
         3JZw==
X-Gm-Message-State: APjAAAVj2OGaTqQxA1Au3FMi9536vwWGsN7OeJU/6VWM69Iho/AqGtmL
        3IuKzZ1Hb883tvjsBAdJf4OFFD8CdgI=
X-Google-Smtp-Source: APXvYqxkBYZfPC7x3lGAzFs1bi2wpXJwOk94pphLLhOAIxK6n5AHo6I1O9kT7X3H1h7pRa01e8IxwQ==
X-Received: by 2002:a2e:8156:: with SMTP id t22mr14187646ljg.77.1553788130703;
        Thu, 28 Mar 2019 08:48:50 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id l21sm5056556lfh.30.2019.03.28.08.48.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 08:48:49 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id h16so13621458ljg.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 08:48:49 -0700 (PDT)
X-Received: by 2002:a2e:8149:: with SMTP id t9mr23507278ljg.2.1553788128992;
 Thu, 28 Mar 2019 08:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190228185027.2480-1-ben.dooks@codethink.co.uk> <20190328072421.GA22720@zn.tnic>
In-Reply-To: <20190328072421.GA22720@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Mar 2019 08:48:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjmxbtceHNbFycT5t=C56B+huPBewWbV5waaY7i09RBQ@mail.gmail.com>
Message-ID: <CAHk-=whjmxbtceHNbFycT5t=C56B+huPBewWbV5waaY7i09RBQ@mail.gmail.com>
Subject: Re: [PATCH] x86/asm: add __user on copy_user_handle_tail() pointers
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.co>, Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-kernel@lists.codethink.co.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 12:24 AM Borislav Petkov <bp@alien8.de> wrote:
>
> Well, but copy_user_generic() (which ends up calling the
> copy_user_handle_tail() eventually) casts those __user pointers to
> (__force void *). Converting them back to __user looks strange to me.
>
> Linus?

Well, it does that because the x86 version of copy_user_generic() can
work in either direction, so it works when either the source or
destination (or both) are user pointers, but they don't _have_ to be.

So the "userness" of a pointer in that context is a bit ambiguous, and
so we've picked the pointers to be just plain "void *".

That said, arguably we should have gone the other way and just made
them both "__user" pointers, and do the cast the other way around.

But there's no absolutely right answer here, and nobody should ever
use copy_user_generic() directly (ie it is very much meant to be only
used as a internal helper for the cases that get the pointer
annotations right).

I do think Ben's patch is probably the right thing to do.

And we could do the same thing to copy_user_generic(), but that would
require switching the casts around in the callers, so may not be worth
the noise.

                      Linus
