Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEEDC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F94021841
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfGrcjQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfGXQyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:54:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34831 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbfGXQyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:54:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so47770553wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 09:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GGnDbdb1w8mdDXJnIzPOA9I6KzGS82PK72BzW8rS+sA=;
        b=HfGrcjQ4nMFBSnwAv3eptOIQkUx6A6Gyr8zx3ikCLLk/yGT6rHRMMyV/7bAFlpQIWn
         rg5NTLg449T4KeZeGrnsFhRaIirq6d2lixbOn85PCMUaUqdxOGRGwx3drhIKMLXZt9LP
         Sc14b+391Qf4dfFYAr1b9J58sOjDWz4m3Y7MDkXqq0dkOJ3LOSRQSCZt7ILZIRQKLWF5
         aKDTgbdeHrBCGMBS5tWRSN+i2ljA2b66wxP1jsuRLSKAmi7vNbkpnfOIuSeoN2hB9Vqj
         6C494UCj+Tx+zTAqP3yI24cnKiS6oDFZJ4NU6cAXZCHOpDaoNF9X892SwQOIf46atwQf
         MFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GGnDbdb1w8mdDXJnIzPOA9I6KzGS82PK72BzW8rS+sA=;
        b=eVEGBoV96wr6Cq2S/qAzsAHR7k1j5fTfcW4bBG9muQZ8RUgM3nJ0qbpRS0B46983Dh
         FMBG/SGene8mi/TFA4RtBxXzH7UWaoyKG03KjNYb8mnhEGAwb2EwvnlHTPTrE/PnU4cx
         3a1LVizTAWhREm1Nsj2R65JW9U0BJjIUCYujbEkr4w7KlCuQd9ZJ4M4MJ9LrtwgS2ekm
         mYulpML++QHXwXcqUbZItnYt+b0JCXaatYYh37NCUATWBNvkFOcQxbkN/PGedkbrbnq/
         1feiVFZZwvSPYUnAdfIeK/z0GRBomvTNBoyc2yJ6NXxC2Bt4ZzB0NqC1YCKFFdw48Ao0
         y5Qg==
X-Gm-Message-State: APjAAAW4Y1d0gqcGlFqqfB2Hl5fx0HfVYM+OcsGflrfbrEw9QcffQhwW
        00FQ7WGRGNing1lz9JEsuaM=
X-Google-Smtp-Source: APXvYqzZHZpbVplb8GHdoH7GYDgxJFDlO7e94sMpgOxhe9ybJ4LWMIZzKPnJpFflUf1OqztzynYvzQ==
X-Received: by 2002:adf:f206:: with SMTP id p6mr16153631wro.216.1563987289028;
        Wed, 24 Jul 2019 09:54:49 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id c1sm100119741wrh.1.2019.07.24.09.54.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 09:54:48 -0700 (PDT)
Date:   Wed, 24 Jul 2019 09:54:46 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] objtool: Improve UACCESS coverage
Message-ID: <20190724165446.GA110233@archlinux-threadripper>
References: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de>
 <20190724023946.yxsz5im22fz4zxrn@treble>
 <20190724074732.GJ3402@hirez.programming.kicks-ass.net>
 <20190724125525.kgybu3nnpvwlcz2c@treble>
 <20190724133516.GB31381@hirez.programming.kicks-ass.net>
 <20190724141040.GA31425@hirez.programming.kicks-ass.net>
 <20190724164821.GB31425@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724164821.GB31425@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 06:48:21PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 24, 2019 at 04:10:40PM +0200, Peter Zijlstra wrote:
> > And that most certainly should trigger...
> > 
> > Let me gdb that objtool thing.
> 
> ---
> Subject: objtool: Improve UACCESS coverage
> 
> A clang build reported an (obvious) double CLAC while a GCC build did
> not; it turns out we only re-visit instructions if the first visit was
> with AC=0. If OTOH the first visit was with AC=1, we completely ignore
> any subsequent visit, even when it has AC=0.
> 
> Fix this by using a visited mask, instead of boolean and (explicitly)
> mark the AC state.
> 
> $ ./objtool check -b --no-fp --retpoline --uaccess ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o
> ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x22: redundant UACCESS disable
> ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0xea: (alt)
> ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   .altinstr_replacement+0xffffffffffffffff: (branch)
> ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0xd9: (alt)
> ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0xb2: (branch)
> ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0x39: (branch)
> ../../defconfig-build/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:   eb_copy_relocations.isra.34()+0x0: <=== (func)
> 
> Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

This doesn't regress clang and I see the warning on GCC now too.

Tested-by: Nathan Chancellor <natechancellor@gmail.com>
