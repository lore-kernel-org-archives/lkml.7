Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93F5C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3C1205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f5WDsrWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfLJVb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:31:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43573 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfLJVbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:31:53 -0500
Received: by mail-pg1-f193.google.com with SMTP id b1so9482506pgq.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 13:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GwuPpgMwTPZEM+EqzujwY/bjr0hgFF4x3/rgCEqS8Mc=;
        b=f5WDsrWQ6ZRIQ/PxW73IwPJ17T1V0msim69wBlYUK+6b9M5fCKCNhn4N1DwWjk6bZ9
         LN84wH5MPyKwryNyUEjUyNs8d6mFs7KJ+1OIHdzWDQh4c/8/vMyWJqZTcScNH+Y7eSfF
         4FbDdrjVgmMk2Rp8xodWm7AOtyvz5sWiB/jsWttl39tyCosQcQJ+byG2mBBdoIw9UZF0
         waRRmF6h2lRTwMrBzjsb5lZ4kf0GdrVAT+eJzN6WY/Z2LAoO4htHd0JAWNn6B4x2oHrg
         mqV7BibZMhUAQx/BjgYgofyqs+GwBItobtMroXkJ8VotH30Hd/8TEkMNJZYyF3rHSewm
         Jtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GwuPpgMwTPZEM+EqzujwY/bjr0hgFF4x3/rgCEqS8Mc=;
        b=eBkGwSjUwjuN1mm3bRB8guFGcMv29hZuZrK2A+SWU3L8F3+9cKgaog77t2JDwFot67
         0YH0efTkqJh5QrjDl28j76tLumkM21rBWTBJaA2cXMXNQ/4aAf/ou4MRVRQfOM2JRzSQ
         8GiZZmNlRkBj6LzCvAZA28Wp0jt85tSm1MD/E7ju8WXZp3/fzniZ99bWf5W+M6qGKWdQ
         t11O628g4y4SYv4+Ipth0/gozInn6kV6pw8cs3qu4OQnnkT+y/KicCW9lcO92aU4YUoI
         i9pzjzdZzmkrZxDtMTVmhdXGZF6wf53O//9qkPPw8JfYgj+HyiyA5NlQusqYxATOHEsK
         schQ==
X-Gm-Message-State: APjAAAUOxZhFkQHVr4bHIXMBW4qQQOpRkoCRVj4GWsmmE5Dk91GBTXyL
        GTVM+aI3e5XjJwn58IXntmFN49bEhZdfCZBRwxxdng==
X-Google-Smtp-Source: APXvYqzs9zHaXPpx5/fRmcbjTOsxQRvvH9Qr9I2jE5nXoJrZnej1b37eMSlm1mwwOPgmBS9e5vTq7NGxMlNDfngPnYg=
X-Received: by 2002:a63:597:: with SMTP id 145mr209239pgf.384.1576013512117;
 Tue, 10 Dec 2019 13:31:52 -0800 (PST)
MIME-Version: 1.0
References: <20191210212511.11392-1-sashal@kernel.org> <20191210212511.11392-19-sashal@kernel.org>
In-Reply-To: <20191210212511.11392-19-sashal@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 10 Dec 2019 13:31:40 -0800
Message-ID: <CAFd5g46bujW0XZeTwd1y2O1E2aeK_DayrES8zw_0zBF4Se0HpQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.3 019/292] objtool: add kunit_try_catch_throw to
 the noreturn list
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 1:25 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Brendan Higgins <brendanhiggins@google.com>
>
> [ Upstream commit 33adf80f5b52e3f7c55ad66ffcaaff93c6888aaa ]
>
> Fix the following warning seen on GCC 7.3:
>   kunit/test-test.o: warning: objtool: kunit_test_unsuccessful_try() falls through to next function kunit_test_catch()
>
> kunit_try_catch_throw is a function added in the following patch in this
> series; it allows KUnit, a unit testing framework for the kernel, to
> bail out of a broken test. As a consequence, it is a new __noreturn
> function that objtool thinks is broken (as seen above). So fix this
> warning by adding kunit_try_catch_throw to objtool's noreturn list.
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Link: https://www.spinics.net/lists/linux-kbuild/msg21708.html
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I don't think this change should be backported. This patch is to
ignore an erroneous warning introduced by KUnit; it serves no purpose
prior to the KUnit patches being merged.

Note: I have the same complaint for this rebase here:

https://lore.kernel.org/stable/CAFd5g45s-cGXp6at4kv+=8v3cuxfbXLPEOKGUfvJ6E+u1caHcA@mail.gmail.com/

> ---
>  tools/objtool/check.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 176f2f0840609..0c8e17f946cda 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -145,6 +145,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
>                 "usercopy_abort",
>                 "machine_real_restart",
>                 "rewind_stack_do_exit",
> +               "kunit_try_catch_throw",
>         };
>
>         if (!func)
> --
> 2.20.1
>
