Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26511C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E234A20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I2sCm8+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfDJXHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:07:20 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40849 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfDJXHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:07:20 -0400
Received: by mail-vs1-f68.google.com with SMTP id f22so2367991vso.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 16:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GCdGa8XvaK3xVTLbpAEbLjShSDf4SFcVmWdHub698F4=;
        b=I2sCm8+wdIemlxNR36Aq3DRXhcx8Hnbjfs0MFEKfZatcsYJJLdAhpYT3f5RxLE2u4I
         NhgX0nrtENwmsLJeQr2pmQX/UzGBTkIFE5Ov4+gI5D3WQlhvw0uzoUu9KDgdT1wISvPg
         z6oEIA40MeAqUK7gkNcGt7vAKgf74VVDtEzDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GCdGa8XvaK3xVTLbpAEbLjShSDf4SFcVmWdHub698F4=;
        b=j6X5buOss8XkT6zUyWcKzAwm5r3vBP2JhaJVqwewDTyKiX/w19As1fuDppwwR1m2gH
         dgUcWLlrAyGJTaTtN1/dCJyeKtJxk6NB1e78xa3zAoh8oh4kLuAgmhNo5stUnjlq4RXt
         nBPka9jRGxIbqOwy4zWxH3oY6Sj/JQA5tBBl6M5HCDucENn4sy3hl3/QNG+GSJ/+V4DW
         ZtAWNo0KtAFfKoXNNTz+YNAlLeUFesXhIrkXNf0OJYL+g5RiOctJ2PO0gpwLU5jdLXng
         4Px36Eux5MfrWiWi4RUl6GcxRro1SFrv1oBwnL9dKrcglS9EzKUfq4b0gm8oewfetgFl
         S5ew==
X-Gm-Message-State: APjAAAWS01v7AluM/6Gw4rl9yrkT2m+7Z2m93nJLqOP7iuyV+cTT98zj
        NBWMdquHSOe1fnCialXq6DKkFmJ6fJg=
X-Google-Smtp-Source: APXvYqyueeZIj68wVoFbO+K4HGCA/J6Ji6zwEgifNFBBmda+/sQNSgwNo/wMD9ecG2k7E295MXwAmw==
X-Received: by 2002:a67:ea53:: with SMTP id r19mr27661839vso.12.1554937638944;
        Wed, 10 Apr 2019 16:07:18 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id b197sm44217354vkd.9.2019.04.10.16.07.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 16:07:18 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id g8so1393846uaj.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 16:07:18 -0700 (PDT)
X-Received: by 2002:ab0:2f8:: with SMTP id 111mr24868511uah.123.1554937147076;
 Wed, 10 Apr 2019 15:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190410224213.20651-1-okaya@kernel.org>
In-Reply-To: <20190410224213.20651-1-okaya@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 15:58:55 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKzBGRr7LjFVdpvHhSFV7C7kuj-6VphhtLsMEoetr_R7g@mail.gmail.com>
Message-ID: <CAGXu5jKzBGRr7LjFVdpvHhSFV7C7kuj-6VphhtLsMEoetr_R7g@mail.gmail.com>
Subject: Re: [PATCH v2] init: Do not select DEBUG_KERNEL by default
To:     Sinan Kaya <okaya@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Changbin Du <changbin.du@intel.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 3:42 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> We can't seem to have a kernel with CONFIG_EXPERT set but
> CONFIG_DEBUG_KERNEL unset these days.
>
> While some of the features under the CONFIG_EXPERT require
> CONFIG_DEBUG_KERNEL, it doesn't apply for all features.
>
> It looks like CONFIG_KALLSYMS_ALL is the only feature that
> requires CONFIG_DEBUG_KERNEL.
>
> Select CONFIG_EXPERT when CONFIG_DEBUG is chosen but you can

Typo: CONFIG_DEBUG_KERNEL

> still choose CONFIG_EXPERT without CONFIG_DEBUG.

same.

>
> Signed-off-by: Sinan Kaya <okaya@kernel.org>

But with those fixed, looks good to me. Adding Josh (and others) to CC
since he originally added the linkage to EXPERT in commit
f505c553dbe2.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  init/Kconfig      | 2 --
>  lib/Kconfig.debug | 1 +
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 4592bf7997c0..37e10a8391a3 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1206,8 +1206,6 @@ config BPF
>
>  menuconfig EXPERT
>         bool "Configure standard kernel features (expert users)"
> -       # Unhide debug options, to make the on-by-default options visible
> -       select DEBUG_KERNEL
>         help
>           This option allows certain base kernel options and settings
>            to be disabled or tweaked. This is for specialized
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 0d9e81779e37..9fbf3499ec8d 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -434,6 +434,7 @@ config MAGIC_SYSRQ_SERIAL
>
>  config DEBUG_KERNEL
>         bool "Kernel debugging"
> +       default EXPERT
>         help
>           Say Y here if you are developing drivers or trying to debug and
>           identify kernel problems.
> --
> 2.21.0
>


-- 
Kees Cook
