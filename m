Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E0AC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80ACD20643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fQfWncG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbfDSTDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:03:14 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36820 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfDSTDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:11 -0400
Received: by mail-ua1-f67.google.com with SMTP id k32so2012812uae.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2j6bVI38nNnTFEsqpyh4i9/0AM+zS7jKtH/c4TEI0Bg=;
        b=fQfWncG3BLeLhGQljJXzFWY5nf+JkAYl/1kkTSYcQxQe0OaZn9X11Ce9h+kI6ZDXYD
         YJ4VMn2zRM7w+KYczXWlS4ubFMdb27WaLsD8FgcdHtMoqHulDVGrnd1V53yO1jFB3A8L
         PeODq1AOm93Y+U8Rfr5sRFt2pQOCkrTCHXxD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2j6bVI38nNnTFEsqpyh4i9/0AM+zS7jKtH/c4TEI0Bg=;
        b=laDT52qvMdDEwo49bJGXO7nmr/a/YAqSJK2mbfbVaocDyWRtAdSVpjvAPwryPeRXy2
         /aY+bPJwiYyH5II2PmrzaymolLGAPj1mDfNf30A1awl4fR9FmjpbSSC/jB9qhgxGaVqu
         dQ3T9juzKQ/74EQNibhDtyhMGudbcDO3nL3B0usoTCH639TihFkwEQB5dqa+mec5rvAG
         2MCuAjgsdNxhOZGvz4hj7XZCITYFfLC/adYqXVaXRjHrjVyL4lVWsZHLsRSwS/EXltkk
         8D7cwniCy06B+RFVNFiYmI1rx+h4DFtmfL+kzzg9Q19Sv/8ogS4Ja6v/oOHQz1idXD68
         zuGw==
X-Gm-Message-State: APjAAAW84p0tXL2yLpbFXnsytHqES5J197BoUZyS1HJx+ikOiVXDbbub
        TM6WQWHtVJLbATEfSSvwgT/vTw8pfUQ=
X-Google-Smtp-Source: APXvYqzAMBiiFmLfj6xcGGTAVcKv5aGKYrtP1qsJN+B9EMMsuq+k3KK1bWsyyL9x2GNXLK+WNh22Fw==
X-Received: by 2002:ab0:2399:: with SMTP id b25mr2275923uan.129.1555686326767;
        Fri, 19 Apr 2019 08:05:26 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 2sm5702667vke.27.2019.04.19.08.05.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 08:05:26 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id p13so1831210uaa.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 08:05:26 -0700 (PDT)
X-Received: by 2002:ab0:1646:: with SMTP id l6mr2231986uae.75.1555686023710;
 Fri, 19 Apr 2019 08:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190312173248.13490-1-alisaidi@amazon.com> <20190312173248.13490-3-alisaidi@amazon.com>
 <CAGXu5jJ5sj3emOT2QPxQkNQk0qbU6zEfu9=Omfhx_p0nCKPSjA@mail.gmail.com>
 <CAGXu5jKcBmj0kwAqjqROXuOi=90=Upy8-J8WviGMjD6FV_Guxg@mail.gmail.com>
 <34381CFC-A90F-4979-9802-2BA0E6539C68@amazon.com> <20190419085140.GA50390@gmail.com>
In-Reply-To: <20190419085140.GA50390@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 19 Apr 2019 10:00:12 -0500
X-Gmail-Original-Message-ID: <CAGXu5jJvB-sfsXdZvf8OKSwhmdgANvnsrhZiNGrtraTeQVoOrg@mail.gmail.com>
Message-ID: <CAGXu5jJvB-sfsXdZvf8OKSwhmdgANvnsrhZiNGrtraTeQVoOrg@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/mmap: handle worst-case heap randomization in mmap_base
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Saidi, Ali" <alisaidi@amazon.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        X86 ML <x86@kernel.org>, Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 3:51 AM Ingo Molnar <mingo@kernel.org> wrote:
> I'd suggest incorporating all feedback and sending a v2 series - it's
> much easier to get people's attention via code submitted. ;-)

I sent my patch out, akpm added it to -mm and then xtensa broke, and
it got removed. Soooo... I'm looking at it again now. I think I might
combine the ideas and in the interpreter case bump the entire mmap
base by the brk randomization size. That should make things less
strange and solve the corner case without reducing available address
space in the general case.

-- 
Kees Cook
