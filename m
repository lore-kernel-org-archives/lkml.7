Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4403EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 20:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12534205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 20:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hz+tpbQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfI0Ujf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 16:39:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39656 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfI0Ujf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 16:39:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id o10so4070849pgs.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 13:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ShSdb9Lrf0RHWqorkRz6ox6yLC4Co85l5XrRSD8mUDw=;
        b=hz+tpbQ8UD9HFLn4XPQ/wh3gVrOLpm74MPRCalrlAr6CjwdCef0T8RnZtNJhOPMhj1
         dN3+lfvvcy2vBL9BHWXS8wBn7kICB6vuKvRPcoEmWGSfjgCYv7SvxtD1SSO9jdt2POgU
         Que6nbJtyfo+TBYUg8aI/So6nHspo7XEhu1nE68omQ0GFodhGdKqBN/t2AM+CD/rxTOk
         rOH4n5WONZDX0TQKbSFsFMrOI0kIyWVv8gxbWhQlphIbVSHSDApDJuJF5ragO9qRCx32
         Hs2CMhIlOz9GQYUEvGIHLTh/FYwSp7FrYZa4HM49XAdMKoi6f640YzUMSCb3ma0RnXhs
         WD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ShSdb9Lrf0RHWqorkRz6ox6yLC4Co85l5XrRSD8mUDw=;
        b=CNi88L0sZaR5ca9Nniw71trmv6JiRLkVqiQJT7Pp9VEIVOhlbpjMYPlBuvQrOQVhw0
         C40x8vts58BqLz85EOI90ll3Rviebe0U2gzJvHKvrGg3IKilW3w2gSvvr6p5yHbHUxGs
         DkzJl3knNvn6pRn3GSuQE6/sBltM6hl3EVvGU+C/hDUmPfP49s3GCDrV9bfs8c467eut
         w9FMDQeOBhdqV4P2UzOBWznzjmKErNHyzYlEGoFIA2u+hFeMLjll9JZy5qcObiGYCp8u
         qtvFBAJdY5WHPOrXXk/lr680mDNjWNo1pvYThjMiit5meuBrJHuHywLTYe+EALCyspUY
         GeBg==
X-Gm-Message-State: APjAAAUxQMwQm1M8hafp7xAu6HpS/36liv/6GD0bIsIvkaMMRd6KR/Ks
        j7SQUkMaq2+It7f4D+cP1ePGI4hvzSAJMuzECA0=
X-Google-Smtp-Source: APXvYqx7R3i+4wZPHGv7dzqvUguFM1DoTCKYqVfvW7A6AAFXwmaN7Wv0rxkvO/0V/MmoBgp7yLAXLSLiqI24y1MtswI=
X-Received: by 2002:a63:6988:: with SMTP id e130mr11619254pgc.203.1569616774815;
 Fri, 27 Sep 2019 13:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190925161922.22479-1-navid.emamdoost@gmail.com>
 <13f4bd40-dbaa-e24e-edca-4b4acff9d9c5@linux.intel.com> <20190927025526.GD22969@cs-dulles.cs.umn.edu>
 <dc68e0dc-9a8e-cc52-c560-3e86c783dbb3@linux.intel.com> <6966df25-e82c-1abe-6a0f-ff497dcda23b@intel.com>
 <20190927153304.GS32742@smile.fi.intel.com> <2e8ef4df-9c5f-f6e0-23ee-32d3bc555330@linux.intel.com>
In-Reply-To: <2e8ef4df-9c5f-f6e0-23ee-32d3bc555330@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 27 Sep 2019 23:39:22 +0300
Message-ID: <CAHp75Veung3v41RMmBoQHE7TFWUccE2oXsVnNgUt0JE0naTfLw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2] ASoC: Intel: Skylake: prevent memory leak
 in snd_skl_parse_uuids
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Kangjie Lu <kjlu@umn.edu>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 7:39 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> > The problem with solution #1 is freeing orphaned pointer. It will work,
> > but it's simple is not okay from object life time prospective.
>
> ?? I don't get your point at all Andy.
> Two allocations happens in a loop and if the second fails, you free the
> first and then jump to free everything allocated in the previous
> iterations. what am I missing?

Two things:
 - one allocation is done with kzalloc(), while the other one with
devm_kcalloc()
 - due to above the ordering of resources is reversed

-- 
With Best Regards,
Andy Shevchenko
