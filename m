Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146E0C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5209207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgAGMh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:37:26 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:35257 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbgAGMhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:37:25 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N7zRz-1jkqIB1dp5-0151o3 for <linux-kernel@vger.kernel.org>; Tue, 07 Jan
 2020 13:37:24 +0100
Received: by mail-qt1-f171.google.com with SMTP id l12so45106623qtq.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 04:37:24 -0800 (PST)
X-Gm-Message-State: APjAAAVCEY34XySqTBUCo6fb5D+W2vLg5EAoqOhLG7g8CjXI3I0CIi3X
        2GFgzeXZzPFVQWqLnDbES0alWQ/wC8Ie0EGef/0=
X-Google-Smtp-Source: APXvYqwGR+1ag/FOo5lFGNP2agZe8JgiRzCUJT/p2HcrAqJ11wxrKbu23yPKHpHtix875YAxzOB8d2DOP1xgp2mKHDU=
X-Received: by 2002:ac8:6153:: with SMTP id d19mr78188452qtm.18.1578400643312;
 Tue, 07 Jan 2020 04:37:23 -0800 (PST)
MIME-Version: 1.0
References: <201912301716.xBUHGKTi016375@pmwg-server-01.pmwglab>
In-Reply-To: <201912301716.xBUHGKTi016375@pmwg-server-01.pmwglab>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 7 Jan 2020 13:37:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1OsiUV5YuwzSJ4CsD8NHJHjedTA4K7xBKK6Q-4kA8t5g@mail.gmail.com>
Message-ID: <CAK8P3a1OsiUV5YuwzSJ4CsD8NHJHjedTA4K7xBKK6Q-4kA8t5g@mail.gmail.com>
Subject: kunit stack usage, was: pmwg-ci report v5.5-rc4-147-gc62d43442481
To:     PMWG CI <pmwg-ci@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Private Kernel Alias <private-kwg@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Rbyd3mjfyh0X9/KMjlisXksFIavCsu8Lr+cr03ZAUvU6+HL5YqN
 hjWvwrTt+/FrSq1tQulDLzmwtcQHP7PfsCFHrXHiuZFB9Y9P5A2wotTCOXTJjxlqdNpvjFC
 W+lko1z7ji4Ed9svpQ+IyfsjZ7kJ2KIIeSOb8HQpLTbwXSk8kqnTxkODhFlD5C0ml5Gv/pV
 /2olj8Vb6uGRMSNFfcDJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qQZAqj7OKVo=:xgkie9o5LZfBqbCKPP8Rmh
 xYwAzMYf8vIKhL3WWX2yJ34VsGm1c+uhieNBF3Ll1hIPzLakEppOUUnlfrCBoZH7La8UhPtZH
 cJhz4RAUpSHpEKXkKkt1BTcAoMHtz1GD5yI0+0UfzOu6pobkO2oXvQMHPvzGIW86E01aKKpFF
 0/WeUezw88c0ZVqZ1qkXAB1qHkem0P3UAoAzg62mxEc+r0fUWsL7iVOHbWkOzZGOYdfAm/12g
 DSBru8C/gGfkmZzl4S/4oWPmYc5PF6KcOEQfwKLkL2xpc+LBbZJ2DjOQmycOF3ztCIQWlgSvj
 ltyme/DLSFvov/S6a6zfNEFWRouLU7K3l/AiZ6x0bx2Uys/QTs4BYjJW0dzEPlfPxuSGdp8Cc
 T6M9XszNHKUhNDMno62qH2YolsB7ZDMvtqZ5xbamUFLUGw3THLlrYysLDDFpFdyWyh2DraeaM
 wSgALnCh6GPJuRzUeaOerIAWZuaONyXjQFLXFACSo/BOeEx2wKekWj+DxWi7UrSsRrDUMhwum
 2OBEneqI0VwACeA46mVMIYLPNAHw9Xeypy6ekAf0hI9QP3tCutdlXiG9STd2eRx1CrwS8IVCF
 bLYevQkwB3MTSw6i781lHH+d4wLWTWFlkpiI4uHg9z1GCCliOcLN7HKX7ZkHxmY41lED1qafO
 x+i6aZ00vjeMxDHNRllNhP5wMAU8WYbd8DYe4fTKRngBmhEO6Br0V/cMzkzmWImFX7uR9X7kM
 GB8uUzPGatCPxg3WBKJfnT9ZezhQtdQMVHRh+DM0KQcoU5U9Atas7lBEd/WsJW8epa6lqAe6m
 WHJ6hHR6edL0SOr8qFuLlmnyoxZPWkJ+6QoeacxesEKWP7wH9ehb5VsTNTKQvVkeABc+YA1sD
 95ZOr2ZgNEQGPbg/RtpQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 6:16 PM PMWG CI <pmwg-ci@linaro.org> wrote:
>
>
> The error/warning: 1 drivers/base/test/property-entry-test.c:214:1: warning: the frame size of 3128 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> ... was introduced by commit:
>
> commit c032ace71c29d513bf9df64ace1885fe5ff24981
> Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Date:   Wed Dec 4 10:53:15 2019 -0800
>
>     software node: add basic tests for property entries

This problem is a result of the KUNIT_ASSERTION() definition that puts
a local struct on the stack interacting badly with the structleak_plugin
when CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is set in
allmodconfig:

pe_test_uint_arrays() contains a couple of larger variables, plus 41
instances of KUNIT_EXPECT_*() or KUNIT_ASSERT_*(), each one
of these adds its own copy of the structure, eventually exceeding
the warning limit.

We can work around this locally by splitting up the largest four
functions in this file (pe_test_uints, pe_test_uint_arrays, pe_test_strings,
and pe_test_reference) into smaller functions that stay below the
warning limit, but it would be nice to find a way for kunit to not
use as much stack space. Any suggestions?

        Arnd
