Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B6AC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB7E20578
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567103260;
	bh=we7KckTm+j4Cc51iviJxojOHx/u9G4fufbIVvDGHqcM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DhdX/JOdgBWXjSlGHtukyCeJE/F043SsWuQtBQcRsteJica7EWXUlYDl8bkbWRFuA
	 0+lwOzDK/POicTlD+8lnc+62zgARZkZEoQiOrGs1opLo+jstmR7RqsFMcpvusQr7Jx
	 180bOP/IFQkr9Yf4q6YrRhHEFRXlPxPCeteZOSYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfH2SP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:15:26 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35161 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbfH2SPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:15:23 -0400
Received: by mail-lj1-f196.google.com with SMTP id l14so3981612lje.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 11:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sR4WCPDuQLUM49jwD7zWV6jQzPdEIbVdaFJBv2+v+F0=;
        b=Q27etNQqJrho/WpWtWPyEAO7C4sggphAGNNoPYTYaIC0X/UeOTUTQWxOsNwlS4xe50
         2b21/BhdLQUe9h96f0Z0sa4Y1711aLD93dPnpdbpcUVoXOasM4Utub1mmX1zt4poyHjI
         VwSryBYXrojk5fEf95B7u+sWDd/hndAfWy1RA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sR4WCPDuQLUM49jwD7zWV6jQzPdEIbVdaFJBv2+v+F0=;
        b=TTRulBbYzYBE3f6jS0lK6tGwwTc+w229p5/fiN8T/ixz1ndcQ1RA96M9DRPznWRPIe
         BgBlXpyuyN7tyh5iP2Y/yLt0R6KskPFcjwqhEJf2XpVd7//TK3P1lN5B3o4ua3lrjk6H
         0e1TdhwGvK5Ls7PFlcWzhUym4BKRMKrZyEayQHTtSSKuLzHkGC/NHYm3dgxJxqkv3YAZ
         SImBXCEKJbNF2JV2+nZWf0XEYMEiC+8GRqVfh4UsmKCq5qf0IUDYHB7xcxhdh5cyIqj5
         OoVSvTEuPz++MmrFpNvh53qOLwGIY6ffdh5ZEzcVpzsg89gXRllVrCxOPbWzHVthNvup
         yPug==
X-Gm-Message-State: APjAAAWWwr7LTAUw7iCGHPmhpMSaCDU5Gvrq+Uo+F1WsOIEnh8Otp0lS
        q2Sn3m4bJNOdFTTKu45Ds15LYgC195Q=
X-Google-Smtp-Source: APXvYqy26zhl3O9gTOC3PBQDYxzlWPRXO0OeV/DnmK8pYOYNwQzAwftRPappkTlThufIWdLRrnpAGg==
X-Received: by 2002:a2e:988c:: with SMTP id b12mr889383ljj.212.1567102521341;
        Thu, 29 Aug 2019 11:15:21 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id f23sm453525lja.25.2019.08.29.11.15.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 11:15:20 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id e27so3946692ljb.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 11:15:20 -0700 (PDT)
X-Received: by 2002:a2e:8ed5:: with SMTP id e21mr6415604ljl.156.1567102520069;
 Thu, 29 Aug 2019 11:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk> <CAKwvOdnUXiX_cAUTSpqgYJTUERoRF-=3LfaydvwBWC6HtzfEdg@mail.gmail.com>
In-Reply-To: <CAKwvOdnUXiX_cAUTSpqgYJTUERoRF-=3LfaydvwBWC6HtzfEdg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Aug 2019 11:15:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZ7Ge8QUkkSZLCfJBsHRsre65DkfTyZ2Kt5VPwa=dkuA@mail.gmail.com>
Message-ID: <CAHk-=wgZ7Ge8QUkkSZLCfJBsHRsre65DkfTyZ2Kt5VPwa=dkuA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] make use of gcc 9's "asm inline()"
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 10:36 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> I'm curious what "the size of the asm" means, and how it differs
> precisely from "how many instructions GCC thinks it is."  I would
> think those are one and the same?  Or maybe "the size of the asm"
> means the size in bytes when assembled to machine code, as opposed to
> the count of assembly instructions?

The problem is that we do different sections in the inline asm, and
the instruction counts are completely bogus as a result.

The actual instruction in the code stream may be just a single
instruction. But the out-of-line sections can be multiple instructions
and/or a data section that contains exception information.

So we want the asm inlined, because the _inline_ part (and the hot
instruction) is small, even though the asm technically maybe generates
many more bytes of additional data.

The worst offenders for this tend to be

 - various exception tables for user accesses etc

 - "alternatives" where we list two or more different asm alternatives
and then pick the right one at boot time depending on CPU ID flags

 - "BUG_ON()" instructions where there's a "ud2" instruction and
various data annotations going with it

so gcc may be "technically correct" that the inline asm statement
contains ten instructions or more, but the actual instruction _code_
footprint in the asm is likely just a single instruction or two.

The statement counting is also completely off by the fact that some of
the "statements" are assembler directives (ie the
".pushsection"/".popsection" lines etc). So some of it is that the
instruction counting is off, but the largest part is that it's just
not relevant to the code footprint in that function.

Un-inlining a function because it contains a single inline asm
instruction is not productive. Yes, it might result in a smaller
binary over-all (because all those other non-code sections do take up
some space), but it actually results in a bigger code footprint.

              Linus
