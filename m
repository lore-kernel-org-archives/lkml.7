Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325B0C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00ABF208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HHIbNAl2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfF0VaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 17:30:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36177 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF0VaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:30:19 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so1973769plt.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 14:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l3YW+2jcLgYN4oaHRnnDv11W/CoBacLZ8zMmJkEioDc=;
        b=HHIbNAl2DMs1IW6sciIhs6PFHnrTCBjgCkjuj06Oo0rz7KROq+01ZEgs3EYfCyWt9g
         X/fOp37LHF3JlyHWre/fn05fWjbJ+DoE+W8AGoNZ/FLVyYFSwD3xRbSzphAvXyus91nC
         ZAte9fqAIHU303twh6upCBqPVo0LL6sWpZklezw/L/+AysyP8a6XojjW6NPUBwIPDg2/
         26cx/z1HcStpgO4xq2HuKcVsTmA/vrfVz4yHnaApiXWr8j6I0Ix9Z1yGXMiJT+yc14dN
         SqAyl2meWSIQU1nFR2GIjLS0O8pnZFp+eKLZFRQvHd0PAL0Jk3BzNjBnKFADnOOatin4
         kzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3YW+2jcLgYN4oaHRnnDv11W/CoBacLZ8zMmJkEioDc=;
        b=Vz4lPEyEbjB2m3FgnYb6rGYa7Q3uUJvjPOXHHxqIUQqg3m/dMi6WjJBkjWBsnw7Rh4
         mog5OVNZtLvIun1FHchOGAas1O13ZemfN/OuTZYSrcTg7mp8NS8z1/wAyZqjWZBMOfmG
         KRQV4/TcQFAYZYx56+4ibk+tg0Z3mUrY9bDev1Xz+7Vb9QmJ3zZx7TfSu1cN5tyMrnef
         UIz86UNHI+/oE3uypzkBUMuuoV7EiqGV/ebxKViHVCYbS8VvuCZ9dBKm7NvUQs1Eyg6u
         bDyHLPCBUnVTXci8IC90Er58xALx0tieVRjj5AQgsc0sCAnm1URIok7e3PVz5rNcZ7xv
         fvcA==
X-Gm-Message-State: APjAAAW9hCNy5kahQymdn2rR7kiXLYMI2HZijIhvIjdKOGjtwMrtoojy
        Lh8ANXmfvO7K4Sfq+0jEoNMwjgCf9jTC7AS62XVUQRBXmeE=
X-Google-Smtp-Source: APXvYqyUPXnMqtFiZgEBNqGmZ1gbO1OGNJO0ge+IQZz6/jmXf6xraTK3+4sqd1/0kiqwzcG31BNkPRvjuAuBYiOV/sg=
X-Received: by 2002:a17:902:4aa3:: with SMTP id x32mr6831689pld.119.1561671017667;
 Thu, 27 Jun 2019 14:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190627191448.110756-1-natechancellor@gmail.com>
In-Reply-To: <20190627191448.110756-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Jun 2019 14:30:06 -0700
Message-ID: <CAKwvOdkmacZ0Pu+KcmHb+-e4x0DZs1=FfAKHSo-2xf9LWtknAQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Add ability to test Clang's integrated assembler
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Dmitry Golovin <dima@golovin.in>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 12:15 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> There are some people interested in experimenting with Clang's
> integrated assembler. To make it easy to do so without source
> modification, allow the user to specify 'AS=clang' as part of the
> make command to avoid adding '-no-integrated-as' to the {A,C}FLAGS.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/577
> Suggested-by: Dmitry Golovin <dima@golovin.in>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 5102b2bbd224..d77481129339 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -527,7 +527,9 @@ endif
>  ifneq ($(GCC_TOOLCHAIN),)
>  CLANG_FLAGS    += --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
> +ifeq ($(shell $(AS) --version 2>&1 | head -n 1 | grep clang),)
>  CLANG_FLAGS    += -no-integrated-as
> +endif

This is a nice suggestion and solution.  Thanks Dima and Nathan.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
