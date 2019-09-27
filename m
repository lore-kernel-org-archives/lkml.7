Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E4DC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 22:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530A721850
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 22:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nb7R0Uo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfI0WId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 18:08:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32947 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfI0WId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 18:08:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id d22so1597638pls.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 15:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QclGIxEt9wIwf/D5SYN1US1c97mZDr9iuEHzA7hulOc=;
        b=Nb7R0Uo8kJGk6pIv8mrz1TSF1TwnUnKp1wVJGg+UdXj3D4RCiF7u0hawk91MqImsVQ
         aXOsqOPLeYFnReqiyQ5aiodoOy1ByH7GoAqSIQnAWjd3vltsjZpGQrhwiHnvTf3t5ydY
         ByIW8N6lJG+/BIIgWqYkHWAaGNaqGuOqzItiKEA0W/3HjdpA7vWsWT/JrXzybFhBg9Md
         6SOQPxkTfGcqG3XTYKHzXLd5jP7fE1b7SNTfv1OHz42/1WJTIN175zJJXKcW6NREOiwh
         BDKoz5wf5mDQTuX9vJ8VdBQgWyjJzPyy7sHiwnV3VC0tN3MzbNCPWeGagWeCNBK/eE7w
         mFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QclGIxEt9wIwf/D5SYN1US1c97mZDr9iuEHzA7hulOc=;
        b=kLy/rTnf3dTiqhR30wP76NCBcuLVXpEQdLsYz1ct5kFGfUTX1jq03o/xMM7Z1yA1NR
         9jjZczjrizhTYTNNH/kFhZksyfZuQx1/xMKPAk5hP4q2uWILe2IbaxId+CFNfHOChs0g
         dejsHNTLxr9FQR93G7aGd1hvFAToCdLvBsv54iTlFbAZ2OAE2i8uc4EhDTzAcWm5mxYS
         T3nZDVRvp+pXsrsizi+ciWQQ3A2HqMzJwpPcIOPoG+3WZJdZB2VQm86pVxf4bVrfOT2E
         MPNVLO9tL6z2XrDSwC9JsA/Fqotf8gmZjf9aBjb6rQlDWAHSgb8+rASvRhTZ33uTUnqZ
         hyJg==
X-Gm-Message-State: APjAAAV4tZ6JOHUasHARfZYb9obgmt0bq1WD8wvHWU/lhZdQhV0KZzZe
        cwEJ6tY/m1KHaouy2eHjNVe5T1f5JKrDHd5abWNdmw==
X-Google-Smtp-Source: APXvYqz92+mVA5I3LKt61mIUPkDYBwp18EWEu6GPdh84rUZXFmpV9Q2ceBhRV8PBVhENBXLuxesaMZzgzmtIzdlR5c0=
X-Received: by 2002:a17:902:d891:: with SMTP id b17mr6858867plz.119.1569622112129;
 Fri, 27 Sep 2019 15:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190830034304.24259-1-yamada.masahiro@socionext.com> <f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de>
In-Reply-To: <f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 27 Sep 2019 15:08:20 -0700
Message-ID: <CAKwvOdk=tr5nqq1CdZnUvRskaVqsUCP0SEciSGonzY5ayXsMXw@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rmk+kernel@arm.linux.org.uk, Will Deacon <will@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 3:43 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Fri, 2019-08-30 at 12:43 +0900, Masahiro Yamada wrote:
> > Commit 9012d011660e ("compiler: allow all arches to enable
> > CONFIG_OPTIMIZE_INLINING") allowed all architectures to enable
> > this option. A couple of build errors were reported by randconfig,
> > but all of them have been ironed out.
> >
> > Towards the goal of removing CONFIG_OPTIMIZE_INLINING entirely
> > (and it will simplify the 'inline' macro in compiler_types.h),
> > this commit changes it to always-on option. Going forward, the
> > compiler will always be allowed to not inline functions marked
> > 'inline'.
> >
> > This is not a problem for x86 since it has been long used by
> > arch/x86/configs/{x86_64,i386}_defconfig.
> >
> > I am keeping the config option just in case any problem crops up for
> > other architectures.
> >
> > The code clean-up will be done after confirming this is solid.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> [ Adding some ARM people as they might be able to help ]
>
> This was found to cause a regression on a Raspberry Pi 2 B built with
> bcm2835_defconfig which among other things has no SMP support.
>
> The relevant logs (edited to remove the noise) are:
>
> [    5.827333] Run /init as init process
> Loading, please wait...
> Failed to set SO_PASSCRED: Bad address
> Failed to bind netlink socket: Bad address
> Failed to create manager: Bad address
> Failed to set SO_PASSCRED: Bad address
> [    9.021623] systemd[1]: SO_PASSCRED failed: Bad address
> [!!!!!!] Failed to start up manager.
> [    9.079148] systemd[1]: Freezing execution.
>
> I looked into it, it turns out that the call to get_user() in sock_setsockopt()
> is returning -EFAULT. Down the assembly rabbit hole that get_user() is I
> found-out that it's the macro 'check_uaccess' who's triggering the error.
>
> I'm clueless at this point, so I hope you can give me some hints on what's
> going bad here.

So get_user() was passed a bad value/pointer from userspace? Do you
know which of the tree calls to get_user() from sock_setsockopt() is
failing?  (It's not immediately clear to me how this patch is at
fault, vs there just being a bug in the source somewhere).
-- 
Thanks,
~Nick Desaulniers
