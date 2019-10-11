Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82458ECE58E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0B82196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aUcLe5s9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfJKH1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 03:27:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38836 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfJKH1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 03:27:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id b20so8782956ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 00:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PXGQmsqTapiIi2DhUs9f3RGCuwoUA1FtXGFtbOssoUc=;
        b=aUcLe5s9fLYXfWdO1nU+IcaUqji/ba0XGgmPaXLGIqDAiKKfjNxU9dRwn51wVqsRk1
         X5hvDH19knyBjkXiN7DlZmt4cOzNly0AJpmQ5TcrqqUurlGTpHwWfQCiCX+JHuFeEdW+
         NUeWBOsIXokWt/pvgES23YR7C+RsSBZ6LJyyifkFpj1Y/wq9h7rrjb7LG4KDJ0x9qNZq
         VqMbmJHWVJrEcxeRkqmTnB8YLnzsq7SXs/79uFyA0apdMH9uUyMObiVBQ1a3jIL3sZv0
         Ya1MsLQ2+02db9YcVOhZROJPVFszzjIlWqNtQufqu7tMe69GbqHfZUtkyFuhUy1e0nL0
         ZTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PXGQmsqTapiIi2DhUs9f3RGCuwoUA1FtXGFtbOssoUc=;
        b=erqiRTGS7ZdDQQy41hQPiCsoyQ6Htpf+lJhW1aGi7MGyswWRd6/thxaEIdIjYr8WJK
         B8cz5xae9jHKANDI5ZxhtlVRiIhpXBa8z/Ej5MKj13ekRNtb4OBfWz2DCGVrMbQhuE7u
         wuheDmN6gDehgcbQyOOtEyJkLiUqV5+NXvVYTODJmM/xIEFkL2y4tPkM2IIyNHD2RCjk
         Sc5pKKd0RJg2i3cp3zi15lvL/cfD5R1Do+pwBi6rJuzY4AEzJ9nQ+UOQZSx3Wtqon6gk
         BtZesPw7HqqHwGfvPxh44V9DQUcY2mZuZwJ1C14tlBZ9tpNS3HPHKjNOLoswpdcc+YGl
         24ew==
X-Gm-Message-State: APjAAAVHd7kHNwtQ5H1s0fU+9ZwJEbkW2r5AgHqLlZ5i2tyIiDbcOW6O
        RaKcfdtrUNuYFL8NGrrhehVpTbPRph+9x1AI4c5A6Q==
X-Google-Smtp-Source: APXvYqy90+Zu82pTgrHNKhjBbi/20ah6ebAn7AIrhS5P1XlF61ZPkrJsPOICAZmOkSbGNMnO5pNgabigCro3sumPiYw=
X-Received: by 2002:a2e:9e0a:: with SMTP id e10mr8732217ljk.35.1570778826314;
 Fri, 11 Oct 2019 00:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191003000310.17099-1-chris.packham@alliedtelesis.co.nz>
 <20191003000310.17099-3-chris.packham@alliedtelesis.co.nz>
 <CAMuHMdV7syxxtnHEcgFBrf5DLo-M_71tZFWHHQ6kTO=2A1eVhg@mail.gmail.com> <86blutdlap.wl-maz@kernel.org>
In-Reply-To: <86blutdlap.wl-maz@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Oct 2019 09:26:54 +0200
Message-ID: <CACRpkdb7W1iitkRh=B-cw1JGPey76SrAgasvHkh8a81o3n9qGQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: iproc: use unique name for irq chip
To:     Marc Zyngier <maz@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Li Jin <li.jin@broadcom.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 10:14 AM Marc Zyngier <maz@kernel.org> wrote:
> On Mon, 07 Oct 2019 08:30:50 +0100,
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Chris,
> >
> > CC MarcZ
> >
> > On Thu, Oct 3, 2019 at 2:03 AM Chris Packham
> > <chris.packham@alliedtelesis.co.nz> wrote:
> > > Use the dev_name(dev) for the irqc->name so that we get unique names
> > > when we have multiple instances of this driver.
> > >
> > > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> >
> > A while ago, Marc Zyngier pointed out that the irq_chip .name field
> > should contain the device's class name, not the instance's name.
> > Hence the current code is correct?
>
> Thanks Geert for looping me in. The main reasons why I oppose this
> kind of "let's show as much information as we can in /proc/interrupts"
> are:
>
> - It clutters the output badly: the formatting of this file, which is
>   bad enough when you have a small number of CPUs, becomes unreadable
>   when you have a large number of them *and* stupidly long strings
>   that only make sense on a given platform.
>
> - Like it or not, /proc is ABI. We don't change things randomly there
>   without a good reason, and debugging isn't one of them.
>
> - Debug information belongs to debugfs, where we already have plenty
>   of stuff (see CONFIG_GENERIC_IRQ_DEBUGFS). I'd rather we improve
>   this infrastructure if needed, rather than add platform specific
>   hacks.
>
> </rant>

I have reverted the patch.

Yours,
Linus Walleij
