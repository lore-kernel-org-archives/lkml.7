Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82056C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0E6217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dbvb6XCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388509AbfGPTpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 15:45:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46715 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfGPTph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:45:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id c73so9594229pfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 12:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3AgUbM0e5/92Cpo+sVKZd+RAcuqfF3u7zDN3lIzhJzQ=;
        b=Dbvb6XCqTipqnHRs6g4Di/rpUpD0ZwaKrdunT90pIH/J/v/8eHGkSWCWBIVL9M8pUH
         1HNlccZCrpxwvgw2uwBMO8yuz8B8ZKg4n1tKHnthtWL/OUmZ/t54+mhbn2I/UPjb/u2o
         ajj/c72so+iOxoDOVMq97sa/RldaeLd5MFpezcmglVVXI0g8G5KbuDB48TQItpfdvQRa
         d5JOB1mqnpUigRMITdFSWKLudZL0AJJEbLjrVsnfWfnlshTraD4BNQN61G95MeO3mGz3
         +gHAfTxJyAZ9UW4v/pdPO9OzYftmqIRpjJH3Y2v1AF/pfVdiO1JPjLwPLZxBuj9AVAQ5
         uQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3AgUbM0e5/92Cpo+sVKZd+RAcuqfF3u7zDN3lIzhJzQ=;
        b=fd7jyL4c1vKJYXhviUL6Spwe22DSQUIKbYM04HmdhKzGR1y29yx3hsbgKslxpj/5d5
         9XWgVzVVLChzsapYV8JUZgP5MtX9iOydOdGgw+WFn0OxRj/RHLuAn1itkRx6Y8OcBJMw
         l6/H1+Wkscmnbi2SFmGnO+wvqaY5kocCFGsFFn5cR8qTtS2BeCZcjae0QfjZI1K84Wi+
         VXK0hTboqLzzqegpZiZHkKPJcO5SPHPhy3NVq7tGmbMSG9y4uV1PBmfU7CQmz0FJpG3n
         coKGIzZ96uht7fr8Usi6x3qe1JO1ARMpq2uczmrS4rSsPnhnpPnEHvqUJzzOTWJBIcN0
         wKXg==
X-Gm-Message-State: APjAAAVgrECy7QwnauJkz7F7H5Lu11CVB6vvb7QLeqlQ8SSmSIWDhAwH
        1IXaSdz4NYOhrqiiivNsFi6tcRsnr37cVN8DSr7YKQ==
X-Google-Smtp-Source: APXvYqyQKTKN3LsCMk/VwuKF6YRJV3ojfFHsMtv6uUYsfbcNay4GyBwJMDnmsNxhh6+sFg8wjrhNvKwav8fgfbdT5Jc=
X-Received: by 2002:a17:90a:bf02:: with SMTP id c2mr39169049pjs.73.1563306336472;
 Tue, 16 Jul 2019 12:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAG=yYw=S197+2TzdPaiEaz-9MRuVtd+Q_L9W8GOf4jKwyppNjQ@mail.gmail.com>
 <CAKwvOdmg2b2PMzuzNmutacFArBNagjtwG=_VZvKhb4okzSkdiA@mail.gmail.com> <20190716145716.6b081bdc@gandalf.local.home>
In-Reply-To: <20190716145716.6b081bdc@gandalf.local.home>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 16 Jul 2019 12:45:25 -0700
Message-ID: <CAKwvOd=r3xh+yxCgFqQObwi=sMb9oqG0UcTvNJQ4KWKvN82g8A@mail.gmail.com>
Subject: Re: BUG: KASAN: global-out-of-bounds in ata_exec_internal_sg+0x50f/0xc70
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        tobin@kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 11:57 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 16 Jul 2019 11:28:29 -0700
> Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> > The cited code looks like a check comparing that the pointer distance
> > is greater than the size of bytes being passed in.  I'd wager
> > someone's calling memmove with overlapping memory regions when they
> > really wanted memcpy.  Maybe a better question, is why was memmove
> > ever used; if there was some invariant that the memory regions
> > overlapped, why is that invariant no longer holding.
>
> I'm confused by the above statement as memmove() allows overlapping of
> src and dest, where as memcpy() does not.

Yes you're right; I confused the two.  From the snippet in the
original email, it looks like the body of a fortified memcpy was
provided, and a memmove declaration was below it.  So replace my
assumption of a bad call to memmove with a bad call to memcpy (which
should then make more sense, hopefully).
-- 
Thanks,
~Nick Desaulniers
