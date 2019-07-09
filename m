Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B992AC73C5C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 22:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C2C2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 22:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562709637;
	bh=bZB3wvd281Tkbuktzn2vzVJvaisRfC1J+QDnNtgkiYQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=E+LNcm6in/uCZdPbZ+oje+Kd/Oe5Isg8CdUyvvT4WeJB0wGmm22SRyIvbVBZ4xgcl
	 FtE4k8MqmF73jKRqUMey9B/FJXp6td/mCfCdwdwvAEz6f4uGM+tr2d0KkGV5O4jvOv
	 seVEZn9wNMJCEHwUXr3DVfY89WCy39W5yZa3S+RU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfGIWAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 18:00:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43974 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfGIWAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 18:00:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id c19so98562lfm.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 15:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8LCwmhlroqvJoYVtDftuB4WQNbdMt0NyyAkLxO2Zs9Q=;
        b=HhwTYpbATadQKDGXoiAludJULBBU0pueoAUphrh8Qaksl3ncvO1J6KZ62+ktfNXAlG
         DSFOMyGTLdI8yJsK/mFpOMYNtuCJoMkpBXOq7FBXxcPYOfCtbbBNq2ixwBKZmzQQJHLn
         MZfyY2VFMtHkHDCy/N+jJ5bx9mtpYey9ALX2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8LCwmhlroqvJoYVtDftuB4WQNbdMt0NyyAkLxO2Zs9Q=;
        b=UPypmSYYednkaMuqk11qlETMmpCw444/Dt4eMr07LbtNmj+vNW48nJtoZOeUf38gbe
         sffE4TwtgSO7Dlkg71BbMHIvUEr8aIgdUsqwroh0rbt1dRdNmCIB3aHHu+xU1qnsPK9z
         RmytII11eRLLCSqdvuU/UOpBeYTD4U24RKXZrA9/H3EtIXupyP8rCKZFXFkC32eY0YoI
         BKDdHUCF4+Yk3+znskQlv3Awv8QAr/0FGyAMhio50Lk5SvskUAKxr5rpon0NiqeXwERw
         bZ4MPby4OeS8oXyv4JmavuQJkeCGuKPO552s9R2OKTCGUBFfgEb9WCDI9U1d2VR9u5l6
         sSqQ==
X-Gm-Message-State: APjAAAV7uot15x21Z2CDcnzYi1RQCVDXJAulWgMWKzhOt5j0RzlGJ1YS
        kg5Q22j2iNKiZYP8KHokQRrDX+vxjZU=
X-Google-Smtp-Source: APXvYqxMZDziGZtnvBS3DIV/DeEaELQzJvxt+7lr1h8pkyT2tMUn6vnrB8LPkCCBFSqc8dumtE+ffw==
X-Received: by 2002:ac2:47fa:: with SMTP id b26mr12661782lfp.82.1562709633098;
        Tue, 09 Jul 2019 15:00:33 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id c15sm57781lja.79.2019.07.09.15.00.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 15:00:32 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id c19so98489lfm.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 15:00:31 -0700 (PDT)
X-Received: by 2002:a19:641a:: with SMTP id y26mr11915886lfb.29.1562709631714;
 Tue, 09 Jul 2019 15:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190708162756.GA69120@gmail.com> <CAHk-=wigbHd6wXcrpH+6jnDe=e+OHFy6-KdVSUP2yU5aip-UAg@mail.gmail.com>
 <CAHk-=wgkWTtW-JWVAO0Y6s=dRgZGAaTWAsOuYaTFNJzkF+Z_Jg@mail.gmail.com> <CAHk-=whJtbQFHNtNG7t7y6+oEKLpjj3eSQOrr3OPCVGbMaRz-A@mail.gmail.com>
In-Reply-To: <CAHk-=whJtbQFHNtNG7t7y6+oEKLpjj3eSQOrr3OPCVGbMaRz-A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Jul 2019 15:00:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com>
Message-ID: <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
To:     Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 2:45 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> and I suspect it's the sensitive bit pinning. But I'll delve all the way.

Confirmed. Bisection says

873d50d58f67ef15d2777b5e7f7a5268bb1fbae2 is the first bad commit
commit 873d50d58f67ef15d2777b5e7f7a5268bb1fbae2
Author: Kees Cook <keescook@chromium.org>
Date:   Mon Jun 17 21:55:02 2019 -0700

    x86/asm: Pin sensitive CR4 bits

this is on a bog-standard Intel setup with F30, both desktop and
laptop (i9-9900k and i7-8565u respectively).

I haven't confirmed yet whether reverting just that one commit is
required, or if I need to revert the cr0 one too.

I also don't have any logs, because the boot never gets far enough. I
assume that there was a problem bringing up a non-boot CPU, and the
eventual hang ends up being due to that.

                   Linus
