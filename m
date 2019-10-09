Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13500C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3794206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Sn8u1WRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbfJIUHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 16:07:36 -0400
Received: from mout.web.de ([217.72.192.78]:46229 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730490AbfJIUHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 16:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570651615;
        bh=SomjzGLYWNmKI5LdMK1dUZRhc+1Ld9HiIOpQO2lDapo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Sn8u1WRduZCwSjosVa7AhhAe7B75PslTNdlPqwmpGWhUhKMYURTEK35QATEsblJfV
         SiyYxV2Uzuxqs1upAdjxR4pxaFc4on/M8/7ixeS2lIqQQ7wmgn7EN8JZWn80I/y5ow
         N/Y3DSWUpaMcDGouuvgnyjVmxEv1EmjDxr7BlvVM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.177.35]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M4ZXs-1htAbD0ksG-00yhZA; Wed, 09
 Oct 2019 22:06:55 +0200
Subject: Re: string.h: Mark 34 functions with __must_check
To:     Steven Rostedt <rostedt@goodmis.org>,
        kernel-janitors@vger.kernel.org, kasan-dev@googlegroups.com
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
 <20191009110943.7ff3a08a@gandalf.local.home>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ce96b27e-5f7b-fca7-26ae-13729e886d46@web.de>
Date:   Wed, 9 Oct 2019 22:06:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191009110943.7ff3a08a@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:UuGZv/Rj7bp1Zs67fNW7zUExO1QJjGbL2a9NMe7fh5N4ZcXmGrt
 A5oyZlnGoa2hWqsgGGLAsCG6/ojI0ilIKHV1tuZTEXcrUBYhIbXeM9M+BqZoXMAXfKmqFrq
 +1EDWNPXIXmQiYjeNK25KRC1MSx7n74SriuD1m2jqaHRecQkgppVLgoDJRFeTDrZ7Gf57Qc
 3CDkGVRzVzBvwmLyrPu7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QcbYFq7GTgk=:QKlX5Ux0TnOjhgdpdlSLWF
 4yfCSyyJXqDhg05ZUXFZI46xLTxqLLtEo3kNq5SDnR7Mu3+8p0VR408o/uyNgDiOI+f6QlNTz
 wQO+GtTOvJyvmzhZkbcMOgO8rt3X9aVJT8hk0ws97jXBRDVfudqBog2W6FUEtPtTS0zEqj8EH
 /UGCnKEx4yvar58N2qlBPtUxuuiPOmv8skQR7P9ESLoAiPe0PjCLkQQAFrqR9s6B2xsJSeUrl
 ejE6q9vYlp/5VKrXwXvRzyem9Q7UaH4KrJs6l52tyXb+qy2HIXEuWNxLD6X4FXpc+IHzQHn/3
 iev4l9TS31gOhmp5fBJbIpcSOZJ7C3LrrinkqjVaK0dMOgp2fD6X87d0Aa2XSYC98qL/DHaAe
 H5rmvw9KrrpxEnXvD3wfRTbrVBFsLKKr0cgNoOnJ0+uk20ldGnmXNo6Xh4i+/E71f6c+hSPFq
 ibXxnj9q5p2rTzVQr0h1dsQZUumjW0ZGyI8MfxZpa1M8AA0QPtnI8bhlv2hyqLpcmZwA0C29/
 rsiffqyAEtMJlR3LrcIw1iwc7HgZH5XzW1A+N7L6egyaW1s2KpwVwJSAKnpZbQHOP/Dbugt/4
 xE+6d1Wm1eNgmRqUN5Pm/U3p3kkPbUrvpjgL65Z5KoCgqoMPHLfo6Z/YGtNLU1XR9K2qO3N4D
 BFEZiBsXHQXUjTQgteUs5NP6Mwwdj3O1RfCTCIGic1lTZj9uPQay3QWl680i3A8D1LkMmQP6J
 G2J9/O52seLF+l25z1uNHULOe98GF+uk2b9v6bHr0AqEsj3jJtgCcMY9TZ8eVfV6uNpPDlLuQ
 Fy9tUdxIxmEAkh69GlXZG/i9qJFzt7WVgsd3R91rhC7O0FmQbF3S5RIbHWGwVRrnhkr9N2wrQ
 Q7G1J6vzW7PGFv1Tial3e1bUUAy87/Jo/MgY2bi9PYuyNcVQCi/GiBmLUx582gbvLbIRXd1e+
 GSE3N0vL4qos02Wu3M+IFvlJCXAeTbWHvbC1Q14ibt5VWiYI52YTk7SHPFTUlTNqTvWgk+/O0
 IsO6M2gl96B9GI148viUpRNfsmUgrxXp+ooLJeo2YTlN8Xw4Tl2TrGxmsy9JTObQ6LSf15j7A
 2Y1uO8+s6yzBxgGkuTHOtiy7CeWFPBxcfO7Ts2dWEIpiJLbrZdlLNgvqdcKLUeW4vdoHU6b6y
 zSQTMQpKuCW/lApdUVnVSgM7HxGTKLiJV5syMmazHjT65de4QfGmm72Z/ucI/cYEmIMibW6Xe
 2vEeQsgqmWmE+DWY2SYjNofWbog/rjVOSb2Jokd8d8IFmWNowiQO5+obCmmo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm curious. How many warnings showed up when you applied this patch?

I suggest to take another look at six places in a specific source file
(for example).
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/test_kasan.c?id=b92a953cb7f727c42a15ac2ea59bf3cf9c39370d#n595
https://elixir.bootlin.com/linux/v5.4-rc2/source/lib/test_kasan.c#L595

Regards,
Markus
