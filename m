Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC278C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898C520674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gWmQ5BBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDBVpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:45:40 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45787 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDBVpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:45:38 -0400
Received: by mail-vs1-f66.google.com with SMTP id n14so8677262vsp.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M08pZ30qIC0xl4xO4cVProKNh6rJryNHNCf1B+M1lhg=;
        b=gWmQ5BBLJ4Scwqy3fGXvBfP0UqYItZCQIKv88Zh9uVGaOk5N0XEOGQRo8Mclufko2Z
         X/2VUvAlqN3/tiy+1Bumk7kzStZ9hsS1fEk3Hza7xw0fUbOQ/X7rsFvz/yWoDInjhzms
         gX7YScbIYUaTf2se4aZuuxAsZwOl5cGvQLjog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M08pZ30qIC0xl4xO4cVProKNh6rJryNHNCf1B+M1lhg=;
        b=oXVgFOe23HoUs0y6cr5Unev9GGJYbdtJqzM9q/YGn+ClSzhWi723UlqVybm31eeV7b
         iCEj9v+DX37M2WsoDQHcyC27RUU8uvYF6qPrO349VfAxo9CYdgq0FOViitqYBSyNkx5v
         gtE9/wzqsUkOBs8FkFpiPjzop6POMOWHMX/BNq7D83ywCcIjprVk+YJLoa7w8QfPamgY
         rfmI8a1rEWGFOPm1KgZQMGEnPus1WrfiBOFPC3j9dSNBhxq4N6tA4syo3ayWdma0N7La
         9u7ZYch6V+mow7M93bD8b8RyOP8M5HUTvllMCTFRqtHp9aFffrhbtLEwyXO2YBwVJTgg
         Ag4w==
X-Gm-Message-State: APjAAAVWiasUXRkcrX0p/ZKOfPYR3XboXv4hyedRzY61HUr3uGeS3Zxd
        TuY94XdzYYbZXOrn6jDeVOiRWaZprE0=
X-Google-Smtp-Source: APXvYqwE4oaRMthM85EZsyee1tKJS8wmQ8Wzsc7h5+KV8rR60qXWufLB/8y/CVfNRw8ST3QQoemnaw==
X-Received: by 2002:a67:ad1a:: with SMTP id t26mr44330581vsl.124.1554241536514;
        Tue, 02 Apr 2019 14:45:36 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id f39sm4288671uaf.9.2019.04.02.14.45.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 14:45:34 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id n4so8747772vsm.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:45:33 -0700 (PDT)
X-Received: by 2002:a67:1345:: with SMTP id 66mr25919533vst.30.1554241532827;
 Tue, 02 Apr 2019 14:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190306214226.14598-1-tobin@kernel.org> <20190306214226.14598-4-tobin@kernel.org>
In-Reply-To: <20190306214226.14598-4-tobin@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 2 Apr 2019 14:45:21 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJHKS=cghJDRwhTAEXg2yEOKjxGxKinDWHv3X4fZ5oxfQ@mail.gmail.com>
Message-ID: <CAGXu5jJHKS=cghJDRwhTAEXg2yEOKjxGxKinDWHv3X4fZ5oxfQ@mail.gmail.com>
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
> [...]
> diff --git a/tools/testing/selftests/lib/prime_numbers.sh b/tools/testing/selftests/lib/prime_numbers.sh
> index 78e7483c8d60..6f782386d897 100755
> --- a/tools/testing/selftests/lib/prime_numbers.sh
> +++ b/tools/testing/selftests/lib/prime_numbers.sh
> @@ -2,18 +2,17 @@
> [...]
> -if /sbin/modprobe -q prime_numbers selftest=65536; then

Here it is! This conversion loses the "selftest=..." argument to modprobe.

And I think all of these files could be reduced to a single script
that did something like:

. $path/kselftest_module.sh

run "strscpy" test_strscpy
run "bitmap" test_bitmap
run "prime numbers" prime_numbers selftest=65536

and kselftest_module.sh could define a "trap {...} EXIT" to perform
the reporting of everything that got run.

-- 
Kees Cook
