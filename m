Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8F3FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8D721A49
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFNgX47+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436649AbfJPSzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 14:55:04 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44770 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436638AbfJPSzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 14:55:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id u40so37643072qth.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 11:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=215ZBerRTMMvl/Ijng0HKjRnsXOqsXt0a9H0WhV1Gdk=;
        b=dFNgX47+yn5y5aSzyG5fvds+4iZz2ZVcygnhlO/TFDDGxgLapBFuqKVnexxrntaUr6
         fiArRNNdIKP4qK0Em+wCpsO75GsiMqBVV2DOdMCJz/1/pbRGFwINU0uKinfUqZdP1dGA
         FTGEllIAVag49z4efR4OkmnHckUoM1s2tfLLmYpLFwTdT3UVM/CS/AXXtX4q/EmM+SfZ
         VD8kR+1rc5bBqhBBsvzXqjeTkZm41brj1KB7Kdq8Zjip2e08o4AhrWjzBYN2ciQyLFqo
         q2AiPBEozgmUXBPJJsk+ibrR99Pi9LjlcJZN44/zk8ZeQg48UJsSIEzg+OAsZXlwVHLA
         aV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=215ZBerRTMMvl/Ijng0HKjRnsXOqsXt0a9H0WhV1Gdk=;
        b=LBX6GyjZbfMYAtNmGzsodtfazBpX3g5gK5mtYVln5kdPwv1+qSZT6UXu1y8lLSEAHi
         R+Ky86wCSnXTAiRT+tKX85as7JDZm9rPDsmCJtjeX5yZ+xPThCWThePs1qVIA+s2kC/l
         VvpJhWhZ1XB6B8HtK3DufxqfAluqLn2b7UhjZDkZTxF/7d2w6GjN9w4UAXm1ctEA1ZKO
         PeN2dRQK3Yc0si7dAnxodHcppOGlO4DGJ/PDcAAtmKqJHFArNEQ/Q1OrJPTQadnjaDpr
         f8KWrh2ZxQ2W9bzsH9pcQoCTP4loYHFmAIAGDh5TbLoId9hLUTdInPWofpZTL5FW8bQN
         KH0g==
X-Gm-Message-State: APjAAAWfIQxtluc5WoRdXNpCVhg8zuwpBbJQ7w3+SYHdy9X+Z4i80s67
        Gg9Ob/YLowjRtTS0fkAA7Aw=
X-Google-Smtp-Source: APXvYqxzTERqBQzFzqsZvJZcXfJfiW/6hYpbVzuLshfRe9ZdrNWNNzJxc2ZlnwryCz/df2jpkY8Hqg==
X-Received: by 2002:a0c:f787:: with SMTP id s7mr43874485qvn.221.1571252102649;
        Wed, 16 Oct 2019 11:55:02 -0700 (PDT)
Received: from rani ([2001:470:1f07:5f3:9e5c:8eff:fe50:ac29])
        by smtp.gmail.com with ESMTPSA id z6sm11165855qkf.125.2019.10.16.11.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 11:55:02 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani>
Date:   Wed, 16 Oct 2019 14:55:00 -0400
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Arnd Bergmann <arnd@arndb.de>, "S, Shirish" <sshankar@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "yshuiv7@gmail.com" <yshuiv7@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Matthias Kaehlcke <mka@google.com>,
        "S, Shirish" <Shirish.S@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: AMDGPU and 16B stack alignment
Message-ID: <20191016185500.GA2674383@rani>
References: <CAKwvOdnDVe-dahZGnRtzMrx-AH_C+2Lf20qjFQHNtn9xh=Okzw@mail.gmail.com>
 <9e4d6378-5032-8521-13a9-d9d9519d07de@amd.com>
 <CAK8P3a3_Q15hKT=gyupb0FrPX1xV3tEBpVaYy1LF0kMUj2u8hw@mail.gmail.com>
 <CAKwvOdnLxm_tZ_qR1D-BE64Z3QaMC2h79ooobdRVAzmCD_2_Sg@mail.gmail.com>
 <20191015202636.GA1671072@rani>
 <CAKwvOd=yGXMwdoxKCD2gcEgevozf41jVmqCkW7CU=Xvd7mqtjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOd=yGXMwdoxKCD2gcEgevozf41jVmqCkW7CU=Xvd7mqtjw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 06:51:26PM -0700, Nick Desaulniers wrote:
> On Tue, Oct 15, 2019 at 1:26 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Tue, Oct 15, 2019 at 11:05:56AM -0700, Nick Desaulniers wrote:
> > > Hmmm...I would have liked to remove it outright, as it is an ABI
> > > mismatch that is likely to result in instability and non-fun-to-debug
> > > runtime issues in the future.  I suspect my patch does work for GCC
> > > 7.1+.  The question is: Do we want to either:
> > > 1. mark AMDGPU broken for GCC < 7.1, or
> > > 2. continue supporting it via stack alignment mismatch?
> > >
> > > 2 is brittle, and may break at any point in the future, but if it's
> > > working for someone it does make me feel bad to outright disable it.
> > > What I'd image 2 looks like is (psuedo code in a Makefile):
> > >
> > > if CC_IS_GCC && GCC_VERSION < 7.1:
> > >   set stack alignment to 16B and hope for the best
> > >
> > > So my diff would be amended to keep the stack alignment flags, but
> > > only to support GCC < 7.1.  And that assumes my change compiles with
> > > GCC 7.1+. (Looks like it does for me locally with GCC 8.3, but I would
> > > feel even more confident if someone with hardware to test on and GCC
> > > 7.1+ could boot test).
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
> >
> > If we do keep it, would adding -mstackrealign make it more robust?
> > That's simple and will only add the alignment to functions that require
> > 16-byte alignment (at least on gcc).
> 
> I think there's also `-mincoming-stack-boundary=`.
> https://github.com/ClangBuiltLinux/linux/issues/735#issuecomment-540038017

Yes, but -mstackrealign looks like it's supported by clang as well.
> 
> >
> > Alternative is to use
> > __attribute__((force_align_arg_pointer)) on functions that might be
> > called from 8-byte-aligned code.
> 
> Which is hard to automate and easy to forget.  Likely a large diff to fix today.

Right, this is a no-go, esp to just fix old compilers.
> 
> >
> > It looks like -mstackrealign should work from gcc 5.3 onwards.
> 
> The kernel would generally like to support GCC 4.9+.
> 
> There's plenty of different ways to keep layering on duct tape and
> bailing wire to support differing ABIs, but that's just adding
> technical debt that will have to be repaid one day.  That's why the
> cleanest solution IMO is mark the driver broken for old toolchains,
> and use a code-base-consistent stack alignment.  Bending over
> backwards to support old toolchains means accepting stack alignment
> mismatches, which is in the "unspecified behavior" ring of the
> "undefined behavior" Venn diagram.  I have the same opinion on relying
> on explicitly undefined behavior.
> 
> I'll send patches for fixing up Clang, but please consider my strong
> advice to generally avoid stack alignment mismatches, regardless of
> compiler.
> --
> Thanks,
> ~Nick Desaulniers

What I suggested was in reference to your proposal for dropping the
-mpreferred-stack-boundary=4 for modern compilers, but keeping it for
<7.1. -mstackrealign would at least let 5.3 onwards be less likely to
break (and it doesn't error before then, I think it just doesn't
actually do anything, so no worse than now at least).

Simply dropping support for <7.1 would be cleanest, yes, but it sounds
like people don't want to go that far.
