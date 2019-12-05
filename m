Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD0CC2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 22:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EDB20707
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 22:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nhguw729"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbfLEWZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 17:25:04 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43311 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbfLEWZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 17:25:04 -0500
Received: by mail-pf1-f193.google.com with SMTP id h14so2261756pfe.10;
        Thu, 05 Dec 2019 14:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i7d8gLjd+sLoiJpXei1q6a6kERigQFuSYg7tC9xLpLQ=;
        b=Nhguw729g/WUMhWFkxEF7GWHFRtvnBoAnkFhvhi7jPBIXNhvjwFDNssMX1ScVNCjVY
         dW8HB3etskB92IitKyrS5OMjiXsowoD2PjZKU1GmTTxwR2hxRQyVEsiJv4lVR/kqOpD3
         nEw2j1J0191duIdNWJmeI4q0fWmk9pkWe0I0N2ae+Co2AWVGtk9CJ0C+tKyA1YTZ0+ez
         48pGKZFjF7owmWUoJIbih8f5sRKw+VwGRUOA2WxacA6mFFm6rBHZBE/qQVGvCYFNdJYa
         GLtYcGVHUtWACOHYF9ybZSqr//+XnNMD71B5OmkWLgxbYOQ34mM975xOfvQDjHQEBcRA
         GczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7d8gLjd+sLoiJpXei1q6a6kERigQFuSYg7tC9xLpLQ=;
        b=acY+3j5os/SbzpHWqWTeqRHOI+WXZCTJImL/Dz/muGr3oKBT10U4Roy3cAXcTW7oz0
         OFvXOMtFJfSYjZtLkmIfeZ0oLgZunBdHH4S27r8u2PBa91C/DQstwHtZOvgrgV4h56GY
         rYBsTUGglzOhDaHH+AjNrAp3B82IGYd+F8lw/eoAUfpPVfhVbu/KS5vT4DCJ4O7XpBN1
         V+1TlKI+0dMR54UfT5yxJcOyXHNNV4vVtgsfy0w2xZxzluoolMNJYZfqThjL3tLh3mOc
         jqecxMr+D2/rr3mpk6GZtJ0l6aopLbzdZ8D2gGI+VYoIFmh7VXYqboo0lZ3gox8ptJFZ
         jF2w==
X-Gm-Message-State: APjAAAXZ6Baeck6SRkXo/2oHUuwjJEAOlXQSvseCGLq9d2FJdlYglE3n
        +4gB9U5s6T0WEpQuIRMZmevptdZwHvIWBunlZy4=
X-Google-Smtp-Source: APXvYqxMbd1CA+h65ymSEClEw1SnfCASsf92gbJSoej2Vn3nUlZUtazzWber25+lZzHthoOXsseTrIP4ugkGyOQ1uYg=
X-Received: by 2002:a65:490e:: with SMTP id p14mr2933470pgs.4.1575584703737;
 Thu, 05 Dec 2019 14:25:03 -0800 (PST)
MIME-Version: 1.0
References: <20191205215151.421926-1-jim.cromie@gmail.com> <20191205215151.421926-20-jim.cromie@gmail.com>
In-Reply-To: <20191205215151.421926-20-jim.cromie@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 6 Dec 2019 00:24:52 +0200
Message-ID: <CAHp75VcSkm4M7VOuMWnNUOMAPbbvmodGfn9_Pu25H213pMuxFA@mail.gmail.com>
Subject: Re: [PATCH 17/18] dyndbg: rename dynamic_debug to dyndbg
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "David S. Miller" <davem@davemloft.net>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 11:54 PM Jim Cromie <jim.cromie@gmail.com> wrote:
>
> This rename fixes a subtle usage wrinkle; the __setup() names didn't
> match the fake "dyndbg" module parameter used to enable dynamic-printk
> callsites in modules.  See the last change in Docs for the effect.
>
> It also shortens the "__FILE__:__func__" prefix in dyndbg.verbose
> messages, effectively s/dynamic_debug/dyndbg/
>
> This is a 99.9% rename; trim_prefix and debugfs_create_dir arg excepted.
> Nonetheless, it also changes both /sys appearances:
>
> bash-5.0# ls -R /sys/kernel/debug/dyndbg/ /sys/module/dyndbg/parameters/
> /sys/kernel/debug/dyndbg/:
> control

> /sys/module/dyndbg/parameters/:

Isn't this path a part of ABI?

> verbose
>
> Finally, paths in docs are ~= s|/dynamic_debug/|/dyndbg/|,
> plus the kernel cmdline example tweak cited above.


-- 
With Best Regards,
Andy Shevchenko
