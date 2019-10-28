Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7092CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A527D217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyHrjkQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390223AbfJ1Ok1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:40:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40083 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729692AbfJ1Ok1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:40:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so9402764wmm.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 07:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jDefaEjucmPfmXoR6EuBuaPt+jroTYHe9nD2t6DWPcM=;
        b=GyHrjkQ9vfDcU5wXh/083wbH2nwmUq1lmiDg5F9BZ27v/NXI1oRLFMmzFLAuSBWcxl
         XI5/FBrUcyDMVVYKj1881yfZA6CrszdspyFZ5xex8ShXZ+dNrEwWmFhbY81SYSlEn+iX
         j0KtxvWOSRWPum+MygEV+FXMyNcQGVsXlUJ78l4nE68Cf/iPvqbftsFaWDzx4pPnoRfI
         vSdGX+vjEg1LeRJ1nY7GAlGCpGrkohzhWXH+1MoWM+AWwC3D9+AF5p3GjcB3ljwydS72
         sngthVWQc0n+v2F9ex8lSVcwrDvKtLzLVwoTeM5ozZ8sEXh4sV6W/boOT2qyfv70gvW8
         AoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDefaEjucmPfmXoR6EuBuaPt+jroTYHe9nD2t6DWPcM=;
        b=KRWsmjb7sXD+psXQwPHgAFy8IFB2jTD/o+4SyjEgEXKzzTHqoO2Oj9SGRouciJtcm9
         UYW7k3rZsMY8Re4i1x7X6oWEiJpEB4GYDGxQH5o6kEPDaJ98k/2asoenhQOMx8A2oVk4
         F35jrgCqInGbFZyDquTKdj2fRRsTNP3ybUkk+KHSUmN+rdyyxgDnfuMC5oZDHaKNmnYd
         zK8ADlpo69Y1hS3l9HlvvCLKEvdTYx7MM9WbJ+4l1eppiAiFUNNdMlTcNwcpOu+Xpmip
         o5Tl1o3RixWvm+XY87r+DIUTsUPzNTT1s0F1Vu4vC0So/faOdU0GeWEeOIcvUlGbWkM7
         t/Cw==
X-Gm-Message-State: APjAAAUPMJnSwocyMMQT+yJz2a/JoXV4kaDu5M/ehK3AJrWZthxsKpRP
        WFobXQF8ISW5+gk3NgYefLeUzJQIdEzybKuzFZs=
X-Google-Smtp-Source: APXvYqy58Usq1lGliMFgwEEdW88D9FmQUX6S4e8se9/pX5LCyyjc/WamJJyqnV2P2m8Mh9W1nLUcPZ3SGC+5SoTpig8=
X-Received: by 2002:a7b:cd91:: with SMTP id y17mr293848wmj.113.1572273624910;
 Mon, 28 Oct 2019 07:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191025075335.GC32742@smile.fi.intel.com> <20191025075540.GD32742@smile.fi.intel.com>
 <166c9855-910d-a70c-ba86-6aebe5f2346d@intel.com>
In-Reply-To: <166c9855-910d-a70c-ba86-6aebe5f2346d@intel.com>
From:   Andrey Zhizhikin <andrey.z@gmail.com>
Date:   Mon, 28 Oct 2019 15:40:19 +0100
Message-ID: <CAHtQpK5zBE_6HGMRcdVFj5-zoUrwaPjqrCB=2GUB9CtvE8FhbQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] add regulator driver and mfd cell for Intel Cherry
 Trail Whiskey Cove PMIC
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 1:42 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 25/10/19 10:55 AM, Andy Shevchenko wrote:
> > On Fri, Oct 25, 2019 at 10:53:35AM +0300, Andy Shevchenko wrote:
> >> On Thu, Oct 24, 2019 at 02:29:37PM +0000, Andrey Zhizhikin wrote:
> >>> This patchset introduces additional regulator driver for Intel Cherry
> >>> Trail Whiskey Cove PMIC. It also adds a cell in mfd driver for this
> >>> PMIC, which is used to instantiate this regulator.
> >>>
> >>> Regulator support for this PMIC was present in kernel release from Intel
> >>> targeted Aero platform, but was not entirely ported upstream and has
> >>> been omitted in mainline kernel releases. Consecutively, absence of
> >>> regulator caused the SD Card interface not to be provided with Vqcc
> >>> voltage source needed to operate with UHS-I cards.
> >>>
> >>> Following patches are addessing this issue and making sd card interface
> >>> to be fully operable with UHS-I cards. Regulator driver lists an ACPI id
> >>> of the SD Card interface in consumers and exposes optional "vqmmc"
> >>> voltage source, which mmc driver uses to switch signalling voltages
> >>> between 1.8V and 3.3V.
> >>>
> >>> This set contains of 2 patches: one is implementing the regulator driver
> >>> (based on a non upstreamed version from Intel Aero), and another patch
> >>> registers this driver as mfd cell in exising Whiskey Cove PMIC driver.
> >>
> >> Thank you.
> >> Hans, Cc'ed, has quite interested in these kind of patches.
> >> Am I right, Hans?
> >
> > Since it's about UHS/SD, Cc to Adrian as well.
> >
>
> My only concern is that the driver might conflict with ACPI methods trying
> to do the same thing, e.g. there is one ACPI SDHC instance from GPDWin DSDT
> with code like this:
>
[... cut ...]

That's a good point, and this is what I tried at first when I started
to work on this problem. In my case INTEL_DSM_V18_SWITCH (fn=0x3) got
executed in the mmc sub-system, but without the regulator or DSDT
support the card did not get the proper voltage.

The DSDT on Intel Aero reference platform looks different here.
Currently I don't have it on hands, but would be able to look it up
next week.

-- 
Regards,
Andrey.
