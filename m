Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466ABC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0393E20830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SVPzt/BE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfDBV3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:29:48 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:34144 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfDBV3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:29:48 -0400
Received: by mail-vk1-f195.google.com with SMTP id x84so2018355vkd.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mdMF1dPhHlX6mW7IUYjf4Lqz+x729lAivuO2qyg8Mxg=;
        b=SVPzt/BE6w0xzkBcjPhBSZ3wPhCvnJFBZ2QV9GRk54lvn1iturdJocsJW+5LRvuV/d
         gulVktjsRTLeatu5JPLuuzLMX56A/JRA7V0XnebLJa/R6gWHZgdzWgHj2LkLKJitTcV4
         0cj7Tg+e55wARmJbOxZT1HE76BsWp/RHcCgfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mdMF1dPhHlX6mW7IUYjf4Lqz+x729lAivuO2qyg8Mxg=;
        b=bIHiKW5DLSGBk32uE3ppIsBTanmNa2gXfD0IBQ5zhrBPf9YLV1mQxCTT9lhMRy3hd/
         jSA0kMxJd5B+WhQB7HDyrCO1Q8uK+CvMi0wtAzzFcL8vNPHVy1Y5gnRwY6q6cQzgOsyE
         Qz3R/Ykqpm3TB3KGT5jAtzAzRPkseSNFnR5kgExMuM058LcVV+XJDwW6foiFQ8ApaD1h
         Q2KPK2n0qOEFTVNUuP0dvNDguGUU6fgxuhiqncxBnBwQacvrqUT+hd+pTRhpaNMkadT1
         OHMPorqvNOOFmvd9B8zlnkWAGHhF0zCj9vfrvHogq4sXSTiHZ45SlXOcS1KiyMcW+VKD
         oK3w==
X-Gm-Message-State: APjAAAVP97UOUrryTMTeHYrXfNzaXVfwx05JDxC4AmXCWTCQ4WJHLfxr
        DLPpmCJpJnv807bK1H8e3K8r4FPNv/w=
X-Google-Smtp-Source: APXvYqzGwCE7HmicKbcus7g9q8fr7M8px0Y74QQCd2sjUeEoe4t1Xmc4tlQ9PfJX6YBmTi79rgzcKw==
X-Received: by 2002:a1f:2c8:: with SMTP id 191mr37793247vkc.29.1554240586377;
        Tue, 02 Apr 2019 14:29:46 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id y1sm14519067uai.0.2019.04.02.14.29.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 14:29:43 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id h71so3337150vkf.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:29:43 -0700 (PDT)
X-Received: by 2002:a1f:2443:: with SMTP id k64mr11670405vkk.47.1554240582841;
 Tue, 02 Apr 2019 14:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190306214226.14598-1-tobin@kernel.org> <20190306214226.14598-4-tobin@kernel.org>
In-Reply-To: <20190306214226.14598-4-tobin@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 2 Apr 2019 14:29:31 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+OPGL3N95cxRWDm5zi=ZpyEH5qA4==UdedYqWr_yi6GQ@mail.gmail.com>
Message-ID: <CAGXu5j+OPGL3N95cxRWDm5zi=ZpyEH5qA4==UdedYqWr_yi6GQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] kselftest/lib: Use new shell runner to define tests
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 1:43 PM Tobin C. Harding <tobin@kernel.org> wrote:
>
> We just added a new script kselftest_module.sh that can be used to
> define kselftest tests that run tests within a kernel module.  We can
> use it to reduce code duplication in all of the test runner scripts in
> tools/testing/selftests/lib/.
>
> Use new shell runner tools/testing/selftests/kselftest_module.sh to
> define test runner scripts.
>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  tools/testing/selftests/lib/bitmap.sh        | 25 ++++++++++----------
>  tools/testing/selftests/lib/prime_numbers.sh | 23 +++++++++---------
>  tools/testing/selftests/lib/printf.sh        | 25 ++++++++++----------
>  3 files changed, 35 insertions(+), 38 deletions(-)
>
> diff --git a/tools/testing/selftests/lib/bitmap.sh b/tools/testing/selftests/lib/bitmap.sh
> index 5a90006d1aea..ed4180ea0021 100755
> --- a/tools/testing/selftests/lib/bitmap.sh
> +++ b/tools/testing/selftests/lib/bitmap.sh
> @@ -1,19 +1,18 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>
> -# Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=4
> +module=test_bitmap
> +description="bitmap"
>
> -# Runs bitmap infrastructure tests using test_bitmap kernel module
> -if ! /sbin/modprobe -q -n test_bitmap; then
> -       echo "bitmap: module test_bitmap is not found [SKIP]"
> -       exit $ksft_skip
> -fi
> +#
> +# Shouldn't need to edit anything below here.
> +#
>
> -if /sbin/modprobe -q test_bitmap; then
> -       /sbin/modprobe -q -r test_bitmap
> -       echo "bitmap: ok"
> -else
> -       echo "bitmap: [FAIL]"
> -       exit 1
> +file="kselftest_module.sh"
> +path="../$file"
> +if [[ ! $KBUILD_SRC == "" ]]; then
> +    path="${KBUILD_SRC}/tools/testing/selftests/$file"
>  fi

Can this just be reduced to something like:

. $(dirname $0)/../kselftest_module.sh

call_functions_here ...

> +
> +$path $module $description
> +
> diff --git a/tools/testing/selftests/lib/prime_numbers.sh b/tools/testing/selftests/lib/prime_numbers.sh
> index 78e7483c8d60..6f782386d897 100755
> --- a/tools/testing/selftests/lib/prime_numbers.sh
> +++ b/tools/testing/selftests/lib/prime_numbers.sh
> @@ -2,18 +2,17 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Checks fast/slow prime_number generation for inconsistencies
>
> -# Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=4
> +module=prime_numbers
> +description="prime_numbers"
>
> -if ! /sbin/modprobe -q -n prime_numbers; then
> -       echo "prime_numbers: module prime_numbers is not found [SKIP]"
> -       exit $ksft_skip
> -fi
> +#
> +# Shouldn't need to edit anything below here.
> +#
>
> -if /sbin/modprobe -q prime_numbers selftest=65536; then
> -       /sbin/modprobe -q -r prime_numbers
> -       echo "prime_numbers: ok"
> -else
> -       echo "prime_numbers: [FAIL]"
> -       exit 1
> +file="kselftest_module.sh"
> +path="../$file"
> +if [[ ! $KBUILD_SRC == "" ]]; then
> +    path="${KBUILD_SRC}/tools/testing/selftests/$file"
>  fi
> +
> +$path $module $description
> diff --git a/tools/testing/selftests/lib/printf.sh b/tools/testing/selftests/lib/printf.sh
> index 45a23e2d64ad..89717915d028 100755
> --- a/tools/testing/selftests/lib/printf.sh
> +++ b/tools/testing/selftests/lib/printf.sh
> @@ -1,19 +1,18 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
> -# Runs printf infrastructure using test_printf kernel module
> +# Tests the printf infrastructure using test_printf kernel module.
>
> -# Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=4
> +module=test_printf
> +description="printf"
>
> -if ! /sbin/modprobe -q -n test_printf; then
> -       echo "printf: module test_printf is not found [SKIP]"
> -       exit $ksft_skip
> -fi
> +#
> +# Shouldn't need to edit anything below here.
> +#
>
> -if /sbin/modprobe -q test_printf; then
> -       /sbin/modprobe -q -r test_printf
> -       echo "printf: ok"
> -else
> -       echo "printf: [FAIL]"
> -       exit 1
> +file="kselftest_module.sh"
> +path="../$file"
> +if [[ ! $KBUILD_SRC == "" ]]; then
> +    path="${KBUILD_SRC}/tools/testing/selftests/$file"
>  fi
> +
> +$path $module $description
> --
> 2.20.1
>


-- 
Kees Cook
