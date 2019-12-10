Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8C8C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2446520836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yi+iiwyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfLJV0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:26:10 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41623 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbfLJV0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:26:07 -0500
Received: by mail-pg1-f194.google.com with SMTP id x8so9494763pgk.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 13:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P3CtzH8AoZNRV0QZPYFHChpbwIUEtjX+HfgVaCPCW0A=;
        b=Yi+iiwyyrF3IYMCCzCBjiPMce2oqIFmM0Xe7X7HraruPyvvuHKlt27cS/SnnCG2hw5
         5oMQEsLdEizNsGATmWxJhL17P3CrGayxm5W6xXSUB9EsGKO5L0am6CiDgj66illqeJZA
         mDtWxaOARAr9pxMLBrmpZpISvGD8xa5dWuokcVoxjObx10YcKt+BDYQhHqE+C2qf5niv
         Nno9unu53nGCKBKa1MXv8G8TdFv596C1aMr9ssWcEuAq7ilHnxw5AbBy5b+gb7LNfQN0
         T01Apo8Ke1kZwbHByG6dz+/NN02QV/h33F2cVGpfGCLBXPVAYhXnqgwZ+s8+XwGLaPYv
         IwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3CtzH8AoZNRV0QZPYFHChpbwIUEtjX+HfgVaCPCW0A=;
        b=cdyN9+UL6Mz2+wr4OI+P3hj+qVE83Hiu9rxLqd1nZWjxXN96JO65e65CMwwZ/qstTn
         gkZEoWYvYtNrz+b8tIsf1o03lydTiqkQoFMCp2Veen4Su1dCL4LRfzevop7jlkyQ69fB
         vkjZEbF4+mi34ngypl2d4h/lVf51onTHC0VjMdbO1L2Ggxvqrcfv8i0eezOJHsvXO4kZ
         1OEtqCu8u6u9P5LS3VYr+PmtVd6yvBpllwCyFGCMVXkaSoDYPVZc2zOoygJruBmo0nfT
         L4fH4ZsLAEYfeX4eQIvM5Pod6y0eYIDcu1piZiEJ7AYWlzG/G3Cwg+pgkBgWaWPNFtOa
         ZBHA==
X-Gm-Message-State: APjAAAUZpN01O0TbsoTuIqfEW7W2WtXQrCIGc6n0/cCQUNQ/gKAt6Vu5
        P344oOYVuSHM5Uzt/UERawjkrQ68PKjR4ysW5u9enQ==
X-Google-Smtp-Source: APXvYqxpquTI2AjFI2FJW7H/UjW477l0ZNP57sYRhalkJYdVRDhwtSnkXMVoH2DkQcUGAGX7ywj1awJ0Yv6fEh5hpRI=
X-Received: by 2002:a63:480f:: with SMTP id v15mr162738pga.201.1576013166051;
 Tue, 10 Dec 2019 13:26:06 -0800 (PST)
MIME-Version: 1.0
References: <20191210210402.8367-1-sashal@kernel.org> <20191210210402.8367-25-sashal@kernel.org>
In-Reply-To: <20191210210402.8367-25-sashal@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 10 Dec 2019 13:25:54 -0800
Message-ID: <CAFd5g45s-cGXp6at4kv+=8v3cuxfbXLPEOKGUfvJ6E+u1caHcA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.4 025/350] objtool: add kunit_try_catch_throw to
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

On Tue, Dec 10, 2019 at 1:04 PM Sasha Levin <sashal@kernel.org> wrote:
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

> ---
>  tools/objtool/check.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 044c9a3cb2472..543c068096b12 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -144,6 +144,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
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
