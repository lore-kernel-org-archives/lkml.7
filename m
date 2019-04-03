Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11B1C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9A520830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bXJJZJw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfDCMuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:50:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34606 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCMuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:50:35 -0400
Received: by mail-io1-f65.google.com with SMTP id n11so13950137ioh.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 05:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eBNtlZLQadO9S2XT/iY4Mfivp7agUEzDErrrS64Pf7w=;
        b=bXJJZJw7nZuNdH4El+6DCIKrwEq7uAW0H4I3tBJcuf9lX6zvLOMnhZqoCEbbujJSov
         x+C5C3C4fEkO6BRb6IAFK/+TrepqHk9DROAxYqZjd+VY5DVd9k2MCX1XKq6BoOTrEM/9
         zISXNd4uSY6yxiu6w92ri6ZyFt74yMiNoSMFPZPiKmcldciC77fsPIAVZA6shse5SJr1
         qnZI+Wkz4IkcOE3tLZ8h0Z38bxJLKbAZqf5Hhn0CUyj0Hi37nvhxluIE9Y3hEPzRDWRU
         /cyoWU88so6plfMyRVVHM8R8o6H7Ic7maFA6931nvHhJBXWkj5XAdjuQ1udszpD3xu9y
         QEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eBNtlZLQadO9S2XT/iY4Mfivp7agUEzDErrrS64Pf7w=;
        b=AO5+JxjYU+k4OBn0hGJtLeOLXmh54O0pQIEGV5smXENrDwVwz+7rE9Ifk6rtvXnra3
         0cMI/oRv32C7CCz5bvhuCQd+EBRnvbtghOfvIEVBRtBZsqpZdFKeSXEpguygSNgDJomI
         gp3Y4wTrC4MzRiJEhlNWdhDJjZvJqRU97MEWceQohKc9DdvygeIYWeC2YpUYIxwPHqKV
         t7aW3VykYtMtnxZp+8lL1WUAhAE3KraNtkC4QNohyZqwoGR+muiePH7g4Lnwc64Ht3xM
         elAJDa5AqJcu7T2u1MjAEl9JTDJT2GF1sfr7lVxJwJ1g7BpXsckvlq7FRYrcLoxe4S6M
         rrSg==
X-Gm-Message-State: APjAAAWF7PTZw97E5S2VhhUPCGvmXMdfSjr/5cmkHZVZCgnBrEZWxO25
        gmQRSxjFcKzD/WawC+OWpnh0F5X5YqwVz5MTPsfsGw==
X-Google-Smtp-Source: APXvYqwasBN0FWldjcStamNte3U0/QTjaZgi3ExR9SZtQRhuvXfKInDtTsGYfV23rUatDtxU+VFoqqxDDbvkPvNzthM=
X-Received: by 2002:a6b:3b43:: with SMTP id i64mr10868653ioa.121.1554295834459;
 Wed, 03 Apr 2019 05:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190322133105.5945-1-brgl@bgdev.pl> <20190322133105.5945-2-brgl@bgdev.pl>
 <CAHCN7xJj_aA8XFR6=ZxO-WrfkJRY5fS6NgjHbeqpdfhUnn1apA@mail.gmail.com>
 <CAMpxmJVBTny7kzADSZHQXk_ZUjnRaNWu0Ly3WC8v+zPmR8Dizg@mail.gmail.com> <bb734e20-d2c7-73f4-e2c5-3b810ccf4c81@ti.com>
In-Reply-To: <bb734e20-d2c7-73f4-e2c5-3b810ccf4c81@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 3 Apr 2019 14:50:23 +0200
Message-ID: <CAMRc=MdYhaED30Xu8oJiJD7F9z=SPu6u+1p32mQnX0tEL=iOiA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ARM: davinci: fix cpufreq registration on da850-evm
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 27 mar 2019 o 12:14 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> Hi Bart,
>
> On 26/03/19 11:21 PM, Bartosz Golaszewski wrote:
> > wt., 26 mar 2019 o 15:00 Adam Ford <aford173@gmail.com> napisa=C5=82(a)=
:
> >>
> >> On Fri, Mar 22, 2019 at 8:31 AM Bartosz Golaszewski <brgl@bgdev.pl> wr=
ote:
> >>>
> >>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>>
> >>> The system_rev variable is never set on davinci and is always 0, so
> >>> we're using the default max operating point of 300MHz. The cvdd suppl=
y
> >>> comes from the tps6507 pmic and the voltage can go all the way to 1.3=
V
> >>> so the maximum supported rate should be 456MHz.
> >>
> >> My understanding is that only certain revisions of the silicon can go
> >> to 456MHz.   The L138's Datasheet lists both a 456 and 375 version.  I
> >> cannot find a way to read a register to determine which version of the
> >> silicon is available. Maybe Sekhar can confirm.
> >>
> >
> > Commit 28bd2c341120 ("davinci: am18x/da850/omap-l138 evm: add support
> > for higher speed grades") mentions the following:
> >
> > ---
> > U-Boot on the EVM sets up ATAG_REVISION to inform the OS
> > regarding the speed grade supported by the silicon. We use
> > this information to pass on the speed grade information to
> > the SoC code.
> > ---
> >
> > Should the system_rev somehow reflect that revision? Any way I can chec=
k it?
>
> Can you check if the procedure in doc/README.davinci in U-Boot sources
> still works?
>
> Environment Variables
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The DA850 EVM allows the user to specify the maximum cpu clock allowed by=
 the
> silicon, in Hz, via an environment variable "maxcpuclk".
>
> The maximum clock rate allowed depends on the silicon populated on the EV=
M.
> Please make sure you understand the restrictions placed on this clock in =
the
> device specific datasheet before setting up this variable. This informati=
on is
> passed to the Linux kernel using the ATAG_REVISION atag.
>
> If "maxcpuclk" is not defined, the configuration CONFIG_DA850_EVM_MAX_CPU=
_CLK
> is used to obtain this information.
>
> Thanks,
> Sekhar

Hi Sekhar,

I built the current upstream u-boot and the get_board_rev() function
for da850-evm doesn't seem to be called at all. For instance the
lego-ev3 platform does this:

./lego/ev3/legoev3.c:108: board_rev =3D get_board_rev();

but in davinci this function seems to be unused and I don't see it
called from any other core u-boot component. I don't see any commit
that would mention this function but there are a lot of commits
removing get_board_rev() for other boards in git log. Is it possible
it stopped being used at some point?

Bart
