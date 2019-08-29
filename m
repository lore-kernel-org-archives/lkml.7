Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE560C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9526C205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567103462;
	bh=0LnZeMG6knH5fJnwLZBQ4lURggHyWEed77onBeWolWU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=E5uamQIkvfsnERvOT3CNeMO8OvV4Ly+nB0Kte78q0tuwsgEqKwNl9opcX3uxPb87j
	 cw6/4uvN4pUbORPTOQKRa3QPOO9bLv2fNPyPVT2Anv5bxmH9JEMW9K8adbPHsTbjrP
	 plyc3Auxouw8AbWDUR4SBVd7OxMtO12o8n3ifrng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfH2SbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:31:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46499 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbfH2Sa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:30:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id f9so3948764ljc.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 11:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eLRCb7IDKwd9Z6eMXVFq9v2wg3nX4xhHUDMDC8KHnII=;
        b=ZYz0cIUb+Hnsqfj21oaOtiMXKftE8tiZCwkI+a8OgXA14ybCS+TstFfOHohtgYjxb4
         X9BwLzRbJp0E0A5C/fzTZ2XHtEShrWZ162MaPs7BfgO3M3AhQtB2AiNlDwrKmDKoUgFj
         c+JdW3zKKsbnWhifytf6wYLJDrrLKpmbtWlqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eLRCb7IDKwd9Z6eMXVFq9v2wg3nX4xhHUDMDC8KHnII=;
        b=Xud0ON19hkrcJ9rso7QKYBGp7toLA/SrVkWNopEhWyJb4V67WL9Yq//AI9mSVNTZDv
         Ovov3UKG+uCXV1AFMCgcHPkIzX0VHXU++Z6WXkMjZjsKj98xwTAn7mvbblsCTz4t1CwY
         1Cs1zbyl6mwse1zL8bmMCeXDsDH0FHJgDWAfT/rYKk/wgyKebvNcq3jIKuSrVu72h4Rn
         rGQYgxAW8D2peMor6MqGbWNvChIPj97H98/XPlKv5u6ocLoqiZiYStm7OS12uS+90y8W
         2BkdB/IhRqnLItlSGXK9FqBIV7hhjT1wErwo5ME6RZZ/h+YaMEzDOUvAba7yUmz9/xi3
         XHWw==
X-Gm-Message-State: APjAAAWh/KyWTGTZqF7fL76mbGvJTC73/IeRfesVxpZIbbRtXKRih0Xl
        YYq+xVSCQ7Qgtoc9JztQ+VNCT3Ttok4=
X-Google-Smtp-Source: APXvYqzBg8LqXZGB+1HDmPaNvpuER07HPDjaq5LW0xRBgiDIlcGMw6iLTfyV84LfSJ4eAwXaRWft2Q==
X-Received: by 2002:a2e:9b13:: with SMTP id u19mr6495561lji.40.1567103453758;
        Thu, 29 Aug 2019 11:30:53 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id s20sm469475ljg.88.2019.08.29.11.30.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 11:30:52 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id f9so3948599ljc.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 11:30:52 -0700 (PDT)
X-Received: by 2002:a05:651c:1104:: with SMTP id d4mr6182276ljo.90.1567103452117;
 Thu, 29 Aug 2019 11:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190827145102.p7lmkpytf3mngxbj@treble> <CAHFW8PRsmmCR6TWoXpQ9gyTA7azX9YOerPErCMggcQX-=fAqng@mail.gmail.com>
 <CAK8P3a2TeaMc_tWzzjuqO-eQjZwJdpbR1yH8yzSQbbVKdWCwSg@mail.gmail.com>
 <20190827192255.wbyn732llzckmqmq@treble> <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
 <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com>
 <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
 <CAK8P3a0bY9QfamCveE3P4H+Nrs1e6CTqWVgiY+MCd9hJmgMQZg@mail.gmail.com>
 <20190828152226.r6pl64ij5kol6d4p@treble> <CAK8P3a2ATzqRSqVeeKNswLU74+bjvwK_GmG0=jbMymVaSp2ysw@mail.gmail.com>
 <20190829173458.skttfjlulbiz5s25@treble>
In-Reply-To: <20190829173458.skttfjlulbiz5s25@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Aug 2019 11:30:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi-epJZfBHDbKKDZ64us7WkF=LpUfhvYBmZSteO8Q0RAg@mail.gmail.com>
Message-ID: <CAHk-=wi-epJZfBHDbKKDZ64us7WkF=LpUfhvYBmZSteO8Q0RAg@mail.gmail.com>
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

On Thu, Aug 29, 2019 at 10:35 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Peter suggested to try WRITE_ONCE for the two zero writes to see if that
> "fixes" it.

I'm sure it "fixes" it.

.. and then where else will we hit this?

It's one thing to turn a structure zeroing into "memset()", but some
places really can't do it.

We use "-ffreestanding" in some places to make sure that gcc doesn't
start calling random libc routines. I wonder if we need to make it a
general rule that it's done unconditionally.

Sadly, I think that ends up also disabling things like
"__builtin_memcpy()" and friends. Which we _do_ want to have access
to, because then gcc can inline the memcpy() when we _do_ use
memcpy().

We used to do all of those heuristics by hand, but wanted to let the
compiler do them for us.

So:

 - we do want "memcpy()" to become "__builtin_memcpy()" which can then
be optimized to either individual inlined assignments _or_ to an
out-of-line call to memcpy().

 - we do *not* want individual assignments to be randomly turned into
memset/memcpy(), because of various different reasons (including
function tracing, but also store tearing, yadda yadda)

Conceptually, "-ffreestanding" is definitely what a kernel needs, but
it has been *too* big of a hammer and disables real code generation,
iirc.

             Linus
