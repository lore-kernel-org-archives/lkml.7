Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF07C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 23:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E293520692
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 23:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fwi70FRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390584AbfIMXaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 19:30:01 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38697 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388993AbfIMXaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 19:30:00 -0400
Received: by mail-vs1-f66.google.com with SMTP id b123so19727510vsb.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 16:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6e1N1HadwMgefYTfoH4GPm+Nq2OuNTMxQu6eofVTHgI=;
        b=Fwi70FRcAmJTv0Dh/UDj+Sx87sUmeJcTq2dFxFXtV/ubv6WAEyGjp5+mRE7NXkKWGu
         0V/EXOlbzfKDlb3Jbso/vZoR1xMpw0egUxGpk+mN9ds9STbRNGXp45IoZOY74oVh/9ia
         IKH3PKUGJwAbblp3VhAcHkrWyzPb9LareUXEvdwloOvHLq2r94aPPw+ajgGg8BQ7MOZD
         Cz39+CjBTnBTqfeSXjUpBU7tMX0MHMdezkqfE19P5Xe+aDAwTgB0JQyOLfxx1NvtPWCD
         8xO8k7n1VNwdLW96q53r45M4ixHyBdhb8Dc/60VQbkjHA+yDq92bQMDmBRXxUq9CPW/f
         eNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6e1N1HadwMgefYTfoH4GPm+Nq2OuNTMxQu6eofVTHgI=;
        b=WYFcT0ONvq0rDGg/FzlzlLdjY7YNvwkH+CfmSA5PEmKsXuMdfJQuVv4HvxEMgaKPBf
         /BKc5F5lBRm2c8Pyjt1c8ceufiJhHquAV6TLn9YTt3NHQogsK6oNrEgFlbCAr45kCRzR
         mtUYMFMnzUTTytU/thA65aIv5xRXKyV5npWbLN4Yfzekq8dv9anF98kWeHzm20Z24705
         teh8CjWXmyHn9oMwP79OAKDc3WaJeOsUz7oinF5AVNs2bnXYqbj7Z9Ya2V58QWsWbr7b
         Or4yROHSxUZVahBOV7zSOVTfImWH0TgPWPZKnSaXGD+CMKwHTrsJD/yxb35G50MmVHmw
         Kj8Q==
X-Gm-Message-State: APjAAAW4ryJ+LtqvJ50flFxO4fF6rwTWrNyFuX8DIOMi629Wbr22pltn
        i8iAzw2A3pJT8ToU4QnQw8oAd++oe90S0SK3SNCD8A==
X-Google-Smtp-Source: APXvYqx9rjxVbBZZxcf7hpmGQwjsiOnMZvDaHUu8Ro3xlKLe6+44T4khXpb/tyE1fksUrJ8sC4v6WEI4xI4k+xsNoDY=
X-Received: by 2002:a67:2606:: with SMTP id m6mr6031246vsm.5.1568417397917;
 Fri, 13 Sep 2019 16:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com>
 <20190913210018.125266-3-samitolvanen@google.com> <CALCETrXve9j=fwaH1rNptKB8OPv_wM4QSPoGa2u9qvHFNE8u7A@mail.gmail.com>
In-Reply-To: <CALCETrXve9j=fwaH1rNptKB8OPv_wM4QSPoGa2u9qvHFNE8u7A@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 13 Sep 2019 16:29:47 -0700
Message-ID: <CABCJKudUJn_q6H2DNtZYS--QJtsgydex9752PwFTT9tH608nww@mail.gmail.com>
Subject: Re: [PATCH 2/4] x86: use the correct function type for sys32_(rt_)sigreturn
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 3:44 PM Andy Lutomirski <luto@kernel.org> wrote:
> Shouldn't these be COMPAT_SYSCALL_DEFINE0?

Sure, that would work too.

> I think you should pick this patch up and add it to your series:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/syscalls&id=07daeef08d26728c120ecbe57a55cb5714810b84
>
> with the obvious type fixup, of course.  And then write a little patch
> to use COMPAT_SYSCALL_DEFINE0 for rt_sigreturn and sigreturn.

Thanks. I'll do that and send v2 next week once I get some more
feedback on the other patches.

Sami
