Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1815C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C472067B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfJOHTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 03:19:22 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38178 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfJOHTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:19:21 -0400
Received: by mail-qt1-f196.google.com with SMTP id j31so29149582qta.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 00:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qv7Az5tD/2XKPoU73wFDWyAMqFq/42sDZyfm822TJb4=;
        b=HSZ7759lULRSm51Y2uVkg96Ys1NfIwYuiEWs3E5iJipT5zJZLR5QTTFGSmN5JAE8QQ
         BZpe+Swpid3D1qd5hy2fa9NpvapPuLhackONp24jK7OeDOf8v8IO9bi+22brA3Pu6Jjb
         S7u08fCxAsSGYmhvEthEBQpl0c/v8p5A/YiTnJChyXJBDlHyC0PZMsL1EzAeFb93WgPd
         UIg83V7frNx+qr3COf3MdKKPiuYZOkGLbhIHE+U9NZd78gEM6NBn8CjZ1B/8jmfTjlXE
         3ARgb+QN37tD/bcyqPV7atp/sKV0KCF/m3rYtSndFKUxQR1zU+h6N1ACr8B9afTYPgMt
         bDqg==
X-Gm-Message-State: APjAAAVNrwbH2SmBn4/CBhuSLGE16KBeo2fwWf8YkGH5ffyFvoBY98eO
        PeN95yz34BDPLxOL5a5jDASbBq9jjBnklAMPdlQ=
X-Google-Smtp-Source: APXvYqwEf7+nYwWc61OYEaNaRzAZ8uh3kP2DVnSCpuosyoqHQiMTeGmwjT2VpKWTH2nEMXm6Ffgs1TODM9UjJHE55vs=
X-Received: by 2002:a05:6214:1150:: with SMTP id b16mr35117488qvt.197.1571123960489;
 Tue, 15 Oct 2019 00:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnDVe-dahZGnRtzMrx-AH_C+2Lf20qjFQHNtn9xh=Okzw@mail.gmail.com>
 <9e4d6378-5032-8521-13a9-d9d9519d07de@amd.com>
In-Reply-To: <9e4d6378-5032-8521-13a9-d9d9519d07de@amd.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 15 Oct 2019 09:19:04 +0200
Message-ID: <CAK8P3a3_Q15hKT=gyupb0FrPX1xV3tEBpVaYy1LF0kMUj2u8hw@mail.gmail.com>
Subject: Re: AMDGPU and 16B stack alignment
To:     "S, Shirish" <sshankar@amd.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "yshuiv7@gmail.com" <yshuiv7@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Matthias Kaehlcke <mka@google.com>,
        "S, Shirish" <Shirish.S@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 9:08 AM S, Shirish <sshankar@amd.com> wrote:
> On 10/15/2019 3:52 AM, Nick Desaulniers wrote:

> My gcc build fails with below errors:
>
> dcn_calcs.c:1:0: error: -mpreferred-stack-boundary=3 is not between 4 and 12
>
> dcn_calc_math.c:1:0: error: -mpreferred-stack-boundary=3 is not between 4 and 12
>
> While GPF observed on clang builds seem to be fixed.

Ok, so it seems that gcc insists on having at least 2^4 bytes stack
alignment when
SSE is enabled on x86-64, but does not actually rely on that for
correct operation
unless it's using sse2. So -msse always has to be paired with
 -mpreferred-stack-boundary=3.

For clang, it sounds like the opposite is true: when passing 16 byte
stack alignment
and having sse/sse2 enabled, it requires the incoming stack to be 16
byte aligned,
but passing 8 byte alignment makes it do the right thing.

So, should we just always pass $(call cc-option, -mpreferred-stack-boundary=4)
to get the desired outcome on both?

       Arnd
