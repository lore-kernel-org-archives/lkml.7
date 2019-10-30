Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879BDCA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 12:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDB92080F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 12:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rTgsJpzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfJ3Mph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 08:45:37 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42610 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfJ3Mpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 08:45:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id z12so1439170lfj.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 05:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z/lBvgj2tEa3ewK9stecrJwWbqYMjUJzw11XHWG5FOU=;
        b=rTgsJpzWI5VRDYzYA8OK+NMiiwUWn+nXQxhEXl702L+YTP/w8CrLC81P0JJEIstmBR
         1CwT5RWxJkiYre2CpQ3vgohfeSR+vd0HmESrAN+Pc8K3Pp+ldKsr2ITBANimBtbruOqp
         fUhw/5Pu/rRI1CsSEc/1avDvKOGppY2Pvel+6OsYVyIp4EpQ1rlJS3APYLqEY/MrQ4PJ
         gvOlJloA0E5eSPhtgMyesfaO9SmwcFsZxjHpurmfcKYl8F7mt4tS0gGLKD2vDi3aWhPZ
         zF8mfNYh1u7i3D+o/kdwc53E/0Fsr57dp+xD9DqF4w6uJlx8zqhDNoxTgpbYTFpqAQ+w
         x8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z/lBvgj2tEa3ewK9stecrJwWbqYMjUJzw11XHWG5FOU=;
        b=aLSGDQldPPvhHbF/DJW/kyHGb3ZH1eppOF5nEg5KXU/LerW5E3rryErZsca/0dadZO
         /Mkm3A2VGsxNNfL6b+q+k4BQahWDmo8blLPLLSEcnyin7PZKZ68S4JZNWzspmrZynimW
         a2JRDfZDyrEmqNfoV0sQJJT7XfJIz5FReW4zg0vvlI/8PdvFqwIi8abN7hzPrWaOk5qQ
         WIXOaqzo6K7KKuB3srHvCa9S+fljY8QOsqNl5KFx8vEo3NalOZY9p4q8XyhAencgt+cg
         17BoNqnI1BAL+eF3IvTE/WVOuR+SxilGNhCCIx4qMb9tobNjSifmW6ispbI2T+ck47xf
         nfBw==
X-Gm-Message-State: APjAAAVDUskRm6hd1RZE7ujtKEN0ja9WWcZFcNAAed+E8ZCTg7naHYyC
        zowIqqXDg2cWLlWiRd2SFksGzBpTQlF0Xo5FzgGiGg==
X-Google-Smtp-Source: APXvYqzCnpzso0Psg3jJulXH2mRfwtdawfmefqJGiB+XfZIOBEFwhCwPfWOmE5n9Iqbz9Ejbwbc6JT9xQ6haKiRivgw=
X-Received: by 2002:a19:3f0a:: with SMTP id m10mr6181421lfa.67.1572439534595;
 Wed, 30 Oct 2019 05:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190405015859.32755-1-tobin@kernel.org> <20190405015859.32755-3-tobin@kernel.org>
In-Reply-To: <20190405015859.32755-3-tobin@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 30 Oct 2019 18:15:22 +0530
Message-ID: <CA+G9fYsfJpXQvOvHdjtg8z4a89dSStOQZOKa9zMjjQgWKng1aw@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] kselftest: Add test runner creation script
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
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
        kernel-hardening@lists.openwall.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobin,

On Fri, 5 Apr 2019 at 07:30, Tobin C. Harding <tobin@kernel.org> wrote:
>
> Currently if we wish to use kselftest to run tests within a kernel
> module we write a small script to load/unload and do error reporting.
> There are a bunch of these under tools/testing/selftests/lib/ that are
> all identical except for the test name.  We can reduce code duplication
> and improve maintainability if we have one version of this.  However
> kselftest requires an executable for each test.  We can move all the
> script logic to a central script then have each individual test script
> call the main script.
>
> Oneliner to call kselftest_module.sh courtesy of Kees, thanks!
>
> Add test runner creation script.  Convert
> tools/testing/selftests/lib/*.sh to use new test creation script.
>
> Testing
> -------
>
> Configure kselftests for lib/ then build and boot kernel.  Then run
> kselftests as follows:
>
>   $ cd /path/to/kernel/tree
>   $ sudo make O=$output_path -C tools/testing/selftests TARGETS="lib" run_tests

We are missing "kselftest_module.sh" file when we do "make install"
and followed by generating a tar file "gen_kselftest_tar.sh" and
copying that on to target device and running tests by using
"run_kselftest.sh" script file on the target.

Could you install the supporting script file "kselftest_module.sh" ?

Error log,
-------------
# selftests lib printf.sh
lib: printf.sh_ #
# ./printf.sh line 4 ./../kselftest_module.sh No such file or directory
line: 4_./../kselftest_module.sh #
[FAIL] 1 selftests lib printf.sh # exit=127
selftests: lib_printf.sh [FAIL]
# selftests lib bitmap.sh
lib: bitmap.sh_ #
# ./bitmap.sh line 3 ./../kselftest_module.sh No such file or directory
line: 3_./../kselftest_module.sh #
[FAIL] 2 selftests lib bitmap.sh # exit=127
selftests: lib_bitmap.sh [FAIL]
# selftests lib prime_numbers.sh
lib: prime_numbers.sh_ #
# ./prime_numbers.sh line 4 ./../kselftest_module.sh No such file or directory
line: 4_./../kselftest_module.sh #
[FAIL] 3 selftests lib prime_numbers.sh # exit=127
selftests: lib_prime_numbers.sh [FAIL]
# selftests lib strscpy.sh
lib: strscpy.sh_ #
# ./strscpy.sh line 3 ./../kselftest_module.sh No such file or directory
line: 3_./../kselftest_module.sh #
[FAIL] 4 selftests lib strscpy.sh # exit=127
selftests: lib_strscpy.sh [FAIL]

- Naresh
