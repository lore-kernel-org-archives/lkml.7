Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6476C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7990120850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E9mX03t2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbfDJRbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:31:12 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34457 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbfDJRbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:31:11 -0400
Received: by mail-vs1-f67.google.com with SMTP id t78so1864947vsc.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 10:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=buarTpMpYVe3UZS2VK6+hfLEe4/q9AW+Y3TyUczlzJg=;
        b=E9mX03t2/Efc/jgaW2mhuVBVOZvt6AP9QuK9gW57Tb1jV6XSrWqHIwdCoUde/fgPOs
         tKWGvx376ve/hS7yE0bC7Ge70iAcv+1oXsMqHNFF5wuRqWA3ccoYcX1uWNvTyMPxnBaI
         ZyRE8QMfEtpGaprsECs/RGUu1JqJgmrIkrNMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=buarTpMpYVe3UZS2VK6+hfLEe4/q9AW+Y3TyUczlzJg=;
        b=GkL6xHQM0LsQ1iRcuWd6bA9/5dMMjpX0B9B1RXs2ijZw2Rw9VvyBevUdYge7Vq+qto
         0mp22Hqxefr6F4lBwUKN8cdgdbDGZLYn/p0ibMUtujBS36fKmjkRpI5bRrFufzXM+ek7
         gRzWReKqrNMdKkXPBZ2XFY+jh6kxvteYaHvmBH3byMQc/2Dw9KMT+CyB0ZksSI99l4b8
         kkr+m3Ldv1QnJEtuehILeLWszFhEX0IeAaZuSYcqAQvsKvxASV7ESHcSAtkSH94+wRqp
         YFFkmVddUq5UJPHmb3GgWFSlD3z9jD1B/70OQPgg/RC6a/cTXO+YWMhPp+VTyhe99VSc
         5pxg==
X-Gm-Message-State: APjAAAUUmsoXmathfSZIZP9EQYTW3OTzGNyHBVA4D40q7KwwtceETrqP
        rdAs8x7X0UMfo8509+VfxxsCA/4PYr4=
X-Google-Smtp-Source: APXvYqztVT6KL3TFZYXTKajKN1W3iVLg7EcypPBMcjbOl3i5SgU0HlNPDaHP2c8S0ytWlrklj+B8+A==
X-Received: by 2002:a67:cf09:: with SMTP id y9mr24950651vsl.141.1554917469423;
        Wed, 10 Apr 2019 10:31:09 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id t11sm5725570vkc.53.2019.04.10.10.31.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:31:08 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id h71so749108vkf.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 10:31:08 -0700 (PDT)
X-Received: by 2002:a1f:264b:: with SMTP id m72mr13890985vkm.43.1554917467893;
 Wed, 10 Apr 2019 10:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190410075434.35220-1-yuehaibing@huawei.com>
In-Reply-To: <20190410075434.35220-1-yuehaibing@huawei.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 10:30:55 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLmbiLZmLtFKpEJAB_VFpaOjDMhWk=Z_sD1iegM2kpSYw@mail.gmail.com>
Message-ID: <CAGXu5jLmbiLZmLtFKpEJAB_VFpaOjDMhWk=Z_sD1iegM2kpSYw@mail.gmail.com>
Subject: Re: [PATCH] lib/Kconfig.debug: Fix build error without CONFIG_BLOCK
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joe Lawrence <joe.lawrence@redhat.com>, dunlap@infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 12:55 AM Yue Haibing <yuehaibing@huawei.com> wrote:
>
> From: YueHaibing <yuehaibing@huawei.com>
>
> If CONFIG_TEST_KMOD is set to M, while CONFIG_BLOCK is not set,
> XFS and BTRFS can not be compiled successly.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: d9c6a72d6fa2 ("kmod: add test driver to stress test the module loader")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  lib/Kconfig.debug | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 2020d76..65ad61b 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1939,6 +1939,7 @@ config TEST_KMOD
>         tristate "kmod stress tester"
>         depends on m
>         depends on NETDEVICES && NET_CORE && INET # for TUN
> +       depends on BLOCK
>         select TEST_LKM
>         select XFS_FS
>         select TUN

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
