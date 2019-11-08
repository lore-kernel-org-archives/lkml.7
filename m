Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F047C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 01:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4116C2178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 01:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o1RBKYxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfKHBHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 20:07:44 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43844 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfKHBHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 20:07:43 -0500
Received: by mail-pl1-f194.google.com with SMTP id a18so2835111plm.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 17:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vNYHIxb4w5wh5OJ2UcsY/rxFSYSM5NjM0g5yCBahmMM=;
        b=o1RBKYxFeem3vQdmMcb09c/Czaur5BjspbdukbuDfCPWavGuCZYv2d5eYk3lzUh5zm
         64GDst1itnU6KFqzbvLptz0a7TprmbEIfrVlckuFFjVVhbFLt4noKjbjPsr0C2VT7zs7
         oCXWMnTKo7jhXWG8Azi4vgX7U037o0KWgXiqfqk324fSvD+XVtYNGMlNsvtdRQlFlnzx
         XhjuZEhaqpSLjag1ZJGKxsH9Alr304AWYK1hlAREjI/7pwZH/cCON+gJC3eoMzy5jIvC
         XO2TvoGVoVH9G7xuHsfnddVQJF6HiX0rJKy4qOrdLFUwO9ViLCySgdXxB6CKMgB7DQ+x
         zuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vNYHIxb4w5wh5OJ2UcsY/rxFSYSM5NjM0g5yCBahmMM=;
        b=OEGbdE9qAMCBOe5KenKztsgWhw+KMjeFk4eWiFKpyrdENSHtMBzpkBenamyJWhaOsL
         jMxN8EzC3vji+AI14QnNLocY3lD9JGLH6nJaDq3GIybLuHwvyxWKn1TIdG79M5s1GAPP
         oXXkddkgEVYrQSQQgmRxCju/xB1aCUAr4ar1opF2PHVNOhUsttrHJgFm+j83BDKZrbBa
         4PHUcQsPINTp63jtraz2SGSz8wj5uE711370Nrhb0vtABsnc5ZdbfzbkKASf1c+Pc3NU
         uT0j4Y38BD0riyUOdUjWdQiCqM0cxkiacpFWowNfzkfNrfnlx4FnSFb39ppxg722HWDe
         EhBw==
X-Gm-Message-State: APjAAAXwX6pu3VyQylIPS9rGAzXKD7HxhGrR31P3QTCGMxK+MeQy0vtJ
        PKI7R8AnCsgkcCzYI1DHAT0/qODCq7fnqaaiVYGvRQ==
X-Google-Smtp-Source: APXvYqw+LoU/IiQ8hdHb0R4rY4nc0yI7TqoKto/BO3EMbJDNKkiWiBcBbg8Rvg4gxblStWoydjQcOZFgytKxwL5aXKY=
X-Received: by 2002:a17:90a:252d:: with SMTP id j42mr9572203pje.131.1573175262439;
 Thu, 07 Nov 2019 17:07:42 -0800 (PST)
MIME-Version: 1.0
References: <1571335639-21675-1-git-send-email-alan.maguire@oracle.com> <1571335639-21675-3-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1571335639-21675-3-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 7 Nov 2019 17:07:31 -0800
Message-ID: <CAFd5g45qUkKMHizkmM6O54a3_zOjTN_PxDbD+bwHkgvr1wPrcg@mail.gmail.com>
Subject: Re: [PATCH v3 linux-kselftest-test 2/6] kunit: hide unexported
 try-catch interface in try-catch-impl.h
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 11:08 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> also remove unused kunit_generic_try_catch
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  include/kunit/try-catch.h  | 10 ----------
>  lib/kunit/test-test.c      |  1 +
>  lib/kunit/test.c           |  1 +
>  lib/kunit/try-catch-impl.h | 23 +++++++++++++++++++++++

Just wanted to say that I *am* happy with the *-impl.h naming scheme
here since there is a public header file with almost the same name. So
everything looks good to me with this patch.

>  lib/kunit/try-catch.c      |  1 +
>  5 files changed, 26 insertions(+), 10 deletions(-)
>  create mode 100644 lib/kunit/try-catch-impl.h

Thanks for the patch!
