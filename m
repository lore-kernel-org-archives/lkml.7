Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E612BC10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AA020657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfCKOBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:01:10 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36704 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfCKOBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:01:10 -0400
Received: by mail-qt1-f193.google.com with SMTP id b3so5104603qtj.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NAVSCLI4bpYkN0vehk8e+9hfFe+zl25LDlWzCtnVJs4=;
        b=d+yCGpp89+aNOSMnMpgYxHr2+erWT+zo6mImDGtQMIZPy2qbgBaKEG7IsWJqMu/0+Q
         eU9yrywTLJ3vvP7jfEKkhkWd94nX7yzvk0BpPzg03BWMP8hgrFlCxcFGGAvUOBKUOzz3
         /bVcA2wfWgn7S5bhRb9ebqnMcGxyHtP/kBEVswX+3qIvV87ZSL2vdTUprq03mLeIFCOc
         gYJEkgQ5S/vdLTFt6E2Y5AgUEPenhLRTR7zBGOmjqmqatrRB7U/qT8MaBPAsjWaxKwWl
         hPKvz1ZeFC2thZgrBJNCW8LY2Z/5AmqcOPPYZ/d6BSXkA5XwWYmmLheNseF4jw2kHNCq
         OmZA==
X-Gm-Message-State: APjAAAUzOgtOUql3SzqjRPOkC6Qy9V6BDqa3Ox+MrfAvqgBl7z375f+g
        nd+l4xX+hzmr8WUS0YuQmOcOIkIOYfjGUjvtTwo=
X-Google-Smtp-Source: APXvYqxsIdm3BSNVGFp9FsU9rosmUSaPmP2VP43e8DD+SIqNd/ILmWEbKSwxunuPwJTx91N1nbWiyX+pBuqhbxBTK2A=
X-Received: by 2002:a0c:b501:: with SMTP id d1mr26308451qve.115.1552312869102;
 Mon, 11 Mar 2019 07:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190310183051.87303-1-cai@lca.pw> <20190311035815.kq7ftc6vphy6vwen@linux-r8p5>
 <20190311122100.GF22862@mellanox.com>
In-Reply-To: <20190311122100.GF22862@mellanox.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Mar 2019 15:00:50 +0100
Message-ID: <CAK8P3a1PpgjRKFemEi7mLuECh1srs8bbzoc07RSrFsx+febjaQ@mail.gmail.com>
Subject: Re: [PATCH] mm/debug: add a cast to u64 for atomic64_read()
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Qian Cai <cai@lca.pw>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 1:21 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
> On Sun, Mar 10, 2019 at 08:58:15PM -0700, Davidlohr Bueso wrote:
> > On Sun, 10 Mar 2019, Qian Cai wrote:

> >
> > Acked-by: Davidlohr Bueso <dbueso@suse.de>
>
> Not saying this patch shouldn't go ahead..
>
> But is there a special reason the atomic64*'s on ppc don't use the u64
> type like other archs? Seems like a better thing to fix than adding
> casts all over the place.

Agreed in principle, but I'd note that it's not just ppc64, but almost all
64-bit architectures. x86-64 and arm64 changed over last year
from returning 'long' to 'long long', apparently as an unintended
side effect of commits 8bf705d13039 ("locking/atomic/x86: Switch
atomic.h to use atomic-instrumented.h") and c0df10812835 ("arm64,
locking/atomics: Use instrumented atomics").

It would be nice to just do the instrumented atomics on all 64-bit
architectures for consistency, but that would be a lot of work, and
would not actually give us additional instrumentation on most of them,
since they don't support KASAN (except s390).

       Arnd
