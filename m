Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF79BC04AAE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10142082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="D8snUQHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfEFGsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 02:48:19 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37551 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfEFGsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 02:48:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id 132so2334264ljj.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 23:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C2U/Y3HrsZsGwgSrYLbL41jSdN4fVhl+NLwRQdY4iqY=;
        b=D8snUQHAfdzQm9GkWQI34dkVAxrAJuZkmWsqO5irUHT1hWyV2hkSyYSsSclecD9gti
         eZwTtFWJLX5djPnJJpwa1CrKEH1nOO0tvUGWucaebAmsJGSDQJQdRdXKpwRfY3sKAUYf
         4wqO50fRoeyvl+KoXsP2lu7dYVZcoUzjU59UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C2U/Y3HrsZsGwgSrYLbL41jSdN4fVhl+NLwRQdY4iqY=;
        b=SQ3Ud71MjHcViVo+hIEEKtU/mWjfLeCaUCaNqvRYAMRoLOuWlXh8MzPTWYVGAFD6qE
         /Jp/5J5lf9NnZ8ULcCVE/et7Jp31nogGSAMPWqvE2qeiMwVscDCXDkHheiY8pknXIucJ
         53XOm87+Z3lrUGv9Un/qyG+PYEeswyN19S1jYuVIsAyRI5Q3G+X6Us8J9DqN24HQ/Gpq
         qtWlXQ8Age3uvKWays7v6t7OaoXrKlrhRtAbgXdBh8bm3HyU5Uf3NWV9ONFVfRIWEBZf
         w1CaA5gPnFBfZ6Glj0Rr11bmOAqLlEsRqt4nJkaWdfLXVQMy4oog+pn6xIkopOYFWl99
         A8ow==
X-Gm-Message-State: APjAAAVuDouTauvNT2XEbOXAdY6a2y7P1hiVqAMWu64hDkd0u5MBS0jh
        Ug5iaVYA232dQ7AlOXwQkGdN/A==
X-Google-Smtp-Source: APXvYqzZ60bhW+zmKxgQWKFu3bPVmpIDGkgZaXEtzr6qDGU0QdrT3fUUEmHHE44uPUNcpPCQcav0rQ==
X-Received: by 2002:a2e:7503:: with SMTP id q3mr587089ljc.190.1557125297062;
        Sun, 05 May 2019 23:48:17 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id j13sm2142583lfb.34.2019.05.05.23.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 23:48:16 -0700 (PDT)
Subject: Re: [PATCH 00/10] implement DYNAMIC_DEBUG_RELATIVE_POINTERS
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <1afb0702-3cc5-ba4f-2bdd-604d9da2b846@rasmusvillemoes.dk>
Date:   Mon, 6 May 2019 08:48:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2019 23.25, Rasmus Villemoes wrote:

> While refreshing these patches, which were orignally just targeted at
> x86-64, it occured to me that despite the implementation relying on
> inline asm, there's nothing x86 specific about it, and indeed it seems
> to work out-of-the-box for ppc64 and arm64 as well, but those have
> only been compile-tested.

So, apart from the Clang build failures for non-x86, I now also got a
report that gcc 4.8 miscompiles this stuff in some cases [1], even for
x86 - gcc 4.9 does not seem to have the problem. So, given that the 5.2
merge window just opened, I suppose this is the point where I should
pull the plug on this experiment :(

Rasmus

[1] Specifically, the problem manifested in net/ipv4/tcp_input.c: Both
uses of the static inline inet_csk_clear_xmit_timer() pass a
compile-time constant 'what', so the ifs get folded away and both uses
are completely inlined. Yet, gcc still decides to emit a copy of the
final 'else' branch of inet_csk_clear_xmit_timer() as its own
inet_csk_reset_xmit_timer.part.55 function, which is of course unused.
And despite the asm() that defines the ddebug descriptor being an "asm
volatile", gcc thinks it's fine to elide that (the code path is
unreachable, after all....), so the entire asm for that function is

        .section        .text.unlikely
        .type   inet_csk_reset_xmit_timer.part.55, @function
inet_csk_reset_xmit_timer.part.55:
        movq    $.LC1, %rsi     #,
        movq    $__UNIQUE_ID_ddebug160, %rdi    #,
        xorl    %eax, %eax      #
        jmp     __dynamic_pr_debug      #
        .size   inet_csk_reset_xmit_timer.part.55,
.-inet_csk_reset_xmit_timer.part.55

which of course fails to link since the symbol __UNIQUE_ID_ddebug160 is
nowhere defined.
