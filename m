Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD796C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6CE20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dOU/qw00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfCGWoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:44:14 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:44434 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfCGWoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:44:14 -0500
Received: by mail-ua1-f68.google.com with SMTP id r21so10763323uan.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 14:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUHLbMAFh1XP9ezIoT7K3vy06uC2QjrYpdrVOkv4+Tk=;
        b=dOU/qw00dOHqTt/ZIyTQVOasoCy+1kwcnt9kY8RUbOBGHRYmqPveS9P7w53DyA/Kbq
         Aj6+TDDuU/hm8+wuX9H5b/YjAZEgJCLjF31DEn/WEJu6eLL1w4ZvUY79du6zp+VKbquy
         5zric/gC+lZRC1Zz1NIfyZJm0TfzBCpALHFPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUHLbMAFh1XP9ezIoT7K3vy06uC2QjrYpdrVOkv4+Tk=;
        b=sbXSe5XV8FkIktZoxVBNh5757kivZ1xvkaRXZuMO0MAeRCOrJ94tN3F4FEhNvxRkms
         6lpc/v1HoCEVQGBJ9fwNBAILOWQrtTMbjphooLNEj3gwi5wkTfxw+uD6hqnNfCX71xgO
         3MY4xglxeKGF5buQdNGpcdq4AsnFdAoJ/eTvlyRjdYk4qxkJva0DNXIDsynTkzAwFfoE
         1ijqyFrNPaEvlMoRQVPoumdiFyWMNSN7sz38zxT/7sCt85G8JzhGINcD6/mNeH2WD1F4
         0xTCFJoHvgQZkPZj/DGJabzsShumLUdIALe53qCqh/LLCyuXlDr38Y67LMxw38Y+dzk4
         bZIQ==
X-Gm-Message-State: APjAAAUpWfUMoPAEjKr1QfIM3m35rIftgq6o7J4FG4mtjQRXX0AsNhQo
        Fpqq2UBWTa2zSvybZGFyFU2XgHSYP4U=
X-Google-Smtp-Source: APXvYqywIEkeInfZWtHKWi8mEdtc3vLF2ZrStX1NScWpdrE6JcmGf3QHI2SylX7yt453Y1AolLEjGg==
X-Received: by 2002:ab0:2498:: with SMTP id i24mr7996702uan.123.1551998652734;
        Thu, 07 Mar 2019 14:44:12 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id v128sm1219542vke.16.2019.03.07.14.44.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 14:44:09 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id y19so5553286vsc.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 14:44:08 -0800 (PST)
X-Received: by 2002:a67:6983:: with SMTP id e125mr8051619vsc.222.1551998648337;
 Thu, 07 Mar 2019 14:44:08 -0800 (PST)
MIME-Version: 1.0
References: <20190306214226.14598-1-tobin@kernel.org> <20190306214934.GA16461@eros.localdomain>
 <20190307211858.GA28495@eros.localdomain>
In-Reply-To: <20190307211858.GA28495@eros.localdomain>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 7 Mar 2019 14:43:57 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLdCQ0QtCdbbfE+=JccZk01aSdV_5dWVj6g8X-dKpOr8Q@mail.gmail.com>
Message-ID: <CAGXu5jLdCQ0QtCdbbfE+=JccZk01aSdV_5dWVj6g8X-dKpOr8Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] lib/string: Add strscpy_pad() function
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>,
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

On Thu, Mar 7, 2019 at 1:19 PM Tobin C. Harding <me@tobin.cc> wrote:
>
> On Thu, Mar 07, 2019 at 08:49:34AM +1100, Tobin C. Harding wrote:
> > On Thu, Mar 07, 2019 at 08:42:19AM +1100, Tobin C. Harding wrote:
> > > Hi,
> >
> > Man, I didn't see the merge window was open, I thought rc8 only came out
> > on Sunday.
> >
> > Sorry, please ignore this.  Will re-send again later in the cycle.
>
> Multiple people have suggested to me (offlist) that it is fine to go
> right ahead and send patches whenever.
>
> Shuah, do you take patches to kselftest at any stage of the dev cycle?
>
> Kees, same question please?

I don't official "close" my tree, but I'm certainly less likely to
respond in a timeline manner near the merge window. ;) (And as a
result, I haven't had a chance to look these over yet.)

-- 
Kees Cook
