Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E66C04AAA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9FC2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B9RPr9e5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfECHQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 03:16:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38165 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfECHQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 03:16:19 -0400
Received: by mail-lf1-f66.google.com with SMTP id v1so3701610lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 00:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rtSbGYmKklFW+DrwkU0C+VxMVLVuu2pUhj66Een1PGY=;
        b=B9RPr9e5dWYYhfvLP6A/hH+KrXtO/Yez0gb/5L0LdyKb8z8MZhdeHeOt+yi2UNKxXX
         kqhFr7Ga99BGfpc+a7PON1hZXY4Ke+EL0MrvbB7dteYDQWAsBcmhEJ18AHotXv2HHwvf
         komU/gZlAC7p1nBwxEhrNanbFdWzVS7fMkxqZYXV4NNNER5XUhDvqqrg89GlUsrbC9/D
         4CA9xMlkTkFFYb1aVaVqqM/PSMm01raoSSns+BYDEleFwFzhtuVKCTIBCc/I5EIMtaw6
         O/utJQ8G1FP22BHM9I2VTN84Si0h+UUECdvX4JD7wVp96wfqesqzdaujEMuf6dNutDQo
         5AjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rtSbGYmKklFW+DrwkU0C+VxMVLVuu2pUhj66Een1PGY=;
        b=Ey6ZGCJ6byi2SbOdvictXSDyVtO97QlR0uX+3Dd8egiC47/An9tHbeycVkBP7WHCgY
         n11EpWWw6GBfCZWY4zyRaDULPjfwvE6S0cav1CIhMezRYW1PSxDZ1G8DmE/4tm+mo2ws
         BJqwu6hPCoHVjb1GPvuZuiy3rshUPlWYqGvHrh3rEsijwfT1VZ9MZrRBhypBvBNL6V0A
         ik+qLkAAaSlrJjo48TL1No5kiXBCelO/2UYW6vSZvi5GNEl91CRgkQR9GOWuQ1+kR73q
         eTJVA9TB0LodrDyVBRRUmVi/kcRecmWPDRbElPHy+AZ+ByBKIxdjx/SqebJdZxXQ593V
         +9vQ==
X-Gm-Message-State: APjAAAUPg5/11KSZqCvXaUWKVjwXTFgJcUu+129rdyI52ErM7RF60u25
        M7LOsLn3/m+ru6IQnTnDlxKGNwxL1QAap3RbTmlMtg==
X-Google-Smtp-Source: APXvYqzJk0GUKle7WEk7r+TX6j6b6Koid9bqgPMCDj802pdYnmzrB/eWrxxyZQDNpWxQCQ3SCkyms1KNQoSQ8MdZwSE=
X-Received: by 2002:a19:f001:: with SMTP id p1mr4474778lfc.27.1556867777010;
 Fri, 03 May 2019 00:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190415202501.941196-1-arnd@arndb.de> <2424c672-e3fb-4c32-4c24-fafc59d03a96@uclinux.org>
In-Reply-To: <2424c672-e3fb-4c32-4c24-fafc59d03a96@uclinux.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 3 May 2019 08:16:05 +0100
Message-ID: <CACRpkdaJ+2bub_nDp9=5b4kyKjWDnOGKscWg3KsEVixDpk8rzA@mail.gmail.com>
Subject: Re: [PATCH 1/6] ARM: ks8695: watchdog: stop using mach/*.h
To:     Greg Ungerer <gerg@uclinux.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm-soc <arm@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 3, 2019 at 8:02 AM Greg Ungerer <gerg@uclinux.org> wrote:

> I dug out some old ks8695 based hardware to try this out.
> I had a lot of trouble getting anything modern working on it.
> In the end I still don't have a reliable test bed to test this properly.

What is usually used by old ARMv4 systems is OpenWrt or
OpenEmbedded. Those is the only build systems that reliably
produce a userspace for these things now, and it is also the
appropriate size for this kind of systems.

> Ultimately though I am left wondering if the ks8695 support in the
> kernel is useful to anyone the way it is at the moment. With a minimal
> kernel configuration I can boot up to a shell - but the system is
> really unreliable if you try to interactively use it. I don't think
> it is the hardware - it seems to run reliably with the old code
> it has running from flash on it. I am only testing the new kernel,
> running with the existing user space root filesystem on it (which
> dates from 2004 :-)

Personally I think it is a bad sign that this subarch and boards do
not have active OpenWrt support, they are routers after all (right?)
and any active use of networking equipment should use a recent
userspace as well, given all the security bugs that popped up over
the years.

With IXP4xx, Gemini and EP93xx we have found active users and
companies selling the chips and reference designs and even
recommending it for new products (!) at times.  If this is not the
case with KS8695 and no hobbyists are willing to submit it
to OpenWrt and modernize it to use device tree I think it should be
deleted from the kernel.

Yours,
Linus Walleij
