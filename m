Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41D2C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA30C20674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fk4X2w27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfDBVpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:45:35 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:44672 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDBVpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:45:35 -0400
Received: by mail-vk1-f193.google.com with SMTP id q189so3333195vkq.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jiR53DRcgLqP9uNCZmvUrgO5I32DdD96CewoNrMSJBM=;
        b=Fk4X2w270/LiYtW6qYuDov5rxNdixPrEF5fibxnOHIjM0wZiy5HMTaKhQ3779Yb+YO
         w1TLvXzyg/60j1GNPmJt7sPdNG8lp7BWEmPmpxlkrxvSOkFiccqaCt5TgGUWwZU8oCpr
         Ztbucz+BwYy7B9o6i4PYSX+CU6vj8z51vKgrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jiR53DRcgLqP9uNCZmvUrgO5I32DdD96CewoNrMSJBM=;
        b=cdV5NnBPfxbgXJ6VVRwwFbNzfPBP0Y2JQjKbdG60bGIIaNT8tOjXMGVr4rGSB+UadY
         tV0nbRz9/yxSANYQjQLSZxvUmIlugYyCz+sG3kQJL+6bbB0+vmvwnsTjWwB3HTSqOp8z
         y+8a4GG277CeBbE7yZRGHpNen3wnDe7Zs9uSWj4z8Bsa/qiOBYgNO0XC9ADvip11NWdP
         l5ezlrUmWCS3OE1+X/1J8dA/apn3Fzr/X+uAuiWK8mF36gIWHnotex9Y4Oww4KoadKfZ
         32E62KWy2Ka4pMDz7oCJpzbjlki+99xAmqMs2xACJ8fjIyiUSO3rDmOVxx1jX28isV8U
         NDJw==
X-Gm-Message-State: APjAAAVVF7X2DjAzRotOr05eNy9LvQNVZGpTqNOkycoSwBarON8h/Vt8
        xqyOibNnTtlRTwvJejfzJd7rvr/oemo=
X-Google-Smtp-Source: APXvYqzbGZBXcX5CDI6MpB25+4sIZMJsze4EsLufw2fCsTvH7F0bjWoKvjR/8JlE9ljJT1kbm+rwUg==
X-Received: by 2002:a1f:1691:: with SMTP id 139mr42609895vkw.25.1554241533526;
        Tue, 02 Apr 2019 14:45:33 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id s195sm3720649vka.42.2019.04.02.14.45.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 14:45:32 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id w13so7698116vsc.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:45:32 -0700 (PDT)
X-Received: by 2002:a67:76c7:: with SMTP id r190mr31726333vsc.196.1554241088914;
 Tue, 02 Apr 2019 14:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190306214226.14598-1-tobin@kernel.org>
In-Reply-To: <20190306214226.14598-1-tobin@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 2 Apr 2019 14:37:57 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJeFOBBiofjG6_rqbf+_0fbKC46pzyfoACWt+NBg-bXtg@mail.gmail.com>
Message-ID: <CAGXu5jJeFOBBiofjG6_rqbf+_0fbKC46pzyfoACWt+NBg-bXtg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] lib/string: Add strscpy_pad() function
To:     "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Jann Horn <jannh@google.com>,
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
> This set makes an attempt at adding a framework to kselftest for writing
> kernel test modules.  It also adds a script for use in creating script
> test runners for kselftest.  My macro-foo is not great, all criticism
> and suggestions very much appreciated.  The design is based on test
> modules lib/test_printf.c, lib/test_bitmap.c, lib/test_xarray.c.

Hi Shuah,

The bulk of this series is in the kselftests. Would you be willing to
carry this series?

I think it might be able to use a v4 just to clean up the
script-finding logic, but I might be entirely missing something about
the best way to do it.

Thanks!

-Kees

-- 
Kees Cook
