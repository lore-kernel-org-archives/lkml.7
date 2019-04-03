Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D17C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909F7206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iomVU4Oa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfDCPt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:49:59 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39564 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfDCPt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:49:59 -0400
Received: by mail-it1-f195.google.com with SMTP id 139so12032690ita.4;
        Wed, 03 Apr 2019 08:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NzY1LjUHGXOC4VbRaUK0sk/6i2+TQmErFx9YPp2U7JQ=;
        b=iomVU4OaxvF8q+R0lpHekC9FOOZGz5Bkmrrp8H8yPxok2SXbZzZcuRW2ITXaD1HcCD
         sI8YALvYVxBh6QUgxMvbdRb4ETvhOqYdyTzNrqAclNnnnUKimqYQZoqbIK3renTPJKFx
         WfdMd4uyeOXS+UnXBe9EKYT3R+niFR7/FEgtwkJ85qIa3Q/XDlPqr8ZPaijmI+fjng5P
         WT9YCXmlvHocQmnnfZ1nkTIHrgqZf4f335pAnuvJdJdHBooFbQUslQ4n7QoPpUW4ctmB
         4LFjjPNsAeHoytvgKoq3zvYbhpmMo/15TTVDtpH75NH+b9nXK/2q3urv7LSoaQzgDJ4r
         qKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NzY1LjUHGXOC4VbRaUK0sk/6i2+TQmErFx9YPp2U7JQ=;
        b=MkSqSrNGQF+nTeQIhShAY1bngbxTUSoevFMDW07r7CsNhbIOeTgtGyyaCrKZ7eiCo0
         jVH0eC7QH3ogdj56cxBoN/d13PgpmV9cLeRHpFQeIINrA4negohDwo4RbTswXHdLl6JD
         UQKtx3bsG5hBAqpEnF7wJwkSaf9GIrZdh1SQVNbfn+Tovh52UD6egscv6Hv8JjIulzXj
         o6TQzNzHQxfRGSVlrF44lRz7nXS4dI/1GzQEliMHrV2FDFdddOqyLZevdRliYunlzkbE
         2n2LwYM7qjMeZjWuHqaq8AR8g3eb3nzosCx60HOf0V2FqYC/Tv5paWsNPk2t+KuOOnpJ
         +V2g==
X-Gm-Message-State: APjAAAVmBrls75kz/TAFeWPT5Ko+aauUtulXihyrs0pqukm9sNlB8A1q
        fwThjES4LME7NFRSZeMd3nDcuc3Db7ikw8SAAlM=
X-Google-Smtp-Source: APXvYqyUlNRhU44L4VRmoL6P55EoPlXCM5fpIDlAcKhFCe8jkgKkKoMQAycItioseHDxHjnHpu6DOW6EaAYpn32MYN4=
X-Received: by 2002:a24:480e:: with SMTP id p14mr877517ita.61.1554306597901;
 Wed, 03 Apr 2019 08:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190322133105.5945-1-brgl@bgdev.pl> <20190322133105.5945-2-brgl@bgdev.pl>
 <CAHCN7xJj_aA8XFR6=ZxO-WrfkJRY5fS6NgjHbeqpdfhUnn1apA@mail.gmail.com>
 <CAMpxmJVBTny7kzADSZHQXk_ZUjnRaNWu0Ly3WC8v+zPmR8Dizg@mail.gmail.com>
 <bb734e20-d2c7-73f4-e2c5-3b810ccf4c81@ti.com> <CAMRc=MdYhaED30Xu8oJiJD7F9z=SPu6u+1p32mQnX0tEL=iOiA@mail.gmail.com>
In-Reply-To: <CAMRc=MdYhaED30Xu8oJiJD7F9z=SPu6u+1p32mQnX0tEL=iOiA@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 3 Apr 2019 10:49:46 -0500
Message-ID: <CAHCN7x+-GRBygMt9APi9sf19PQksfmXk9sOZUo-1YY40RhUmng@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ARM: davinci: fix cpufreq registration on da850-evm
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
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

On Wed, Apr 3, 2019 at 7:50 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> =C5=9Br., 27 mar 2019 o 12:14 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a=
):
> >
> > Hi Bart,
> >
> > On 26/03/19 11:21 PM, Bartosz Golaszewski wrote:
> > > wt., 26 mar 2019 o 15:00 Adam Ford <aford173@gmail.com> napisa=C5=82(=
a):
> > >>
> > >> On Fri, Mar 22, 2019 at 8:31 AM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
> > >>>
> > >>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >>>
> > >>> The system_rev variable is never set on davinci and is always 0, so
> > >>> we're using the default max operating point of 300MHz. The cvdd sup=
ply
> > >>> comes from the tps6507 pmic and the voltage can go all the way to 1=
.3V
> > >>> so the maximum supported rate should be 456MHz.
> > >>
> > >> My understanding is that only certain revisions of the silicon can g=
o
> > >> to 456MHz.   The L138's Datasheet lists both a 456 and 375 version. =
 I
> > >> cannot find a way to read a register to determine which version of t=
he
> > >> silicon is available. Maybe Sekhar can confirm.
> > >>
> > >
> > > Commit 28bd2c341120 ("davinci: am18x/da850/omap-l138 evm: add support
> > > for higher speed grades") mentions the following:
> > >
> > > ---
> > > U-Boot on the EVM sets up ATAG_REVISION to inform the OS
> > > regarding the speed grade supported by the silicon. We use
> > > this information to pass on the speed grade information to
> > > the SoC code.
> > > ---
> > >
> > > Should the system_rev somehow reflect that revision? Any way I can ch=
eck it?
> >
> > Can you check if the procedure in doc/README.davinci in U-Boot sources
> > still works?
> >
> > Environment Variables
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > The DA850 EVM allows the user to specify the maximum cpu clock allowed =
by the
> > silicon, in Hz, via an environment variable "maxcpuclk".
> >
> > The maximum clock rate allowed depends on the silicon populated on the =
EVM.
> > Please make sure you understand the restrictions placed on this clock i=
n the
> > device specific datasheet before setting up this variable. This informa=
tion is
> > passed to the Linux kernel using the ATAG_REVISION atag.
> >
> > If "maxcpuclk" is not defined, the configuration CONFIG_DA850_EVM_MAX_C=
PU_CLK
> > is used to obtain this information.
> >
> > Thanks,
> > Sekhar
>
> Hi Sekhar,
>
> I built the current upstream u-boot and the get_board_rev() function
> for da850-evm doesn't seem to be called at all. For instance the
> lego-ev3 platform does this:
>
> ./lego/ev3/legoev3.c:108: board_rev =3D get_board_rev();
>
> but in davinci this function seems to be unused and I don't see it
> called from any other core u-boot component. I don't see any commit
> that would mention this function but there are a lot of commits
> removing get_board_rev() for other boards in git log. Is it possible
> it stopped being used at some point?

Look for setup_revision_tag in arch/arm/lib/bootm.c

The function appears to be called from there.

There is a __weak reference in the header file which I think allows
people to remove them without breaking bootm.

adam
>
> Bart
