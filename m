Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E7CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E08A20836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfLJRvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:51:33 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:57219 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfLJRvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:51:33 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mr9OA-1hzN2L2hCo-00oGcT for <linux-kernel@vger.kernel.org>; Tue, 10 Dec
 2019 18:51:31 +0100
Received: by mail-qk1-f172.google.com with SMTP id z14so6835430qkg.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 09:51:31 -0800 (PST)
X-Gm-Message-State: APjAAAVLh7K0yoiAPQVyGgf6m6FppAqz4namXhHleENIoWXagEvEOBLU
        QhJ7QDardumFaIiC7KfhtS3CE5DTSx0jDgu7vgY=
X-Google-Smtp-Source: APXvYqwLAiu3+p6iaDMl8EgpIoU3Zkljq9QMkI/BV/wvJWrCucp15nuCsyQOzr2eqfgSN1ubzhiRY5fsSG/rTWJnItM=
X-Received: by 2002:a37:b283:: with SMTP id b125mr27668682qkf.352.1576000290527;
 Tue, 10 Dec 2019 09:51:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575977795.git.vitor.soares@synopsys.com> <f9f20eaf900ed5629dd3d824bc1e90c7e6b4a371.1575977795.git.vitor.soares@synopsys.com>
In-Reply-To: <f9f20eaf900ed5629dd3d824bc1e90c7e6b4a371.1575977795.git.vitor.soares@synopsys.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 Dec 2019 18:51:14 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1cwoTbT3zsa-tfApwewDT1-ksHZs6_vkBYpKbgptsfjw@mail.gmail.com>
Message-ID: <CAK8P3a1cwoTbT3zsa-tfApwewDT1-ksHZs6_vkBYpKbgptsfjw@mail.gmail.com>
Subject: Re: [RFC 5/5] i3c: add i3cdev module to expose i3c dev in /dev
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-i3c@lists.infradead.org,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:itayKSU1OR2FDC8JQ5IYL5ANIZSz6coceAnGeYRSXoEgxjJupnz
 1ADsw1AvYUgPvkRJwt4NwL0imXkpP7YUOy8gg/h85KKe/Lly4OJ1clzftm01Ucrv2YEEHQ3
 DjwK+0qW+RQ5RlnxJA5eEUkFiZnOYDJxccIGdcrGWzq0U3ZKT+fXBApR6dLh6Ky4gdnbb3z
 yFUXQkyoLtnRCGaf7CfIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gJWvan+hM+g=:dElaufqJbaVrH7lL+OT1Yr
 2LQQvp7KS9SWvlLYfWGkHaUMRGYJHT/NMs1YyRojl6UMFTlu73aTtoVErjWmFTfC9gS+sH/Uj
 TNTxIUZPrYulNdmS/6i+7rgSu6gc3AKF4ukEsoYh1yrn73fV+644SFibcovxRqxJfaJ5ANnWy
 i+KdL11/837jIGloKQcpsDBNa7NC70M6mixyNmlyidaMaTlV+uu298IthyWLCJK0kRazvpCyA
 3PBpGgh226C1aGnJtE/A4/OrdagBSsYffWaKg4BeurJ2TfMvIQJjzR+lixUmyNBzN+0a37S8J
 8vQZA0bYIcYXNNK4YkbYDxNts2J6+GsAceKQ574GObAqzhclhtNWeO5NB4RNSrnMrJFtD3tYj
 pFTxszdZLeFSZ5n95x5sQXdKd4azZUX5zmCp43GCNrSU5sQQOeWVkFknDqDo7VbhzWI4hsiEx
 kfq/msADCxPI46Xy79P7+Ae63ULKPo7BFyItWnoe7qQJsAu04EaI+TwcBlIdp60Y9lc2hpIZQ
 tgASJdGveocpttbLs7J/R2D0eCzNDNiM4WOOAPFSz3qsZth2K+FbxYa5fytJU23bZUOoUQFbk
 p4ngZVxTtmMrWAGfFLBxOxCOUZ5+VFmTKLcfsXg7/xNJk1q6hzlw5rupUvhfeGzyYs0B6B76N
 UcR8pRiGrPpoKrDKm2akCwaZwRRwxZukZxY22abzm1v29raq5ORMW6mYU/kgpQzYhHre4mbcT
 avKQFkc+Is1beFyNN8OtGg/+sqCwJKqTmxk5t2t/oJR45ja6OgBEbAKa+G72DeKz3V7Mst/K4
 H30xsvGJ9XuEdrGON15AH5KSzir/UO7zPFb5gOqiTTv2qysV9ECXhCMNcEko1dIQvWXGw9jnR
 +emwQeHIVN0l1BlG5BZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 4:37 PM Vitor Soares <Vitor.Soares@synopsys.com> wrote:
>
> +/* IOCTL commands */
> +#define I3C_DEV_IOC_MAGIC      0x07
> +
> +struct i3c_ioc_priv_xfer {
> +       struct i3c_priv_xfer __user *xfers;     /* pointers to i3c_priv_xfer */
> +       __u32 nxfers;                           /* number of i3c_priv_xfer */
> +};
> +
> +#define I3C_IOC_PRIV_XFER      \
> +       _IOW(I3C_DEV_IOC_MAGIC, 30, struct i3c_ioc_priv_xfer)
> +
> +#define  I3C_IOC_PRIV_XFER_MAX_MSGS    42

This is not a great data structure for UAPI, please see
https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/tree/Documentation/core-api/ioctl.rst?h=compat-ioctl-endgame&id=927324b7900ee9b877691a8b237e272fabb21bf5

for some background. I'm planning to submit that documentation for
mainline integration soon.

     Arnd
