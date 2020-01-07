Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF4EC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBFB2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgAGNyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:54:36 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:60325 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgAGNyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:54:35 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mnq8Y-1jV55U0jbG-00pI9v; Tue, 07 Jan 2020 14:54:34 +0100
Received: by mail-qk1-f181.google.com with SMTP id k6so42678792qki.5;
        Tue, 07 Jan 2020 05:54:33 -0800 (PST)
X-Gm-Message-State: APjAAAXQxuz4KREulreElswh1Jjf1oNapnUkTtO2gvkSaRJKHbl7WSXg
        BP+ympirVerd79FjGwoCYquJYD1lw1qdFVnWJuY=
X-Google-Smtp-Source: APXvYqxganD8ZrCIqDyUtQfBqO0agkD208yuy9nhgKAOXvloNNFhJIXLOG+bMa6bJ39dPMJZh/yjpxY1x4nnSb3sYgE=
X-Received: by 2002:a37:2f02:: with SMTP id v2mr84906448qkh.3.1578405272953;
 Tue, 07 Jan 2020 05:54:32 -0800 (PST)
MIME-Version: 1.0
References: <1578399963-2229-1-git-send-email-krzk@kernel.org>
 <CAMuHMdULcBE1inRzTRFJeRDToT1wW+nrMEfiUs7DxMLR0tqb3w@mail.gmail.com>
 <CAJKOXPcbUfUcmU2O50M5Hs2y6ggg-m5qU-AJ6HjSL9dFTCp64A@mail.gmail.com> <20200107133256.GA648@pi3>
In-Reply-To: <20200107133256.GA648@pi3>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 7 Jan 2020 14:54:16 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1EiHCVo0aJzwsv_kbT9ENMScnxfWM7Zoc08fd7bL=D1g@mail.gmail.com>
Message-ID: <CAK8P3a1EiHCVo0aJzwsv_kbT9ENMScnxfWM7Zoc08fd7bL=D1g@mail.gmail.com>
Subject: Re: [PATCH] sh: clk: Fix discarding const qualifier warning
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:tU0eO8O6xurj+b44Y54kgigL29BQZecRwNVL9NdGsXX8W+0xG9d
 m/KvYojG5ZmCv5v/Tw6t2Vp5ecy5m4Wy3UfF7q9r9G+7O3HT9j0k1Kp3f+iXh1JiBXnAow5
 rhWeNuacha9UnIIBiF+cOftztsw+DfX5wLAeVAFQKRvbvLwSmv4RSSffFGzCc+VNX1in7+f
 eyp3rHoR/gTTKymVq3WIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pBpIjKq4bxc=:sfOGqOKLVrui8Kc9jwGZFG
 6WgealvGo0mB1XnzG5lmF93aviHe27egZjqE7+z2gpmyqdjL0s9vEtigUTT4hkWsVOxaJ0pBp
 uMNGoEYg9NHdkDDQUZhZM4K/iraHORT+amkLhegud09jBD+zmX+xwS6BqSp7Fw9akwj6rcvtz
 B2uPCPiEx1ThqbUjOAZPwSzoen3KMm407InYVdsffFPsqE1I6eRusUBiiYp+UnaeHNEEhX36A
 p5z5/vU5hT8iuWPr2PguDEAF4xNX8cVuMsyVnAEZ8HG4D93U9/zT/114jAaeoGa5T6TpUwAAV
 /yH3Xe14ggrg93R9gr/isKHW34Kyj8zfYLPd+/NfK0AvAkcuc4vjeY6j/exQ7bs708QQ9Mw1I
 eKn0WQWhsdzgsKkXMBTO0rrw9PhYvFxOF30LskXnAUdX8VeeF/ITtr0YnZsGikC6ssqqG184J
 hPAp+PG6AKU8l4TAuWpQqniSx8M3475gC+UjUKkRbLRfFdWvCZShkNg6WkJtgO+NMAFmRfhoC
 oF0M18fotksFQJuzLwLBH70eXJR+I06VbsehAiPGIbcS/yjSr2h7PUmzqeNBNKXmSCayWnUBt
 5UKSX3QPr8LMKnPDpYYn1AgoWacjC2BIR3hMuImeV9P2wgm9npAyHX77o5SKr9wHxYAmW6Rfn
 AG+ZYu08gSMXYYm+GQx3o+hCxySZu80Pp3HHT6EjQsEA6ff35OE6jxqdkp1imiyMXYKPwREyw
 wZ1L48N01cHh+I6mBNjZ5THOks01zjFRTm4i7dKBFYA4AeEFCczs8+7Do4FWElaC4Z9QWvmyb
 ZO0chCUZ1dOqodlFllRxu3Hcbv2EDYPk0cZ2dLMmL6WfHqTzXGZ1j3bXAmZd/ttJxu9Zjbm/i
 EAkML5yNme0/pQxR7Dhg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/powerpc/kernel/iomap.cOn Tue, Jan 7, 2020 at 2:33 PM Krzysztof
Kozlowski <krzk@kernel.org> wrote:
> On Tue, Jan 07, 2020 at 02:05:14PM +0100, Krzysztof Kozlowski wrote:
> > On Tue, 7 Jan 2020 at 14:00, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Since this is a SuperH driver, I adjusted it to the SuperH
> > implementation - lack of const. However iIndeed it makes sense to have
> > them all taking "const"... Let me check, if I can fix it (without the
> > real HW).
>
> That will be non-trivial because many platforms define ioreadX() with
> non-const. For example entire alpha with many its implementations of
> ioread(). Even include/asm-generic/iomap.h defines them as non-const...

I found these instances:

arch/alpha/include/asm/io.h
arch/alpha/kernel/io.c
arch/parisc/include/asm/io.h
arch/parisc/lib/iomap.c
arch/sh/kernel/iomap.c
arch/powerpc/kernel/iomap.c
lib/iomap.c
include/asm-generic/iomap.h

At least the last four file would have to be done at the same time as
the header is shared, but the actual conversion should be trivial.

       Arnd
