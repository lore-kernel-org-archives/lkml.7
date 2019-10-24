Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC83CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDEB2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571935305;
	bh=1SNHEg6+c998ctNCmd9SgwSXFWQKSNG1btG3g+zXoyw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yWlZrP1jcgtWirR8+hdnIGrZ9l+7/L6/ogcxBYau7Q3pmbLFyLMCZ1Ui0E7tiG9AY
	 +pl5cGiNPILkRsw9AdxNxvfX0tZnXj2hca8L2cdYtkpO/kKGjG8XXPgb7gBpdrM6YL
	 4RIZRneGDRUOlr9K35Ou6gBKPPdUQb94HESMQQl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393966AbfJXQlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390204AbfJXQln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:41:43 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E1F521925
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 16:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571934839;
        bh=1SNHEg6+c998ctNCmd9SgwSXFWQKSNG1btG3g+zXoyw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b/TQ/9/CbwW5SRUBfFuJHDwGl6ndjWOCM/d9EMkad3YaXL0FAm+86hjsxnERu7yH4
         sjURls7sokdzhUyNIzGgkzPpElNUh3EDG/lcGFuqXN7wtCXu2GD11z6lecOndhLUod
         EBQXFXo8LqoUIoKIATNtZqQ0XBcc89G+oAiFVsoE=
Received: by mail-wr1-f47.google.com with SMTP id t16so21693103wrr.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:33:59 -0700 (PDT)
X-Gm-Message-State: APjAAAU6LhPBR5QWcywVh7I/BW5vWKXtC1TZRqLZCcrKXUdcD6pPHkI2
        YjeZQTXdgKnvR9Pu47MqsAAP1AMtJ06Ht490kIj8wA==
X-Google-Smtp-Source: APXvYqyYjlrS0PO0VZ1qRMGKSsFiVVDLw2A2GrTFkiqLwXEeea+luMRqO7GJCnjTjc6QcZfFsb1uJ7GKgNFlLm/NEro=
X-Received: by 2002:adf:f342:: with SMTP id e2mr4921768wrp.61.1571934837618;
 Thu, 24 Oct 2019 09:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <ef1c9381-dfc7-7150-feca-581f4d798513@suse.com>
 <CALCETrWAALF7EgxHGs-rtZwk1Fxttr56QKXeB6QssXbyXDs+kA@mail.gmail.com> <8f9f812b-c28a-5828-d8d9-37ae7e2f99da@citrix.com>
In-Reply-To: <8f9f812b-c28a-5828-d8d9-37ae7e2f99da@citrix.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 24 Oct 2019 09:33:45 -0700
X-Gmail-Original-Message-ID: <CALCETrXp0oEu1zeCHUjPJb+i6Y7vR6zCtHGKzP3qpW3S49mhBg@mail.gmail.com>
Message-ID: <CALCETrXp0oEu1zeCHUjPJb+i6Y7vR6zCtHGKzP3qpW3S49mhBg@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH] x86/stackframe/32: repair 32-bit Xen PV
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Jan Beulich <jbeulich@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 9:32 AM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
> On 24/10/2019 17:11, Andy Lutomirski wrote:
> >> +# define USER_SEGMENT_RPL_MASK (SEGMENT_RPL_MASK & ~1)
> >> +#endif
> >> +
> >>         .section .entry.text, "ax"
> >>
> >>  /*
> >> @@ -172,7 +183,7 @@
> >>         ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
> >>         .if \no_user_check == 0
> >>         /* coming from usermode? */
> >> -       testl   $SEGMENT_RPL_MASK, PT_CS(%esp)
> >> +       testl   $USER_SEGMENT_RPL_MASK, PT_CS(%esp)
> > Shouldn't PT_CS(%esp) be 0 if we came from the kernel?  I'm guessing
> > the actual bug is in whatever code put 1 in here in the first place.
>
> Ring1 kernels (32bit) consistently see RPL1 everywhere under Xen.
>
> Back in the days of a 32bit Xen, int $0x80 really was wired directly
> from ring 3 to 1, and didn't bounce through Xen.  This isn't possible in
> long mode, because all IDT gates are required to be 64bit code segments.
>
> Ring3 kernels (64bit) consistently see RPL0 everywhere under Xen,
> because presumably this was less invasive when designing the ABI.
>

OK, gotcha.

So I'm fine with this patch if you improve the comment and definition.
