Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2495FC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBE520882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4ahhfCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394844AbfITG0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:26:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34120 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393028AbfITG0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:26:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so3255549pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 23:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LeeQoMGTXrRBU+JKxk+jVpopZJw5u/plTILSsmUcTZw=;
        b=a4ahhfCzFTkFo2i7Jnkvd9VOWhYkk3HR6g8fDY1ANP3+1zsur6ESJGetvXFA1r9uUe
         fK3rQdhXpx+VoLg+ELxsN8OvdFyecODbyw5rAnHEY/TiCjzct090W93Fe3dUmM3W8bHM
         V34WnuIAQcwJCTiImTUQG8X5nmoRMtooFnxmzOtKN1Hrk5QgXTHMcFGke7jXj8vKQNsg
         ONqwYJG3F5jpib0RKtxSlpAbosYElv9N+DbfF1DyakbCcnnsfmqG1yybNs/sFRKGfdJk
         x9BeT3cx/oKWVI2fYyyJaUkHrqfCuMzKiNGzAbKKiOQk/PmTswSmhElcS2bj/Kmz8660
         nLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LeeQoMGTXrRBU+JKxk+jVpopZJw5u/plTILSsmUcTZw=;
        b=dRiYtWe0x/JNN5+BGiGfE6sgiK9bPvsiQ1lNiusAg3C91byAs7mHRlnhnZ14Z40art
         Ydx3xG+0aS0+CXx4pNfOXXrLs6n8pfNK/5WnPCJPkx8E5/q2lr78GHT7lhvuv7la108T
         yzKvuMuC7M+Yn4LkDdL/fojJOSw1GuBvUP7ukeunDwz3ZtwuTblIV+viMBJjBeLPXmcM
         Gu2nwKR1KIVpHrdKIQQAu5/lSH9jHVJRc/aZtAxlJCiD639QDgxm08ovg7rNu1t8+YPa
         PYzDgjFO7XMSIEvvWDgo02AP2VJv71Hl6Zb+8pmqGnkR86LVankANjogaXzhTD5my8iu
         3KeA==
X-Gm-Message-State: APjAAAUOdEnZdEfhPtwG7dP/YfGrQkOFibHIc+dPdgDFM95UHCA1pwkR
        bv0aQW9/nMFSKAOsYrnOUTkYY+ClJmjgMLXMMvM=
X-Google-Smtp-Source: APXvYqz1mOt0BkUYLYHDSH/7BLj3eKNyj+DdJEhgiZXHU93YMu5sGsX0VBEEMLcTahK5Zu2d2hWvz+1t7SdaJxYGurU=
X-Received: by 2002:a62:c141:: with SMTP id i62mr15538021pfg.64.1568960781786;
 Thu, 19 Sep 2019 23:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com> <20190920062544.180997-19-wangkefeng.wang@huawei.com>
In-Reply-To: <20190920062544.180997-19-wangkefeng.wang@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 20 Sep 2019 09:26:09 +0300
Message-ID: <CAHp75VdQES5oasGzi0JdnZAEL2AfCozHJaHBa9dpg1Ya_N17-A@mail.gmail.com>
Subject: Re: [PATCH 18/32] platform/x86: Use pr_warn instead of pr_warning
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 9:10 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
> pr_warning"), removing pr_warning so all logging messages use a
> consistent <prefix>_warn style. Let's do it.
>

Please, split on three patches (per driver).

>  drivers/platform/x86/asus-laptop.c    |  2 +-
>  drivers/platform/x86/eeepc-laptop.c   |  2 +-
>  drivers/platform/x86/intel_oaktrail.c | 10 +++++-----

-- 
With Best Regards,
Andy Shevchenko
