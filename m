Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8663DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9C82087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TNRBdFuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfCKUg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:36:56 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33380 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKUgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:36:55 -0400
Received: by mail-ua1-f66.google.com with SMTP id q17so50092uam.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 13:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LjX1mXr/Sze1JdJH9x5mTfNwlxsdBA39jaK3xSmQnP4=;
        b=TNRBdFujLUtjm997S0IXwqMLr+tHOS6h80LD1HVoUXhNSpTL1EzoxMJ4mVIQwwZ21b
         wZkZUSQWV1x4XSVqizD3HVJHKf5DXusVuPOCTEy9repjj8Wz2XUjULYDRnWGHESQVvz2
         iyn4MavLRue2VFTSx8FVZv9WpWOi0GID8VLuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LjX1mXr/Sze1JdJH9x5mTfNwlxsdBA39jaK3xSmQnP4=;
        b=ujJWhDnFvW+mX729F9zqZvdJw1DUd63+98mFQFkEr1lc+CY3tfvRdQOqvga5C9j4QZ
         fi5SZtQTAY2o7Vf1OyG9e395WsySlOWFF6z/6g0X45SADN/M33p3F9TrU+7irHZgI8jb
         yYRgvELFSukVEnbAqVD2LkoyJEClXzVCAYjlZtbkdJJ9qMjx6IiFQ2IIcLklu2z7s+7n
         iwGnGVXNaK2dZl+wnSF9Y4ZTlDc3cKuw6h4e+F8h6Hxj1SkzBWqkW0x8RFfttHdYgBEH
         Om5noeCLKgJCycExVxtPLKwmjdlAssiu0ul5xWk2bVkhzSYjwg+oFRXiOT7EasnQ099+
         GoBA==
X-Gm-Message-State: APjAAAVIOeBzFI0f2mGOCUNR1Ucz7V9SX+ltzQvXrlKPZsetpElZEtL8
        njBweQO1p3GBtXU+GeTpXPbtoLfRlRI=
X-Google-Smtp-Source: APXvYqwQTfKr9B9TE+qks+LgRoVzE4COTAbceJHRj4lHC5P5b9GARHSTewEB+8wCxWQybMLhXsEFbg==
X-Received: by 2002:ab0:3384:: with SMTP id y4mr17580214uap.30.1552336614058;
        Mon, 11 Mar 2019 13:36:54 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id n124sm2365608vkd.14.2019.03.11.13.36.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 13:36:52 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id y19so239756vsc.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 13:36:52 -0700 (PDT)
X-Received: by 2002:a67:89c9:: with SMTP id l192mr17561264vsd.188.1552336612318;
 Mon, 11 Mar 2019 13:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <155221755096.13878.3370977359110476046.tglx@nanos.tec.linutronix.de>
 <155221755097.13878.5173016541431155948.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjNes0wn0KUMMY6dOK_sN69z2TiGpDZ2cyzYF07s64bXQ@mail.gmail.com>
 <alpine.DEB.2.21.1903111516190.1691@nanos.tec.linutronix.de>
 <CAHk-=whUyG3+Zwb74LSOPGtTBvK9N6DG4f=Y5Yv9Xzcy-qY0Qw@mail.gmail.com>
 <CAGXu5j+NB16S2gAz9TOW6izZykuOXqRoP0nDkTqgn02OJ2ht5Q@mail.gmail.com>
 <CAHk-=wh6=X2TauxJzEBkLwcq5wcV3zM53FLDiVjD4LiBRcD9Qg@mail.gmail.com>
 <CAGXu5jJLnsQm20A87-1+vH4kXwE1APjNqv=6qx32gCYk7SaW_g@mail.gmail.com> <CAHk-=whQYG7iHO8Gv2Ka2_2tXNJkX1LdsyqKUZ=EO0aP6uS+2g@mail.gmail.com>
In-Reply-To: <CAHk-=whQYG7iHO8Gv2Ka2_2tXNJkX1LdsyqKUZ=EO0aP6uS+2g@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 11 Mar 2019 13:36:40 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJkB2L3-_Q1Vw_myCcx8hE49Vih8ogHqTFEYsio5LRm3w@mail.gmail.com>
Message-ID: <CAGXu5jJkB2L3-_Q1Vw_myCcx8hE49Vih8ogHqTFEYsio5LRm3w@mail.gmail.com>
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

On Mon, Mar 11, 2019 at 12:23 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Mar 11, 2019, 12:14 Kees Cook <keescook@chromium.org> wrote:
>>
>> >
>> >         this_cpu_write(cpu_tlbstate.cr4, __read_cr4() | cr4_pin);
>> >
>> ..
>>
>> The protection needs to be around the actual "mov %rdi, %cr4" that
>> native_write_cr4() exposes,
>
>
> You misunderstand.
>
> The above is just the "initialise cr4 shadow cache" case.
>
> If you do the above, I think we may have cr4 values initialled early enough that all CPUs can then just use the "check that the pinned bits were set" unconditionally in the actual routine that changes cr4.

Oh! I see what you mean -- separate the or and test. Okay, I'll look
at that too.

-- 
Kees Cook
