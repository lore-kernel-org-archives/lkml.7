Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BF7C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC89206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="swuHrS5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbfDQTID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:08:03 -0400
Received: from mail-it1-f170.google.com ([209.85.166.170]:37775 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfDQTIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:08:02 -0400
Received: by mail-it1-f170.google.com with SMTP id u65so6196621itc.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 12:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OUguioRnkkOtXfn8MCcdCtihLKJAwW4dPEPsNDxxckc=;
        b=swuHrS5rK/zw2AIHToL3i9iRG38IuAR8vjBCZv9rDrVEeBBUWX0poW/r5VShb6fIea
         LeUCc4HsagKc/1D1TLF8eUqli4aevqcrwerCLUzq+aUtaPliacRbmIGm2zLVpBguclQj
         ZloKDb1XyujFeuGCrbxt0K7LQSMVSRlo8otozaBmwvjLm/ENvD0gY6WDEyXK5668eLAb
         rAdoXlWo8M1Zv+yVV8fGiMZuoZwPPP2SZ0fTHdIX8zhYWG6hAAxTSnjSQBtST73yspau
         deRZ9ab6VhU19LRaF5qqUU8mVikHiFiuvn8MrIZ/9rPWEMB0TQqkWmk+H70HenVSEmE6
         UygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OUguioRnkkOtXfn8MCcdCtihLKJAwW4dPEPsNDxxckc=;
        b=kn4IpXAHRZxGZWH0AtiQKSusYJVin/xMXowdTElIWQ+o4/EFDoAequqTZ7ewZGw1pC
         YSj+Oy8zP/cmYeiPCl6cFbkYN01iBy7H2VlYY9AGBnRClPWzDVZWbzZx0hBHqe25YwoL
         bjSHrFLYGQcNK9g6RQ0w+DSLsXERIuRxs82CWyE031QPSiKvxe/UEtNi+N/GV5KaZZ46
         x0kFxgnXMDQL04umv8/6ikviBN6FY4AH4VD+Dq6XM7yKQbS8ouIUgOe1iwKFWzHwNFUS
         WhMsG1t9ffxz3y8TxC8AUjDfSX6zEYgMhftdHZdZf0Gl7WVEORYqmAIA5Hkdva6v2Po8
         Lztg==
X-Gm-Message-State: APjAAAUjrLYvYNSV6kiAzCChxIAx+/2mEGNWJHZHf1pFdoWiauZ6CNZ+
        ybUlhZo8ARZLnUIg74iHNksUZ05Ltw8I9M2j+9VRlA==
X-Google-Smtp-Source: APXvYqyw+4+2Z1yiryHwnhu9XCRC0+/WMxExt8JlOE11w+pZeEpaV/tbOu5x8MsVDEiPCW4Wo8IQTA/IAhoqpDcpauo=
X-Received: by 2002:a05:660c:4c2:: with SMTP id v2mr121801itk.71.1555528081522;
 Wed, 17 Apr 2019 12:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190412080152.3718-1-jian-hong@endlessm.com> <tip-0082517fa4bce073e7cf542633439f26538a14cc@git.kernel.org>
 <20190416082042.GA69717@gmail.com> <CAD8Lp44pQRYdw4cbfMt3uOSO23dzy_mWTt5T-Zjft08WWu_yUA@mail.gmail.com>
 <20190417061650.GA31060@gmail.com> <CAD8Lp45BLaoXF=RNcncqcTtNvaGHP72+a1CxcjoeBXDiw9TKbA@mail.gmail.com>
 <17516564-37AC-4F77-9C0D-0DD71F8045EA@zytor.com> <CAKv+Gu_jqoKiqq4ozcPwSxLmpuaWsFKy_xyYGhECLz+KLHOjOw@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F48AFEFF2@ORSMSX114.amr.corp.intel.com> <20190417182341.GA5140@gmail.com>
In-Reply-To: <20190417182341.GA5140@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 17 Apr 2019 12:07:50 -0700
Message-ID: <CAKv+Gu9NJH02obRtgtNf7O7Bd8Z0SdKjsBLppGd60f6ryq6OoA@mail.gmail.com>
Subject: Re: EFI reboot vs. ACPI reboot (was: Re: [tip:x86/urgent] x86/reboot,
 efi: Use EFI reboot for Acer TravelMate X514-51T)
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Drake <drake@endlessm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        linux-efi <linux-efi@vger.kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 at 11:23, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Prakhya, Sai Praneeth <sai.praneeth.prakhya@intel.com> wrote:
>
> > I will ask around internally to check if it is a good idea to make EFI
> > reboot the default method when the machine is booted in EFI mode.
>
> Or whether there's some robust signature that indicates "modern EFI
> system where EFI reboot is the primary method"?
>
> Major EFI version or ACPI version or such?
>

I am actually at Microsoft right now, and I managed to get
clarification on how Windows deals with this: Windows will attempt to
use ACPI reboot first, and will only attempt to use anything else if
that fails. EFI reset is actually its least preferred option, and so
it is highly likely that it is untested on most of the shipping x86
hardware if any of the other methods work.

So let's not touch this.
