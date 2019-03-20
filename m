Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC8BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDAF21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtX6Q/T5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfCTR3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:29:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45333 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfCTR3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:29:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id y3so2271625pgk.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bzPAqLhtW879JqqZCnD6KDyGjZqO0mml2qpCV44Pwks=;
        b=ZtX6Q/T54hlirmZ/BcKDT9JvU9ErIz+I2hBRGxuD8OnZdqu1EyQVvOjK2TDfygf5sO
         jLCm9ky8l9NQN6DrcKBz5CjUEZTLqQxotPB64eGRUhlvi2A2FN1rspW9dWmHKhwX6IOK
         8Jaj/6Em/1ErugZYuvi0APbDfd20zs1iGAFDet5HDt48Z0s2otiHzjGyZaty28Y0tS5i
         9wUjYVBIq89tnMo5s2miVPA9bM7bGzvb7fh0cZH6ioKQ7+nkB1pUPoUVGkER1NcvhjMj
         eqvq7fRT0A/DelzxQsZb5/TB7CYrvD5Ab+uVDf5lJe99H3FO7kKUkL7v4+bSJKzUZdaV
         zqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bzPAqLhtW879JqqZCnD6KDyGjZqO0mml2qpCV44Pwks=;
        b=t7mgA8OyHdiv37Qq2eviTypudEthsPXvKCrSgxcsr1QpouXro3dFgnmkeVf7XPmVyA
         WUcLW3l00CRKpWzNNYGOVU+JZNUyAKQh4YCQAdhRnHd01skWnkT0UtTTWa0zqOceNp+R
         SSN5ZV1p90kArtap25yoKnnuW/nPE4PNawXEc31TFj1wq1QhOE/5rgdN4i2XuFYktoVv
         ToSl0bXz33Mcjqik6HjGArPjhkEOqjldOGHnTK0YydpW0lB/n3dzJ8LCVidX/qU2eMAR
         52ZVpAeCxWWQsAmdozBPc+J8l/EsFWVtjK0XPsjQ8hArPAD+nE839XxplEH3vrvdp0uF
         H/kA==
X-Gm-Message-State: APjAAAVShBca+dqdGixzDbKqHRI3P5rLkMJg4Z0/nP+YvFu2rSYC3fyM
        sn/aPlQzsfnVSoSseW1Iy7/CdNa+8gdUzzCZprg=
X-Google-Smtp-Source: APXvYqyA0wXo3YRvVsAKBVZJUDwARi+Uj3QytkFmj9+dOZQmOrUm0L/jO0c8srZVQRsHMXAH8ByHQdkruNFZbjY0Sgo=
X-Received: by 2002:aa7:914f:: with SMTP id 15mr8757532pfi.49.1553102981104;
 Wed, 20 Mar 2019 10:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
 <20190319184325.72807-8-andriy.shevchenko@linux.intel.com>
 <8742b0a2-de4e-9865-cb3e-dfda0dec6a0a@infradead.org> <20190320151715.GG9224@smile.fi.intel.com>
 <415863c9-8a06-f392-a558-bce694069d09@infradead.org> <20190320161543.GH9224@smile.fi.intel.com>
 <20190320163038.GD15821@nazgul.tnic>
In-Reply-To: <20190320163038.GD15821@nazgul.tnic>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 20 Mar 2019 19:29:30 +0200
Message-ID: <CAHp75VdNkm_FBo2ZnKG3D0gp6r_2pSfNZcCNw0Efq=rfTWTTAg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] x86/boot: Support nocfg parameter for earlyprintk
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 6:32 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Mar 20, 2019 at 06:15:43PM +0200, Andy Shevchenko wrote:
> > I don't see the proper place.
>
> I see Documentation/x86/earlyprintk.txt which kinda begs to collect
> earlyprintk documentation...

It says only about USB, but okay, I may shift it as a chapter.

-- 
With Best Regards,
Andy Shevchenko
