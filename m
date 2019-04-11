Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC323C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0262084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gFW00Cqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfDKRlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:41:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33810 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDKRlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:41:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so3765000plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 10:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P3snWbZlbejCCmhYDZMrWqV9hDWcu3eDsUXFC9h+FXk=;
        b=gFW00CqtGnaT+LcxfRQnMLuJMWUg7a12LhRAzBAfBPl3j/fc+KQrh7/sZyWH03o5cc
         v5Hn8rVpJqaTVSltYhNBPAzNwtQJSRZPUG94kQxqd9RL6gUkcNhqp47z49l1zOm8ubKt
         AjxsxQfip45fMbHCGOReM0O+HpuhzzxlFOxJFh7W1o0Ov7NAbvZfylpw7aL+PG5d+GBx
         f9OINTu/OrCCJs/nLdU/vxMIYV0Tb1SeFCkDSjBLPaP/XimpDvlm1gSNmylf64zIPysm
         Bjb8efXtlrgvVdHtHRpCAPDrRtw8OL1QM/ROkCkkmvlX2XmTIaXTBnA0KlEi3m79jZ6F
         poow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3snWbZlbejCCmhYDZMrWqV9hDWcu3eDsUXFC9h+FXk=;
        b=LtMkdUFSlRsET14UUXKYGC/X/RovjrWGe/sBptUYe1QmEXnvup0XmFN9l1UwaiMqel
         LkQ3UZ7gaX/UuXutZ/+K2RY82H3cuEKPiAfFNnRCAjwvT+IXCfO2ROPQIHouBmtkqS5G
         QIxS1mMsuV9Cy9p5UxwK8Qujsg5Mvi6M0bwvZfV1xZ6AiFaZq50aOZyGPtAzWR5l6wln
         RR6rflFaDRhEhG7cuoPmauClXn+y8z5WWyw2IdJNr6mRhXElmVKuUZEVX2vuGK2/KVkp
         7xE0GnzGl8Z6YBpFon4p5IMSwTqoq6vvznk0l5v6cuTF1HzV5bBnTgLxWmheSk454AGo
         UxQA==
X-Gm-Message-State: APjAAAU5g3PwMZYF1WAYOE3HWLVY7IU05uzIlfzJz+JDmeSG3lLkL0a1
        1ho156CCfiYiUESJg0YhpSCCLbUygVgfVaV2oTO0xQ==
X-Google-Smtp-Source: APXvYqx6FJQnvTz9U1ABzqPP2IWDuLrKGqCOd2SXk5IeBi+dRPeOZ4oQ1RcMQ8XtkQUnzfkmh9v1rdVqjdVHHAr/4vI=
X-Received: by 2002:a17:902:7588:: with SMTP id j8mr14428861pll.139.1555004480694;
 Thu, 11 Apr 2019 10:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190410220301.2332-1-louis@kragniz.eu> <c8e4bd0958e7c58465a2535cb10b2ee994334045.camel@perches.com>
 <CAHk-=wgoxnmsj8GEVFJSvTwdnWm8wVJthefNk2n6+4TC=20e0Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgoxnmsj8GEVFJSvTwdnWm8wVJthefNk2n6+4TC=20e0Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 11 Apr 2019 10:41:09 -0700
Message-ID: <CAKwvOdkh=oUoQyT5_mjti-3f3JeQf+CzLDtEOCi7zCZ0coSFBg@mail.gmail.com>
Subject: Re: [PATCH] afs: use correct format characters
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>, Louis Taylor <louis@kragniz.eu>,
        David Howells <dhowells@redhat.com>,
        linux-afs@lists.infradead.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 9:31 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Apr 10, 2019 at 4:01 PM Joe Perches <joe@perches.com> wrote:
> >
> > I really think this clang message should be ignored.
>
> Agreed.
>
> > It's really unnecessary as every vararg argument smaller
> > than int size is already promoted to int.
>
> Exactly. It's a pointless warning, making for more complex code, and
> making people remember esoteric printf format details that have no
> reason for existing.
>
> The "h" and "hh" things should never be used. The only reason for them
> being used if if you have an "int", but you want to print it out as a
> "char" (and honestly, that is a really bad reason, you'd be better off
> just using a proper cast to make the code more obvious).
>
> So if what you have a "char" (or unsigned char) you should always just
> print it out as an "int", knowing that the compiler already did the
> proper type conversion.
>
>                              Linus

https://bugs.llvm.org/show_bug.cgi?id=41467

I still think -Wformat helpful for catching completely nonsensical
format strings like printing a floating point type as an integral
type, or not having the correct number of arguments for the number of
format strings.  We'll take a look to see if we can differentiate
between those and these "integer widening" ones better.
-- 
Thanks,
~Nick Desaulniers
