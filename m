Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F98EC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4C920674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="etco+EDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfDWO6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:58:12 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36455 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbfDWO6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:58:11 -0400
Received: by mail-it1-f193.google.com with SMTP id y10so635436itc.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 07:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ag7zBPESARv7AdniPMqyXmsA87Ho5Yldxwq0K1TAMSo=;
        b=etco+EDy8heu0T+W2qeA00+rqzgwFMn+V8AWyfzZK8wAaMXcbsjKenA9IT3v80AyGn
         X1xqeWdIyhBSwo8BY7MBq3DLieTuKdEZdfO2lN2pOQdRoUbP98eoPmvPHns6WEypHZDg
         RWUWsQbe9mcyfiRK2POxV+Z27kmGrO0YQdxO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ag7zBPESARv7AdniPMqyXmsA87Ho5Yldxwq0K1TAMSo=;
        b=GdbGdzpw3EBhFiTOteYumXKcTtxaxRTFaWc8dzJTfWbQloiVMXPjb0x0XHLLn0rdYr
         MNryfM6ocJG7TvBU6FcrUPOTZMF1OSmGsmU9d8WWfER4yQoyJ/AcrC4T0aLQ5EHX5DpA
         mqTDP8XC0plQuILnBM7+se2ksPZVjzIAhNqavH6PRrUJQEDpdA9gtCJh9c4uJL8Eyg/a
         um9Y/nltsF5EB3fMAuwkaY2x1XysfvVVKwJNKe7p9LwKJFsc6usS22Y70CILfJK4wrIC
         uwOLtFnFLhq8AXO1C+Y7wO/R3j1OtfEme4ajyQJkpeNv9x1q/X08l6+Qy6mXzQLICl5F
         19wA==
X-Gm-Message-State: APjAAAXLlCvir/N6O/Ahy9B+dX7p98I7lcOcWn599cEQnMTYMUkEuqmY
        h/Uhym+IxaBRCUmb1MAcHPJnDip6uU7oNDGnjqdX8A==
X-Google-Smtp-Source: APXvYqwQ57zYiDRU0wIYedbbpGpXu6cwSBYRvjbUmAO64PYYXMHdTUUYGu/a9zxqtoAEoxVN/jBMM8mh4b6AWcfWvzU=
X-Received: by 2002:a24:650d:: with SMTP id u13mr2565690itb.1.1556031489515;
 Tue, 23 Apr 2019 07:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553677194.git.kirr@nexedi.com> <d916d401a80e9834c95970d86ca71c0154e988a6.1553677194.git.kirr@nexedi.com>
In-Reply-To: <d916d401a80e9834c95970d86ca71c0154e988a6.1553677194.git.kirr@nexedi.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 23 Apr 2019 16:57:58 +0200
Message-ID: <CAJfpegt9DRmwKksR0QSA7NzQP_=a=yJybdL9mOP1cw5goGkdgw@mail.gmail.com>
Subject: Re: [RESEND1, PATCH 1/2] fuse: convert printk -> pr_*
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Maxim Patlasov <mpatlasov@parallels.com>,
        Anatol Pomozov <anatol.pomozov@gmail.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Andrew Gallagher <andrewjcg@fb.com>,
        "Anand V . Avati" <avati@redhat.com>,
        Alexey Kuznetsov <kuznet@virtuozzo.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Constantine Shulyupin <const@makelinux.com>,
        Chad Austin <chadaustin@fb.com>,
        Dan Schatzberg <dschatzberg@fb.com>,
        linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 10:15 AM Kirill Smelkov <kirr@nexedi.com> wrote:
>
> Functions, like pr_err, are a more modern variant of printing compared to
> printk. They could be used to denoise sources by using needed level in
> the print function name, and by automatically inserting per-driver /
> function / ... print prefix as defined by pr_fmt macro. pr_* are also
> said to be used in Documentation/process/coding-style.rst and more
> recent code - for example overlayfs - uses them instead of printk.
>
> Convert CUSE and FUSE to use the new pr_* functions.
>
> CUSE output stays completely unchanged, while FUSE output is amended a
> bit for "trying to steal weird page" warning - the second line now comes
> also with "fuse:" prefix. I hope it is ok.

Yep.  Applied, thanks.

Miklos
