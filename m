Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09248C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F772184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389119AbfEXHlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 03:41:11 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40121 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388960AbfEXHlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 03:41:10 -0400
Received: by mail-qk1-f193.google.com with SMTP id q197so6033838qke.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 00:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FRYxcsA8gB9FibohJrWOdhqpBp517njxkreby+OWZAA=;
        b=a5i0hc5HW8w1Q7zIUP9Y7DPRDw4v8USDI6kD/nh9++tvffpz1+pgiRf+aAWJCuQAvc
         OIBY6KFziDqoUfqsDk4O8SSfsHBCc31jzc/FwSqDjEjnEaV6VHe3X5K5lB/RstOu6hL9
         6CBlzXrLrpyAJoqlrkVjZ+tF9DJfKL63h6Lo156jmtIPoH1W+ZAGO0a2+cW4cXIytmOc
         h5wPK2oeuI+jYnGTp4IRuEob+oJ8PTmig6ExqmPWRNIwhP43sScFJPdsstJuTgX3J/Ts
         MWPDI6l//x6qkrE65S1luOK+DeMthJi+YNLJML9Es5IOQ8yzvWdi+9LneyLUVHQP9RJe
         kndg==
X-Gm-Message-State: APjAAAW72Ci0vCiVaABYqUXR6hnFXMLStBV1GipmXcGSA1nvfm5IQhKT
        koA87j/MdXUDHVrfdJe81IhW9nhznkluqXATU5E=
X-Google-Smtp-Source: APXvYqwKjoorl+i2iSi0wJjXdbgxY2NnU3CoD/Rr8CXva8Z9KCBM7/GgIHAXtDLbf7tJIkQBQvIgx6lRi0X7Yz2ZISg=
X-Received: by 2002:a37:3ce:: with SMTP id 197mr78391397qkd.14.1558683664367;
 Fri, 24 May 2019 00:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAAzmS69VFrTPzZ8DY_NPPTZYtBssocRnQOFAyo3VbSTO4CesbA@mail.gmail.com>
 <20190523161532.122421-1-natechancellor@gmail.com> <CAKwvOdmjQvCh__ZH+gLLgcKy4u1n5cgJQPU1WRuitEp+UZra5w@mail.gmail.com>
In-Reply-To: <CAKwvOdmjQvCh__ZH+gLLgcKy4u1n5cgJQPU1WRuitEp+UZra5w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 24 May 2019 09:40:47 +0200
Message-ID: <CAK8P3a3RE3Jwft6WTNavV7St3P+mVFwRyCQFVaO3==LB7j29rw@mail.gmail.com>
Subject: Re: [PATCH] misc: sgi-xp: Properly initialize buf in xpc_get_rsvd_page_pa
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Cliff Whickman <cpw@sgi.com>,
        Robin Holt <robinmholt@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Stephen Hines <srhines@google.com>,
        Tony Luck <tony.luck@intel.com>, rja@sgi.com,
        Fenghua Yu <fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 8:05 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Thu, May 23, 2019 at 9:20 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns:
> >
> > drivers/misc/sgi-xp/xpc_partition.c:73:14: warning: variable 'buf' is
> > uninitialized when used within its own initialization [-Wuninitialized]
> >         void *buf = buf;
> >               ~~~   ^~~
> > 1 warning generated.
> >
> > Initialize it to NULL, which is more deterministic.
> >
> > Fixes: 279290294662 ("[IA64-SGI] cleanup the way XPC locates the reserved page")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/466
> > Suggested-by: Stephen Hines <srhines@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>
> From https://github.com/ClangBuiltLinux/linux/issues/466#issuecomment-488781917
> I tried to follow the rabbit hole, but eventually these void* get
> converted to u64's and passed along to function that I have no idea
> whether they handle the value `(u64)(void*)0` or not.  Either way,
> they definitely don't handle uninitialized values/UB.
>
> I was going to cc Robin who's already cc'ed, but looks like this code
> was last touched 7-10 years ago. + Tony and Fenghua for ia64 since
> sn_partition_reserved_page_pa is defined in
> arch/ia64/include/asm/sn/sn_sal.h.
>
> In absence of consensus, I'll prefer NULL to uninitialized.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Thanks Nathan for following up on this.

I also had to take a look, and I think I understand what's going on,
and interestingly, the code is correct, both before and after your patch.
It's described in this comment:

/*
 * Returns the physical address of the partition's reserved page through
 * an iterative number of calls.
 *
 * On first call, 'cookie' and 'len' should be set to 0, and 'addr'
 * set to the nasid of the partition whose reserved page's address is
 * being sought.
 * On subsequent calls, pass the values, that were passed back on the
 * previous call.
 *
 * While the return status equals SALRET_MORE_PASSES, keep calling
 * this function after first copying 'len' bytes starting at 'addr'
 * into 'buf'. Once the return status equals SALRET_OK, 'addr' will
 * be the physical address of the partition's reserved page. If the
 * return status equals neither of these, an error as occurred.
 */
static inline s64
sn_partition_reserved_page_pa(u64 buf, u64 *cookie, u64 *addr, u64 *len)

so *len is set to zero on the first call and tells the bios how many bytes
are accessible at 'buf', and it does get updated by the BIOS to tell
us how many bytes it needs, and then we allocate that and try again.

With that explanation added,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
