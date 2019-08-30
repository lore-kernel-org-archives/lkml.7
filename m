Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43FCC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CD42342B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567180887;
	bh=gPgp1hjhHWas4I6NCdE+YDoGfMazeYBDqeyL8HEZ+W4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GEW1kmBOJs4K1yMuctMkXMpH6a3HMEuaP4HO4fSC8bETQLR2OUSHc/3gpqxA2To/K
	 UllxJPvK/zQm2axxyhO1NIbcud85qLg97Wa5/O6+IqoMVLPa2wrfgEI4ylzOFyn24b
	 NthWgmnAtWhJF8LBiYSFrugReziWrWlNxIy2fY8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfH3QB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:01:26 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36857 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbfH3QBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:01:25 -0400
Received: by mail-lf1-f65.google.com with SMTP id r5so5757521lfc.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ltWuTNDx89MOEcanga9Bo5hPEURK5Z+mB3gG62hMcco=;
        b=T7kIPLTi34kEqIU+W+AIgKyQ3cuKZmqAdNQX/KNu2XeDo1WgbS93cnpFNBwutGK5p2
         q6GyVhWJmTzfknWgupPENqUN6Vyfh44pzGr3sIdf3y0uGx4drdwjD3gk0FUU40illTTn
         grTmkkR1K+OEzzErr3bXvKknTFp+ikAXpU/4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltWuTNDx89MOEcanga9Bo5hPEURK5Z+mB3gG62hMcco=;
        b=hbkJ8UFNExWV+BHQPK6mwdr36lzgVOCtvBdixpffwknZ4Wf67V6eWoCQirScGp1qH0
         We7BKQ6FJfRZfbDoCqCIaNdeiSlc1ULA3GNS7/ViBmlHhElr2pYv2V1q74oejLA8gazs
         o6GdByoe/+t6JUQuvhoOoTbG9DunyT/+y8ALIJ4PQFMbjv2d1CBH45qf4UDZSiP3B6K4
         xDDQoba9/OHBajJiRGSp3mnA6ag+sDPW90c5ZJ6JpIj7QlRXoAz+IG4pZ4tJ/jtd/oVA
         UEtxRHuYW2EXp4LrXndbzcttbHtXZIHNne/y4f3g5vKJsPi4fsZEUrbx4AgJifKxaK4N
         d+cw==
X-Gm-Message-State: APjAAAVFTOaPLpDgc4ILV1JI58kAjYVpVxrM+7lerXhJboqcSj7UOYiu
        O5OwNNK1Jdz7wxYZMmKOPbbcW2Ea+EU=
X-Google-Smtp-Source: APXvYqxrMqhr0TbpZ5Nt8a9ITee0a4TAMw2pa4CuP+P9ow5UwdaAcHuUiURmPQYLyhyiXdS42EYwYg==
X-Received: by 2002:a19:5218:: with SMTP id m24mr10085084lfb.164.1567180883534;
        Fri, 30 Aug 2019 09:01:23 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id m9sm1093347lfp.45.2019.08.30.09.01.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2019 09:01:22 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id u29so5720409lfk.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:01:22 -0700 (PDT)
X-Received: by 2002:ac2:4c12:: with SMTP id t18mr9983076lfq.134.1567180881892;
 Fri, 30 Aug 2019 09:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
 <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com>
 <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
 <CAK8P3a0bY9QfamCveE3P4H+Nrs1e6CTqWVgiY+MCd9hJmgMQZg@mail.gmail.com>
 <20190828152226.r6pl64ij5kol6d4p@treble> <CAK8P3a2ATzqRSqVeeKNswLU74+bjvwK_GmG0=jbMymVaSp2ysw@mail.gmail.com>
 <20190829173458.skttfjlulbiz5s25@treble> <CAHk-=wi-epJZfBHDbKKDZ64us7WkF=LpUfhvYBmZSteO8Q0RAg@mail.gmail.com>
 <CAK8P3a1K5HgfACmJXr4dTTwDJFz5BeSCCa3RQWYbXGE-2q4TJQ@mail.gmail.com>
 <CAHk-=whuUdqrh2=LLNfRiW6oadx0zzGVkvqyx_O1cGLa2U6Jjg@mail.gmail.com>
 <20190830150208.jyk7tfzznqimc6ow@treble> <CAHk-=wgqAcRU99Dp20+ZAux7Mdgbnw5deOguwOjdCJY0eNnSkA@mail.gmail.com>
 <d1af87f139b54346b420d06855297cfa@AcuMS.aculab.com>
In-Reply-To: <d1af87f139b54346b420d06855297cfa@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Aug 2019 09:01:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh33ouqv7UNovQn8WWXGA_kXEHDY3_H7x5-_j33AHYPwg@mail.gmail.com>
Message-ID: <CAHk-=wh33ouqv7UNovQn8WWXGA_kXEHDY3_H7x5-_j33AHYPwg@mail.gmail.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
To:     David Laight <David.Laight@aculab.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
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

On Fri, Aug 30, 2019 at 8:55 AM David Laight <David.Laight@aculab.com> wrote:
>
> Even in userspace you might be accessing mmap()ed PCIe device memory.
> The last thing you want is the compiler converting anything into
> 'rep movsb'.

Agreed, although for actual IO accesses you likely should really be
doing "volatile" anyway.

But yeah, in general it's just not obviously safe to turn individual
accesses into memset/memcpy. In contrast, the reverse is obviously
fine (and _required_ for any kind of half-way good performance when
you do small constant-sized memory copies, which is actually a common
pattern partly because the insane C aliasing rules have taught people
that it's the _only_ safe pattern in some situations).

This is why I think "-ffreestanding" and "-fno-builtin-memcpy" are
completely broken as-is: they are an all-or-nothing thing, they don't
understand that it's directional.

                 Linus
