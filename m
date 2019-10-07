Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0155EECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2274206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfJGVFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 17:05:02 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46472 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbfJGVFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 17:05:02 -0400
Received: by mail-ot1-f65.google.com with SMTP id 89so12215117oth.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 14:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXkJHb3KhCKEoZEZcO0GspzG/wMrxtcRAJbZdKj0If8=;
        b=iPWa+HMuiRe3zCj0QwvBd/o5EgXm1ymWTEwlNevvzEb5pfIWCODLYfmS/x+1xl+xia
         O6GGzVEsx0cyWaJ7h+GwTBv1kG3ZNDMFrJKO7i+dEhEE+sZIQrv99otzF7x2lR4quKcU
         xQhDxPQN0r8ckpgTEKQkQOCJuMSsCHFXpGrSoBfLQ/90nqM2E4gFZ8z1yIED8dH1yjFm
         Hr7dMUsl/HpVYvS7kO3wuPqiRMvkUloWHnkB17k7vsBIbq+8U6o5DVfqxqDWotodCyY4
         slK7gXc+fGmYsZNnHyTv9uMeWEYGwjY8ilu20c94saDxYqeuawHcXxLCEdeoRcpTHIlk
         XmPA==
X-Gm-Message-State: APjAAAVDOzHS7dHh7Q0jRyLFWKc+YUJhXfNBEWsF7IO0ywHH4X8yfiwg
        GVip78+1XLDPOBCMKik2Jzu5GOPFKhrzMV+pHrI=
X-Google-Smtp-Source: APXvYqwdDiVUo+BTNkwqvPFHz9Ni48T/54pw3N3lgQvqJehMtNaY58HilBq3evea04cYViMhGVSO5GN4ttY0b/V+hAc=
X-Received: by 2002:a9d:404d:: with SMTP id o13mr13219964oti.39.1570482301215;
 Mon, 07 Oct 2019 14:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191007071829.13325-1-geert@linux-m68k.org> <f0250c51-a653-6cac-9e6b-affa74d8559c@infradead.org>
In-Reply-To: <f0250c51-a653-6cac-9e6b-affa74d8559c@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Oct 2019 23:04:50 +0200
Message-ID: <CAMuHMdWSu00nfeQbE6hX7Ok=WZveiZ=i178Uhk3sgpF3k4Ax3Q@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.4-rc2
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Mon, Oct 7, 2019 at 10:48 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 10/7/19 12:18 AM, Geert Uytterhoeven wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v5.4-rc2[1] compared to v5.3[2].
> >
> > Summarized:
> >   - build errors: +10/-3
> >   - build warnings: +152/-143
> >
> > JFYI, when comparing v5.4-rc2[1] to v5.4-rc1[3], the summaries are:
> >   - build errors: +5/-10
> >   - build warnings: +44/-133
> >
> > Note that there may be false regressions, as some logs are incomplete.
> > Still, they're build errors/warnings.
> >
> > Happy fixing! ;-)
> >
> > Thanks to the linux-next team for providing the build service.
> >
> > [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/da0c9ea146cbe92b832f1b0f694840ea8eb33cce/ (233 out of 242 configs)
> > [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/4d856f72c10ecb060868ed10ff1b1453943fc6c8/ (all 242 configs)
> > [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c/ (233 out of 242 configs)
> >
> >
> > *** ERRORS ***
> >
> > 10 error regressions:
>
> >   + error: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!:  => N/A
>
> Hi Geert,
>
> What arch & config is the above build error from?

That was a new one in v5.4-rc1 for sh-allmodconfig (blamed on David Daney).

> Sorry to bug you about this.

Np.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
