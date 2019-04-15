Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EE9C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1132070D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LqmQpn5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbfDOUCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:02:04 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44020 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbfDOUCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:02:04 -0400
Received: by mail-yw1-f67.google.com with SMTP id j66so6472113ywc.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 13:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ykRqAIluU0NXsuz7m0Y2cAIvAKzXoeZkUO2WAzqLZw=;
        b=LqmQpn5Z1qhKBlkwDJqV0cR2Yk2DijDZhxwv4S9Kw3NL3UNjnt4kpQ5Z8UCOpLF/1T
         bHeWPlrhDk/m6wVJ0oMcXmqz36JaDgXxl5Keo73mcqNoXJDHxaF+MYly9J0mB9K12HwG
         s6QqmVumLNmqEeMbE/lQTAuyhW5kzCeiC7BwTf2W3kpVpqDAGrwGoqGwFMweJUvRUtPl
         3CnAxamx2AeAlUttnxj5wX23mobAU2WIYFRefahf3YIWOQbeGgk55Zislw7GPMYuwKPf
         XmfXp8s56+5BCprqrOC8uL1+vp0KY08GRY3TXx77wyHFRxJjM1YVEecdS+DIqr4bpaZ5
         emNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ykRqAIluU0NXsuz7m0Y2cAIvAKzXoeZkUO2WAzqLZw=;
        b=IhZI1LUMvTVzqbOsCdsyXoJI7ZfJniqPm4AXbIJRxIrG63512hiqL32im9o3JIPk+H
         3rrdb1VdsbJcZow0L8aPqBU2A0Upi/7NRA1gOCJqxbdryV14f65XCEVWuk83BB6WHZXZ
         CGV0sWU7gPTfmHkSq+6J1MLFsXe6w004u7zcXwdjh/Pt2wfU2yYQMAg3Q2pcEk8iDLyj
         Vy5RP5OLxBtruR54ChndX67O9NMRokIas1spqy3o6L0KoBEV8jRAOjn8Cr6JXNhnfZ7y
         tBxzTeYEow2LLn022caSF5VkJHVqr1VB59mmMpqAG9+JmKyCuyzokSRMvAScSJp2SY1C
         f0Ww==
X-Gm-Message-State: APjAAAX0iGzfwNIPZ06f0lZ6ocVoupiAyXVJ+jRcxwzDWkPMjbcfK3f2
        I7clZ06m4rAWhFRVNvusEQpORd2pU8N/KGZieoQr3A==
X-Google-Smtp-Source: APXvYqw0dYDSSDt1BitpQJva9u+gyVKXlF8K0n4lSdPPTcYA2nT+LE1oJJC6iF/QeRqfM5A58k3IaPG2schHr4Li6uo=
X-Received: by 2002:a81:1054:: with SMTP id 81mr58903408ywq.48.1555358522808;
 Mon, 15 Apr 2019 13:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190415192734.935387-1-arnd@arndb.de> <20190415192734.935387-2-arnd@arndb.de>
 <CO2PR01MB21683E465191EA8246503774D02B0@CO2PR01MB2168.prod.exchangelabs.com>
 <CAK8P3a1DSN3jcfGngrJFp93Mt98qsibvKvtJGtjHYjOmcM1kNQ@mail.gmail.com> <3665a5ad-ff6d-97a1-ca31-971973a7167f@gmail.com>
In-Reply-To: <3665a5ad-ff6d-97a1-ca31-971973a7167f@gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 15 Apr 2019 13:01:51 -0700
Message-ID: <CABXOdTce7EXE7xZhh=YUj23wxRzwYKGv=7TueJ3nfUuKhUgz4A@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: ep93xx: keypad: stop using mach/platform.h
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Hartley Sweeten <HartleyS@visionengravers.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 12:56 PM Alexander Sverdlin
<alexander.sverdlin@gmail.com> wrote:
>
> Hi!
>
> On 15/04/2019 21:47, Arnd Bergmann wrote:
> >>> We can communicate the clock rate using platform data rather than setting a
> >>> flag to use a particular value in the driver, which is cleaner and avoids the dependency.
> >>>
> >>> No platform in the kernel currently defines the ep93xx keypad device structure, so this
> >>> is a rather pointless excercise.  Any out of tree users are probably dead now, but if not,
> >>>  they have to change their platform code to match the new platform_data structure.
> >> <snip>
> >>
> >>> diff --git a/include/linux/platform_data/keypad-ep93xx.h b/include/linux/platform_data/keypad-ep93xx.h
> >>> index 0e36818e3680..3054fced8509 100644
> >>> --- a/include/linux/platform_data/keypad-ep93xx.h
> >>> +++ b/include/linux/platform_data/keypad-ep93xx.h
> >>> @@ -9,8 +9,7 @@ struct matrix_keymap_data;
> >>>  #define EP93XX_KEYPAD_DIAG_MODE              (1<<1)  /* diagnostic mode */
> >>>  #define EP93XX_KEYPAD_BACK_DRIVE     (1<<2)  /* back driving mode */
> >>>  #define EP93XX_KEYPAD_TEST_MODE              (1<<3)  /* scan only column 0 */
> >>> -#define EP93XX_KEYPAD_KDIV           (1<<4)  /* 1/4 clock or 1/16 clock */
> >>> -#define EP93XX_KEYPAD_AUTOREPEAT     (1<<5)  /* enable key autorepeat */
> >>> +#define EP93XX_KEYPAD_AUTOREPEAT     (1<<4)  /* enable key autorepeat */
> >> You have re-defined the keypad register bits here.
> >>
> >> The KDIV bit changes the clock rate. The AUTOREPEAT bit enables key autorepeat.
> > As far as I can tell, they are not register bits, just software flags
> > for communicating between a board file and the driver, so I
> > assumed I could freely reorganize them.
> >
> > Did I miss something?
>
> They are indeed only software flags (just checked datasheet), so you are only changing
> platform data format. But as I do not know any keypad user in person, I'd rely on
> Hartley's opinion in this case (if it's a good idea to change platform data or not).
>

If there are out-of-tree users, it would be their responsibility to
upstream their code. If they don't, any changes in platform data is
their problem, not ours. Either case, platform data does, if anything,
reflect an in-kernel API, and thus is fair game for cleanup.

Guenter
