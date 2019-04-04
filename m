Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2321C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9035A20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REZetr+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfDDLOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:14:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40154 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfDDLOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:14:44 -0400
Received: by mail-io1-f66.google.com with SMTP id d201so1612077iof.7;
        Thu, 04 Apr 2019 04:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MdLNdGN9g35Q/VLDwMl8+nvpLgW30VBVUixts+QiA9g=;
        b=REZetr+YNPW+7XmLi9CoNAiM5cv3zcINTLzCSi9xmL6JuScV/Ph3nGDhzFU9But/IG
         xZnfk8tgV/yiMUOwRjv1582j9tR4xbJCzzSEMgMiHxV7Pdhe568z4BlhxmTD+1yd59bQ
         QR7eQphGxFCfS2KTAPXI3nCsA9JFyPl4RyGKwechubuuviHhceA6lfSU6CtCyYaqs1qs
         a4+cxdVXeqLijMfXpxZm04cKDW8N0H1e+eatPPURpX0Pwl1u+4aw17W1n7qh0hRyoZ5J
         H5PMYRnNY7vL2APYJ2QmyxzfB/zgWQs2lVIzAz/lPS1Lk7420kHSX1so31uCM1rV2fo7
         oRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MdLNdGN9g35Q/VLDwMl8+nvpLgW30VBVUixts+QiA9g=;
        b=AeESABUfBGBXf3xbXD5/rWbW3ONvo7Uf/72GBsUVusaUKbWC90eqJCdej3MeGwQ027
         xr29uvS8nW4VuCc/WK5BkaAW+T/A3SM79eulsVBBXApznQkXFbcARcAst1lZCY8rA63H
         YcXaiG1St2mEGjauj68lthVLBZ/btpX1it3G2cY7Q+l3O3a4U7wLTjOjMDLjMrJ3ThJL
         euXlS0jCwp7mmg5tjKu12xi5uT2/Y2t5AQOPg+Sm68QVWjDwdPrFjHH5JFpPYvNQ4sID
         4agWSWw4uwtwZRG1lnZwGeQ8GnbbeGo5eIpWsfyjDAc/Pr5GPWRwskV91/6lrtTasbI6
         19xw==
X-Gm-Message-State: APjAAAV6dDd14XeZkQKOZjxrzWV5JcJorJB75/n3iW3tqtQj+vB40l3D
        TniSgYNCoa951L15lYazfpqcHO6kwpHs2DdHl44=
X-Google-Smtp-Source: APXvYqy8Qnf9eBFT3Re/e0o/fvYL92wZCpvNTGipZ/TWLrOVhlZIMBUFZpdEkvpzQZvXrKfWeAmZPXq3YjLD4NpVXhs=
X-Received: by 2002:a6b:e61a:: with SMTP id g26mr3794244ioh.105.1554376483349;
 Thu, 04 Apr 2019 04:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190322133105.5945-1-brgl@bgdev.pl> <20190322133105.5945-2-brgl@bgdev.pl>
 <CAHCN7xJj_aA8XFR6=ZxO-WrfkJRY5fS6NgjHbeqpdfhUnn1apA@mail.gmail.com>
 <CAMpxmJVBTny7kzADSZHQXk_ZUjnRaNWu0Ly3WC8v+zPmR8Dizg@mail.gmail.com>
 <bb734e20-d2c7-73f4-e2c5-3b810ccf4c81@ti.com> <CAMRc=MdYhaED30Xu8oJiJD7F9z=SPu6u+1p32mQnX0tEL=iOiA@mail.gmail.com>
 <CAHCN7x+-GRBygMt9APi9sf19PQksfmXk9sOZUo-1YY40RhUmng@mail.gmail.com> <CAMRc=Md-XtFYP_c4afNDHdYDUV77tGpvau8AsG1KGwQ6Hm+FhQ@mail.gmail.com>
In-Reply-To: <CAMRc=Md-XtFYP_c4afNDHdYDUV77tGpvau8AsG1KGwQ6Hm+FhQ@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 4 Apr 2019 06:14:32 -0500
Message-ID: <CAHCN7x+kAPYgFJ9iZQTPm2Vypni4CgmWmBw96fgbQr0ch456bw@mail.gmail.com>
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

On Thu, Apr 4, 2019 at 5:01 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> =C5=9Br., 3 kwi 2019 o 17:49 Adam Ford <aford173@gmail.com> napisa=C5=82(=
a):
> >
> > On Wed, Apr 3, 2019 at 7:50 AM Bartosz Golaszewski <brgl@bgdev.pl> wrot=
e:
> > >
> > > =C5=9Br., 27 mar 2019 o 12:14 Sekhar Nori <nsekhar@ti.com> napisa=C5=
=82(a):
> > > >
> > > > Hi Bart,
> > > >
> > > > On 26/03/19 11:21 PM, Bartosz Golaszewski wrote:
> > > > > wt., 26 mar 2019 o 15:00 Adam Ford <aford173@gmail.com> napisa=C5=
=82(a):
> > > > >>
> > > > >> On Fri, Mar 22, 2019 at 8:31 AM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> > > > >>>
> > > > >>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > >>>
> > > > >>> The system_rev variable is never set on davinci and is always 0=
, so
> > > > >>> we're using the default max operating point of 300MHz. The cvdd=
 supply
> > > > >>> comes from the tps6507 pmic and the voltage can go all the way =
to 1.3V
> > > > >>> so the maximum supported rate should be 456MHz.
> > > > >>
> > > > >> My understanding is that only certain revisions of the silicon c=
an go
> > > > >> to 456MHz.   The L138's Datasheet lists both a 456 and 375 versi=
on.  I
> > > > >> cannot find a way to read a register to determine which version =
of the
> > > > >> silicon is available. Maybe Sekhar can confirm.
> > > > >>
> > > > >
> > > > > Commit 28bd2c341120 ("davinci: am18x/da850/omap-l138 evm: add sup=
port
> > > > > for higher speed grades") mentions the following:
> > > > >
> > > > > ---
> > > > > U-Boot on the EVM sets up ATAG_REVISION to inform the OS
> > > > > regarding the speed grade supported by the silicon. We use
> > > > > this information to pass on the speed grade information to
> > > > > the SoC code.
> > > > > ---
> > > > >
> > > > > Should the system_rev somehow reflect that revision? Any way I ca=
n check it?
> > > >
> > > > Can you check if the procedure in doc/README.davinci in U-Boot sour=
ces
> > > > still works?
> > > >
> > > > Environment Variables
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > The DA850 EVM allows the user to specify the maximum cpu clock allo=
wed by the
> > > > silicon, in Hz, via an environment variable "maxcpuclk".
> > > >
> > > > The maximum clock rate allowed depends on the silicon populated on =
the EVM.
> > > > Please make sure you understand the restrictions placed on this clo=
ck in the
> > > > device specific datasheet before setting up this variable. This inf=
ormation is
> > > > passed to the Linux kernel using the ATAG_REVISION atag.
> > > >
> > > > If "maxcpuclk" is not defined, the configuration CONFIG_DA850_EVM_M=
AX_CPU_CLK
> > > > is used to obtain this information.
> > > >
> > > > Thanks,
> > > > Sekhar
> > >
> > > Hi Sekhar,
> > >
> > > I built the current upstream u-boot and the get_board_rev() function
> > > for da850-evm doesn't seem to be called at all. For instance the
> > > lego-ev3 platform does this:
> > >
> > > ./lego/ev3/legoev3.c:108: board_rev =3D get_board_rev();
> > >
> > > but in davinci this function seems to be unused and I don't see it
> > > called from any other core u-boot component. I don't see any commit
> > > that would mention this function but there are a lot of commits
> > > removing get_board_rev() for other boards in git log. Is it possible
> > > it stopped being used at some point?
> >
> > Look for setup_revision_tag in arch/arm/lib/bootm.c
> >
> > The function appears to be called from there.
> >
> > There is a __weak reference in the header file which I think allows
> > people to remove them without breaking bootm.
> >
> > adam
> > >
> > > Bart
>
> Thanks, now verified that this still works in board file mode for
> da850-evm. Now the questions is - what about DT mode? Should we only
> enable the lowest possible mode (300MHz) and leave it to the user to
> enable any higher frequencies?

From everything that I can find in Logic PD's database, the standard
da850-evm kits and SOM's are 375MHz, so I think it's safe to run up to
that speed.  I would disable the speed options for 408 and 456, but
leave them shown for anyone who may have purchased a custom version
with the 456MHz variant which I can also see there are some.  At least
for the L138 and AM1808 SOM's, those customers who who they are, so
making it obvious how to enable it would be a good thing.

Just my two cents.

adam
>
> Bart
