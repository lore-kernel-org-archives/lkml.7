Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB7EC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3242023CBB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dp82oyom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfE2QCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 12:02:18 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38383 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfE2QCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 12:02:18 -0400
Received: by mail-oi1-f194.google.com with SMTP id 18so1695050oij.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 09:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=62cNvFIcuC30Vs4emJnPJCkHc2meqeg0IuwOUNIHv1Y=;
        b=dp82oyombgOo4fiEI8WZqg0QChsRZspYmsbXUUYADzX2iXHaucjAyoTVGDlyRP7bwN
         kRKBN47yyxY4tRMx1dcUZx1YyBuEVCcnKW141ARGrJeurVxG7hWahaX8w+ufWN2L56SZ
         wMRMmM+bsgNHadVfreRM9VCnT+HUg3k/HKSrHtmgkGzKUeo2vHV3cUPbMCEYY70xfCPy
         cxMfj77p/KVMXM3WhB0yLyaeqq8jE6aoiQEQzoCDi9U0cCQnKYUmD9FzJjD/Y21PnKRq
         P0LFh3jOlifxUfFROrdKMkobyQahqiQEWQyfjhJffYC2Qr29wezJSdhiHr9qGNQ3uq3w
         kbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=62cNvFIcuC30Vs4emJnPJCkHc2meqeg0IuwOUNIHv1Y=;
        b=soo1LOO2XhvmfiQBFpJzCd0kn18GFGAeY2mrXKn3CS4/qUK4FVupmldqK0AjjYXPZI
         Fqt9vG4j6V5dqne+iFVEsMQ6+QyxNXJUx9a/0v3fG+QraQxcgn7LZN3uwI/3hOxkeveW
         YDnm72xEI97OEebP4E3tNz6LyjuOW7Awe64PcymBNYStLSNX9UunMdNCjNUu1dJPVa9S
         d7H03044DwSrsTyp6yaA4xTo6aFc7IlNvVybm9f/V1nIyR457D1ILBwbAQNTnRe33eIL
         LUp7ljZssRL0bZfl6v8WA6h2+Z4n3bbHbawIGr0JIqOJjznpiZQlRl+obh+AsARdMm+O
         lvJA==
X-Gm-Message-State: APjAAAVfYZl5eBs7cXDbVN3BOGffYJ4Wcq8dimt2Lkndd4OlCssZQtl5
        9kIpzS8UG5oF3Urjvt8COzFhHL6CRCoH2/y++gb7z09O
X-Google-Smtp-Source: APXvYqzqphJ6SbZXWqVWgyEhTnKk3OolqmkgeIQ+BFr7EfM9hq9ostBmOR8NJC+0l3whKh00VCMndbKhg5BWwdepJxU=
X-Received: by 2002:aca:fd45:: with SMTP id b66mr6794311oii.157.1559145736960;
 Wed, 29 May 2019 09:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190529113157.227380-1-jannh@google.com> <87v9xtz1yt.fsf@xmission.com>
In-Reply-To: <87v9xtz1yt.fsf@xmission.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 29 May 2019 18:01:50 +0200
Message-ID: <CAG48ez0Qu2CDhP4MPXTxxqLjTpk0X5ZubQQDfNRoP0JRrYt4Og@mail.gmail.com>
Subject: Re: [PATCH] ptrace: restore smp_rmb() in __ptrace_may_access()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 5:59 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Jann Horn <jannh@google.com> writes:
>
> > Restore the read memory barrier in __ptrace_may_access() that was deleted
> > a couple years ago. Also add comments on this barrier and the one it pairs
> > with to explain why they're there (as far as I understand).
>
> My bad.
>
> When I made that change I could not figure out what that barrier was
> for, and it did not appear necessary.
>
> Do you happen to know of any real world problems?

No, this is just from reading the code and trying to make other
changes to it. (I'm trying to figure out how to finally deal with some
of the other issues in the ptrace access check, so I've been staring
at that code a lot over the last couple days.)
