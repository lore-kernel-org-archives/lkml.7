Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48174C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137CF217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rzXoLbnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfH1Wos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:44:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41951 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH1Wos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:44:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id 196so691516pfz.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fg4hkBW4Rh+wg07E+LmFT0I3S5Xi5d7e8tr7Ly1+a64=;
        b=rzXoLbnvwqHwrRtfdfGoDm9v20lH2YNJMq8coCDWUWk8lA5bprt+ocd5S4OBZCtP+6
         AGTmxjYfHNYTquETbYg+coq/5JLvr6ZpiTyMXgcmSFoz7OS0Pp7mDWlXhdKh06gu6gX3
         jUq85nEvsNVkDI4+sLEUqiPsklXYJf9Bs0t2ftvEeKV38Kp0m9Xhk8/2TWO4XwnxyOmR
         D+PdH+tiaPtScIlDUEbmEEcuqMa9EFqa3wynZ/R0gYWEr/PRfy4QEnN6bqrGvuuRTPmo
         T8vwsX3l1mo8gYQlgYgdOx8q/rR+xQwFewybomviCJK9R538dijw4M8Gd3fGJ9IzfaUE
         YYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fg4hkBW4Rh+wg07E+LmFT0I3S5Xi5d7e8tr7Ly1+a64=;
        b=INAukai23AY/6kHWgGxQLw2zokp6Ril300mKHpEiGjSfi+1IbCMwRxeC0gAgWYF8n0
         FS40hcVqwTo8emo/VwjKXi7ghT+asA9QEnJ2cRbFOkhw2+V1xMq4c97pT7pIl7f11qlJ
         6HVP/YICLuaXn4Cr7OQ2y84H3XZxkvvXr427i2xveL6V284q5a5JsbPPpKtASexGSWGA
         fgPkTGgo0UbvF7P+KUCHJM8qg4Av+cPKTlxaJPO/AXDBN2q+xuuswnTGHRFiBzA+ehd1
         v9PI7GSqU7i51BuYSW2k1ov1HFjdteFLzNIDE9VkP9ZHlhuBeKJHapwBUzgXOY3Nfy2n
         7TLw==
X-Gm-Message-State: APjAAAU/kmTUREpkxJcqK38VAS178c+VRzi3wPmf2YWvMmtJOI1y+rHJ
        nx33mkrAT1ozFDnwmJJToWGRix1W2+q5rgkzXBHKWg==
X-Google-Smtp-Source: APXvYqw14PB1SgFqcUtGpnsICk2aPoB03QyuBTKYD70R65UhQjW5dOJGe3FMJ6TdIv5iZQyyyb3QzY7NVt8aaoY39RI=
X-Received: by 2002:aa7:984a:: with SMTP id n10mr7594671pfq.3.1567032286687;
 Wed, 28 Aug 2019 15:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190827204007.201890-1-ndesaulniers@google.com> <CA+icZUVT8GJCPSSB=jLKLu=-OrWAj5W3Rkbx1ar0SGcEq0-D0g@mail.gmail.com>
In-Reply-To: <CA+icZUVT8GJCPSSB=jLKLu=-OrWAj5W3Rkbx1ar0SGcEq0-D0g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 28 Aug 2019 15:44:35 -0700
Message-ID: <CAKwvOd=OsoWoRQ+drUR7c0L_NikmwJvdWCq50oU_TK4aVK0juQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] treewide: prefer __section from compiler_attributes.h
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        "David S. Miller" <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 3:00 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Tue, Aug 27, 2019 at 10:40 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > GCC unescapes escaped string section names while Clang does not. Because
> > __section uses the `#` stringification operator for the section name, it
> > doesn't need to be escaped.
> >
> > This fixes an Oops observed in distro's that use systemd and not
> > net.core.bpf_jit_enable=1, when their kernels are compiled with Clang.
> >
> > Instead, we should:
> > 1. Prefer __section(.section_name_no_quotes).
> > 2. Only use __attribute__((__section(".section"))) when creating the
> > section name via C preprocessor (see the definition of __define_initcall
> > in arch/um/include/shared/init.h).

Case 2 referenced below.

> >
> > This antipattern was found with:
> > $ grep -e __section\(\" -e __section__\(\" -r
> >
>
> Hi Nick,
>
> thanks for the v2 of your patch-series.
>
> I just checked v2 on top of Linux v5.3-rc6...
> arch/um/include/shared/init.h:  __attribute__((__section__(".initcall"
> level ".init"))) = fn
>
> ??? ^^

Right, thanks for checking.  That case is a section dynamically built
via preprocessor, so that's the case I'm referring to in case 2.

>
> > See the discussions in:
> > https://bugs.llvm.org/show_bug.cgi?id=42950
> > https://marc.info/?l=linux-netdev&m=156412960619946&w=2
> >
>
> List CBL issue tracker to discussions:
> https://github.com/ClangBuiltLinux/linux/issues/619

Will do in v3!

-- 
Thanks,
~Nick Desaulniers
