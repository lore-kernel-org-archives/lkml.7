Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF95C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806C221921
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="1ULS90MZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfGVNFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:05:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35253 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbfGVNFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:05:19 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so73730986ioo.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1jqepYSM8WgsfNhH9i6/YmrUUqtzbVePUVomMLzy33Q=;
        b=1ULS90MZsmEbXmWbaF0QWNzWQeIyvX3nMexbCWW3bIDyrwA1SBD4M8CcVNxWsfCEg4
         B0t1QzXfpmjzwQNntgJNQph37W5d5AYhgNj5BMrMSvCN1beQU/wCHX6hb8ccyTn6tWqK
         dbMKtJueIa7bz9hqtGjQ0fSnLv1SuGQeM0OKKBUiNcrCHRQAbM14cQJD3DnWxpVuiV5S
         9SAjHqgz/PucnHm0xwwkN+KsBp0uQ/L7xzqCQ2yYKxrYs8K2Gk1y6edeM/pfVrjOPTbf
         T1WMIACxUllzT6rwlTB7VlswzseKsf7K0QXSAU8FA0Vs0q+Es96lYcqpYPV04rMuGQHX
         mGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1jqepYSM8WgsfNhH9i6/YmrUUqtzbVePUVomMLzy33Q=;
        b=Hv9uQwgOlCoEeJn9dgvMAJT0VmEK/uyH6gBw7iMrqBZvDvU2oV1vprV6am+HAfRMM9
         3D9YTULAq88rVLpD/IifxZXzt+pYD64bMU2Sq5oK8bue9zEpOSwJWEEv7gJn8ox+DDTJ
         UQOOS1MCN6F+D0Jz7ejo94Be9OzEEMoWJeFkuKs2BhFTGuRIFknmXl3MH4kv/Qb8BKcF
         9FuI9ug1ocw/qkmLZNU6S4DYxu0R0h4rjQGNV+vxBQVRU/IAEy9Qof+cl8jbVF24I9Xg
         FL4PBtD9ARauaXeaoTRx8E2egDDvPEkdTVfKK6wQv1dibOAtTb0I3QPYpFmBeTYvzHVc
         SwUA==
X-Gm-Message-State: APjAAAX/z6sQwqAAEzdJXjlujhXJYK7M80G0lT2Za5LAhP1uU6n/MtwT
        OdB9j+Jw1ByD5gNQv2icMG8FruRT5Z9vcHSPCLI=
X-Google-Smtp-Source: APXvYqx/sHmrZLwV04MCliJab1gGr9EjdpbABuDnFoHuAACMlgn+680zCHYQpldi8m4kPii6mLKfJyW3nBU+34QHi0E=
X-Received: by 2002:a6b:f80b:: with SMTP id o11mr57184471ioh.40.1563800718793;
 Mon, 22 Jul 2019 06:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAMRc=MdaLPcy4fJOEbcXAriHLHrXUZD6Bh5X2Eq+2OBvcC4cOQ@mail.gmail.com>
In-Reply-To: <CAMRc=MdaLPcy4fJOEbcXAriHLHrXUZD6Bh5X2Eq+2OBvcC4cOQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 22 Jul 2019 15:05:07 +0200
Message-ID: <CAMRc=Mc0WmdfB4bsN+o8xxtv7WTrvwAZmJAQ_GvjrK0twsCw4A@mail.gmail.com>
Subject: Re: [v5.3-rc1 regression] Hitting a kernel BUG() when trying to load
 a module on DaVinci SoC
To:     Yang Yingliang <yangyingliang@huawei.com>,
        Jian Cheng <cj.chengjian@huawei.com>,
        Nadav Amit <namit@vmware.com>, Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 22 lip 2019 o 14:12 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(=
a):
>
> Hi,
>
> with v5.3-rc1 I'm hitting the following BUG() when trying to load the
> gpio-backlight module:
>
> kernel BUG at kernel/module.c:1919!
> Internal error: Oops - BUG: 0 [#1] PREEMPT ARM
> Modules linked in:
> CPU: 0 PID: 1 Comm: systemd Tainted: G        W
> 5.2.0-rc2-00005-g7dabaa5ce05a #19
> Hardware name: DaVinci DA850/OMAP-L138/AM18x EVM
> PC is at frob_text.constprop.16+0x2c/0x34
> LR is at load_module+0x1888/0x21b4
> pc : [<c0081bbc>]    lr : [<c0083c4c>]    psr: 20000013
> sp : c6837e58  ip : c6b4fa80  fp : bf00574c
> r10: c0601008  r9 : bf005740  r8 : c0493e38
> r7 : c00807f8  r6 : 00000000  r5 : 00000001  r4 : c6837f38
> r3 : 00000fff  r2 : bf000000  r1 : 00004b80  r0 : bf005818
> Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 0005317f  Table: c6b78000  DAC: 00000051
> Process systemd (pid: 1, stack limit =3D 0x(ptrval))
> Stack: (0xc6837e58 to 0xc6838000)
> 7e40:                                                       bf005740 c649=
2a90
> 7e60: 00000001 c6bf5788 00000003 c6837f38 bf0058c0 bf0058a8 bf00a495 c049=
3e38
> 7e80: 00000000 c05368c0 00000001 00000000 c0580030 c0574b28 00000000 0000=
0000
> 7ea0: 00000000 00000000 00000000 00000000 6e72656b 00006c65 00000000 0000=
0000
> 7ec0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> 7ee0: 00000000 00000000 00000000 aefb2bb8 7fffffff c0601008 00000000 0000=
0004
> 7f00: b6cee714 c00091e4 c6836000 00000000 005bc668 c00847b0 7fffffff 0000=
0000
> 7f20: 00000003 00000000 0000b2d0 c884e000 0000b2d0 00000000 c8852dcb c885=
33a0
> 7f40: c884e000 0000b2d0 c8858cb8 c8858b34 c88568d4 000058c0 00006190 0000=
23b8
> 7f60: 00006713 00000000 00000000 00000000 000023a8 00000024 00000025 0000=
0019
> 7f80: 0000001d 00000011 00000000 aefb2bb8 00000000 00000000 00000000 0000=
0000
> 7fa0: 0000017b c0009000 00000000 00000000 00000004 b6cee714 00000000 0000=
0000
> 7fc0: 00000000 00000000 00000000 0000017b 00000000 00000000 00000001 005b=
c668
> 7fe0: be907b00 be907af0 b6ce66b0 b6c3fac0 60000010 00000004 00000000 0000=
0000
> [<c0081bbc>] (frob_text.constprop.16) from [<c0083c4c>]
> (load_module+0x1888/0x21b4)
> [<c0083c4c>] (load_module) from [<c00847b0>] (sys_finit_module+0xbc/0xdc)
> [<c00847b0>] (sys_finit_module) from [<c0009000>] (ret_fast_syscall+0x0/0=
x50)
> Exception stack(0xc6837fa8 to 0xc6837ff0)
> 7fa0:                   00000000 00000000 00000004 b6cee714 00000000 0000=
0000
> 7fc0: 00000000 00000000 00000000 0000017b 00000000 00000000 00000001 005b=
c668
> 7fe0: be907b00 be907af0 b6ce66b0 b6c3fac0
> Code: e1a01621 e1a00002 eafe4531 e7f001f2 (e7f001f2)
> ---[ end trace 2cbefb0005882c52 ]---
> Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000000b
> ---[ end Kernel panic - not syncing: Attempted to kill init!
> exitcode=3D0x0000000b ]---
>
> I bisected it to commit 06bd260e836d ("modules: fix BUG when load
> module with rodata=3Dn") with commit 7dabaa5ce05a ("modules: fix compile
> error if don't have strict module rwx") on top to make it build.
>

I got the commit hashes wrong, because I was playing with a modified
tree. They are 2eef1399a866 ("modules: fix BUG when load module with
rodata=3Dn") and 93651f80dcb6 ("modules: fix compile error if don't have
strict module rwx") respectively.

Bart

> Let me know if you need me to provide more info.
>
> Best regards,
> Bartosz Golaszewski
