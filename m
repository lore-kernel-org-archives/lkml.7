Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38DFC0650F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 01:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A642086D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 01:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riia59qc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbfHFBxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 21:53:53 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46297 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbfHFBxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 21:53:52 -0400
Received: by mail-qk1-f194.google.com with SMTP id r4so61611170qkm.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 18:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d7kc24UT0Ui3ma1mQirb3g1ID4GWXa9XQcfUit7kQkw=;
        b=riia59qcc0cQpXINkDNLStgnmv/95VnlG86qMLMOWsOC6J2f3POgXMdllI6p2YOwIW
         frVwwBvzxO5HICfRqE04MJgk+hdxxDjsS8AQLDN6r5cnWb8kAMsbSyfvtAI6PoRkkmx6
         Z1U7yNnr47jc8mXTieDX/7gJ108OSmafDwp5Kg3I7/PJhZIppW4FwVmgk2d+OmkLAQur
         Q6EUXlofGz2375qWDcViMtohrFcNwHsKWvSMQCFUNF70kAkstnoX8UfFlk7OnRxGlSCY
         ANeRCSqE4Ql6Cj4hx/tyyJTPa2IutfMB+3fQQLsnHC4fGlM/v+26jxInQydAo6OLF0MD
         AO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d7kc24UT0Ui3ma1mQirb3g1ID4GWXa9XQcfUit7kQkw=;
        b=sw8boRGrz8E8P8b6L8vyLw6PfrDuzs7AcC+It77lXF/ho9fTCBlFyZexkJ+63v/jYM
         929EdEm1v88FPg3wu+IhWENc/ZbYpjtKaak0XwyxbuL4bfYWol4j1LTwrS7DJ/cXpAX8
         IPtsFnIj7nJdixF8PRCvXrkHehASSluMFQ3EKFEfDIyfi8ljb6a0R/9mzA4ab1eKJ2zM
         eomJEOf4dcs3iC9CVdny4Bvbw48xBi5PAw1FfxGKcsSqXv4RHKwSTp2a1mNEHi9RTdZh
         cHaEFGbIrN1f1eX73tNEpTt+slxsA7iqh0pnaOeiqsB9N7Oub4B69XRLcLlD8/bG358E
         3vnQ==
X-Gm-Message-State: APjAAAWcgCS1ZBSU6/p8hsZp+GXp3nFPniMlbhI7w0LybUhGmMj9cazE
        76v3z1v1tjPSMfwD6JwXQIwsPOKOVTSbpNspu2Qxhrz7xrs=
X-Google-Smtp-Source: APXvYqxWZi4lUfIEh6D4yIIdP4OZZqI7XWtZ6Vxz6LrMCABfvh7TOEVKMH6djoJTvdzrMbkzbFkYc+lGJCn7FidzSew=
X-Received: by 2002:a37:3c9:: with SMTP id 192mr1116843qkd.37.1565056431753;
 Mon, 05 Aug 2019 18:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190730044326.1805-1-luaraneda@gmail.com> <20190730104746.GA1330@shell.armlinux.org.uk>
 <CAHbBuxoMBiq23Rkt7-jm42O4ePY=23ZsgNEVf3UJKQ2Dg+3fbg@mail.gmail.com> <26427757-9ed1-36fa-3e4d-7357703ec548@xilinx.com>
In-Reply-To: <26427757-9ed1-36fa-3e4d-7357703ec548@xilinx.com>
From:   Luis Araneda <luaraneda@gmail.com>
Date:   Mon, 5 Aug 2019 21:52:58 -0400
Message-ID: <CAHbBuxpNQnWwTe5U_4S42-BLK1j7+cGOde49KbYnxtE6eFCCPw@mail.gmail.com>
Subject: Re: [RFC PATCH] ARM: zynq: Use memcpy_toio instead of memcpy on smp bring-up
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thanks for the review.

On Mon, Aug 5, 2019 at 5:53 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> On 31. 07. 19 6:12, Luis Araneda wrote:
> > Hi Russell,
> >
> > Thanks for reviewing.
> >
> > On Tue, Jul 30, 2019 at 6:47 AM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> >>
> >> On Tue, Jul 30, 2019 at 12:43:26AM -0400, Luis Araneda wrote:
> >>> This fixes a kernel panic (read overflow) on memcpy when
> >>> FORTIFY_SOURCE is enabled.
> > [...]
> >>
> >> I'm not convinced that this is correct.  It looks like
> >> zynq_secondary_trampoline could be either ARM or Thumb code - there is
> >> no .arm directive before it.  If it's ARM code, then this is fine.  If
> >> Thumb code, then zynq_secondary_trampoline will be offset by one, and
> >> we will miss copying the first byte of code.
> >
> > You're right, I tested what happens if the zynq_secondary_trampoline
> > is ARM or Thumb by editing the file where it's defined, headsmp.S
> >
> > When the .arm directive is used, the CPU is brought-up correctly,
> > but if I use .thumb, I get the following message (no panic):
> >> CPU1: failed to come online
> >
> > This seems unrelated to solving the panic, as the message
> > even appears with memcpy and FORTIFY_SOURCE disabled.
> >
> > I could add the .arm directive to headsmp.S
> > Is that your expected solution?
> > Should that change be on a separate commit?
> >
> > I'd like to know Michal's opinion, as he wrote the code.
> >
>
> There are two things together. Thanks Russel to pointing to it.
> 1. How to support SMP in thumb2 mode?
> Adding .arm mode to headsmp.S which ensure that cpu starts in proper
> mode and correct code size is copied.
> And also point to secondary_startup_arm in zynq_boot_secondary to switch
> cpu from arm to thumb mode.
>
> 2. And the second is this patch to fix FORTIFY_SOURCE.
>
> Feel free to create the first patch too or I will do it myself.

I'll be sending the two patches as a series (I already tested that
they work), so they can be picked by the stable trees.

Thanks,
Luis Araneda.
