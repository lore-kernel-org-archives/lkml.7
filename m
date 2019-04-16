Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54E6C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29AA2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W3oZFdzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfDPRea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:34:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46596 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPRe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:34:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id 9so10718784pfj.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 10:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fr+DUYGj0BFE/b0bL+NgRy30N3r6qhwncMT3DHk1FiY=;
        b=W3oZFdzVBg81OvqCQIa1CPu+9vgQFs4iBJ2n1CuQOlr5Ddom6oPQfZwGEO83GDUarx
         IBjYK+P/2hsnHxd+/VIq58dK3Jmimm197pSmxNGWfE+sWaRFufdYP+GA6jB01Sad7I0h
         o1SM1O8dBXVtVdNEVUZsxOw6KiCODHIOoYdOvC4h9tCr0FD8sqCQ14Wgw+7S9laDalJ1
         K/djcWR0Adp4s0iKbUvOcLilFAQzB2gqeoeeBHTS1q0ITtQ0JTH+NjvvH5UIWV5QQClI
         7o8NP2F7tnILZrT7RMd49vDHsV4hxkXpn+S2SZUhx6I4lYnN1vJP1uJlr/2aJo35VkL3
         Ro8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fr+DUYGj0BFE/b0bL+NgRy30N3r6qhwncMT3DHk1FiY=;
        b=gGRRLA89RGnuS9GEhspOWibvfMEYaAgnciby+2A1/6m36YkW7z2IdmLfHww4kVE9Md
         gXAVylmov/XyILa7uhLvAi71ljmeRNZ8duqmnofWd+kSQ+Ar30speUK6WgFnZgJnjncj
         x7NuVNa3wSM6mk3hJOLmRVDM7BL7w+1xjaJxgGrMS4MXReJfwWGxBWVI73ux7QJTHA8f
         yppufzzG90Up0RGO/Va6ziiznk2I1yJQdrgs6hx+cXDYMQ8AuobXCqXi+7RixHERlnut
         wuPhOPk584Djw/Tb2mcNdctDnUotWpsT1+dU73YXRCr3ZZk6MZpMG5x9cLLKdi8lL3x5
         uNqQ==
X-Gm-Message-State: APjAAAWge4vZVE+AeoI9P4Sb0NFTXvrcQZfGXhcqGQe2K9OKtH2VvpwU
        sIyVrSjqTQeUKHzod+9TptEWFQ/BSHalKCpM3h9h6g==
X-Google-Smtp-Source: APXvYqzUWg+jckORyNjcSsHjysCIhOCILFEcT27Zd2MdxiHcF6CzXRowd+qukc6roCxe2SSdLc+4ICbdpOUghYGeltw=
X-Received: by 2002:a62:448d:: with SMTP id m13mr84533774pfi.182.1555436068309;
 Tue, 16 Apr 2019 10:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190415143821.GA46880@beast> <20190415170604.GA44415@lakrids.cambridge.arm.com>
 <CAKwvOdk_jFQKW2C2=925So_dvZ6dm03AXMZ9Nk+O1J2xyhE2EA@mail.gmail.com> <20190416170808.GC54708@lakrids.cambridge.arm.com>
In-Reply-To: <20190416170808.GC54708@lakrids.cambridge.arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 16 Apr 2019 10:34:16 -0700
Message-ID: <CAKwvOd=7S3LECgK5murYLjs0=RBjPXo2xrfrPowg=rUE217XoA@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: sysreg: make mrs_s and msr_s macros work with
 Clang and LTO
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Alex Matveev <alxmtvv@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:08 AM Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Apr 15, 2019 at 10:22:27AM -0700, Nick Desaulniers wrote:
> > Also, I look forward to this patch for use of Clang's integrated
> > assembler (regardless of LTO).  I remember getting frustrated trying
> > to figure out how to resolve this for both assemblers, and I had
> > forgotten this solution existed.
>
> Is this the only blocker for the integrated assembler?

I don't have a good handle on the number of issues that clang's
integrated assembler has for arm64 kernels, but IIRC last time I
checked I think there were under 10.  It's my goal over the next
quarter to investigate and get bugs filed so we know the order of
magnitude of issues.  This particular issue was the trickier/trickiest
one.  Linaro also recently has added staffing to beef up Clang's
integrated assembler for arm32/arm64.

-- 
Thanks,
~Nick Desaulniers
