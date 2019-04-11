Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBD3C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A822073F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="swR2B25q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfDKT4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:56:11 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:35944 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfDKT4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:56:11 -0400
Received: by mail-ot1-f53.google.com with SMTP id o74so6357788ota.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 12:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Qir9wvkA8qfxST45YQXEIhp3CE+ItIlUgOK81B0/Gc=;
        b=swR2B25qXIX+13VeCNlMuQp29DLizmajdL6xn11YexB4kmAcMtJ9Nsnzg5WqYkSK9x
         1xzwn+DP8cEmGebjW1EGJ95dJIyeW2HEDxr3OppGf/eM9aSY2075vIPn29rK4KLqE90J
         lkp1Z2tx0LTpGnXVIyHISUBgSmzZSegLYgfnjuNRk5+rt8Ann9BR/AKjj8Pd2jEbEGlH
         EXNZYP6qKIFwv9hbYiaFajd3+SbKPwcqQ2yzHPSdM5u0BsIowillBjBQhgxNmjJ1PRtd
         O0SQAuE62npYE9ulebHxEzi95KIjadrt35asKsyTG9TFbpONnNDwb+x3S6wSXbjZWjtm
         KxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Qir9wvkA8qfxST45YQXEIhp3CE+ItIlUgOK81B0/Gc=;
        b=EnNyfSp886vZ+Ee8n2CZ+Qc9binBcnJXVEHbQLbKZ7g0QqyZq2bdVhY605qI7c0vwA
         y1W/UrO/2XXf+hXl9de0f4MQkP+BK18EkSpGCdrDRVpkxWCerPyOx8lnvdJxOnxX6I5r
         oZQ8cZ0RkyDLOOO2YSlnYtWfOKOgLZvkUhgzgmpyK+BFJI+j30KZKdeMOSlsnrI+0F1r
         6ZHIxBmr2DR9dG4TbDxWcn6DeYpG9q4tRajCj9wDzYu+t/l1Hvo1iBGp0arph/ZIOSbn
         Vg2smxVHA5zRMGkANs1URGO/H5ojKOgimLZzFy6zvV8NiJUcKigP6PfjIOn8RdaUWa0f
         iu0A==
X-Gm-Message-State: APjAAAVPlVHLxgXg0q2pWtdciK3PfGI/PlvZwzxdd4D+BG/jrXiJzez/
        /X0+i2KmSsblz0ylJ3SUiQ4VJXMZ5NbERoGjvRo1aw==
X-Google-Smtp-Source: APXvYqzLEBpJZXnJgHwMNYalkM7Q5Sdvf7ShgV7ehBrDnhE1eVMH8FoZ0zwa3zk/fHApCW6CNgAiqtZaAEjD/rEMGmA=
X-Received: by 2002:a05:6830:1cb:: with SMTP id r11mr28711652ota.302.1555012570762;
 Thu, 11 Apr 2019 12:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <1050734985.2625.1554838340011.JavaMail.zimbra@efficios.com>
 <1933578130.3292.1554928159928.JavaMail.zimbra@efficios.com>
 <20190411164219.GE29081@fuggles.cambridge.arm.com> <1469455003.811.1555005112414.JavaMail.zimbra@efficios.com>
In-Reply-To: <1469455003.811.1555005112414.JavaMail.zimbra@efficios.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Thu, 11 Apr 2019 20:55:59 +0100
Message-ID: <CAFEAcA849mmSds9euyvR2uLWqEeA2eedkmcq1O4pT6-S0oK8BA@mail.gmail.com>
Subject: Re: rseq/arm32: choosing rseq code signature
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        carlos <carlos@redhat.com>,
        richard earnshaw <richard.earnshaw@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019 at 18:51, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> ----- On Apr 11, 2019, at 12:42 PM, Will Deacon will.deacon@arm.com wrote:
> > Peter suggests that anything of the form 0xe7fxdefx should trap in both A32
> > and T32, although it does assemble to UDF; B <imm11> in T16. I'm not sure we
> > should get too obsessed with trying to encode a signature that universally
> > decodes to a trap.
>
> That's a nice trick.
>
> >
> > Whatever you choose, it would be worth checking that it doesn't clash with
> > other allocations such as software breakpoints in GDB.
>
> GDB seems to have [1] :
>
> #define ARM_LE_BREAKPOINT {0xFE,0xDE,0xFF,0xE7}
> #define ARM_BE_BREAKPOINT {0xE7,0xFF,0xDE,0xFE}
> #define THUMB_LE_BREAKPOINT {0xbe,0xbe}
> #define THUMB_BE_BREAKPOINT {0xbe,0xbe}
>
> None of which match the value you hint at.

Hmm? The ARM BPs match 0xe7fxdefx when considered with
the appropriate endianness (clearly somebody has
been down this line of thought before). Still, as long as
we pick different values for the 8 bits of freedom we
have it should be fine.

> /*
>  * RSEQ_SIG uses the udf A32 instruction with an uncommon immediate operand
>  * value 0x5de3. This traps if user-space reaches this instruction by mistake,
>  * and the uncommon operand ensures the kernel does not move the instruction
>  * pointer to attacker-controlled code on rseq abort.
>  *
>  * The instruction pattern in the A32 instruction set is:
>  *
>  * e7f5def3    udf    #24035    ; 0x5de3
>  *
>  * This translates to the following instruction pattern in the T16 instruction
>  * set:
>  *
>  * little endian:
>  * def3        udf    #243      ; 0xf3
>  * e7f5        b.n    <7f5>
>  *
>  * big endian:
>  * e7f5        b.n    <7f5>
>  * def3        udf    #243      ; 0xf3

Do we really care about big-endian instruction-ordering for Thumb?
It requires (AIUI) either an ARMv7R CPU which implements and sets
SCTLR.IE to 1, or a v6-or-earlier CPU using BE32, and it's going to
be even rarer than normal BE8 big-endian...

thanks
-- PMM
