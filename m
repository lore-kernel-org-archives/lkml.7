Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD9FC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 07:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905C92089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 07:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568360136;
	bh=NDw2seXvTKUKS4QDL1x4GHhhgUj9AoFeWn8UAqZu18E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nd32lVnRkQTpU+tRlOF0v7ZugkvhZx9nK5qODJoezr828xpk0zvIa26sWEw8v0nD1
	 c8h0O92TmhW7MM57yhi65rf6obmOXhZsn1Uxnkqxyl/CMOsXc2GDxy2z09EXPr6lWu
	 94Z84yqwIPetHi1jHBDx54qt+C6/cN/YaSbZS7ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfIMHff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 03:35:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35101 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbfIMHff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 03:35:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id n10so1600229wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 00:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e9KqrpRewRK330rqZdSd9xo5DsZMlUgKKAeLiHEs+aY=;
        b=pqGi7MpXngval3it54/qIEijJxSYP4A+8HAPW4TGVPJklPx4eJngR2MJEZE+kQZZEb
         DDQ6M4gXrLuz/ffUMjB1Om+ibgocGvasGqq/we4hQ2VOQ+o9UUxRIH+ZtFSm5YGt76kQ
         2MPUe7XC5ywBHR85bfL+Hdx08VEbo5M0vNo4uOhYaXCfY0bs0xYJe+AUVF573M+kNOjS
         QNp3Bz+ZJ+G7efbTateZD29OTcAMu7wBXcbnaxAf6y7W7QsCL3FL2nCx3996eMo5+DCt
         AUyIyDha0KQeJR4xaWo0ZNPZPpE/CPcrGNgK+s+mJqeOueY2EWmgc9FGTnuDMelbY0Zb
         h+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=e9KqrpRewRK330rqZdSd9xo5DsZMlUgKKAeLiHEs+aY=;
        b=Rl1MN4Zr2VpJ7Ik/6yeh9E6jGDAsc5g8qHSiDz91nqA/KEaa0Pzs336M86RvQl4pZj
         H6DL9iZWM08Zl5qcuvbVPGwXByaONtpvFhcFPtP92xiR9YGSztzXG/ZN8vzYJwVJtpK0
         OF5+wQFsPRjG4Y6EHwTmvTQllihpVwm6gxITYhW54H5t5pMNl2GDEKgRn8jezOY3i79P
         m0mEaPKVgu6XBZ94Ax+4ZzV3cGvy2tcTeXd9cZI2pJPYL+ujstn3scLMbaq4GSUknNel
         Cnt3nUARDObXJdJbRGpkJhuuphLEzqm4rvj3HKREGFOFOPmWeAYQg5D//FYMkCWvFa3v
         2rQw==
X-Gm-Message-State: APjAAAWJJI6FfNWnektKmaCLUw1Mjici71BIwit9JTBdDH8xAkwfdX3s
        yPjlrZN9nND7W/HgtNpGwyk=
X-Google-Smtp-Source: APXvYqxeWxznf3qz8ENEIFhXeqAgpe2VTZMkW6p1fJeT3D0sKQpnbvDmjHsvJmfCWAkdgqJrNMa/1A==
X-Received: by 2002:a1c:28d4:: with SMTP id o203mr2212033wmo.142.1568360133199;
        Fri, 13 Sep 2019 00:35:33 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j26sm51088014wrd.2.2019.09.13.00.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 00:35:32 -0700 (PDT)
Date:   Fri, 13 Sep 2019 09:35:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Improve memset
Message-ID: <20190913073530.GA125477@gmail.com>
References: <20190913072237.GA12381@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913072237.GA12381@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> Hi,
> 
> since the merge window is closing in and y'all are on a conference, I
> thought I should take another stab at it. It being something which Ingo,
> Linus and Peter have suggested in the past at least once.
> 
> Instead of calling memset:
> 
> ffffffff8100cd8d:       e8 0e 15 7a 00          callq  ffffffff817ae2a0 <__memset>
> 
> and having a JMP inside it depending on the feature supported, let's simply
> have the REP; STOSB directly in the code:
> 
> ...
> ffffffff81000442:       4c 89 d7                mov    %r10,%rdi
> ffffffff81000445:       b9 00 10 00 00          mov    $0x1000,%ecx
> 
> <---- new memset
> ffffffff8100044a:       f3 aa                   rep stos %al,%es:(%rdi)
> ffffffff8100044c:       90                      nop
> ffffffff8100044d:       90                      nop
> ffffffff8100044e:       90                      nop
> <----
> 
> ffffffff8100044f:       4c 8d 84 24 98 00 00    lea    0x98(%rsp),%r8
> ffffffff81000456:       00
> ...
> 
> And since the majority of x86 boxes out there is Intel, they haz
> X86_FEATURE_ERMS so they won't even need to alternative-patch those call
> sites when booting.
> 
> In order to patch on machines which don't set X86_FEATURE_ERMS, I need
> to do a "reversed" patching of sorts, i.e., patch when the x86 feature
> flag is NOT set. See the below changes in alternative.c which basically
> add a flags field to struct alt_instr and thus control the patching
> behavior in apply_alternatives().
> 
> The result is this:
> 
> static __always_inline void *memset(void *dest, int c, size_t n)
> {
>         void *ret, *dummy;
> 
>         asm volatile(ALTERNATIVE_2_REVERSE("rep; stosb",
>                                            "call memset_rep",  X86_FEATURE_ERMS,
>                                            "call memset_orig", X86_FEATURE_REP_GOOD)
>                 : "=&D" (ret), "=a" (dummy)
>                 : "0" (dest), "a" (c), "c" (n)
>                 /* clobbers used by memset_orig() and memset_rep_good() */
>                 : "rsi", "rdx", "r8", "r9", "memory");
> 
>         return dest;
> }
> 
> and so in the !ERMS case, we patch in a call to the memset_rep() version
> which is the old variant in memset_64.S. There we need to do some reg
> shuffling because I need to map the registers from where REP; STOSB
> expects them to where the x86_64 ABI wants them. Not a big deal - a push
> and two moves and a pop at the end.
> 
> If X86_FEATURE_REP_GOOD is not set either, we fallback to another call
> to the original unrolled memset.
> 
> The rest of the diff is me trying to untangle memset()'s definitions
> from the early code too because we include kernel proper headers there
> and all kinds of crazy include hell ensues but that later.
> 
> Anyway, this is just a pre-alpha version to get people's thoughts and
> see whether I'm in the right direction or you guys might have better
> ideas.

That looks exciting - I'm wondering what effects this has on code 
footprint - for example defconfig vmlinux code size, and what the average 
per call site footprint impact is?

If the footprint effect is acceptable, then I'd expect this to improve 
performance, especially in hot loops.

Thanks,

	Ingo
