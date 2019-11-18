Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5104C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92D12071B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLJw4b1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfKRKWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 05:22:55 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35305 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRKWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:22:55 -0500
Received: by mail-lj1-f193.google.com with SMTP id r7so18272077ljg.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 02:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DAtGwM1Dd9Ta5yF4mgqEr8Nmjpd1oOCvyYj5VoGyqhM=;
        b=XLJw4b1UGCc1u0a+oqZOHKdSa5Rl/rcFNdW4twDB5kJwcDr4/JTUWt1q1bnnjdQfZd
         ln1/UBQZ0txrIj0fh0gGZHk0ubOqNuARolhLcuTs4TUeovxWbuDdT1KxnFFzdzTS6R97
         AG58cxdnbz+fvnN623n/WOwT/3uuifxL/pnJvuEeVPwAoH2e7EkqXWcVH3TTYsNI7okP
         cc/NlM6wuRpSvxysOeQSHOhekRn/LjVecyh7WyW1YausThb/0cZmfb+Za52jH62fL6++
         mahOKMiy2ZA+e/3w2n9TkCF9xv92q1w5vzRAbvDa9cB4yCFgylfiG9oc2N9pxgTSvg9z
         ML2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DAtGwM1Dd9Ta5yF4mgqEr8Nmjpd1oOCvyYj5VoGyqhM=;
        b=jEMDi3J+kdXqJdR42kksrtv17CxuBcVwB+XXjU2yP2awqRT/IDOwPUwjCmv5m1skrY
         dl8B6hoUUwaW+FVkcjgkXppQDEfPeYemY4sBVGIXwV99e8ZAp++W55UH96vtIIc13r/r
         lquFtnXzgAScEA0GcsXBSy6tcckkXwsRP1R7fQht0xE03PcSfRGWY1JQ7M3jPBKEx+G5
         u5ZB+0knUw/grkk3ya2ouCnmM1FK/M2fdnfPDQvGLELLD4nmfixJSNFuzI5q1VWY/lAj
         5gVeli6pPTlfK8uldue4OwtGcEuTIz1fWPoT3AtOJ1CpZSrJvyD+zcj8OF8ZkB6KeO/c
         VDzg==
X-Gm-Message-State: APjAAAXVz/YPLaVjh45WnD6sBrB+B/Uj6Z5Zhdcv/NzVQTp68ek0228V
        4IbMZcedUi+hhaD0xcoRXXOnvTsuEeMyZlSD7zU=
X-Google-Smtp-Source: APXvYqwT/6TNNP9ekklQsDdau2lMNHX0wwj1VItmxln78iAAWLSxMmPhVf8A4tsABOj7Pzfo5jlsVMd5DVTM7buSllg=
X-Received: by 2002:a05:651c:1127:: with SMTP id e7mr20039891ljo.70.1574072571914;
 Mon, 18 Nov 2019 02:22:51 -0800 (PST)
MIME-Version: 1.0
References: <CAKwvOdmSo=BWGnaVeejez6K0Tukny2niWXrr52YvOPDYnXbOsg@mail.gmail.com>
 <20191106120629.28423-1-ilie.halip@gmail.com> <CAKwvOdnJR3vbHd6Z0eLK9CppABWFL4E0Rjh6SzDN6U6mShS2qQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnJR3vbHd6Z0eLK9CppABWFL4E0Rjh6SzDN6U6mShS2qQ@mail.gmail.com>
From:   Ilie Halip <ilie.halip@gmail.com>
Date:   Mon, 18 Nov 2019 12:22:40 +0200
Message-ID: <CAHFW8PSdd=-v3i6wzkG3vQB3LcUznxaZUfWEw_f3QGiRre8TLA@mail.gmail.com>
Subject: Re: [PATCH V2] x86/boot: explicitly place .eh_frame after .rodata
To:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone had a chance to look over this patch?

Thanks,
I.H.
