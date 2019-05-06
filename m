Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38EFC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866282082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="HfCKA2Gc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfEFHe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:34:59 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39799 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfEFHe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:34:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id q10so10175447ljc.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 00:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ok4FiX0qqzxFXNlfPJQBxeAS7MtYAthIHs0pXM/1gsw=;
        b=HfCKA2GcWuIWfyCu6q7Vb4VuU5C85rltY95cYwAzVOuNpcOxt9Vpj8t6IWJzXJpM16
         uc9PlW5f9Go3h/CJ9UsWwq1rdbfbTV7+cveeHt9cUsGuK9G3I7pEgW3Zv9bOFVDQOZbH
         MpdHFdCp7U0R6aqGNC2FBUx6AIBp++6riZnVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ok4FiX0qqzxFXNlfPJQBxeAS7MtYAthIHs0pXM/1gsw=;
        b=s8AW9AAlOAsUAda3HdLWbgN0rPSSyw5jkTt6dcHkB8VnOIQGBZB/jqPER41gJ072hh
         +ZwvBsc4rsHSdtJbGZ3wYZJ2hiOoNih+wjUxX1BC9VOML4hhIddSxs5gGOivGuzQOMW2
         vNTn3A+6IghMx3nMDw79aW18/5FPWHwTdP9LTMHXO+zoMhIzODszyPbW2Ea4Wq+kqQiZ
         dPCHCUyXcJrb6B/Pg9YBb68MoCGJA8rwB6eGroh8zX03uTDNXxCFuKugtVC9jqfE0ZWI
         S6OjHbRjXG9PmJpXrRj/8rwBM9JcWMKQnVKxi+ne7C1oS74qC3BN7A8aqcTXoyYbVnle
         gX1g==
X-Gm-Message-State: APjAAAVKZFTDJ9lqPcf6LmH2x90Jra0PbVGFf96s7TQVC1u0QyNAB0Zd
        k8FVCKAD2Kf7cRs4clMHQXTn2Q==
X-Google-Smtp-Source: APXvYqyIXcDanMudqDV0cbvEgmg2JswEqVaUi3W8CZa23fGsbc0VYTSqSxQKNyi+uTC2tZHBHGapWQ==
X-Received: by 2002:a2e:9f07:: with SMTP id u7mr3713010ljk.115.1557128097278;
        Mon, 06 May 2019 00:34:57 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y25sm2083764ljh.31.2019.05.06.00.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 00:34:56 -0700 (PDT)
Subject: Re: [PATCH 00/10] implement DYNAMIC_DEBUG_RELATIVE_POINTERS
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
References: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
 <1afb0702-3cc5-ba4f-2bdd-604d9da2b846@rasmusvillemoes.dk>
 <20190506070544.GA66463@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <25dfde77-fdad-0b99-75ec-4ba480058970@rasmusvillemoes.dk>
Date:   Mon, 6 May 2019 09:34:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506070544.GA66463@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2019 09.05, Ingo Molnar wrote:
> 
> 
> It's sad to see such nice data footprint savings go the way of the dodo 
> just because GCC 4.8 is buggy.
> 
> The current compatibility cut-off is GCC 4.6:
> 
>   GNU C                  4.6              gcc --version
> 
> Do we know where the GCC bug was fixed, was it in GCC 4.9?

Not sure. The report was from a build on CentOS with gcc 4.8.5, so I
tried installing the gcc-4.8 package on my Ubuntu machine and could
reproduce. Then I tried installed gcc-4.9, and after disabling
CONFIG_RETPOLINE (both CentOS and Ubuntu carry backported retpoline
support in their 4.8, but apparently not 4.9), I could see that the
problem was gone. But whether it's gone because it no longer elides an
asm volatile() on a code path it otherwise emits code for, or because it
simply doesn't emit the unused static inline() at all I don't know.

I thought 0day also tested a range of supported compiler versions, so I
was rather surprised at getting this report at all. But I suppose the
arch/config matrix is already pretty huge. Anyway, the bug certainly
doesn't exist in any of the gcc versions 0day does test.

I _am_ bending the C rules a bit with the "extern some_var; asm
volatile(".section some_section\nsome_var: blabla");". I should probably
ask on the gcc list whether this way of defining a local symbol in
inline assembly and referring to it from C is supposed to work, or it
just happens to work by chance.

Rasmus
