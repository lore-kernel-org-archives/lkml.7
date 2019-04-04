Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EAFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615C3205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pnGGaQ5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfDDKBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:01:34 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54288 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfDDKBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:01:33 -0400
Received: by mail-it1-f196.google.com with SMTP id a190so2785371ite.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 03:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yQqy5633naz9ZVmb/XbHF2bm08Eks0wHR7zngF2kpNM=;
        b=pnGGaQ5yTsSx4DZD0C7N7Qwhg9JRBNb3VSF2CsRBzL7cVvh9KRZA/u7eiyv7j2ITMw
         ThIk9xXFr8HImlr/89wz8uVV2y49b+6lfQ1hqL/aaZ0DE8KzgFC8+BoP/IJDUN4zG+S2
         WxlpuHbMJ/FNKrPt88JGdJoBujgY4Cwu5nj315NxW9s2qGSf38b8dORWtBenvVj/F4dn
         rmmnYSnxTn+HcIt21F2vCG4BW4LUh3qRqkz9U3gFoXMpbKZRNDMvc0RQVhzSqS8mtq4K
         yBj3hMnyv8Fmwq1ytd7am28T8o9SzWRydR+omLlOg1A6cIamkmW7omF4Sc1um+SfU89Y
         rpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yQqy5633naz9ZVmb/XbHF2bm08Eks0wHR7zngF2kpNM=;
        b=k7YkBJDASd9GjQHMjXdEWxOZjiQBRzbop8/05I1un7E7gIRa7fJRFNVBs/t/BKqge/
         9rkaQSEm3jWZV/zSFLvN4wQPDzUkO5aAjmHT4kLHBciCfc0viWUMjorTCrwg9mPmajDI
         5gA+tV/+xfQKbUS0mwg8g2fLL+UHZQFH0jBYgYonnViCi+h0o7GUP9pyOsr0Il7ARNOc
         RhkMevZc/IooWzjDtZjogbImuTfUlxp6GUpZKeNm9tePRCvwlnx0tr+WKU2K7pWbDFRA
         CXyHtzZrJtlrZ9BKbdPREf2B+4IUc0GWOT+mlc83xLwlNGcuJO2pmyGSs7AFZNJJ3qrG
         4Gpw==
X-Gm-Message-State: APjAAAUTcfnqWNXck7aTE/EhlZmoPkJPCmBuO/++uQ5lOU4a9aUeF+TX
        XtEFPayINmrcXXef2ebI+Mo7Vw3tUrh6mujsfbsJdw==
X-Google-Smtp-Source: APXvYqwWkt5Xzdv/Itge6JN/eCPWxU4C2oM6z51lh5rczR2K41iPLdrhkVmdO8Bnvkr8eEfXSaW3Bj+Kc63DCmvmDjA=
X-Received: by 2002:a02:5bc2:: with SMTP id g185mr4010098jab.31.1554372092646;
 Thu, 04 Apr 2019 03:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190322133105.5945-1-brgl@bgdev.pl> <20190322133105.5945-2-brgl@bgdev.pl>
 <CAHCN7xJj_aA8XFR6=ZxO-WrfkJRY5fS6NgjHbeqpdfhUnn1apA@mail.gmail.com>
 <CAMpxmJVBTny7kzADSZHQXk_ZUjnRaNWu0Ly3WC8v+zPmR8Dizg@mail.gmail.com>
 <bb734e20-d2c7-73f4-e2c5-3b810ccf4c81@ti.com> <CAMRc=MdYhaED30Xu8oJiJD7F9z=SPu6u+1p32mQnX0tEL=iOiA@mail.gmail.com>
 <CAHCN7x+-GRBygMt9APi9sf19PQksfmXk9sOZUo-1YY40RhUmng@mail.gmail.com>
In-Reply-To: <CAHCN7x+-GRBygMt9APi9sf19PQksfmXk9sOZUo-1YY40RhUmng@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 4 Apr 2019 12:01:21 +0200
Message-ID: <CAMRc=Md-XtFYP_c4afNDHdYDUV77tGpvau8AsG1KGwQ6Hm+FhQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ARM: davinci: fix cpufreq registration on da850-evm
To:     Adam Ford <aford173@gmail.com>
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

=C5=9Br., 3 kwi 2019 o 17:49 Adam Ford <aford173@gmail.com> napisa=C5=82(a)=
:
>
> On Wed, Apr 3, 2019 at 7:50 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > =C5=9Br., 27 mar 2019 o 12:14 Sekhar Nori <nsekhar@ti.com> napisa=C5=82=
(a):
> > >
> > > Hi Bart,
> > >
> > > On 26/03/19 11:21 PM, Bartosz Golaszewski wrote:
> > > > wt., 26 mar 2019 o 15:00 Adam Ford <aford173@gmail.com> napisa=C5=
=82(a):
> > > >>
> > > >> On Fri, Mar 22, 2019 at 8:31 AM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> > > >>>
> > > >>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >>>
> > > >>> The system_rev variable is never set on davinci and is always 0, =
so
> > > >>> we're using the default max operating point of 300MHz. The cvdd s=
upply
> > > >>> comes from the tps6507 pmic and the voltage can go all the way to=
 1.3V
> > > >>> so the maximum supported rate should be 456MHz.
> > > >>
> > > >> My understanding is that only certain revisions of the silicon can=
 go
> > > >> to 456MHz.   The L138's Datasheet lists both a 456 and 375 version=
.  I
> > > >> cannot find a way to read a register to determine which version of=
 the
> > > >> silicon is available. Maybe Sekhar can confirm.
> > > >>
> > > >
> > > > Commit 28bd2c341120 ("davinci: am18x/da850/omap-l138 evm: add suppo=
rt
> > > > for higher speed grades") mentions the following:
> > > >
> > > > ---
> > > > U-Boot on the EVM sets up ATAG_REVISION to inform the OS
> > > > regarding the speed grade supported by the silicon. We use
> > > > this information to pass on the speed grade information to
> > > > the SoC code.
> > > > ---
> > > >
> > > > Should the system_rev somehow reflect that revision? Any way I can =
check it?
> > >
> > > Can you check if the procedure in doc/README.davinci in U-Boot source=
s
> > > still works?
> > >
> > > Environment Variables
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > The DA850 EVM allows the user to specify the maximum cpu clock allowe=
d by the
> > > silicon, in Hz, via an environment variable "maxcpuclk".
> > >
> > > The maximum clock rate allowed depends on the silicon populated on th=
e EVM.
> > > Please make sure you understand the restrictions placed on this clock=
 in the
> > > device specific datasheet before setting up this variable. This infor=
mation is
> > > passed to the Linux kernel using the ATAG_REVISION atag.
> > >
> > > If "maxcpuclk" is not defined, the configuration CONFIG_DA850_EVM_MAX=
_CPU_CLK
> > > is used to obtain this information.
> > >
> > > Thanks,
> > > Sekhar
> >
> > Hi Sekhar,
> >
> > I built the current upstream u-boot and the get_board_rev() function
> > for da850-evm doesn't seem to be called at all. For instance the
> > lego-ev3 platform does this:
> >
> > ./lego/ev3/legoev3.c:108: board_rev =3D get_board_rev();
> >
> > but in davinci this function seems to be unused and I don't see it
> > called from any other core u-boot component. I don't see any commit
> > that would mention this function but there are a lot of commits
> > removing get_board_rev() for other boards in git log. Is it possible
> > it stopped being used at some point?
>
> Look for setup_revision_tag in arch/arm/lib/bootm.c
>
> The function appears to be called from there.
>
> There is a __weak reference in the header file which I think allows
> people to remove them without breaking bootm.
>
> adam
> >
> > Bart

Thanks, now verified that this still works in board file mode for
da850-evm. Now the questions is - what about DT mode? Should we only
enable the lowest possible mode (300MHz) and leave it to the user to
enable any higher frequencies?

Bart
