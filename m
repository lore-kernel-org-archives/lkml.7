Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04B0C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D42C206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfG3HFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:05:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35647 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfG3HFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:05:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id y4so64482123wrm.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 00:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iWB4kphKN7udeRXcBiB5uX9NupkEYoNs++i9LuElms0=;
        b=VzJ6s3KTIcAxktC1Fa+7LVscSSBlump5G/HfJ1OSSukpInS0XKMGNudgni3e/rhSg/
         4TCpGZs07DUMfNLcbl9YMg/D5Uyx903BIYq+WerH93uq1lqlWpTg5C8NAV1XyR6FfxlI
         404fQMd/FOygxZfCTnrBbwMUWVSptiepmgiel/8UKX4fNF3jo1/pVZRJ+74MXsSO8FmM
         fSwvrn2WfQ7DvySGedsHWGaa9luX0msaQsVTFZ7BZDWjb4e5iof6aPkrl/pMyvcrubHw
         j7eMAtNrWyqqEfOsHAvxBsp3wgjFMB1zizaJoCxdOHCitZgAjHBGdrRWSlmG2+yOKiQY
         dxSQ==
X-Gm-Message-State: APjAAAXrTHzHEkCR9dM7mTWe7N47S6tyEzjf0fAYXZJxvPKBBQ4xi5wE
        llkGkl4nR3wdC97XKLK0hKM6g4fpPbsesEKYzTYhRg==
X-Google-Smtp-Source: APXvYqxA4UA7p0prw4c6NzYin/F7bh8MqYAWlv4qSe05+PF4h1IO2PnD8upJ/jsqgAtF4FdeJ6+W7tNqg3vH/w5+Hbs=
X-Received: by 2002:adf:ab51:: with SMTP id r17mr99183914wrc.95.1564470321909;
 Tue, 30 Jul 2019 00:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190729205454.GA5084@embeddedor>
In-Reply-To: <20190729205454.GA5084@embeddedor>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 Jul 2019 09:05:10 +0200
Message-ID: <CAMuHMdVuf7O3yRJ7EgjqQ=HdZSg8Qv4yVKmWM9b0McSYhX9MyA@mail.gmail.com>
Subject: Re: [PATCH v2] sound: dmasound_atari: Mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 10:55 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Mark switch cases where we are expecting to fall through.
>
> This patch fixes the following warning (Building: m68k):
>
> sound/oss/dmasound/dmasound_atari.c: warning: this statement may fall
> through [-Wimplicit-fallthrough=]:  => 1449:24
>
> Notice that, in this particular case, the code comment is
> modified in accordance with what GCC is expecting to find.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>  - Update code so switch and case statements are at the same indent.

Thanks, this time it works as expected.
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
