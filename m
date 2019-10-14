Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE16C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 22:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E345C2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 22:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y7lIqjnt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbfJNWWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 18:22:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44924 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731126AbfJNWWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 18:22:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id q21so11121310pfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 15:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=iNkEDH3ViExpb/y5HnKz3o/CDE3c8oQsLUlWmGCk2mA=;
        b=Y7lIqjntH5QlaeThyf1TiQlgL4k3YYX6zT4Rp28vGgY/nou3sE+AbBJONe/Qj9YmuU
         66QHF8+NmolZkNWV5gcyXImhJrxu2FaFqgXexfaW+t9B6+j/AsTzVXb0LZOFsKU/+kH6
         1m5ue/Hfh+crxXF2Wu/f+hID38C5u4poBphX0lR5tyh6kTPJwfnQEBROi53IEP7UDZVC
         V1i/mceVKN1jgjF8Af4KwksD3lOPBdGXg6vSB48kFS3mLEUsRitYWPA6IQHCDMBtOOez
         vu1OK/S8RfBJwgZAoJMQNv+hPTJtddvnWcIY/7UnrmVEEBdAeiG7UEfjyGYAePfCIkr2
         auzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=iNkEDH3ViExpb/y5HnKz3o/CDE3c8oQsLUlWmGCk2mA=;
        b=rbPaZk/mbWKfoihTvL8jI2oL1g+hk8yGrrxuXC+KPjoApTc7x5/eBjJ+sR+N7wVzg0
         ytt44yeoIsa+5mw2+llKF+c4bxsUkXGOvjUrsX3mLl39vlR+5IlLWKNem2MjPcSQCdmN
         UQcsGPEnI8TWW+V25yhhcAftP9nfdjB7WnPaWL64OzvqqFA+919yR9t8WjATtFFgJZol
         qBd8zogSbqUhaizUHjwCmTgpBWOwevBm1iWayIpPq9GH/k+MECuEbFFHINhEzuTefIoW
         A4CNir1XCPaMn0UpmosnXRJpxo8X9gFJjjdWYM6AputQvPZp3fwWErcloiGwkqWi9pDU
         lSBQ==
X-Gm-Message-State: APjAAAWFNrUiRKwmC3xF2dyGJ3XZ4i+m4onAGBTll5c2/GU73xhVhimg
        MSdod8c3So0NPxpj9JkmolsBF3QgITTVe6fImrmCPQ==
X-Google-Smtp-Source: APXvYqyurIJ6E+QxMgFHbL4rfPZ1AU4lFd/bZMy6hC8w1IIoa031nWIwxtdnOnNxHXJ9H/rpV+E6U6q9ZR4mOXuO8As=
X-Received: by 2002:a63:5448:: with SMTP id e8mr7961310pgm.10.1571091740976;
 Mon, 14 Oct 2019 15:22:20 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 14 Oct 2019 15:22:09 -0700
Message-ID: <CAKwvOdnDVe-dahZGnRtzMrx-AH_C+2Lf20qjFQHNtn9xh=Okzw@mail.gmail.com>
Subject: AMDGPU and 16B stack alignment
To:     Harry Wentland <harry.wentland@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>
Cc:     yshuiv7@gmail.com, andrew.cooper3@citrix.com,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Matthias Kaehlcke <mka@google.com>,
        "S, Shirish" <shirish.s@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "Koenig, Christian" <christian.koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The x86 kernel is compiled with an 8B stack alignment via
    `-mpreferred-stack-boundary=3` for GCC since 3.6-rc1 via
    commit d9b0cde91c60 ("x86-64, gcc: Use
-mpreferred-stack-boundary=3 if supported")
    or `-mstack-alignment=8` for Clang. Parts of the AMDGPU driver are
    compiled with 16B stack alignment.

    Generally, the stack alignment is part of the ABI. Linking together two
    different translation units with differing stack alignment is dangerous,
    particularly when the translation unit with the smaller stack alignment
    makes calls into the translation unit with the larger stack alignment.
    While 8B aligned stacks are sometimes also 16B aligned, they are not
    always.

    Multiple users have reported General Protection Faults (GPF) when using
    the AMDGPU driver compiled with Clang. Clang is placing objects in stack
    slots assuming the stack is 16B aligned, and selecting instructions that
    require 16B aligned memory operands. At runtime, syscalls handling 8B
    stack aligned code calls into code that assumes 16B stack alignment.
    When the stack is a multiple of 8B but not 16B, these instructions
    result in a GPF.

    GCC doesn't select instructions with alignment requirements, so the GPFs
    aren't observed, but it is still considered an ABI breakage to mix and
    match stack alignment.

I have patches that basically remove -mpreferred-stack-boundary=4 and
-mstack-alignment=16 from AMDGPU:
https://github.com/ClangBuiltLinux/linux/issues/735#issuecomment-541247601
Yuxuan has tested with Clang and GCC and reported it fixes the GPF's observed.

I've split the patch into 4; same commit message but different Fixes
tags so that they backport to stable on finer granularity. 2 questions
BEFORE I send the series:

1. Would you prefer 4 patches with unique `fixes` tags, or 1 patch?
2. Was there or is there still a good reason for the stack alignment mismatch?

(Further, I think we can use -msse2 for BOTH clang+gcc after my patch,
but I don't have hardware to test on. I'm happy to write/send the
follow up patch, but I'd need help testing).
-- 
Thanks,
~Nick Desaulniers
