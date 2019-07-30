Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA67DC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B038D206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW8mDMFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbfG3RQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:16:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37305 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfG3RQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:16:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id i70so19657606pgd.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 10:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GGF9RjFoGl0n9E5UL5M2eDbk4GrLA32wjcx/hWzqzO8=;
        b=nW8mDMFVO4A9IuF6Y0m7xTQWGioPRJ0B8lKGekV0xRoFp0Trko7fTNQzp19OSFpCZX
         k6Y82+1DtavAAwdh/UUp83KxyaM+fnK43lSMCmY6IdJ7E4ubZPEJsaQhMFmxOQuW6c3s
         hXpVAzcWYWQTpTXx50UkIYCKg93F2z886vNKUJN/McdIZxaQXsfdQTbMx5nr5UVy9gfj
         I6I7wb6o4bvb7ycJXMY9MZ27Zg/aFdDzF318VcAbz9Pgcm77j/OPh+KxxPvNxtj1oM4M
         34rVYAU54Bx7eNERhnWSXuQBUhF1Fra7+SmOPoDa8Z3Yu/N88V70At2qE3BSnruyok4M
         HoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GGF9RjFoGl0n9E5UL5M2eDbk4GrLA32wjcx/hWzqzO8=;
        b=tWlW5sMEcYhWD7vlpDurlcE87l/5tBWCMhd51yu+0lu9K1Eb5juM4TM1etvfCiU3a6
         jhwnjjRjI5plPlcZmFXPpSQLY6fq9V1vDGrdpdk5fAP2EpElv6OANZ6Ml9afb0IH0t2W
         0Tht6KnKvI2J24CynI3M9tUBHDwPBqO148Y0ufsbl52lDMmBY3+lcQqT1lMlswBp+ndX
         mEPVCjg4izaxt5qgiNDXV2ZiUEWJWgUsw6bNYYJDpxZxLUavDKvyk4QFLyHuowfd7cGd
         XN2bHsRecB4p6s/CsePbhzNCvHEITilJWZIqyWUncpMoZSSauIGlGjCR+8CWqsdCbM7r
         SlkQ==
X-Gm-Message-State: APjAAAWChohvjqxMAgiFw8yJ0QBvnOrAZ+Hk6bd5UlqVol4/Hdbnm2A0
        HxQYrdCv411s9DY1IwUAnRr5bTCV2aasLNY8SHQ=
X-Google-Smtp-Source: APXvYqy9s9E59PSMMSzw2c4RTo6oxxF2gawG5VD6QAQXGdDD/qINoGGfvrUk9DqrpSs/rpkyGy0ySJ3kzRUdArX37O0=
X-Received: by 2002:a63:e54f:: with SMTP id z15mr109465810pgj.4.1564506972011;
 Tue, 30 Jul 2019 10:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190730053845.126834-1-swboyd@chromium.org> <20190730053845.126834-3-swboyd@chromium.org>
 <20190730064917.GB1213@kroah.com> <5d4063e0.1c69fb81.fb7c2.9528@mx.google.com>
In-Reply-To: <5d4063e0.1c69fb81.fb7c2.9528@mx.google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Jul 2019 20:16:00 +0300
Message-ID: <CAHp75VcRJBmtqs6mN2wNE+fY8hVnPLDWRYZHQSwKXWsmhmhi8w@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] treewide: Remove dev_err() usage after platform_get_irq()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 6:36 PM Stephen Boyd <swboyd@chromium.org> wrote:
> Quoting Greg Kroah-Hartman (2019-07-29 23:49:17)
> > On Mon, Jul 29, 2019 at 10:38:44PM -0700, Stephen Boyd wrote:
> > > We don't need dev_err() messages when platform_get_irq() fails now that
> > > platform_get_irq() prints an error message itself when something goes
> > > wrong. Let's remove these prints with a simple semantic patch.

> > Can you just break this up into per-subsystem pieces and send it through
> > those trees, and any remaining ones I can take, but at least give
> > maintainers a chance to take it.
>
> Ok. Let me resend just this patch broken up into many pieces.

Please, for the subsystems / drivers where I'm the (co-)maintainer,
please split on per driver / module basis.
I will pickup them preventively, since it will be anyway run-time
bisectability breakage.

-- 
With Best Regards,
Andy Shevchenko
