Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECFCC33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DFA2070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJ8VyuDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgAHQsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:48:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36949 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgAHQsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:48:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so4142457wru.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 08:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oThwVOSRghlMQrtGPJX+ACmEzpakZ7+aStYbwUOl/sQ=;
        b=KJ8VyuDbKf/CPrDOdmCtRVxpPCX/7Bw2aLcUSgFdoCjxTyv2qSBWu4ufbzJFir/k3d
         y3fNIDlz6I1cgxg6GcWbamUyAFo5XarJYOMqCqgWxWGFC8/ozip7Kdd2Dz2GBbR1y7Gd
         w6IGiT/m172BO9/zrnfDaW2THDf8WhTBmx0Vh4F3WFBce1UUSebyzVN38MIhOG6d3O6M
         dUrrq7OlsDBXdhZ5DQWdUdQ6rpHgvpWe6kvJM+kKRK6oA5Hlxb0SUULePRnvyIflSrAY
         YacENCL515yBuZFJKvrQ8jMHHERmGLu5nuWHeBhd4w70PcOJ3grnKyX8gfc9V4a7/ZLk
         DLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oThwVOSRghlMQrtGPJX+ACmEzpakZ7+aStYbwUOl/sQ=;
        b=Xz3UIHoasWHW08kNsZcnFrD6l6Fxzo33lprp28djMY77R6PHIYpuOBJdRrZP0zBoXE
         cKiiJ81TCK5PgnBMU5+yT3RKvshN/cfHmGP3+4MB+KsaV+2J4FsocSmqKUoIoYLwxk4l
         Fhk3qvm7tmtWOWicfU3a6FZzbCfttdxmLuOvo27FLl5FIk1QVqDCKUbSE4X96wjA9XTQ
         pK/oEoRV1fRBd5BXF0S81tb3Fl1tf4+0utLFejtHc/iw5UvkDrVlWyXLolQpUFfimg8b
         0J77ddEnnzzZfahQ4qen1VxA9REU8w7oDFGOjNN8IbJRB3iSj4dgnNCyZg+AE7JK0WZE
         owvg==
X-Gm-Message-State: APjAAAX9Px9zd9D2bHC93sG8UaFlUFFzWYCeYhZn9aMyA9acR+l1yyZw
        RLbRMLRcvCAK/W5fsTmD+3Qikj7CgiOhMz5y7EATpw==
X-Google-Smtp-Source: APXvYqxld4/J+48jZWMZsKYas2V8hJ6QfYzgpwPJfWXcagD63FIKHzy4jZc/YPSKMusV0C4z/jLQo+8YZf5zhAIJeoE=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr5359077wrr.32.1578502088604;
 Wed, 08 Jan 2020 08:48:08 -0800 (PST)
MIME-Version: 1.0
References: <20200108102304.25800-1-ardb@kernel.org> <20200108102304.25800-3-ardb@kernel.org>
 <20200108154031.GA2512498@rani.riverdale.lan> <CAKv+Gu8AOukQL3qokt+Rz3PKBRWWnSULGUr=+yxg_HPM8-uodw@mail.gmail.com>
 <20200108155700.GA2602122@rani.riverdale.lan>
In-Reply-To: <20200108155700.GA2602122@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 8 Jan 2020 17:47:57 +0100
Message-ID: <CAKv+Gu_EVuX1nktX6Ueyot7XFgtq+AG9SqRHvN91r9oG5GL_wQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] x86/boot/compressed: force hidden visibility for
 all symbol references
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2020 at 16:57, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Jan 08, 2020 at 04:47:51PM +0100, Ard Biesheuvel wrote:
> > The EFI stub already sets the hidden visibility attribute for the few
> > external symbol references that it contains, so it is not needed in
> > the context of this series.
> >
> > In the future, we can revisit this if we want to get rid of the
> > various __pure getter functions, but that requires thorough testing on
> > other architectures and toolchains, so I'd prefer to leave that for
> > later.
>
> We don't need it for the stub right now, but then this bit in the cover
> letter is not yet true, we still need to be careful about libstub code.
>
> > ...we can start using ordinary external symbol references in the EFI
> > stub without running the risk of boot regressions.

Spurious GOT entries will now be caught by the ASSERT() in the linker
script and fail the build instead of causing hard to debug boot
regressions, so it is not entirely untrue either. But I take your
point.
