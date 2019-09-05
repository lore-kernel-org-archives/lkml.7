Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F0BC3A59E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 00:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1368B2168B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 00:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dtj7XFHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbfIEAXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 20:23:39 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42678 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfIEAXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 20:23:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id y1so374816plp.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 17:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7CKrfPs9bY4+1JCWPVff8SlFdFjfkWj3tkBTRcIvvog=;
        b=Dtj7XFHPOZGUx3T6sZxqg88xQy7i9xrpuP8kA0qC7imAwCblqNE6Fz0vfUqb0Rqkqx
         ZaFXQyonZepTin2o8CRzP+Vh4dUcwOGxOL/3sPxcri5CUM0EFUWB9vQ3u2Ri8jnJIJCy
         p10HISfN43d9ISaY3JKTP2xT8GgvLjfrCQZAj0xAlw9UcQ7t0sUOtDKeJoVjF4CaPczE
         aFonQ3U0jIxBDSKR8IzAdyJcmzPjNXfSw09tvWgNbmihd2Q4ax8AeaFfLMKF1Ko1VO6a
         j7sN4+rDY6xYjPwKiRhJ6Kq/3mPl6Q4ep9l/2gp0/Vo+DjAn6d2By7+v25vVg9NXxqon
         8k4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7CKrfPs9bY4+1JCWPVff8SlFdFjfkWj3tkBTRcIvvog=;
        b=ZHWgzmeoGNm8cgbva7zUBmNmrKL9byF+gXFRSwOvinYF6OG0Be/obAxz1itrgULtsR
         UHz4NRVDwRViVUgCnQfOqiZ3gb6n6uXdjDWIxwhzAdpr1nssEJ+QXMm1njcc45y44sCh
         5lLifh1VTeMGf2Lrfbyu3NvYaS8AQ01gJ+FNipJePmHmDufswrberj/SbI3PyS+xHmOH
         PeIwhIFErpjbjL1SSd2lEgwxFPv5385+0uqNStOSgsbzWwmWXM+zVwprcTgrhxRUM28s
         zVipqjzaBafnItIyWQD04eZoHqXIY1qT20dvVffC8GRlIS4ZRl9c7JePs6JwspDQdU+I
         kw3Q==
X-Gm-Message-State: APjAAAWBPj+foL2Ab3R5Rhr2g7rCI2POf2cN3kTzNN3aHPjJBumyjv4Q
        AGM0PlG+xYXYfcdn/Qg7KTOzvFSifrLrwXDWQmI5kA==
X-Google-Smtp-Source: APXvYqwly1vpogTNcc7Slek3G8cnJg7Dmz2zelWRT85vl8nOfmyAkwpKfNqqw9818Qe0X2uXwyTyXhQpeHBdkiZaSzA=
X-Received: by 2002:a17:902:988a:: with SMTP id s10mr451231plp.119.1567643018426;
 Wed, 04 Sep 2019 17:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190904214505.GA15093@swahl-linux> <CAKwvOdnX3qVq1wGovViyGJSnySKzCATU4SU_ASsL-9XfDZ8+Eg@mail.gmail.com>
 <CAMVonLiOB4PnbnLGo9gP8MK8kGd_e9vW_t+GOPuHMO_RqmkKNA@mail.gmail.com> <CAMVonLjBcJm2DqyhybLjCDsm8P9jqSybvq0geDAfvbVn=P0N-g@mail.gmail.com>
In-Reply-To: <CAMVonLjBcJm2DqyhybLjCDsm8P9jqSybvq0geDAfvbVn=P0N-g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 4 Sep 2019 17:23:27 -0700
Message-ID: <CAKwvOdnHT3sEq0XkOWVaOBhbypnPEXmtAE9fafC4Bk3xkU-cJA@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/purgatory: Change compiler flags to avoid
 relocation errors.
To:     Vaibhav Rustagi <vaibhavrustagi@google.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        russ.anderson@hpe.com, dimitri.sivanich@hpe.com,
        mike.travis@hpe.com, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 5:19 PM 'Vaibhav Rustagi' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> On Wed, Sep 4, 2019 at 3:28 PM Vaibhav Rustagi
> <vaibhavrustagi@google.com> wrote:
> >
> > On Wed, Sep 4, 2019 at 3:19 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > Vaibhav, do you still have an environment setup to quickly test this
> > > again w/ Clang builds?
> >
> > I will setup the environment and will try the changes.
> >
> I tried the changes and kdump was working.
>

Great! Thanks for your help confirming the fix.  If you put your
"tested by tag" next time it may help some maintainers who use
automation to collect patches.  That way your help is immortalized in
the source!  Such a response would look like:

Tested-by: Vaibhav Rustagi <vaibhavrustagi@google.com>

(see other patches in `git log`)
-- 
Thanks again,
~Nick Desaulniers
