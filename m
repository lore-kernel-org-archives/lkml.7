Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78581C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B92720679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9YeUqrO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfHLQ22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:28:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42939 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfHLQ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:28:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id i30so1227435pfk.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 09:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nqNpCGFtDsa8a+HaBObToOYnGgLCkK9gOXb9jSunYpg=;
        b=q9YeUqrOotnWphtWt+AmZhvUnYaPCLv3zf1CBf8qMjF4Lv+N1SlxcpneZ0RIDVmKx6
         PEnkTk/klNoYA9mDPfS1ByJfxSqRYhoqgiKYO+g2npyQLOG5Qu+wZdc0UZqCNGTVj6Wl
         yU8u4eqsgHXW5p3oDfzLjG2GK6p5qQBuoGkoO9mLVZFafWtSQt7TZy907yptEz88jId2
         sNtQsXtA2kmDSUVFsniFeFTjWLU5ozKhQsrHSVVPnI2O/1vT2frMSBLVsPWgj6Grgo5A
         dhUT541BM69IcvHQhcMqysd8tszX9+Cp6fSRHF9JnCnz5kf0KvGCK6wgfbGF/pPR2y98
         InOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nqNpCGFtDsa8a+HaBObToOYnGgLCkK9gOXb9jSunYpg=;
        b=DNNGPfcZ+YlsN26oB/mBx0bvFdPaAtldH0AiqHdke1WwyzyiaDCQ4DVV2a9WlOdYyI
         d4e485BFSyuXo68cT+vYhbTmrO0zz9Tnv5H0hSHUa8LNnyAiK6bHG5yNbtcslJYdDHRy
         ysVgqqv6Dj2szyN7JPGwvZaccpkTQSnInZunpT7y+kyUQkComP7hjlOvw5FdMw8V5Uca
         bPESvxpMLAfok+8FrFq0vrzMH/MB/SaElqy52tRu2zZVrHx9qxcQQtj5jb/HFkRAt/oR
         0JnvlJE1oL3CFJxPaokeSYA2aj23t5gcU8O5SjmpJyAHRTDH3h+/vd1wWP6C0Epc8+2P
         H5+g==
X-Gm-Message-State: APjAAAWX4ZWbKGu4eDsT09IQWbSZdaowsDlqY6YoG4us9/stNoB5c+17
        hpGN7lH0xY6fl/pzmpWR/FmY0z8mmXwcmJBMIRbG0A==
X-Google-Smtp-Source: APXvYqybiim5GktIVsZhGSf2Jvn0qjk2FW1kum2frzZ3BACvfGCTgX1Xu8z+cPROUCSeIpYWIdG1CQVhIXzzXj+xryA=
X-Received: by 2002:a63:f94c:: with SMTP id q12mr30500912pgk.10.1565627306188;
 Mon, 12 Aug 2019 09:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <c0005a09c89c20093ac699c97e7420331ec46b01.camel@perches.com>
 <9c7a79b4d21aea52464d00c8fa4e4b92638560b6.camel@perches.com>
 <CAHk-=wiL7jqYNfYrNikgBw3byY+Zn37-8D8yR=WUu0x=_2BpZA@mail.gmail.com>
 <6a5f470c1375289908c37632572c4aa60d6486fa.camel@perches.com>
 <20190811020442.GA22736@archlinux-threadripper> <871efd6113ee2f6491410409511b871b7637f9e3.camel@perches.com>
In-Reply-To: <871efd6113ee2f6491410409511b871b7637f9e3.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 12 Aug 2019 09:28:15 -0700
Message-ID: <CAKwvOdmAj34xDcMUn7Fu_aXdtD-7xHjHuU20qY=rFcr_Kz7gpg@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Convert -Wimplicit-fallthrough=3 to just
 -Wimplicit-fallthrough for clang
To:     Joe Perches <joe@perches.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 8:06 PM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2019-08-10 at 19:04 -0700, Nathan Chancellor wrote:
> > On a tangential note, how are you planning on doing the fallthrough
> > comment to attribute conversion? The reason I ask is clang does not
> > support the comment annotations, meaning that when Nathan Huckleberry's
> > patch is applied to clang (which has been accepted [1]), we are going
> > to get slammed by the warnings. I just ran an x86 defconfig build at
> > 296d05cb0d3c with his patch applied and I see 27673 instances of this
> > warning... (mostly coming from some header files so nothing crazy but it
> > will be super noisy).
> >
> > If you have something to share like a script or patch, I'd be happy to
> > test it locally.
> >
> > [1]: https://reviews.llvm.org/D64838
>
> Something like this patch:
>
> https://lore.kernel.org/patchwork/patch/1108577/
>
> Maybe use:
>
> #define fallthrough [[fallthrough]]

Isn't [[fallthrough]] the C++ style attribute?  **eek** Seems to be a
waste for Clang to implement __attribute__((fallthrough)) just as we
switch the kernel to not use it.  Also, I'd recommend making the
preprocessor define all caps to help folks recognize it's a
preprocessor define.
-- 
Thanks,
~Nick Desaulniers
