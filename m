Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BE6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CD721841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553103032;
	bh=ObrDmVxWw9yR/xA5aUForbjUqNkwfSOdazi0F3ZQgAk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RVK+gKCDfvHlJbtl4V+iawaJWGanF8ppJ2JotmTx8f3q4WUWGzJkTg689K6nvwm3K
	 XNqOFbveLqcl2WDei2Ws6UQ2jeKsnRkzovqrso99xpYcZUFQO+4Db/vWHyZ5YgPGoq
	 /gTk//oS0+gqpaEYXFDe7py36gd9iUxORbd6yd18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfCTRab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:30:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36972 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfCTRa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:30:29 -0400
Received: by mail-lj1-f195.google.com with SMTP id v13so2997915ljk.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EomCLa1CYuJu5rcLuBk4tbhoF4LfZAdCZ3teJ+rVGdg=;
        b=DjENWCTbPbl7dyb98ANIB5b9aLP0tT/43VLVPXH/ObMNIJBP9jZ4nx/q4z/nVKv28k
         h+vF2zHFfr/qf6kNbdyLMDP3i3G9s+Hm8bbbYyqESA1DCKhyolzyTO1ZRrwyoJr+F4yN
         ASvN9OuEmRAsI4g/+wbmWsB8+5kApS/MYWU50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EomCLa1CYuJu5rcLuBk4tbhoF4LfZAdCZ3teJ+rVGdg=;
        b=dnobOjBdGJl0ey3fgP1yJI4Kye8k7J8aI6MechxWpbdoQKxSg0b18pHP6uBsdigmZe
         RoaMC4r9Cln21HCV5kCOgLoBZneYlibJezGnCaP7o6PvgxaXSmP11QSxxgcqA0ItD/Rz
         /5oYoq77xaqcZOEix80mrWxTWHKWPViob76A4FM7lRD2tda9uo0qybIx7+TcrRMCyLg9
         jzJjBsmYRn7tRq51iLhHxMpMYtQO/honfomBnyg6Yq9DMxDpKhGn9ArDt3jAEViLqUYs
         +JKXQXi4em6iqSUZLUAEI8FFqFgc1iuVMwFpZmI/5Cb1k0s0hJGzCAaQ0Yl7Rnml06tX
         vqNA==
X-Gm-Message-State: APjAAAX1njxEWnPpNy/qqaTYJLcdgsbOO3fimSKC1o0LMiBGOku+k7ea
        XoB8O4TIGUhZFlsTgeHDn2queJnIk2Y=
X-Google-Smtp-Source: APXvYqyUvMNJ77FrcJY31WSYKQYT7glRDKisgf9A/dmlBVRKT9PTPLU0DbUSblKNiLa7iCijFH7vYQ==
X-Received: by 2002:a2e:9655:: with SMTP id z21mr15850903ljh.60.1553103026613;
        Wed, 20 Mar 2019 10:30:26 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id q26sm524107lfd.27.2019.03.20.10.30.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 10:30:25 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id u21so2544288lfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:30:25 -0700 (PDT)
X-Received: by 2002:ac2:548f:: with SMTP id t15mr17380123lfk.166.1553103024789;
 Wed, 20 Mar 2019 10:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190320170342.GA11770@redhat.com>
In-Reply-To: <20190320170342.GA11770@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Mar 2019 10:30:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg9-SK6QDhWvgy+7FkV4Q-d0Ae5p3RcAHoKQtRySn9z8g@mail.gmail.com>
Message-ID: <CAHk-=wg9-SK6QDhWvgy+7FkV4Q-d0Ae5p3RcAHoKQtRySn9z8g@mail.gmail.com>
Subject: Re: printk_ratelimited() && proc/sys/kernel/printk_ratelimit*
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steffen Froemer <sfroemer@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 10:03 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> At the same time, printk_ratelimited() uses a static ratelimit_state, so user-
> space can't override the default DEFAULT_RATELIMIT_.* numbers.
>
> Isn't it strange? Shouldn't printk_ratelimited() use printk_ratelimit_state ?

No it shouldn't.

Each printk_ratelimited() is independent, and that's very much on purpose.

One screaming printk shouldn't mean that every *other* printk would be shut up.

That said, it's likely true that nobody should really use
printk_ratelimited() anyway. But if two different users do, they
definitely shouldn't then affect each other.

                Linus
