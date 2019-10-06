Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EA3C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 23:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F93E21841
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 23:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570403203;
	bh=+eD3kl6gHVpYZuSO/fbHkIqJ9INnorTYKsg2JzI5CYE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tdo0uQIHEGqkH35bvKc367mOUpsSt0UihXLdw9VP8dm3ImBQjC5pgaIcgjVRyNmFQ
	 B3jZfgrfEPfkp0YF2MT3PQz9IFfozcKsjQT+PWrFk2Ct0u5Q5f7BjJvi0aHgwSvb3N
	 GPR1AOX/jEckkG17ZZKaSIoKWeO5ib6SV/5/Vmp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfJFXGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 19:06:38 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46653 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfJFXGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 19:06:38 -0400
Received: by mail-lf1-f68.google.com with SMTP id t8so7875858lfc.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 16:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLTnokvqrTEKp/du7ZGxWocwiLdnmjMjOhGQECeegpY=;
        b=K6ZqWtnobAV2cuFZDrGF+QdsYZcJ5WAzg/GLhEbPt6cRFU2151jIBXEJlbzCk2qJGl
         SNrsisuVTqPG8hOsunk4CCvoWZJmu70oxOOQ4TwoDpI8xh21WHKtIidRRHjwwa/URxgz
         OCTqirPBIeK1iusfvpbIbuI7g53wv0JqS3/l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLTnokvqrTEKp/du7ZGxWocwiLdnmjMjOhGQECeegpY=;
        b=oU9vEyJvQzskC9+nBsgM6VgYBspQ69Mxofpd4Fn60nToyuQ+iv2eABiApEIhp9kimJ
         1n3EThRHMwlZfwlSQF7I9OhUU/jTN/dmz7qz96OQrGSSRR15pV+xNzxjJTt9KKmR/10o
         TcP3f3mSto8xBrmH0j5tvuTlDW7d0G/keSSd5hiy8SVZ4Jp44YMToOTORCd7tqLcFp7t
         CP+VkjZg4HTbZOqfly2aLd1tJZj7pcQuXROjof3pitY7JraBZbdkYExN6+IRhnOO5ZPA
         7WsvAaf6yPu8g0h9Wf/YyykXlxuC4t2R21hV1FFFIk7zOl3Q9+Cvs9d1QtdTDxOC8t+7
         iZZA==
X-Gm-Message-State: APjAAAVysxfYVHlInHxYaZ6mTlV3HvLGjFz9onsUaorEDGmSdbqRE+UC
        ciX5yqoBLx+PG7qfMVrpLVOoSBKymCM=
X-Google-Smtp-Source: APXvYqz5qIUz6yuj7NE/G3iNIGsGk5O8pchdnLgjhhx4qVPRbb5hlZPzAELIfDTfz1nUG1rnZLk8zQ==
X-Received: by 2002:ac2:53a3:: with SMTP id j3mr15196051lfh.155.1570403193942;
        Sun, 06 Oct 2019 16:06:33 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id b10sm2717121lji.48.2019.10.06.16.06.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 16:06:33 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id a22so11674580ljd.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 16:06:32 -0700 (PDT)
X-Received: by 2002:a2e:551:: with SMTP id 78mr16735500ljf.48.1570403192234;
 Sun, 06 Oct 2019 16:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net>
In-Reply-To: <20191006222046.GA18027@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Oct 2019 16:06:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
Message-ID: <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 6, 2019 at 3:20 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> this patch causes all my sparc64 emulations to stall during boot. It causes
> all alpha emulations to crash with [1a] and [1b] when booting from a virtual
> disk, and one of the xtensa emulations to crash with [2].

Ho humm. I've run variations of that patch over a few years on x86,
but obviously not on alpha/sparc.

At least I should still be able to read alpha assembly, even after all
these years. Would you mind sending me the result of

    make fs/readdir.s

on alpha with the broken config? I'd hope that the sparc issue is the same.

Actually, could you also do

    make fs/readdir.o

and then send me the "objdump --disassemble" of that? That way I get
the instruction offsets without having to count by hand.

> Unable to handle kernel paging request at virtual address 0000000000000004
> rcS(47): Oops -1
> pc = [<0000000000000004>]  ra = [<fffffc00004512e4>]  ps = 0000    Not tainted
> pc is at 0x4

That is _funky_. I'm not seeing how it could possibly jump to 0x4, but
it clearly does.

That said, are you sure it's _that_ commit? Because this pattern:

> a0 = fffffc0007dbca56  a1 = 2f2f2f2f2f2f2f2f  a2 = 000000000000000a

implicates the memchr('/') call in the next one. That's a word full of
'/' characters.

Of course, it could just be left-over register contents from that
memchr(), but it makes me wonder. Particularly since it seems to
happen early in filldir64():

> ra is at filldir64+0x64/0x320

which is just a fairly small handful of instructions in, and I
wouldn't be shocked if that's the return address for the call to
memchr.

              Linus
