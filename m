Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2267BC04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E618B206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557126351;
	bh=iCfLXKNXU2Ws8eDVDEY48GzQf94Wxp9MOT0L8LwkKmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bviqQ+7TGYXzovdJ67V164jqaB7b9cs+8gw1ByJ71iaGg8M5NpeAFo5yxDmV7FWod
	 nOoZ3uwfDj+3GCv0Nub0/Gg5NtJA+9KZJcf8rb09VI4GDb0tAqkCPQyxPEJkUPK0tH
	 erVcI2La2f9Gb+V0JWg++b0pcaua0FVDbwJBzbEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfEFHFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:05:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56066 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfEFHFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:05:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id y2so14019746wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 00:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5V6LFql9im1SPXc8YxW9Jo3rXT30savTgK/RedsezR8=;
        b=mhLOADL9bqOSSqke/X5TKBE3LDOfe2nbKYMCQidDFMKBOdyksQDafV2jYPTRt2XxBe
         AdhtK98Z9Qxa7k22gSsr4uMp++J7DJbPsAhdgfb4d5rFBZ8JOqqMs1k4kRy78OluZ8NI
         pqQYYSOwsVMYq21D3e54iLqFIjWOrUzSsrICzv8PwvE7myCD7zrEUJp1hdO/BX13E0Nn
         wk/uUxhcjd9TslYzN8t1cQtvFP+7Et0dSRmpFlNiShDBF0XQ6b1XvX5nTSblzJmmF7rO
         c8AhnCXdKulvKkejpAhstMRJse9EKwnjepdomaYnKBuF4DTKvVcp9RCoyhnLMlTUZvdm
         QhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5V6LFql9im1SPXc8YxW9Jo3rXT30savTgK/RedsezR8=;
        b=EkxpgN7RePV45939cj4xv+DJ4xsgXmezEPWdmobgCICxRs6ZpIcrH9JKOE/5bnue4J
         ZfwbIse9EPrqYlhsHUcFCeGHD7Oad3ETTR6pimMLKi3AqWKPl/8d/J16iBHwITz0w2No
         QEwJj+lJmfDWUALisIDDRpta9MZ3GlC5kXCO4J4CjcjYG3VaefTl6a+kwbt6l/FIywj0
         YKNEQwLfUyDEluBHaYbeYzv+vxLvnmYScYXhaH6hu6izLjrGnY39TpvPdqWSd+6Rz5cN
         fVR4J9j5uPfsVMwZtU3BC3eUKxz7xXsS761x1V8dVCjbi/7UWdbaT9FH9n27k+VxfpmH
         4czQ==
X-Gm-Message-State: APjAAAXDKw19f5Zmb5108calFySXD3k3d0U9u1GYVVnJb+7D8823HYyz
        rN/ydVNBOVPuQT3UlYgj3p8=
X-Google-Smtp-Source: APXvYqy4zpd3s31UHNJkzYltTQzBio1Fvf2VRSVUdP+5SE+cZ9IqATPxo97xjNReMAPbQjW779nz8w==
X-Received: by 2002:a7b:ce10:: with SMTP id m16mr9133691wmc.36.1557126347523;
        Mon, 06 May 2019 00:05:47 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id d3sm18551842wmf.46.2019.05.06.00.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 00:05:46 -0700 (PDT)
Date:   Mon, 6 May 2019 09:05:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
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
Subject: Re: [PATCH 00/10] implement DYNAMIC_DEBUG_RELATIVE_POINTERS
Message-ID: <20190506070544.GA66463@gmail.com>
References: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
 <1afb0702-3cc5-ba4f-2bdd-604d9da2b846@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1afb0702-3cc5-ba4f-2bdd-604d9da2b846@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> On 09/04/2019 23.25, Rasmus Villemoes wrote:
> 
> > While refreshing these patches, which were orignally just targeted at
> > x86-64, it occured to me that despite the implementation relying on
> > inline asm, there's nothing x86 specific about it, and indeed it seems
> > to work out-of-the-box for ppc64 and arm64 as well, but those have
> > only been compile-tested.
> 
> So, apart from the Clang build failures for non-x86, I now also got a
> report that gcc 4.8 miscompiles this stuff in some cases [1], even for
> x86 - gcc 4.9 does not seem to have the problem. So, given that the 5.2
> merge window just opened, I suppose this is the point where I should
> pull the plug on this experiment :(
> 
> Rasmus
> 
> [1] Specifically, the problem manifested in net/ipv4/tcp_input.c: Both
> uses of the static inline inet_csk_clear_xmit_timer() pass a
> compile-time constant 'what', so the ifs get folded away and both uses
> are completely inlined. Yet, gcc still decides to emit a copy of the
> final 'else' branch of inet_csk_clear_xmit_timer() as its own
> inet_csk_reset_xmit_timer.part.55 function, which is of course unused.
> And despite the asm() that defines the ddebug descriptor being an "asm
> volatile", gcc thinks it's fine to elide that (the code path is
> unreachable, after all....), so the entire asm for that function is
> 
>         .section        .text.unlikely
>         .type   inet_csk_reset_xmit_timer.part.55, @function
> inet_csk_reset_xmit_timer.part.55:
>         movq    $.LC1, %rsi     #,
>         movq    $__UNIQUE_ID_ddebug160, %rdi    #,
>         xorl    %eax, %eax      #
>         jmp     __dynamic_pr_debug      #
>         .size   inet_csk_reset_xmit_timer.part.55,
> .-inet_csk_reset_xmit_timer.part.55
> 
> which of course fails to link since the symbol __UNIQUE_ID_ddebug160 is
> nowhere defined.

It's sad to see such nice data footprint savings go the way of the dodo 
just because GCC 4.8 is buggy.

The current compatibility cut-off is GCC 4.6:

  GNU C                  4.6              gcc --version

Do we know where the GCC bug was fixed, was it in GCC 4.9?

According to the GCC release dates:

  https://www.gnu.org/software/gcc/releases.html

4.8.0 was released in early-2013, while 4.9.0 was released in early-2014. 
So the tooling compatibility window for latest upstream would narrow from 
~6 years to ~5 years.

Thanks,

	Ingo
