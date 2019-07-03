Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429E6C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0866521852
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ON3AqXpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfGCSnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 14:43:46 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39265 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCSnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:43:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id p24so2495514lfo.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 11:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+1ik/vvOveRHv6gC+vDCsa/NHe6vb//8HQCEW5cYfo=;
        b=ON3AqXpT0V7isG9+j7JZBvuqy4Kap3GDnft3GXOvwOEvAH4TZZ/Eo4sp5enHq9mcK1
         xYgaHeZ1s5Z12So406hFfrw+DQcBIj8VhduCBb+4Bkx7My8FsU2wmNHWiJN/osCBKthw
         6x7O2b/tkLQ8KRvUw/iD9Gp8gShZQpqQsJo+ImQIq6YbleUsyiIPTuSvRtfpr4YBy7hb
         53v6O6RmJAc3h5GslmR5dSdLqf+gQzuw0VYvoEVyV06CBPoF52GEPnG6mfXEZLLa3+jQ
         RsaW/o6aLqQxidSpWMECeGAf4cDvDxHnGQiwHouPN8us1AZ6Kf19a+81ruAuMXfLWOh0
         T7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+1ik/vvOveRHv6gC+vDCsa/NHe6vb//8HQCEW5cYfo=;
        b=t8d4mzXH2s2C1y7CVQYZSYf3FTU++8E3+5PKeiDXlGKgbNaDk2ZcdwfUYQdetTOExU
         RZzvWyEpY69auU7Z67GdtQAZaca8lM8F4+P4zrPP4m9Ey7goGW4SYF5MrfDstVTfGMso
         eMQEiH24oZEBMCIauuraHOa3Caium++QkPi59V8lVHTMSaUA8kkCV2MCfbGsQG98jpri
         L4KT8qwuW+Fo7irWJlWcZtn//X7UxcfHcqUA6FIaQVpBVTPoMeMOrcvenKOO9+HJwM/1
         gI83x+8uTKgH7qmEGB7F1fgZN9iE6DilMNwyjM/ljsjH5WH2TSkph2HV//WU/5/+RH+1
         rDjQ==
X-Gm-Message-State: APjAAAUHwYfo9XwMSyJm2z028JazUav/TYXdpJerWm4DomL+zMtIAVLJ
        3JhXrCaZpXF/aj+hgkC+qd2o9ud8WUGd29Zrqlk=
X-Google-Smtp-Source: APXvYqzajfNogCiazIdQFJmJhPWwHxWc+Z5wwmTmzYBOWXkIYTk3INMO8TqgM5RbVH5cV1J3m23oX2p+tF/cALTXTXQ=
X-Received: by 2002:a05:6512:29a:: with SMTP id j26mr363525lfp.44.1562179423948;
 Wed, 03 Jul 2019 11:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190703005202.7578-1-alistair.francis@wdc.com> <mvmk1czh9y6.fsf@suse.de>
In-Reply-To: <mvmk1czh9y6.fsf@suse.de>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Wed, 3 Jul 2019 11:40:39 -0700
Message-ID: <CAKmqyKPn9GBg=n1j-ZpEdCN4Qfi5qfNtEVgpgF8rYRpof4eNDA@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/2] RISC-V: Handle the siginfo_t offset problem
To:     Andreas Schwab <schwab@suse.de>
Cc:     Alistair Francis <alistair.francis@wdc.com>,
        linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 12:08 AM Andreas Schwab <schwab@suse.de> wrote:
>
> On Jul 02 2019, Alistair Francis <alistair.francis@wdc.com> wrote:
>
> > In the RISC-V 32-bit glibc port [1] the siginfo_t struct in the kernel
> > doesn't line up with the struct in glibc. In glibc world the _sifields
> > union is 8 byte alligned (although I can't figure out why)
>
> Try ptype/o in gdb.

That's a useful tip, I'll be sure to use that next time.

Alistair

>
> Andreas.
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
> "And now for something completely different."
