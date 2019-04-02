Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041F7C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE29A20674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fdwz4X7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfDBVv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:51:59 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:36852 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDBVv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:51:59 -0400
Received: by mail-vk1-f196.google.com with SMTP id w140so854441vkd.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9yzVmBkiITAmoECrhE2RijUJjm9Zk5WVxSbdkQtzOTc=;
        b=Fdwz4X7/m3SaIOqpiO8lhwd6sq4e1mrO7U+WDN85inRTB8woKcUo0JaEDKMDnibTVK
         VPY7QB10GVyet4U5GlAuyG37pi6K9b29sIbUAJsYSmkie3AVXqhbeImhCt/Rz5CKp76A
         Ka+uxsO1uWowcgnkx8LFatMO0sHYj89o+x9xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9yzVmBkiITAmoECrhE2RijUJjm9Zk5WVxSbdkQtzOTc=;
        b=MgBBrq8wxDesr92EiDdLxuAkqk6RiMGtFRS0SdwuUkmuKemUflZlBAYECztEQBZpxo
         I5RfYzIl+9Uy7TgDxIrnQ7AlDsP89Jn1w4SROm5AIZmpl6bS7266ntInnmLlXylj9zbt
         tFl7ip8Nwur/EYADXqGNH49sB7oy1wGDmLk3XnLSzBQ3wURJi7Ojq6BKjlmO8Iom1DWj
         CSPVAIXmxuiYwRRpGHQWcGAwqa1u7yrRsudRyDP5ZGSEjERsTvI8M8W484VeeZaP9wtm
         kYOygKMk7clZ2ElfwYDARkNk/KAc3tJCLMd2kl0zn/+BrnUyt4zhXAKBQZEli/7Jnae6
         qoTw==
X-Gm-Message-State: APjAAAUTZZ4UwKC0R3p68ftZjBFQ1h32fSiHYkculDetvrFQHToRC7MP
        YwsAlVAwJwdffWhm0vYnsEhMXkOwOpo=
X-Google-Smtp-Source: APXvYqw8PHaV7yQKgWiDsOkBzOcnKQTbGZXhm1Xs4vKVxd1i4b5ceLK8vPWBbCuI9T597Q3hCOZL1g==
X-Received: by 2002:a1f:9b55:: with SMTP id d82mr23133669vke.9.1554241917185;
        Tue, 02 Apr 2019 14:51:57 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id m23sm21248946vsl.24.2019.04.02.14.51.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 14:51:54 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id f88so4908828uaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:51:54 -0700 (PDT)
X-Received: by 2002:ab0:60cd:: with SMTP id g13mr106176uam.85.1554241913793;
 Tue, 02 Apr 2019 14:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190306214226.14598-1-tobin@kernel.org> <20190306214226.14598-4-tobin@kernel.org>
 <CAGXu5jJHKS=cghJDRwhTAEXg2yEOKjxGxKinDWHv3X4fZ5oxfQ@mail.gmail.com>
In-Reply-To: <CAGXu5jJHKS=cghJDRwhTAEXg2yEOKjxGxKinDWHv3X4fZ5oxfQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 2 Apr 2019 14:51:41 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL46pxXg8S_ywKmhc0A92qZSgTSH+96YXvuex5tqW20JA@mail.gmail.com>
Message-ID: <CAGXu5jL46pxXg8S_ywKmhc0A92qZSgTSH+96YXvuex5tqW20JA@mail.gmail.com>
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

On Tue, Apr 2, 2019 at 2:45 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Mar 6, 2019 at 1:43 PM Tobin C. Harding <tobin@kernel.org> wrote:
> > [...]
> > diff --git a/tools/testing/selftests/lib/prime_numbers.sh b/tools/testing/selftests/lib/prime_numbers.sh
> > index 78e7483c8d60..6f782386d897 100755
> > --- a/tools/testing/selftests/lib/prime_numbers.sh
> > +++ b/tools/testing/selftests/lib/prime_numbers.sh
> > @@ -2,18 +2,17 @@
> > [...]
> > -if /sbin/modprobe -q prime_numbers selftest=65536; then
>
> Here it is! This conversion loses the "selftest=..." argument to modprobe.
>
> And I think all of these files could be reduced to a single script
> that did something like:
>
> . $path/kselftest_module.sh
>
> run "strscpy" test_strscpy
> run "bitmap" test_bitmap
> run "prime numbers" prime_numbers selftest=65536
>
> and kselftest_module.sh could define a "trap {...} EXIT" to perform
> the reporting of everything that got run.

Though I guess if we want separate scripts per module, ignore me on
this part. :)

-- 
Kees Cook
