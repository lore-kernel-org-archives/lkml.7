Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85351C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5683C23427
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567180151;
	bh=4vQmxNXvlIak9YxKz5wpPcEtHy6GO8FyVXU4QIA5ryo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jZ1CbJojCELdnIQ+JVCCqmAf+P4D66lqouYqh8jrGflf4oDb/PGZBAD9PAuvhdxzt
	 xposOFaLoAMZA446erg12l6jasC7ge8phulWB6gv0lbKjj91bMbx2ZSYC6fcZCVt9f
	 QvFcEzYM8YbpaE4/qUP7g4f+1RDZSUSxSBpTu5aU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfH3PtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:49:10 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46963 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbfH3PtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:49:10 -0400
Received: by mail-lf1-f67.google.com with SMTP id n19so5670481lfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 08:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vxocWBxPoSE7XWEgraDs2g3LtET7UTFJLMjvpVmaI8A=;
        b=TqP98Es77k0/+rmmz3Uc6wMjpz2tzkZWjHrSzsSBeBrfuUyZCOzu0EHDKBLcDbkhDy
         nUVmu9IOeafqbIRFVnLQ+x4s8ZIULtIlYgs6y9oYYYKUxEfSnMP5R09XMsNMjgKkfslw
         9YGKytetf9RH2e53eyPma+gAp9CBNVGWeh/80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vxocWBxPoSE7XWEgraDs2g3LtET7UTFJLMjvpVmaI8A=;
        b=Ao8olDubPpupDb5ZsdLEj7vCUywJjIqQm6vDZ258ITlTodHWnjrdWovI/Zn0aSqt7f
         0slg4Ldq7NNcmlBmcwFF+GtwsIqLEkMjS1LzDlZPfm6RHeuTTJPiyK3CJNPM0ZYTj7Us
         e/kbcpDCEPDy8qm2atKLP+gJ7bo1JPSo8w1MAXpZe7EN6UXHUG8dHB+j6LqfyGSu4C0M
         emkNn6Zs6+FvaBCreQfEj8DLQPCXeT5AcUx/HkZOpOmNiExvWu4xJ2ClgBPwyUjLQC6x
         R1WGIh1ziiTHP2cMhl0cYjHL7Dx1MrYydT5+Wy9locqch9mW2cZD7i+yg92DexqvDBP6
         T3qw==
X-Gm-Message-State: APjAAAUXDPBEhEvktcKR+dZbWoPyT3UHcXsI34RKzCJMlxvkN2XxRMAD
        LK8ZuKkCmctb1EnCDF9t+JDtxRCWOkU=
X-Google-Smtp-Source: APXvYqy5TXeX82wjdwJ6N9qKZGbQiAdOgRf+Asq2aBm4MYvEeFYTG6VHjrXTzHIWrdfux4eXRctX+w==
X-Received: by 2002:ac2:53a3:: with SMTP id j3mr4791419lfh.155.1567180148071;
        Fri, 30 Aug 2019 08:49:08 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id s7sm900079lji.26.2019.08.30.08.49.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2019 08:49:06 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id l11so5717415lfk.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 08:49:06 -0700 (PDT)
X-Received: by 2002:ac2:5976:: with SMTP id h22mr2633464lfp.79.1567180145802;
 Fri, 30 Aug 2019 08:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
 <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com>
 <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
 <CAK8P3a0bY9QfamCveE3P4H+Nrs1e6CTqWVgiY+MCd9hJmgMQZg@mail.gmail.com>
 <20190828152226.r6pl64ij5kol6d4p@treble> <CAK8P3a2ATzqRSqVeeKNswLU74+bjvwK_GmG0=jbMymVaSp2ysw@mail.gmail.com>
 <20190829173458.skttfjlulbiz5s25@treble> <CAHk-=wi-epJZfBHDbKKDZ64us7WkF=LpUfhvYBmZSteO8Q0RAg@mail.gmail.com>
 <CAK8P3a1K5HgfACmJXr4dTTwDJFz5BeSCCa3RQWYbXGE-2q4TJQ@mail.gmail.com>
 <CAHk-=whuUdqrh2=LLNfRiW6oadx0zzGVkvqyx_O1cGLa2U6Jjg@mail.gmail.com> <20190830150208.jyk7tfzznqimc6ow@treble>
In-Reply-To: <20190830150208.jyk7tfzznqimc6ow@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Aug 2019 08:48:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqAcRU99Dp20+ZAux7Mdgbnw5deOguwOjdCJY0eNnSkA@mail.gmail.com>
Message-ID: <CAHk-=wgqAcRU99Dp20+ZAux7Mdgbnw5deOguwOjdCJY0eNnSkA@mail.gmail.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 8:02 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> For KASAN, the Clang threshold for inserting memset() is *2* consecutive
> writes instead of 17.  Isn't that likely to cause tearing-related
> surprises?

Tearing isn't likely to be a problem.

It's not like memcpy() does byte-by-byte copies. If you pass it a
word-aligned pointer, it will do word-aligned accesses simply for
performance reasons.

Even on x86, where we use "rep movsb", we (a) tend to disable it for
small copies and (b) it turns out that microcode that does the
optimized movsb (which is the only case we use it) probably ends up
doing atomic things anyway. Note the "probably". I don't have
microcode source code, but there are other indications like "we know
it doesn't take interrupts on a byte-per-byte level, only on the
cacheline level".

So it's probably not an issue from a tearing standpoint - but it
worries me because of "this has to be a leaf function" kind of issues
where we may be using individual stores on purpose. We do have things
like that.

               Linus
