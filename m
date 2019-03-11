Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD1AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8C420643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mVyKd1Ng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfCKQzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:55:35 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36914 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKQzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:55:35 -0400
Received: by mail-ua1-f68.google.com with SMTP id x1so1763924uaj.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 09:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9lQt9ghVFHjxBbgGtSt8no6ZLGqz4ceORZr9rfva9WE=;
        b=mVyKd1Ngbb0tFabWr5dX39XySGWMS0XYmSi0e9qS3bEFUQfkNtF/zTq2A2UznaFHYZ
         /9oB40R5WBi0PwI/OIdHh4sG7J9ysBMuBtuEGhUScwJB9a9jU/XEcCdkkopjvfYRZJ46
         yS9GARtC5MfBzVfcR/OZmVp9PiZrAaHy0qPZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9lQt9ghVFHjxBbgGtSt8no6ZLGqz4ceORZr9rfva9WE=;
        b=pHMGqHsZ07VGGT0YxmjQ3q8SLCQIvkMWLU37Rn0XP5z4WX7+M6SVt4MQjVsA2xSWN4
         QXTb7gpZj9aIlI06DW0djWzGbtGm6IVNy16jOMAR8NlWwJVgQDcix7QSwtzbnBTjW27e
         W1BI9pPriS3QeWaayAMimcGGAtUpcAPs6Hg9/SbrLFFG+MCT0uYMy6V6LhyL5FpY8ssx
         rcqjaVUt++AEnOK5KnDxvNsCGsIE0cMSExRlRlc8I2ywPA3amFxkuUWS0BLBgzlfzV7s
         WpR0nmVyBBHe79KLONoEoqri5dUj0dMAx1EBiXE5BclzefFcwNwTb5loILnqgw9zzCiI
         yqng==
X-Gm-Message-State: APjAAAWp+yx7JCq1tNcxI9RLPumlRNLYefd4sL/nB9uM5flE6f9rXSET
        lwQ65Dtx0947tU4Las0pggS1Zvo1mmE=
X-Google-Smtp-Source: APXvYqzs12EJ2aKZ0nG7iPIWmVGoaSP5PSgK0haZs/fp/grpHmJyPEgA8Tqb1I4W16AK0L/ngd8DaA==
X-Received: by 2002:a9f:2f0b:: with SMTP id x11mr16408142uaj.78.1552323333291;
        Mon, 11 Mar 2019 09:55:33 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 123sm1158704vsw.18.2019.03.11.09.55.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 09:55:31 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id y19so3156453vsc.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 09:55:31 -0700 (PDT)
X-Received: by 2002:a67:89c9:: with SMTP id l192mr16953335vsd.188.1552323331106;
 Mon, 11 Mar 2019 09:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <155221755096.13878.3370977359110476046.tglx@nanos.tec.linutronix.de>
 <155221755097.13878.5173016541431155948.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjNes0wn0KUMMY6dOK_sN69z2TiGpDZ2cyzYF07s64bXQ@mail.gmail.com>
 <alpine.DEB.2.21.1903111516190.1691@nanos.tec.linutronix.de> <CAHk-=whUyG3+Zwb74LSOPGtTBvK9N6DG4f=Y5Yv9Xzcy-qY0Qw@mail.gmail.com>
In-Reply-To: <CAHk-=whUyG3+Zwb74LSOPGtTBvK9N6DG4f=Y5Yv9Xzcy-qY0Qw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 11 Mar 2019 09:55:18 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+NB16S2gAz9TOW6izZykuOXqRoP0nDkTqgn02OJ2ht5Q@mail.gmail.com>
Message-ID: <CAGXu5j+NB16S2gAz9TOW6izZykuOXqRoP0nDkTqgn02OJ2ht5Q@mail.gmail.com>
Subject: Re: [GIT pull] x86/asm for 5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 8:39 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> They are set early in the boot process, but they are set separately
> for each CPU, and not at the same time.
>
> And that's important. It's important because when the *first* CPU sets
> the "you now need to pin and check the SMAP bit", the _other_ CPU"s
> have not set it yet.

Clarification, just so I get the design considerations adjusted
correctly... I did this with a global because of the observation that
once CPU setup is done, the pin mask is the same for all CPUs.
However, yes, I see the point about the chosen implementation
resulting in a potential timing problem, etc. What about enabling the
pin mask once CPU init is finished? The goal is to protect those bits
during runtime (and to stay out of the way at init time).

I'll play with the "+r" memory output as a way to avoid volatile but
my earlier attempts at that did not produce machine code that was
actually defensive in the face of skipping the "or". (The cr0 case
works; I did use the "+r" method there. It's easy since it's a
hard-coded value -- I had less control over what the compiler decided
to do with register spilling in the cr4 case.)

Anyway, I'll work on a cleaner version and include you on CC.

Thanks!

-- 
Kees Cook
