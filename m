Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55BCC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDA320883
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9H34ToU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405799AbfFKUDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 16:03:33 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39977 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404557AbfFKUDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 16:03:33 -0400
Received: by mail-it1-f196.google.com with SMTP id q14so6854707itc.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 13:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RV2XZvKeHCt5ppTVA2xtZpaWuI8ggUAA1z+9Dn7I/C8=;
        b=B9H34ToUen3Bo1fx+8TmCQkb87rnYGQ7Eq9zOIQOakZliffIiP4mWASY+VN4UOjh/i
         Ew7jPQTWiPn3s/F1RF/sYQAsNqQgAjxIOgkAf2mGSAWcLKe3mTqNg0Qf7DEJPKb6c8FO
         NadVfE8tysk8WhnB+Y/Al8R8Pw9/KSf929Ii81Wh7AB4AVzK6H+Chb132JzJpmEgm0k0
         XRzr+jKmPCs+QV47JyA0iIs0WA8T5xM+BEzZOIFnuRun6ov0lW1BlmuqqEt4rHXfug83
         wvC/fx8J0BI/RW6Pi4X4Kp7DXwvcTxy63ctb3n8SczAYmi9cpNsm7qZjpJGesvcikdyG
         glyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RV2XZvKeHCt5ppTVA2xtZpaWuI8ggUAA1z+9Dn7I/C8=;
        b=oHLmZwOGv1cpTGnUObL6aHdwvlx8fg3wjdgzPWtWLwBDypOta6ClONXrydFmh2Jf3Q
         Tvf7onR1NYkNexH8ZKHjfJ8RT7x/sX2/mxI44Ky6/GG6UBC+gKpsokgRPIEgNLGiUj+K
         ZHxI24icBevPFw59B6xwG37JndY80Q+j1HMvVpowvh7b3ui1TrGh4hFvyFMBoDz/ZkCR
         Y0is/+OGfeq2ho/vHCkQDWE2dObYfErn1/NSzhArKwVKz1d5XZo+IFLjF4EhEhy8437o
         sdq4pbzMqE4t0iDhq665E0CId+LAahy+W9bzOl5v24p6NVRazvGZHtMx47UOLs4H8JM3
         bb5g==
X-Gm-Message-State: APjAAAXBhHtd+fuT5VSBuYirZV51Q705+GW1o83dZlpu1DPxwA0tlWc4
        Gin110rU1LNG8oHLw6JbOuBLAdpat06iljUElAE=
X-Google-Smtp-Source: APXvYqzaDmtnM2/u2YwkAPf2ZtKRjdox7EPRLhSxBsUqpcGpOApjHhQFiYXQZgTZ0VHuAOFEa3uRcW4BbVw4pmV93SM=
X-Received: by 2002:a02:7b2d:: with SMTP id q45mr48125056jac.127.1560283412476;
 Tue, 11 Jun 2019 13:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <1558024913-26502-1-git-send-email-kdasu.kdev@gmail.com>
 <1558024913-26502-2-git-send-email-kdasu.kdev@gmail.com> <CAFLxGvyZCpKthJevFHjjBQXo=j5f-FUip0MAsLy0HaoJzLZ2rA@mail.gmail.com>
 <CAC=U0a2UxMG2SuVCjv=TLzMs7Dg3yqJdxW6ft2tSQgEKj0C6ZQ@mail.gmail.com>
In-Reply-To: <CAC=U0a2UxMG2SuVCjv=TLzMs7Dg3yqJdxW6ft2tSQgEKj0C6ZQ@mail.gmail.com>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Tue, 11 Jun 2019 16:03:21 -0400
Message-ID: <CAC=U0a3co4Ju94pEp4exDYNz=G7YnEztjdZWSjOBKTL+C_7g8Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mtd: nand: raw: brcmnand: When oops in progress
 use pio and interrupt polling
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     MTD Maling List <linux-mtd@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        LKML <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,

You have any other review comments/concerns with this patch, if not
can you please sign off on it.

Thanks
Kamal

On Fri, May 17, 2019 at 7:56 AM Kamal Dasu <kdasu.kdev@gmail.com> wrote:
>
> On Fri, May 17, 2019 at 4:12 AM Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
> >
> > On Thu, May 16, 2019 at 6:42 PM Kamal Dasu <kdasu.kdev@gmail.com> wrote:
> > >
> > > If mtd_oops is in progress, switch to polling during NAND command
> > > completion instead of relying on DMA/interrupts so that the mtd_oops
> > > buffer can be completely written in the assigned NAND partition.
> >
> > With the new flag the semantics change, as soon a panic write happened,
> > the flag will stay and *all* future operates will take the polling/pio path.
> >
>
> Yes that is true.
>
> > IMHO this is fine since the kernel cannot recover from an oops.
> > But just to make sure we all get this. :-)
> > An alternative would be to block all further non-panic writes.
>
> Capturing the panic writes into an mtd device reliably is what the low
> level driver is trying to do.If there are non panic writes they will
> use pio and interrupt  polling  as well in this case.
>
> > --
> > Thanks,
> > //richard
>
> Thanks
> Kamal
