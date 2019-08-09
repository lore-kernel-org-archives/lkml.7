Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEEEC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D5020C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407379AbfHIS2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 14:28:36 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38803 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfHIS2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:28:35 -0400
Received: by mail-qk1-f193.google.com with SMTP id u190so8730064qkh.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 11:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=meYZAOaqZ5KaoPmXpKdQX8BQbEOPXVSFqQOk/Zs8rsA=;
        b=ce7Y8J51F91Wbnr69zfjOY6ncKZCfRi/gCZIPbQ97bT65NFIuYIkz0iibeXJQcKiGk
         rKS2TUIfZn8VOk8PHNSDKFqsb4iGeKhTqn396ib6Y+ZblxVNLxjE550+hqwbSuLXpzP4
         FxIhS/rXFwkj+C+8stHE7lARA8aIpsxqto5TG6UA45FGkeTccTbNK3KAA7OaI66/iwXw
         b07cbNMGulJvlgDVmCq1PsD9nmT8yRmqZzivPA5LTq3CAfqyRwo7R2KqLvi5TLAEpfw7
         3n8RKHDSODsQ6dEjQl+6ZYbJqO3lPjshGipQq+X2StUYyPnHdPTX5Iq5NfsSRRF/JAL4
         hiBg==
X-Gm-Message-State: APjAAAXjyHOtN3zvzAA+8ao4Zru7J7yAUjpUs5puBoxxWl2etukbKczX
        ZeJNYonIazxbFcsqgMMjwO4ijx/WatzFOKsxswOKxJcn
X-Google-Smtp-Source: APXvYqzLxdQHC0gUKiwVO2NJAHpHdYXdIWcXVTsS7VCUpP4IfTQCbdx5V1hKHFH1R7BU89gajb/sE4UT39NYqjWxAtw=
X-Received: by 2002:a37:4ac3:: with SMTP id x186mr18866428qka.138.1565375314918;
 Fri, 09 Aug 2019 11:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <87h873zs88.fsf@concordia.ellerman.id.au> <20190809182106.62130-1-ndesaulniers@google.com>
In-Reply-To: <20190809182106.62130-1-ndesaulniers@google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 9 Aug 2019 20:28:19 +0200
Message-ID: <CAK8P3a3LynWTbpV8=VPm2TqgNM2MnoEyCPJd0PL2D+tcZqJgHg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: fix inline asm constraints for dcbz
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        kbuild test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 8:21 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:

>  static inline void dcbz(void *addr)
>  {
> -       __asm__ __volatile__ ("dcbz %y0" : : "Z"(*(u8 *)addr) : "memory");
> +       __asm__ __volatile__ ("dcbz %y0" : "=Z"(*(u8 *)addr) :: "memory");
>  }
>
>  static inline void dcbi(void *addr)
>  {
> -       __asm__ __volatile__ ("dcbi %y0" : : "Z"(*(u8 *)addr) : "memory");
> +       __asm__ __volatile__ ("dcbi %y0" : "=Z"(*(u8 *)addr) :: "memory");
>  }

I think the result of the discussion was that an output argument only kind-of
makes sense for dcbz, but for the others it's really an input, and clang is
wrong in the way it handles the "Z" constraint by making a copy, which it
doesn't do for "m".

I'm not sure whether it's correct to use "m" instead of "Z" here, which
would be a better workaround if that works. More importantly though,
clang really needs to be fixed to handle "Z" correctly.

        Arnd
