Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0CDC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70552253D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576172514;
	bh=Hwihxtiy20/Qjh2bOmETsVop6SoQWdsHsbvLQ9Wf1fc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=T9/CtJeD1LsFCQpTwSxnFW0mradfJ6wrUhGXQg421US/9b01+xDuzFB8MimxxZoVQ
	 XHPVfj3u8CRPgpb9HhWHWwj3BUgqxarL7noPQXr5IlFSyZkrJ0fvPd4Fim2qUaWC0B
	 ruJqstzKRITk1mHASzfFq99CsUQMrp/njGzV/eE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbfLLRly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:41:54 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34041 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730023AbfLLRlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:41:53 -0500
Received: by mail-lj1-f193.google.com with SMTP id m6so3247525ljc.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 09:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bMM9+SXbUifsEu+Y3zqfvwzhjRsedDBd5kfOwAh/UwA=;
        b=MAwdhQ2ApXj+Y01Th4BCE3RSlffcMF2vn+S1n9g9eLPqUXBxqb7H1E20UVL+9mb/zo
         TUamH+60U4LyvobpVidwKOG160coaIFky35EjHAPgaruzcWX7fUztBbagb0MZDX0xKZK
         b+3B1PXWXfIs13GZ1+vXd3HB1o38BkFLHhGiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bMM9+SXbUifsEu+Y3zqfvwzhjRsedDBd5kfOwAh/UwA=;
        b=ds/YKjX1aL1ADNlXM6LCiDc9+jRF/vh7SMT6TbKXRpoOUwiHfBr1JpwobJ47ulK2al
         SZas584V//xDeQtZFjy1jexcMR/qTxZEQ97KhmKNoSMiy0T/gj53nuIAvoRsaXbkq4+I
         ZKS5pwNkJ2fwdYnAOdoTGXqUMvIDhXtTYN/V6ri5hnADcuIOuJNyTbYQq7O92mOJuFMB
         wzZgPXjg9iPLp5AnsaNs5KV3P0/9KlEyh6lUmvX8lFnSgp7zXStnkm4P4pko3FmkRgGF
         RKaOsWAe4vJmCPOr5cegKb0vFeVLD5pGGWNDJscy9sKkJ3G4vLWL0xnworUIZZrNnfew
         wpFw==
X-Gm-Message-State: APjAAAW01a/Tacb6rJHLFk0Px9vVyu9Te/r4nJfD+XXcA+1zuUiO2Npl
        4q89WjbZzl8484bQcGQkuaSs75im/1Y=
X-Google-Smtp-Source: APXvYqzSRZnR49oGoVFUD9NZ51lkCHBL7xW0gJzLq3Nq9FPt2e2wkmSKE/Q0qSqCrbkBsw/OwLnxXQ==
X-Received: by 2002:a2e:9942:: with SMTP id r2mr6947647ljj.182.1576172510529;
        Thu, 12 Dec 2019 09:41:50 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id b22sm3484752lji.66.2019.12.12.09.41.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 09:41:50 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id k8so3232210ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 09:41:48 -0800 (PST)
X-Received: by 2002:a2e:241a:: with SMTP id k26mr6727345ljk.26.1576172507997;
 Thu, 12 Dec 2019 09:41:47 -0800 (PST)
MIME-Version: 1.0
References: <87blslei5o.fsf@mpe.ellerman.id.au> <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au> <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net>
In-Reply-To: <20191212104610.GW2827@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Dec 2019 09:41:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
Message-ID: <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 2:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> +#ifdef GCC_VERSION < 40800

Where does that 4.8 version check come from, and why?

Yeah, I know, but this really wants a comment. Sadly it looks like gcc
bugzilla is down, so

   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145

currently gives an "Internal Server Error" for me.

[ Delete the horrid code we have because of gcc bugs ]

> +#else /* GCC_VERSION < 40800 */
> +
> +#define READ_ONCE_NOCHECK(x)                                           \
> +({                                                                     \
> +       typeof(x) __x = *(volatile typeof(x))&(x);                      \

I think we can/should just do this unconditionally if it helps th eissue.

Maybe add a warning about how gcc < 4.8 might mis-compile the kernel -
those versions are getting close to being unacceptable for kernel
builds anyway.

We could also look at being stricter for the normal READ/WRITE_ONCE(),
and require that they are

 (a) regular integer types

 (b) fit in an atomic word

We actually did (b) for a while, until we noticed that we do it on
loff_t's etc and relaxed the rules. But maybe we could have a
"non-atomic" version of READ/WRITE_ONCE() that is used for the
questionable cases?

              Linus
