Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A03C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 22:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D892206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 22:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="ThYJ/gBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfKUWXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:23:37 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35101 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfKUWXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 17:23:37 -0500
Received: by mail-oi1-f193.google.com with SMTP id n16so4758793oig.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 14:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1WUkXmE+MiLBrVjy4B14Wseiqa2/J/dX9t8VmDSDp64=;
        b=ThYJ/gBKeV4u3BKOxqKxK7Qmbr/lAmHU6LgncvysJBs2mc0IB2NNwYuC6kETlaTKyb
         ItheWDSajbgyt1JGeuVU461aI/dwTGkWcnLNuLVuMjG4Pnc84uFV3qNY+lhlaI9AfgO6
         wzhSt4WEF+DYi5Qs+uT0L8ZWNufyFukONUquBRXtG1ocU1yPx0wu7ye/zRKKoaziNM2M
         J2Z8/YVUYktSxtUu+CaZ9vmURSnpbLx7m9Q8VsK3L06Ylwgb48rHZ6hYhseS3Uc4sdra
         J83flzAdw9kImotFlrjOUXeujhsok7u8+ZlWvVrjwh+f+txo1B1XDfnG06ClI48rwppv
         0MMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1WUkXmE+MiLBrVjy4B14Wseiqa2/J/dX9t8VmDSDp64=;
        b=G3Y6Z6em7jYv0HyclPB8ZBEkBq1b5DF32vBWW84MzOyxg5aGcEvczYYpxrlPMR4wAW
         Uj8ySriAd4a9xs20nDLkhkh7H8K78jX1hPZiIbP75WUlerUxXFA0pRN0cVrQxdQ9VwQ5
         m2BHBfIridxG/UzZFVszTWrVfGGewvzK+jqn0ufDdC8VEZCJGr6U5M5bvX9c+bUq8U0+
         6j9bD1j2f2cy3HwQyglSjlRXlpreBKzotjtrI1ZEbjv9aIhhdoiSNpRTzvq92Z+5uP3n
         gzVbh0Uuh28beH/8GmSCQTKCX4HNqHZDKKqbu0YAUrNiKyX3Me4V7lCaEwJYpJftnYCf
         r7lg==
X-Gm-Message-State: APjAAAWcm46wygzQTGeJxqvBhy+8tR5lCrOEbK8qjEFS7S9aZ1XjJeJy
        7HiSwsYAe1QLsdxiqvfv3X64Ey7oE6ehfMKx3AjU0g==
X-Google-Smtp-Source: APXvYqw/ylCEFHwpFrhQRnB79Mk0ianRWLG+gfZEBptW/+u/ePkZJSw8APMwDIgnWSDOxbYEX3RbCNe/XkyICFYhZZk=
X-Received: by 2002:aca:cdc2:: with SMTP id d185mr9848394oig.35.1574375016076;
 Thu, 21 Nov 2019 14:23:36 -0800 (PST)
MIME-Version: 1.0
References: <68580738-4ecf-3bb7-5720-6e5b6dafcfeb@gmx.net> <e225fdf0-1044-cc3e-89f8-a569596e8bce@gmail.com>
 <52c0e259-9130-fa56-a036-dec95d4bd7d4@i2se.com> <51d2c5e6-7cd5-02a1-77c9-c96b27a04242@gmail.com>
 <902d2270-8081-b21d-e572-627f470beda7@gmx.net> <6487c38c-505e-99df-2451-c3da4cb02c94@gmail.com>
In-Reply-To: <6487c38c-505e-99df-2451-c3da4cb02c94@gmail.com>
From:   Eric Anholt <eric@anholt.net>
Date:   Thu, 21 Nov 2019 14:23:43 -0800
Message-ID: <CADaigPUZQV8VrnXJJxLESQd_6T9+kib015fSTQow9kZmx6szKw@mail.gmail.com>
Subject: Re: BCM2835 maintainership
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefan Wahren <wahrenst@gmx.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 10:03 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 11/21/19 9:51 AM, Stefan Wahren wrote:
> > Hi Florian,
> >
> > Am 21.11.19 um 18:42 schrieb Florian Fainelli:
> >> On 11/21/19 1:56 AM, Stefan Wahren wrote:
> >>> Am 20.11.19 um 22:54 schrieb Florian Fainelli:
> >>>> On 11/20/19 3:38 AM, Stefan Wahren wrote:
> >>>>> Hello,
> >>>>>
> >>>>> i need to announce that i step back as BCM2835 maintainer with the end
> >>>>> of this year. Maintainership was a fun ride, but at the end i noticed
> >>>>> that it needed more time for doing it properly than my available spare time.
> >>>>>
> >>>>> Nicolas Saenz Julienne is pleased be my successor and i wish him all the
> >>>>> best on his way.
> >>>>>
> >>>>> Finally i want to thank all the countless contributors and maintainers
> >>>>> for helping to integrate the Raspberry Pi into the mainline Kernel.
> >>>> Thanks Stefan, it has been great working with you on BCM2835
> >>>> maintenance. Do you mind making this statement official with a
> >>>> MAINTAINERS file update?
> >>> Sure, but first we should define the future BCM2835 git repo. I like to
> >>> hear Eric's opinion about that, since he didn't step back.
> >> How about we move out of github.com/Broadcom/stblinux as well as Eric's
> >> tree and get a group maintained repository on kernel.org, something like
> >> kernel/git/broadcom/linux.git?
> >>
> >> Then we can continue the existing processe whereby BCM2835 gets pulled
> >> into other Broadcom SoC pull requests.
> >>
> >> How does that sound?
> > this sounds like a good idea. In case the others agree too, can you take
> > care of it?
>
> Certainly, let me work through the process and I will let you know if
> that could work.

This all sounds fine to me, though since I'm not active any more we
should probably drop me out of MAINTAINERS while we're doing this
shuffle, too.
