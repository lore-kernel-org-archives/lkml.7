Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9922EC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D51020842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGysDeQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389324AbfIFPOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:14:07 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40540 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbfIFPOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:14:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id u29so5339740lfk.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 08:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N+hd4ikAg0UpVVUG6qz74A3chZejVQifX4eNqPKApKc=;
        b=aGysDeQkqqUsNV8borziuung6bBqJ0Mo1pKcZHsg1ADcDuLf/EPmdB3gVcOdlmro8+
         Mh1H6+T+aYc9JvScsE/vioBmdPyoN9PXS3mUkWQIGddKEpMti2iFp+yndaqboM4hYA8k
         TrJbP6yz9lHlah3hRm8Q5j3yUQV7Afu1O0UHQ4jl6/3lYNrImddnELOHoetKtPK+Nd7u
         r07Wc9izwlOecsxRaHzmu/29cas/6kqp5peyHHvtK2hajmPCw5qmjWVDr7WUSzWvA8yL
         1ziR0vTTSEIcMWoYDOi5FOGfY06V/77neH0pWZwGL2AcyVXMuPLWFG+vWSv3jgFWfn/6
         //2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+hd4ikAg0UpVVUG6qz74A3chZejVQifX4eNqPKApKc=;
        b=D3fKgNo5T6818ar5yfKTBpTYQP002kFqXgIHR9RTVrzF2RUT0kPaju0muhVjYS0Gss
         tPiIy6geN6YS8o0XW4sVT78ff7yazLCxpPxy+QG9SKX0mHZcVH1IJ9JQ15Ec0NDzjWdP
         6u3uFImn0ajG2sQAgBVgafcRX/43yWe72hMF8bwg7DCAY40LdWByCDS1QrVbk0ne4ZJv
         Jdz0UCjpOSH/IeU0NqXjB1YVCHYU2VeH5mgea/Imn3ZR1bJZYv9mNGrHTqiGYNtDFDie
         FbWnozSAW0CRwzevdC1GvbEj9ioln1lVWT04uVrHaDHQ397jHhz8hlw5OshR30GHuuo6
         6ukQ==
X-Gm-Message-State: APjAAAXw4yMcW57la+FKDzrPOwuCrAV5UHMWCn8DiL4FT5y6Ft/ZvsCr
        PPnGxKlULKwZ7X78z7mq5e37mk3BYb5A+DbgEfc=
X-Google-Smtp-Source: APXvYqyi0p+qM+d7HsVcT3pTYX01Zc9ci7D4z1XblSdvz4NX2dBopTRsTc5Uj/vtBd64msGIMmyMYZATds+lqONrIiA=
X-Received: by 2002:ac2:568c:: with SMTP id 12mr6580937lfr.133.1567782845460;
 Fri, 06 Sep 2019 08:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-1-linux@rasmusvillemoes.dk> <20190830231527.22304-5-linux@rasmusvillemoes.dk>
 <CAKwvOdktYpMH8WnEQwNE2JJdKn4w0CHv3L=YHkqU2JzQ6Qwkew@mail.gmail.com>
 <a5085133-33da-6c13-6953-d18cbc6ad3f5@rasmusvillemoes.dk> <20190905134535.GP9749@gate.crashing.org>
 <CANiq72nXXBgwKcs36R+uau2o1YypfSFKAYWV2xmcRZgz8LRQww@mail.gmail.com> <20190906122349.GZ9749@gate.crashing.org>
In-Reply-To: <20190906122349.GZ9749@gate.crashing.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 6 Sep 2019 17:13:54 +0200
Message-ID: <CANiq72=3Vz-_6ctEzDQgTA44jmfSn_XZTS8wP1GHgm31Xm8ECw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] compiler-gcc.h: add asm_inline definition
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 2:23 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> I can't find anything with "feature" and "macros" in the C++ standard,
> it's "predefined macros" there I guess?  In C, it is also "predefined
> macros" in general, and there is "conditional feature macros".

They are introduced in C++20, but they have been added for a lot of
older features in both the language (see [cpp.predefined]p1, around 50
of them) and the library (see [support.limits.general]p3, ~100):

    http://eel.is/c++draft/cpp.predefined#tab:cpp.predefined.ft
    http://eel.is/c++draft/support.limits#tab:support.ft

> Sure.  But the name is traditional, many decades old, it predates glibc.
> Using an established name to mean pretty much the opposite of what it
> normally does is a bit confusing, never mind if that usage makes much
> sense ;-)

Agreed on principle :-) However, I wouldn't say it is the opposite. I
would say they are the same, but from different perspectives: one says
"I want to test if the user enabled the feature", the other says "I
want to test if the vendor implemented the feature". Which is fine,
but for users the meaning is inverted as you say: in the first case
they want to say "I want to enable this feature in this library" --
they don't want to "test" anything. And since most people will be
users, not vendors writing standard libraries, I think the user
perspective would have been better.

Cheers,
Miguel
