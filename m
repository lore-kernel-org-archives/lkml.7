Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA97ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5400B20B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfJASx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:53:57 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38778 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJASx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:53:57 -0400
Received: by mail-qt1-f196.google.com with SMTP id j31so22999549qta.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 11:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMheytGVabcyJn3FNgJ/7coP4hV/9kpO+I6Es2EfVJ8=;
        b=CdgH7ngm4y78v6w5p11RyCrqEclFfEDETjZ1mmpgGVx19OLBuOSBQOnZmSMrQoFs47
         i2DSu/puicqMJUSDw13iSJ7DsqghAAqIC3hT2bkwPKufRQY69ZXgbey4DRwrKkKnRHRW
         X3P4sPn6q4ZrGtFOS13g3wSmfPOsmSrs3042SMZ2sl5NgstsWJisREi4aGtPGoz74rTD
         D/EcL2HBtjUGv8pDT2XAsqyYUq2m36LgwiXQ89gKbU1EASkTQifV7tGFlrMSitF4EMyH
         3fFQ4QlXM2SnAFZoPUB8n6q9ppVtTNagsFAF9qE/xWlcUi/n0JvflOOSti2+eKfeGktA
         VLCQ==
X-Gm-Message-State: APjAAAXRA6/XXY5JYUm4H4/+6TZKxLOSYwOBzndJkEiqeR5tVkRbhKaU
        ItgegSE0wBZIxwC8sB9MeCKIOSn9KrQbcziL8zS+wY3VOog=
X-Google-Smtp-Source: APXvYqzO/m/ctV2NVfB6dhoF3yXr2H2qJOxbJ0sAOXM2f57fgm3iu0I+vXtPdjc+9u3wEsu9hIMuBM8V266k4GJXy40=
X-Received: by 2002:a0c:b386:: with SMTP id t6mr26513220qve.62.1569956036105;
 Tue, 01 Oct 2019 11:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <201908251609.ADAD5CAAC1@keescook> <CAK8P3a3_sarrMKij5=sp-o16dXERfWkHhUr0fE49Xv8BvXDfaw@mail.gmail.com>
 <201909301611.1363980D7@keescook>
In-Reply-To: <201909301611.1363980D7@keescook>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 1 Oct 2019 20:53:39 +0200
Message-ID: <CAK8P3a28gyC6KQfAKf1CG6CGL=7y_pj2VkbuNTb3YvTi7+8+YA@mail.gmail.com>
Subject: Re: [PATCH] uaccess: Add missing __must_check attributes
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 1:17 AM Kees Cook <keescook@chromium.org> wrote:
> On Mon, Sep 30, 2019 at 12:33:19PM +0200, Arnd Bergmann wrote:
> > On Wed, Aug 28, 2019 at 7:38 PM Kees Cook <keescook@chromium.org> wrote:
> > arch/x86/math-emu/reg_ld_str.c:88:2: error: ignoring return value of
> > function declared with 'warn_unused_result' attribute
> > [-Werror,-Wunused-result]
> >         __copy_from_user(sti_ptr, s, 10);
> >         ^~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~
> > arch/x86/math-emu/reg_ld_str.c:1129:2: error: ignoring return value of
> > function declared with 'warn_unused_result' attribute
> > [-Werror,-Wunused-result]
> >         __copy_from_user(register_base + offset, s, other);
> >         ^~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > arch/x86/math-emu/reg_ld_str.c:1131:3: error: ignoring return value of
> > function declared with 'warn_unused_result' attribute
> > [-Werror,-Wunused-result]
> >                 __copy_from_user(register_base, s + other, offset);
> >                 ^~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> What was the CONFIG for this? I didn't hit these in my build tests.

I saw three randconfig builds trigger it in one day, so not that common.
https://pastebin.com/mUhbNEVR is one of them.

> > Moreover, the same code also ignores the return value from most
> > get_user()/put_user()/FPU_get_user()/FPU_put_user() calls,
> > which have no warn_unused_result annotation (they are macros,
> > but I think something could be done if we want to have that
> > annotation to catch some of the other such users).
>
> It would certainly make sense to mark those as __must_check too... now
> tracking this here for anyone that wants to take a stab at it:
> https://github.com/KSPP/linux/issues/16

FWIW, I have not come up with a way to add the warning, but I
did send a fix for the instances in the math-emu code:
https://lore.kernel.org/lkml/20191001142344.1274185-1-arnd@arndb.de/

      Arnd
