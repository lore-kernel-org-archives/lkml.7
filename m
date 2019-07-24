Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A337C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6C621873
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v1fdWobT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfGXUz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:55:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37093 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfGXUz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:55:59 -0400
Received: by mail-io1-f65.google.com with SMTP id q22so92537401iog.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 13:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uKJBy2iaUBCua8Sau5lsnnlge7l0Cz16fffzcwsA5cs=;
        b=v1fdWobTFZAmP2WoM31GjI+NFuvU3O+BPgFxE3fw8z8pQsD9+1tkE0+CpxhE/J10A6
         28yp+dIM/1fRnlYIzs2C3XP/KGUhcXYDV8rgL445AjvxSYq7tMtGs4ZyUFpB6oup2aCt
         oJh4M2T9NjdDtCXHBigCMF1YJMngAGz/6Erv97zTxjzmopH91PASt66xjGxRlwCqzKqv
         O5hsPLtvwD71rKMyHdC4hixA83PUlj7VAp/nnziSpyJQYsVgY0KxLEdAcrPbDlkEKaCg
         DNC9TGigoDYwq0u4fhUgPSZOHprHAmwPBxU5a3+nvtYbBoqtM2+KdG9QeFgql9y2+Jcy
         2sIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKJBy2iaUBCua8Sau5lsnnlge7l0Cz16fffzcwsA5cs=;
        b=Y9eE+svDr6he3JZ3mdUqugMy75WTUigCLBorSzRnRiNo8UVWLRuOBBdkf/RPJnDDUP
         mn4uCEsJRcJJtjmX+NsNjdgdoYkvAEEhlCt62Kvu/cmfo6j8f00SYtXyChtdlHuQ/A6s
         JBkQXXeXsYJCBwqrRhsVV774uNrwYxCvUnFlOmGdWrcA4jX7forRr5logS1JuLFBbJf+
         P/lGjPfpZOOxCRF5XeTHgPHlCTyQMibhcrwkCEV/reMhXTwQzcEvD5PcxVFakqyymmt6
         rPOVqTjt1d8zdCW04QnOUElKcZE9JLzxyr/TA8ZGs5U9M1crZ16+qcJemHI0fgR2oMVQ
         sngA==
X-Gm-Message-State: APjAAAXbRcyGf3ACNhAyv03BO1KI7ckl3lVKf13Z1/daQwJ5SILsS7Nv
        8JLQlEqAs8Y0bIwz3qBnIKL7FBU6YIOV5JSe5WRXUw==
X-Google-Smtp-Source: APXvYqzve52LHf2o7jPgYP//tdTSzSHvLil6UKvRYwnN3fvVdWkAv5jWj/kufB/dVFJ4NBLhutNrhg0E1wEwNxqpbwM=
X-Received: by 2002:a6b:ec06:: with SMTP id c6mr79740045ioh.198.1564001758141;
 Wed, 24 Jul 2019 13:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190723212418.36379-1-ndesaulniers@google.com> <alpine.DEB.2.21.1907241231480.1972@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907241231480.1972@nanos.tec.linutronix.de>
From:   Vaibhav Rustagi <vaibhavrustagi@google.com>
Date:   Wed, 24 Jul 2019 13:55:47 -0700
Message-ID: <CAMVonLgwzj2vjKtgXJG2=U04-w+29TZhgykeNYRbWTT55wtNMg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86/purgatory: do not use __builtin_memcpy and __builtin_memset
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        yamada.masahiro@socionext.com, stable@vger.kernel.org,
        Manoj Gupta <manojgupta@google.com>,
        Alistair Delva <adelva@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Uros Bizjak <ubizjak@gmail.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 3:33 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, 23 Jul 2019, Nick Desaulniers wrote:
> > Instead, reuse an implementation from arch/x86/boot/compressed/string.c
> > if we define warn as a symbol. Also, Clang may lower memcmp's that
> > compare against 0 to bcmp's, so add a small definition, too. See also:
> > commit 5f074f3e192f ("lib/string.c: implement a basic bcmp")
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 8fc5b4d4121c ("purgatory: core purgatory functionality")
> > Link: https://bugs.chromium.org/p/chromium/issues/detail?id=984056
> > Reported-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
> > Debugged-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
> > Debugged-by: Manoj Gupta <manojgupta@google.com>
> > Suggested-by: Alistair Delva <adelva@google.com>
> > Signed-off-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> That SOB chain is weird. Is Vaibhav the author?
>
No, Nick Desaulniers is the author of v3.

> > +/*
> > + * Clang may lower `memcmp == 0` to `bcmp == 0`.
> > + */
> > +int bcmp(const void *s1, const void *s2, size_t len) {
> > +     return memcmp(s1, s2, len);
> > +}
>
> foo()
> {
> }
>
> please.
>
> Thanks,
>
>         tglx
Thanks,
Vaibhav
