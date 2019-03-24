Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE63C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD180222C5
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnolyfo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbfCXM0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 08:26:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37662 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfCXM0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 08:26:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id q206so4553583pgq.4;
        Sun, 24 Mar 2019 05:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uKfu66mvQqRA/YcTG3vp2291hPAVZQDmUDzveKho0Hw=;
        b=hnolyfo29YXbVjM8VGNHhMnVcULIcdtKND8JAIUeNtRWNRJXSrxF1/AH25OTWN6WX4
         71t4U7NKkNTNtN2ObOORAmgfqY0n7VJNOYkpU5iklny8JxfOmPqmVfXTGJQt/Y1CL0Do
         bQ4NEuVbgC9d0brcM1NDjKMUQCzTy6BBneMcXtIyaCFp/4y+BSGTBBVRaq+awMVzmGbK
         zcufxpJ6uYe7jxpihJwHcBbKdk9oY1cx/RrFL0YYOdpm1Ia4nzev1gxa2swjXX4Vy/ev
         PUy8JM1TGio1Le4CppjqQl5DAsLj2wgg8SdtlXklpkRmm4I1ORfTG881ZC1esqzSl3we
         zTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKfu66mvQqRA/YcTG3vp2291hPAVZQDmUDzveKho0Hw=;
        b=UOfFlpQsr5fjmYjkySXCIxnbPucYbaH/uExJ0TgyDXIcSEYohcQX+7YEUPxcjlrAa8
         Bkzc+76fNCmry2UrpjWJ8C4JKWsZApcs+Witl7iCiz5sp5x4Kvh4cMvbQBZWRlCG1C6s
         H0qtXY0IQOI2iTIsxau5N1D/EHvdqLZrrqEkWnzEZG84UFRAka2vzCnO0yPkHb5EeukS
         azzsYWEMNnmRu+8zZVVAylq9bZ7nNkZJgdsyvzTAxLLIm53w3/CMfOFeAtnxaisef7gf
         PwF/UAkzHfpDMKcojNgMLmBkiOeEbz8Bcs3TLzwmmbiq5W/Z/G4fkOQs5UHwZrpydxtU
         2vgw==
X-Gm-Message-State: APjAAAU6xF8A7eKJ8mXGvA8MpwiKh8O1fYtgXh8Mk0Rjbcic9eNppRml
        VITQYcyk9YyK+zmO07TwASzbVJizd5a36IzFAts=
X-Google-Smtp-Source: APXvYqxbfX+RnFdm5sfTWfmLfjKsxJWXit6p9+/2Qdq+G02bAW7OypBpk7nZ4kDdvXJcIKO4pRj2b+ItAV8vamZcmW0=
X-Received: by 2002:aa7:914f:: with SMTP id 15mr18720988pfi.49.1553430397196;
 Sun, 24 Mar 2019 05:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190323225313.12325-1-pakki001@umn.edu> <CAHp75VdeB=jPaqY_VNDA7YeCiEdyVFJAmOmC4sDvZLBv-7KQ0w@mail.gmail.com>
In-Reply-To: <CAHp75VdeB=jPaqY_VNDA7YeCiEdyVFJAmOmC4sDvZLBv-7KQ0w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 24 Mar 2019 14:26:25 +0200
Message-ID: <CAHp75VfbPue803w06GdJwU_JYcFKEcShLpyGRMhOg9xi4ZwpAA@mail.gmail.com>
Subject: Re: [PATCH v2] tty: 8250: fix a missing check for pci_ioremap_bar
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 2:05 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sun, Mar 24, 2019 at 12:55 AM Aditya Pakki <pakki001@umn.edu> wrote:
> >
> > pci_ioremap_bar could fail. The fix captures the failure and
> > pass an error code upstream. This can avoid potential NULL
> > pointer dereferences in the future.
> >
>
> NAK.
> This will break non-DMA case.

> > @@ -172,12 +172,14 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)

Just to clarify, what you need is simple

void __iomem *regs;

chip->pdata = ... //move it here for better looking code
chip->irq = ...
chip->regs = pci_ioremap_bar(...);
if (!chip->regs)
  return;

and thank you for pointing to this.

-- 
With Best Regards,
Andy Shevchenko
