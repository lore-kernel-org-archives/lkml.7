Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7589C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B6020880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGhG0FJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388458AbfGPS2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:28:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37703 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388345AbfGPS2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:28:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so9515278pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 11:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WeYKS39OFMhl8zrxoxlQCu4IDPAmvCEoho+1+F9/K+M=;
        b=nGhG0FJAUkp4b4zmPkND0sQYo5k36iIb/6RhVcYjX3bMXU/Xm3jDYlZsTIV1Ihv319
         ugALQhOVJ5k/hzaqtvezNXhFkqRYRErw94PsyamEk9dd/qpLl1KoTCfcF82EUha893uT
         u636i4Q3/aJ1/SWOxUQ+tNy7JfXEP6iL5b0uWoltNYMhvzyzes5NRU6Vq0pAtb/il0qi
         4y3SZdLlg3kLMeLXSUrI/bGHXqh8Wk0zT8IqJoRLXjkTA8EGqbk9h/t+nkucJJiAE1oJ
         ci4ne5wz/VZj1DIEAEJib17xhkkd9kR0agOhTTzh7vFPlu68bTP/XgkrTvOctBtES3eV
         h2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WeYKS39OFMhl8zrxoxlQCu4IDPAmvCEoho+1+F9/K+M=;
        b=gQ3FRfr0JSeZyYfJLrMcZ6Hao7MKqSdsn1A01lu22n5R3/vLgciEsKMGFC8862dspL
         d6Vui/+okgcJ/U5OByMW2tWnIXKu3nRK1Upu26dfMDHhvVUWOUyj2gbuVwv4Q3A+ou/A
         9FlgHOvC4WIqaWa+mriLg5HrqXL0xwE5yBH86XUsNq1r+dvSPhbD2+mmE2m2H0epU3zd
         zs0PiohZMIDLsGQj5yTQx3yMaZUKm5u27x57Xx0DsSlH0qIGFDdi4kStGmoBUG86xB8R
         mLyGosJto4ZmlJSCgZtA/mA+zWvUTZc42dQSlgc68+9L/AEZ29s9gMtbc3+vXcYb2xR6
         iHeA==
X-Gm-Message-State: APjAAAUjAlgdmtsbRVzU8je9EfjG1+CfRPOH7MPf5zM1pL5qcmSoMP1q
        Mi2M3CODhnb2/O4VoWhkDmfJ/0NFvZU/Yj5oUYmnZA==
X-Google-Smtp-Source: APXvYqy+seZIjulCJjRu3TVG3OVAN7RKTOI4pjWv7540ZQ3fMp8SANHVHCLTXuwBIJOzJsZDGtmbnYqwuwo+R0idRfU=
X-Received: by 2002:a17:90a:bf02:: with SMTP id c2mr38791644pjs.73.1563301720040;
 Tue, 16 Jul 2019 11:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAG=yYw=S197+2TzdPaiEaz-9MRuVtd+Q_L9W8GOf4jKwyppNjQ@mail.gmail.com>
In-Reply-To: <CAG=yYw=S197+2TzdPaiEaz-9MRuVtd+Q_L9W8GOf4jKwyppNjQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 16 Jul 2019 11:28:29 -0700
Message-ID: <CAKwvOdmg2b2PMzuzNmutacFArBNagjtwG=_VZvKhb4okzSkdiA@mail.gmail.com>
Subject: Re: BUG: KASAN: global-out-of-bounds in ata_exec_internal_sg+0x50f/0xc70
To:     Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        tobin@kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 10:44 AM Jeffrin Thalakkottoor
<jeffrin@rajagiritech.edu.in> wrote:
>
> hello all ,
>
> i encountered a KASAN bug related .    here are some related information...
>
>
> -------------------x-----------------------------x------------------
> [   30.037312] BUG: KASAN: global-out-of-bounds in
> ata_exec_internal_sg+0x50f/0xc70
> [   30.037447] Read of size 16 at addr ffffffff91f41f80 by task scsi_eh_1/149
>
>
> [   30.039935] The buggy address belongs to the variable:
> [   30.040059]  cdb.48319+0x0/0x40
>
> [   30.040241] Memory state around the buggy address:
> [   30.040362]  ffffffff91f41e80: fa fa fa fa 00 00 fa fa fa fa fa fa
> 00 00 07 fa
> [   30.040498]  ffffffff91f41f00: fa fa fa fa 00 00 00 00 00 00 00 03
> fa fa fa fa
> [   30.040628] >ffffffff91f41f80: 00 04 fa fa fa fa fa fa 00 00 fa fa
> fa fa fa fa
> [   30.040755]                       ^
> [   30.040868]  ffffffff91f42000: 00 00 00 04 fa fa fa fa 00 fa fa fa
> fa fa fa fa
> [   30.041003]  ffffffff91f42080: 04 fa fa fa fa fa fa fa 00 04 fa fa
> fa fa fa fa
>
> ---------------------------x--------------------------x----------------
> $uname -a
> Linux debian 5.2.0-rc7+ #4 SMP Tue Jul 9 02:54:07 IST 2019 x86_64 GNU/Linux
> $
>
> --------------------x----------------------------x---------------------------
> (gdb) l *ata_exec_internal_sg+0x50f
> 0xffffffff81c7b59f is in ata_exec_internal_sg (./include/linux/string.h:359).

So looks like ata_exec_internal_sg() is panic'ing when...

> 354 if (q_size < size)
> 355 __read_overflow2();
> 356 }
> 357 if (p_size < size || q_size < size)
> 358 fortify_panic(__func__);
> 359 return __builtin_memcpy(p, q, size);
> 360 }
> 361
> 362 __FORTIFY_INLINE void *memmove(void *p, const void *q, __kernel_size_t size)

...a call to memmove is made? Without having looked at the source of
ata_exec_internal_sg(), it's possible that either through inlining, or
the compiler generating a memmove, that one of the arguments was not
quite right.  I suggest spending more time isolating where this is
coming from, if you can reliably reproduce, or CC whoever wrote or
maintains the code and ask them to take a look.

The cited code looks like a check comparing that the pointer distance
is greater than the size of bytes being passed in.  I'd wager
someone's calling memmove with overlapping memory regions when they
really wanted memcpy.  Maybe a better question, is why was memmove
ever used; if there was some invariant that the memory regions
overlapped, why is that invariant no longer holding.

Anyways, sorry I don't have more time to look into this.  Thank you
for the report.

> 363 {
> (gdb)
> --------------------------x--------------------------
> GNU Make            4.2.1
> Binutils            2.31.1
> Util-linux          2.33.1
> Mount                2.33.1
> Linux C Library      2.28
> Dynamic linker (ldd) 2.28
> Procps              3.3.15
> Kbd                  2.0.4
> Console-tools        2.0.4
> Sh-utils            8.30
> Udev                241
> ---------------------x--------------------------------x
> Thread model: posix
> gcc version 8.3.0 (Debian 8.3.0-7)
> ---------------------x--------------------------------x
>
> Please ask if more information is needed.
>
> --
> software engineer
> rajagiri school of engineering and technology



-- 
Thanks,
~Nick Desaulniers
