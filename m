Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C296C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AFA2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uu8vGnKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfDOOkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:40:00 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:33123 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfDOOkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:40:00 -0400
Received: by mail-vk1-f196.google.com with SMTP id x194so3693246vke.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 07:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h15SCZshwjoJe/PzyJK9gU0ZhQV1UvUjDujKK6qmyOI=;
        b=Uu8vGnKCd1vYYurFVHQvgffUbfGW1mIzOpdJ46Jo392qTJ4mnxKdGmNyLDJbByzQC2
         Jv1TsbFrx9ChFvdqhNBLOu2tZdrbe8CaM4d0zi581c96ctYwgkviOb7/nymY0e4dqiBT
         +6MlOW34QG3pDL+BwdNx1ABMauXtbjtU9xHYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h15SCZshwjoJe/PzyJK9gU0ZhQV1UvUjDujKK6qmyOI=;
        b=BqQpKPXfr1ntZ/7w3gDrg7ruE1nyZG8O+Q24Qxcowo07yLiTz3zGbNhcXPlvGsyKpb
         xgEbvANx0exoeyC8zjWxnGco6Saz6e2XTVDVI4jNHxXQt0Gha7UBW7x2zKaCcuVfuAgm
         6mNHt3XCMm36x8SMxdcS8ryOL/eWxwa5uhfNQ5Xq68KCJoQp/e0v4kcPlMO/2+hrAxyk
         mTbTT+Dh+dLSKX71D0g401p67KgJ2Q/dSqtpkNVZQbHeIXLxtfi4sEHwziU1WMioI88e
         kUNLY9Z1qAyYxK+qb5YMr21BJuY3x7atmVU/vKzDoIZVLLAu07DwBW1xaDXRZ7OnLJ3n
         j/xg==
X-Gm-Message-State: APjAAAVc+uY7vmH/kn13YpSvpnWsOJjbL+L/glnYVhlHMNEHiOGha1g6
        VD6wGOMI8R0huvgBovD2s8X7LE55rDU=
X-Google-Smtp-Source: APXvYqzn1YfuYNpyYQLqZsmqqSa2VOEUDlibfG3Tiu6EeshsNhFUEiUIMRfJK4mCAKwzTtGP5WCjXA==
X-Received: by 2002:a1f:29c5:: with SMTP id p188mr40383001vkp.24.1555339199204;
        Mon, 15 Apr 2019 07:39:59 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id p135sm14130722vkd.8.2019.04.15.07.39.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:39:58 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id o10so9568297vsp.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 07:39:58 -0700 (PDT)
X-Received: by 2002:a67:7816:: with SMTP id t22mr39111448vsc.115.1555339197589;
 Mon, 15 Apr 2019 07:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190412065542.18431-1-bhe@redhat.com>
In-Reply-To: <20190412065542.18431-1-bhe@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 15 Apr 2019 09:39:45 -0500
X-Gmail-Original-Message-ID: <CAGXu5j+o4aSx9mMDJqTMOp-VrvWes-2YEwR1f29z8dm0rUfzGQ@mail.gmail.com>
Message-ID: <CAGXu5j+o4aSx9mMDJqTMOp-VrvWes-2YEwR1f29z8dm0rUfzGQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] x86/mm/KASLR: Fix the wrong size of memory sections
To:     Baoquan He <bhe@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Garnier <thgarnie@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mike Travis <mike.travis@hpe.com>, frank.ramsay@hpe.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 1:55 AM Baoquan He <bhe@redhat.com> wrote:
>
> v1->v2:
>   Rewrite log of the two patches. No functionality change.
>
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> v1 background:
> The fixes for these two bugs were carried in the earlier patchset, patch
> 4/6 and patch 5/6:
>
> [PATCH v4 0/6] Several patches to fix code bugs, improve documents and clean up
> http://lkml.kernel.org/r/20190314094645.4883-1-bhe@redhat.com
>
> Later, Thomas suggested posting bug fixing patches separately from those
> clean up patches. So send both of them in a separate patchset.
>
> For another bug fix patch 6/6, it happened on SGI UV system. Mike and
> Frank have sent a machine with cards to our lab and loaned to me, I am
> still debugging and discussing with Mike about the verification.
>
> Baoquan He (2):
>   x86/mm/KASLR: Fix the size of the direct mapping section
>   x86/mm/KASLR: Fix the size of vmemmap section

These fixes look sane to me. Thanks for solving this!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>
>  arch/x86/mm/kaslr.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> --
> 2.17.2
>


-- 
Kees Cook
