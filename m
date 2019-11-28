Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0076FC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77042158A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jwr8BYRG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfK1Buy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 20:50:54 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47024 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfK1Buy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 20:50:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id 193so12255820pfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 17:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VR2/v9AWTifanIT/eMBWdlLjcrylXavL2K2N3+XyWKM=;
        b=Jwr8BYRG9hc5AwI+XoTTuxNeM7IqXgM0Ugt7NqcfVJem+UlL6jjo8c2CE9bkJ9vRyA
         4s9trIxViiJQSkX7847WiHDXh1bBc1UoFEsFnWpL4EhPKEOacBGNu6rhdY7tuOpKLANB
         BrryU15HsnWXYz3n5+1U9TFSzMvnm/XdPCrZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VR2/v9AWTifanIT/eMBWdlLjcrylXavL2K2N3+XyWKM=;
        b=FWJnvtNBmV+KHAGxsSgrGsmNHAa7oM5FC6q/laGJixjTMWW2Tv5vzyx67UPggcenrq
         7akOMVhJ23TfXBt0BlacYcBOf4J3sDj4bhknvCLBkugTkzEqLNDbF3wBlvJu1bHC9TRJ
         YPLlbudqUyK50iWaSpKKetbWcmclwG3UGyfp8gsyBsy3LapRqbDRtOZ0nefZWKdt3c18
         iqTkYcZ5ch/EOSGVJEKd5u4gzhLqdYJoTwCBAifj/nDO/Ogg0KlgkoP7fJ+MElYOuKZE
         tESQ+XxxlNsSiJbu7hFth7k7MxyQjENzfctcggO3r3g6jDFPoBEciW4si03EWX+U6jPF
         bkjg==
X-Gm-Message-State: APjAAAX9Dg52dXPLezqx22L2jPAvcXLBRat0KRtJ7bTr+18fQSp3siGm
        TnCyW7ms9GGZyG6HHM6X/O5kuA1++Hw=
X-Google-Smtp-Source: APXvYqw6h/1IVnr2+2Jqptg9r4JqNrDvrzg74/nQwWdTpwWZEbfoFKMqUhQlAA8EXDIY9hkk5YUUvA==
X-Received: by 2002:a63:fd4c:: with SMTP id m12mr8479924pgj.211.1574905853402;
        Wed, 27 Nov 2019 17:50:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s18sm18227508pfs.20.2019.11.27.17.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 17:50:52 -0800 (PST)
Date:   Wed, 27 Nov 2019 17:50:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        x86 <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lkdtm/bugs: Avoid ifdefs for DOUBLE_FAULT
Message-ID: <201911271748.A7C361E28@keescook>
References: <201911271118.FCC2D04F@keescook>
 <E359D543-FB4E-4EF5-85E6-40057B57C58F@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E359D543-FB4E-4EF5-85E6-40057B57C58F@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 01:01:40PM -0800, Andy Lutomirski wrote:
> 
> 
> > On Nov 27, 2019, at 11:19 AM, Kees Cook <keescook@chromium.org> wrote:
> > 
> > ﻿LKDTM test visibility shouldn't change, so remove the ifdefs on
> > DOUBLE_FAULT and make sure test failure doesn't crash the system.
> > 
> > Link: https://lore.kernel.org/lkml/20191127184837.GA35982@gmail.com
> > Fixes: b09511c253e5 ("lkdtm: Add a DOUBLE_FAULT crash type on x86")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > applies on top of tip/x86/urgent
> > ---
> > drivers/misc/lkdtm/bugs.c  | 8 +++++---
> > drivers/misc/lkdtm/core.c  | 4 +---
> > drivers/misc/lkdtm/lkdtm.h | 2 --
> > 3 files changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> > index a4fdad04809a..22f5293414cc 100644
> > --- a/drivers/misc/lkdtm/bugs.c
> > +++ b/drivers/misc/lkdtm/bugs.c
> > @@ -342,9 +342,9 @@ void lkdtm_UNSET_SMEP(void)
> > #endif
> > }
> > 
> > -#ifdef CONFIG_X86_32
> > void lkdtm_DOUBLE_FAULT(void)
> > {
> > +#ifdef CONFIG_X86_32
> >    /*
> >     * Trigger #DF by setting the stack limit to zero.  This clobbers
> >     * a GDT TLS slot, which is okay because the current task will die
> > @@ -373,6 +373,8 @@ void lkdtm_DOUBLE_FAULT(void)
> >    asm volatile ("movw %0, %%ss; addl $0, (%%esp)" ::
> >              "r" ((unsigned short)(GDT_ENTRY_TLS_MIN << 3)));
> > 
> > -    panic("tried to double fault but didn't die\n");
> > -}
> > +    pr_err("FAIL: tried to double fault but didn't die!\n");
> > +#else
> > +    pr_err("FAIL: this test is only available on 32-bit x86.\n");
> > #endif
> > +}
> 
> I’m not familiar with the userspace tooling, but this seems unfortunate. The first FAIL is “the test case screwed up, and it’s a bug.”  The second FAIL is “not applicable to this system.”
> 
> 
> ISTM simply not exposing the test on systems that don’t support makes sense. Can you clarify?

I don't like the tests liked in the DIRECT file to change from build to
build (it should be stable per kernel version). Userspace needs to know
how to evaluate the results of running each test, so in both cases, I
consider it a failure: double fault didn't work or you tried to test
double fault on an unsupported architecture. (The SMEP test works
similarly.)

-- 
Kees Cook
