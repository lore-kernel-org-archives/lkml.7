Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FEFC7618F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 19:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFF92075B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 19:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564343439;
	bh=zwvJDergJYvOucjiRE4k72tGgdbXiB65h9zSJ9J4YaA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tKHYColsQGLkeVBdgZ5FmVz4dEQnVQJQlaZ87FzCndXn9HdERwJkp04G4F3OmpiF0
	 4zrDcIaKUQcOqz+kaSg5OkGtn2yZ4a8M7VITub+rKQtruD7ZJ/vf1wGl2eLVOgX5h3
	 3urmQcp1CdMA8G2QW/M2Mx1BqZZfmJoZf3OgDoMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfG1Tui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 15:50:38 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41894 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfG1Tui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 15:50:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id d24so56415499ljg.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 12:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ot50Sc2XXeKUTOrtxbQvTwuDuPIpkR8zJJ05liISdM=;
        b=JHr4KtjC5i/4M1fxincFRsD2UPEJEPLgGtDu1Sqdxivzbua9+qWXK4P51WaJkRKzyI
         IymgS9RwaDHM6BTBYWCYTtifwuwPtQ7Dr2A+/0z5tv8mpeRUtHW1JdKhN7UiM7qaVVO/
         GSk+YuC/ZUWYPLVrHCRT7riT3eIPWYTwdhjCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ot50Sc2XXeKUTOrtxbQvTwuDuPIpkR8zJJ05liISdM=;
        b=nZC7CpXetH/PwiCfujVxQmSXwCxw+bOnmrmvxe5sgMsQAoe5VyPV6ssQWugZc6WIER
         LBQJEpGZeAKD2v9WtkAWAVSF/XVR8R8oRynNisAlLOs3S4qJ3XQ5ldEZDzFpJwuoXk2Z
         XAIx/4OKeyT1QT2xPBZd83+OP+QG/mJupHdPmN0yX6jTpRnzoAym/qu221rAqwPOPAag
         z9Lpf9dHQU7LkLurzdM8gNe5OuYFI/hC8S5ngUc2K80bGZnI3zjnSK/LF2HT+nxwZe1u
         ICsFhoKxdTQchWEff3qVCt5kGV0tzeFasK59tXBhxjEoUTCT25bu+eZ1G78wKaYE0L23
         dRsg==
X-Gm-Message-State: APjAAAVgTOG8FI1fcGkTv3GcJFxtDXFtKB9X4mH/3MUpWmIy0hNmTRwO
        H5XjwwpnnBt1bmD/eD26fVhbGf+cRjE=
X-Google-Smtp-Source: APXvYqxXuSqqjU4D4dyKD5LIuJbXj5PUJO3Xhzu3ZP3lj2x+LEEIFNqYgkrh6VZL0xCk+N09IQBtoQ==
X-Received: by 2002:a2e:89c8:: with SMTP id c8mr56416800ljk.70.1564343435902;
        Sun, 28 Jul 2019 12:50:35 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id z23sm10332136lfq.77.2019.07.28.12.50.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 12:50:35 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id p17so56445090ljg.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 12:50:35 -0700 (PDT)
X-Received: by 2002:a2e:b003:: with SMTP id y3mr56412263ljk.72.1564343434760;
 Sun, 28 Jul 2019 12:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <201907281218.F6D2C2DD@keescook> <CAHk-=wj+1vDh2=eZExibYF9Lo0GsGxaAjxCSwpUFVURrN44cUQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj+1vDh2=eZExibYF9Lo0GsGxaAjxCSwpUFVURrN44cUQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Jul 2019 12:50:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whUmaEX0HATrs1Nsde3Nz+MXn=Tg1_9jL8u2Rd5Wz=oCg@mail.gmail.com>
Message-ID: <CAHk-=whUmaEX0HATrs1Nsde3Nz+MXn=Tg1_9jL8u2Rd5Wz=oCg@mail.gmail.com>
Subject: Re: [GIT PULL] meminit fix for v5.3-rc2
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 12:43 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Side note: I find "meminit" a confusing description for the structleak
> thing.

Not that 'structleak' is all that much better, because it's not
necessarily just about structs either.

'stack variable initialization' is too long. I dunno. But it's more
about "variables" (and in the case of kmalloc etc - perhaps
'allocations') than "memory", I feel.

The point is that in the kernel we do memory management and memory
initialization, and that's something very different.

                     Linus
