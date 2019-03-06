Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27BBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E3520842
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NZmZInxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbfCFRUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:20:46 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40672 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfCFRUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:20:45 -0500
Received: by mail-yw1-f67.google.com with SMTP id c67so10611080ywa.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 09:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0fAYBfIMZ/tQ+FRP8z7xvUzfWqwLNkCkIfrwUlLo8qY=;
        b=NZmZInxYlnWlW9JgeTqiJQfTTWEx3yO4tIyxI3Pga9lWPvoP8bZ/Ixsy6/JvW84aIv
         uHrk+srMEKP9P8sQVwv0GVQASMUl7VODmn7GJjfHi1reR51I6z0rDzaj+xI7PJK5/R6l
         7cS1rieAglVKJ8BD4KB0nsQ0UzvjxkiJpVT9ewywiVful7SflLlX5LCHZeFcUZzua8VR
         HXi3VyQfTyca6xjUTULm7yMfWW4Klnon/XTamKpL3aA2WBxnYgLbGp5b02XPTlTYWrKb
         3aH8PSC0fjOoCPi5yvYrXWTbMPnizrUecK2EhqiCheoGNnyHh/9RNZWf3bUSHhHvaJKQ
         r74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0fAYBfIMZ/tQ+FRP8z7xvUzfWqwLNkCkIfrwUlLo8qY=;
        b=Z9xaIdFX0uhSvJszWEV0fqWDCwh2zb7b8lQbSSNA2QqexJM8hz5oOnChpSzRBKhQwY
         jLRyfQbqD13wAE/kp4HcnTLbNwaKdS4TZC563oYPUwQxK2Sb/2VZ6zkUksSHStCAEi2C
         GH7OhKgNDmYSgi4XhoPxKcm7mVpjYACQwjk662KJMv1+MeKkldP535OXsgH2uIiebKlR
         NxdlBjfVqXDI43lT0ZTjRZR9hovIPihMD5XgANIPYVwmNWfsSnRKRPMWxhlVefU6hft9
         ppllhDQX4MKU/4i/F+gjQOnF2Py0lvCMfWjDdmdN4Nmmh6NZzZdpURWhRp5a0+S0eEec
         Nc7A==
X-Gm-Message-State: APjAAAVC2q2DZvY6gcrYH47vNuGiHHRSQqjtXQUfR8oyaQXdAGZvwPr9
        xpgv7iDgVH9WpLr3IO+sygZm4Atylp5bJgBKZYEg6Q==
X-Google-Smtp-Source: APXvYqwe9K1gGUi3QTv5ADzfuTBbNj7N1K1J/wM/iyTrllDBPkXAEHK9oDpJLMjfK/UpqAG/XyW7onJHJgOBfVri7QA=
X-Received: by 2002:a25:d9cc:: with SMTP id q195mr7672466ybg.247.1551892844420;
 Wed, 06 Mar 2019 09:20:44 -0800 (PST)
MIME-Version: 1.0
References: <20190228002725.57444-1-gwendal@chromium.org> <CAFqH_52tWw8pGwY5fdAPQ6npbfWA7o4OhtPxvbUbCh5TdnbSew@mail.gmail.com>
In-Reply-To: <CAFqH_52tWw8pGwY5fdAPQ6npbfWA7o4OhtPxvbUbCh5TdnbSew@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 6 Mar 2019 09:20:33 -0800
Message-ID: <CABXOdTfqPKq34OVDmJ9qjTr0nqarhpN=f37m3xH9iuHxex+xrw@mail.gmail.com>
Subject: Re: [PATCH] mfd: cros: Update EC protocol to match current EC code
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[resending in plain text mode ]

On Wed, Mar 6, 2019 at 8:57 AM Enric Balletbo Serra <eballetbo@gmail.com> wrote:
>
> Hi Gwendal,
>
> Many thanks to send this upstream.
>
> Missatge de Gwendal Grignou <gwendal@chromium.org> del dia dj., 28 de
> febr. 2019 a les 1:31:
> >
> > Chromebook Embedded Controller protocol is defined in the kernel at
> > cros_ec_commands.h.
> > The source of trust for the EC protocol is at
> > https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
> >
> > Only needed changes have been picked up from this file to the kernel
> > include file leading to gaps between the upstream version and what the
> > latest ECs can do.
> >
> > Fill the gaps to ease future integrations. Changes from the original
> > files is header/footer for license and include files for alignment.
> >
> > Check this include file works on ChomeOS kernel 4.14 and 4.19 on eve.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  include/linux/mfd/cros_ec_commands.h | 3627 +++++++++++++++++++++-----
>
> I'm wondering if we should move this file to include/uapi at some
> point as this file is also used as user-space API for some userspace
> applications.
>
> While we are here I'd suggest if we can also fix the few errors (3)
> and warnings (5) spotted by checkpatch. With that it's an ack from my
> side.
>
> Being strict, though, on most cases the variables are going to be used
> in code that can be seen by user-space programs so maybe we should
> really need to switch to __u8/__u16/etc exportable data types instead
> of the uint8_t/uint16_t/etc types (those are not aimed to be used
> within the kernel). For those types that are internal we should use
> in-kernel type (u8/u16/etc)
>
> There is also the use of the BIT macro instead of the (1 << x), I know
> that this is a maintainer preference.
>
Is all that even possible ? After all, this is an imported file, and
we don't usually expect that imported files meet the Linux kernel
coding style.

Thanks,
Guenter

> [snip]
>
> Thanks,
>  Enric
