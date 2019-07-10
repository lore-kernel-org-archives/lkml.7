Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B15C74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C823D2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="HRta48ew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfGJRom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 13:44:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37452 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfGJRol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 13:44:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so1584067plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 10:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dmbO34ZqHStfI2tyC7TtDVBbhxIxp0PXVd1n64+drE0=;
        b=HRta48ewWh4wUetmF/uhzeoaKvUbzTYOovVQGptvjp+13DOThY1SWptjuP/5K8XcA6
         ZuKIDh+WJdYux9Qkl17HmLvGPw7NdvG4whGU32bV4//+DOYJICMIynku4p4L8jtS00UJ
         c8y+Re0K7yU4LAxSGwBpR/C9Ba48op3KpeJJ0h770D6vCk7ZUI3NKWexZD2Y4MrL8+83
         l/Wz4cauTJALHBGjfkHJF+caw/MabdvYkooqtMFZX5KI/Yz6F9GtbBNnQoz5J7zsJfVy
         r1ooR88MKCmW5nTghd8s/5D27NbDJACnfOPUpcVKlydK5v1iIJdOaXTCH/zlRA+gqYHr
         wJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dmbO34ZqHStfI2tyC7TtDVBbhxIxp0PXVd1n64+drE0=;
        b=Fn/kjDMa2g68xaucYNDojbKuyT+sPDoYUB6sjtNCmd6iQ0WbGKBrp01FZZ67I5dXr+
         8r5Ck/kcGIeGNsX6cE6Cfn+TUWZ1EdMH1tmsgVOT6UFGmknFdy48vLP+6AOMKUW+YhsU
         75Aw0vXxScboVGX1DUT1uR/wR22aYA01ZNv5M0QOqpqblSuM42+BAzu/nbTE0dSEMhRV
         6caXS5CHQ/+ho4t8tMxEq6funtpvXRG9hGKUro9IYodW4zOt7HaC3tYES2XI4FtRQ6Xu
         uBMeQZUthugkNKbuc7fKjQmuyBZzb3aF7u5uIU1D6az4dn2hHXa6zCyacsojeJ4EbZCp
         xnXQ==
X-Gm-Message-State: APjAAAUbEwOtQXIRnL3ugy0iL/tjper8CXLuWNDtIdDTwAr6EWQ2rY/i
        1Q1cHes60rXKY+fvvLwKbjhzBfpdWNYPlZjsVxxOUg==
X-Google-Smtp-Source: APXvYqxQjUcYJsZ6u/BVsrh0Z2/kl5tzSysXuxGU6exHCzTmppV6MJsHqLj/ZSssqOAuDOc4mUj6dVY7LXZra1W5dwM=
X-Received: by 2002:a17:902:fe93:: with SMTP id x19mr37478959plm.77.1562780681028;
 Wed, 10 Jul 2019 10:44:41 -0700 (PDT)
MIME-Version: 1.0
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Wed, 10 Jul 2019 23:14:04 +0530
Message-ID: <CAG=yYw=S197+2TzdPaiEaz-9MRuVtd+Q_L9W8GOf4jKwyppNjQ@mail.gmail.com>
Subject: BUG: KASAN: global-out-of-bounds in ata_exec_internal_sg+0x50f/0xc70
To:     rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
        alexander.shishkin@linux.intel.com, tobin@kernel.org,
        ndesaulniers@google.com
Cc:     lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello all ,

i encountered a KASAN bug related .    here are some related information...


-------------------x-----------------------------x------------------
[   30.037312] BUG: KASAN: global-out-of-bounds in
ata_exec_internal_sg+0x50f/0xc70
[   30.037447] Read of size 16 at addr ffffffff91f41f80 by task scsi_eh_1/149


[   30.039935] The buggy address belongs to the variable:
[   30.040059]  cdb.48319+0x0/0x40

[   30.040241] Memory state around the buggy address:
[   30.040362]  ffffffff91f41e80: fa fa fa fa 00 00 fa fa fa fa fa fa
00 00 07 fa
[   30.040498]  ffffffff91f41f00: fa fa fa fa 00 00 00 00 00 00 00 03
fa fa fa fa
[   30.040628] >ffffffff91f41f80: 00 04 fa fa fa fa fa fa 00 00 fa fa
fa fa fa fa
[   30.040755]                       ^
[   30.040868]  ffffffff91f42000: 00 00 00 04 fa fa fa fa 00 fa fa fa
fa fa fa fa
[   30.041003]  ffffffff91f42080: 04 fa fa fa fa fa fa fa 00 04 fa fa
fa fa fa fa

---------------------------x--------------------------x----------------
$uname -a
Linux debian 5.2.0-rc7+ #4 SMP Tue Jul 9 02:54:07 IST 2019 x86_64 GNU/Linux
$

--------------------x----------------------------x---------------------------
(gdb) l *ata_exec_internal_sg+0x50f
0xffffffff81c7b59f is in ata_exec_internal_sg (./include/linux/string.h:359).
354 if (q_size < size)
355 __read_overflow2();
356 }
357 if (p_size < size || q_size < size)
358 fortify_panic(__func__);
359 return __builtin_memcpy(p, q, size);
360 }
361
362 __FORTIFY_INLINE void *memmove(void *p, const void *q, __kernel_size_t size)
363 {
(gdb)
--------------------------x--------------------------
GNU Make            4.2.1
Binutils            2.31.1
Util-linux          2.33.1
Mount                2.33.1
Linux C Library      2.28
Dynamic linker (ldd) 2.28
Procps              3.3.15
Kbd                  2.0.4
Console-tools        2.0.4
Sh-utils            8.30
Udev                241
---------------------x--------------------------------x
Thread model: posix
gcc version 8.3.0 (Debian 8.3.0-7)
---------------------x--------------------------------x

Please ask if more information is needed.

-- 
software engineer
rajagiri school of engineering and technology
