Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5837C388F3
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 02:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1EC21841
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 02:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569725823;
	bh=mMTH8MAjeJzeH++/ik+qVGnx/gzwG8NspE4xlzb8RMs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YfzttVf8JZx3skNk/6TE60/jrqf6Ph+OPl5s8c6Zjota8RhQccwu28zFoRVovLOJU
	 aierVbGPMe1dlX7P5ZZTjU7IxAOuO6cCX+YJdeEXYJuO9EuIocSwzljH5a4kLHDgyY
	 NynkyNq/gzXSsssKj9GpFQ+GqYzudTkX+HKzIEMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfI2C5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 22:57:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42367 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfI2C5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 22:57:02 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so6001234lje.9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 19:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C8yXdw0h0p8F6fKLaDgDQwFYdgULtupqFt2t+GrVNvU=;
        b=RW7Sb/4aJlXGRC6xwt+1bMJlvhizR+i9Eq9eKpzZfrVoj22korZmpNc2NL6eCx4v0O
         XXPGp9pLIXXPXxFOrIAiDbgDK+vG9IgDXYMiyWVm9YasXG7Vp+l/53OuGPxzOaycRGU5
         yHT20DkiwOMeWk9YTWw/7WVItYlUJvEa7dj2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C8yXdw0h0p8F6fKLaDgDQwFYdgULtupqFt2t+GrVNvU=;
        b=oKVRUbt5lu7z86gCl6Y6WWilh+eKUOljVHrX/832CTjQ346lE9VdH0uX8LYdubLHL8
         ow7Te6vzveI3Et2Rb6OlrSh40wkNKFdKRbnq20bOEq7LeVjju7FWrwRNeCYbESDBGEAi
         QEX9HL1/hWUKGuZqeMvqonqJ095H0a4EGy78RDnZTGurvG3rgyrtakFIJi8RRhensWQ7
         4gCkZyrRmr6Ku7YdJ7XfFCpfl3GR/qscVxnBA7mAeFnI71hYa/tmMxhSu12j8HsgGJfO
         WiztAMXyn9C0ftPdZ033PQKmkq376dwbfjMibXCQVLnyb3SbL0LZVrLSJUiaCVVY++fS
         r4sA==
X-Gm-Message-State: APjAAAXAN2qOmeQxfuIIVl69ZWs9LV3bSX087VH1tVOnVCFUQZpHhi+x
        0AuCZPRnr2Czblybn1hcLjKjWiAqp+o=
X-Google-Smtp-Source: APXvYqxosgtJrPgf9/nnJ/Jp00w0v9WHj3okJhuzs0TgJYbpUwqJu1TMuX+pQ0tc6UrpxEYhI4sP0g==
X-Received: by 2002:a2e:a17b:: with SMTP id u27mr7712449ljl.65.1569725819961;
        Sat, 28 Sep 2019 19:56:59 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id x2sm1802084ljj.94.2019.09.28.19.56.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2019 19:56:59 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id t8so4526616lfc.13
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 19:56:58 -0700 (PDT)
X-Received: by 2002:ac2:50cb:: with SMTP id h11mr7398086lfm.170.1569725818343;
 Sat, 28 Sep 2019 19:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAT-D68xMFrE-D_F-2y+iZt45+8iLF9dmTyO8YwUX-bTqA@mail.gmail.com>
In-Reply-To: <CAK7LNAT-D68xMFrE-D_F-2y+iZt45+8iLF9dmTyO8YwUX-bTqA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 28 Sep 2019 19:56:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjdc7Ovi-iVGBGzuP6prTXVRT8rgbnabBd0AiHRqECMCg@mail.gmail.com>
Message-ID: <CAHk-=wjdc7Ovi-iVGBGzuP6prTXVRT8rgbnabBd0AiHRqECMCg@mail.gmail.com>
Subject: Re: [GIT PULL] More Kbuild updates for v5.4-rc1
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 11:41 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Please pull some more updates for v5.4-rc1

I pulled this, but I'm not sure if I'm going to keep it.

There's thousands of lines of changes because of the header-test-y
thing, and I'm honestly considering just getting rid of that thing
entirely.

It has no actual upside that I can tell, and it's extremely annoying.
It pollutes the tree with hundreds of *.h.s files, which messes up
filename completion, and just generally is ugly and annoying.

So I've unpulled for now, and I'm not sure I want to pull more noise
for this mis-feature.

                Linus
