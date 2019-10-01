Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14663C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD9C21855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BV49VzhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732837AbfJARAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:00:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38424 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfJAQ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:59:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id x10so10068011pgi.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 09:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2awflrC+S8sW6Q8RM/7IHEMp9YVcJWuJTxLTWpq/SvI=;
        b=BV49VzhGClndCpnhV7hfr6O3hnvXTBaeI71S7Wb7NEfFeGK2L2UbE/CHr1SoGn8sqR
         t+jDBhR/ja8iIRH73mXK+85sipatQ7KQi02cIBi3mZZrug3mhTFJBWzZcpHtSXD0L7ot
         U7YiWARFMcbhN4RpZ05H4ne6z+rLWsFutiKvXBIjenmImi90FKyUQToC6CN1mXG2e713
         EEVldl+tL6vYTmxzps3RVIM44J97N+9Lvr0NNtbpJDzt0V9SeUj04OM3eDajFZhs5/bc
         cHcLm79dh6p4hK5pWMlZDm30hvguPG9+fVnYuf+WpzrOwzFupTWqjOlLWDZyIGYmHxCy
         qEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2awflrC+S8sW6Q8RM/7IHEMp9YVcJWuJTxLTWpq/SvI=;
        b=hiJm5FW7ff+xkOZYG2fTXt/CTPaAKdi2wnukgZKQBJdwLvub9UQchrOuyAKEV5RyeI
         hXUex1DYK26z8sW9/1ZQtJQblNWz4ER/ZmUE1coApwDryAiDySVL/o/IlJrLtPupresd
         Tgt+amt/Vn1iDQReOWcCl9ii5Qb+Xlkq0czCLmepaDmyVuYryWNeRUuAbrIMOA9mK0Is
         LjMNkBTNECPiSodnbye7Hr4jN+leSi+uNK5Ikyr4o+epiim3awwjeJH9sx0ZOfNJt148
         0EagAuSdbHPdBVpd7I1IRlx64l3uBlSaVyO1hif44RQBZPVDXQMmYU7DYyAx7ddzp+79
         T3RQ==
X-Gm-Message-State: APjAAAV/arcmAuW6e8HaDBYSu4dshTOjQReBfWYQ3wAlYMAE2mtLWRpj
        vdeMzWis4UvumDTNcK+UrhKYaTUj6GhtXYd0Px+5MQ==
X-Google-Smtp-Source: APXvYqza0SPHw15ijDTzbY4E90ZETPgajrtr0mx3323n/WmbwxvaNA6FJ4ljLciXhra0aRHuEKxCIkefXuD7pecraIk=
X-Received: by 2002:a63:2f45:: with SMTP id v66mr7478314pgv.263.1569949194584;
 Tue, 01 Oct 2019 09:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926214342.34608-1-vincenzo.frascino@arm.com> <20190926214342.34608-2-vincenzo.frascino@arm.com>
 <20191001131420.y3fsydlo7pg6ykfs@willie-the-truck> <20191001132731.GG41399@arrakis.emea.arm.com>
 <ed7d1465-2d7b-d57c-c1b1-215af1ba7a6f@arm.com> <20191001142038.ptwyfbesfrz3kkoz@willie-the-truck>
 <7558914c-fc2d-d05a-ccbe-76ef451670ae@arm.com> <20191001144353.5rn3bkcc6eyfclh7@willie-the-truck>
 <20191001153056.GO41399@arrakis.emea.arm.com> <20191001164657.l2wz3ghq6icm3lim@willie-the-truck>
In-Reply-To: <20191001164657.l2wz3ghq6icm3lim@willie-the-truck>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Oct 2019 09:59:43 -0700
Message-ID: <CAKwvOd=+-PEQXOZBG6rprWdOzHfcQq9ojkGo+Q28vfC4AU=Hwg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] arm64: vdso32: Introduce COMPAT_CC_IS_GCC
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 9:47 AM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Oct 01, 2019 at 04:30:56PM +0100, Catalin Marinas wrote:
> > In the long run, I wouldn't mandate CROSS_COMPILE_COMPAT to always be
> > set for the compat vDSO since with clang we could use the same compiler
> > binary for both native and compat (with different flags). That's once we
> > cleaned up the headers.
>
> But we'll still need it even with clang so that the relevant triple can be
> passed to the --target option. The top-level Makefile already does this:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Makefile#n544

That's not pulling the cross compiler out of a *config* (as this patch
is proposing); rather from an env var.

>
> so I think we should do the same thing for the compat vdso as well, which
> would allow us to remove this complexity by requiring that
> CROSS_COMPILE_COMPAT identifies the cross-compiler to use in exactly the
> same way as CROSS_COMPILE does.
>
> Am I missing something here?

I think the second paragraph you wrote shows we're all in agreement,
but I suspect you may be conflating *how* the toplevel Makefile knows
we're doing a cross compile.  It doesn't read a config, this patch
would make it so a cross compiler is specified via config, Catalin
asked "please no," I agree with Catalin (and I suspect you do too).
-- 
Thanks,
~Nick Desaulniers
