Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483B2CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E91720873
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh0qVbm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390585AbfJ1PB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:01:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36545 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfJ1PB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:01:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id w18so10270411wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 08:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4cgrS1AWNs6QSLnc6iFA7RZ9gvANskUkxBGIRiV49/k=;
        b=Kh0qVbm8NeJDbEzK9gq/qzjHiM4mbbhlIRCHyXpmrd1S1xnMaDlzCv3yi7lx6w13y8
         Gbwq/UTwddHrRAArtRz1OvyKCr+wFx+mvRhVXDVqxZr3SDAwEtPBQ+FwSBWymIpXSSHm
         Q+O1KW6m1zuyqsQgOYaZLZHrX4vGxoopr5SYPjSrHFa10iPmFB8ag9/c/mJn4sZG2DU+
         nvMuRVYGgoB9KpqEeGqZjprx8ZK/nb0ntSuvsGhsuZnzvnEEypf1Aw9SOYUlvseT2FrI
         zBsoyXHImtFWr4glONevuqj8mKQhE0Uc7mC3N3lJNCxSLhBcBXzQHw3P5SeZEqO+BpX0
         gnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4cgrS1AWNs6QSLnc6iFA7RZ9gvANskUkxBGIRiV49/k=;
        b=kyOog3OtjObEF4QE7m1OPSpuxez5/IkvLyYK+U4QXzMWd26frZA99OMFzemj30zTz/
         QNh4kQ+TWejIwg0Tcg+GuXDppWKV67a6HVFFd75A06rYCJryMYFTn968tDJ6G3Is8v0t
         RBOY7RQZhqBCUQ/Awgv0tlOPlTmkwVkt1AtPNQfVagAsgWMTCG84J29OAMjSQ1b+X8bJ
         ngI1/ODWs04v2L1ooXoTT2J3rXITDiwiLIemMBz5Cj6vXemC0cuNzmM7wV1YuLcAEak3
         sthamSORuAz7q0ZwI5gcDlpbLka+CwUS24gnbM+8ZHWKwATxIJuS3Bj+4nUz7knbuHI5
         jxpg==
X-Gm-Message-State: APjAAAUPa799B/l0zGGSd8QoQZ8YLi9clhp9XozKgPmGjWxsqVtj4ji/
        esmaGFnJjigo6H0dX72FTUpMmkprEBv46mpXm9g=
X-Google-Smtp-Source: APXvYqweKf7UQ3IeMh9OnDPUJNB8ESDigzRiKLFYQWrDV0mbCs2KXGkDYwI8PVap2KhduzwnNgARxaGRrwNXCKH6AEQ=
X-Received: by 2002:a5d:614a:: with SMTP id y10mr14979812wrt.164.1572274915444;
 Mon, 28 Oct 2019 08:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191025075335.GC32742@smile.fi.intel.com> <20191025075540.GD32742@smile.fi.intel.com>
 <166c9855-910d-a70c-ba86-6aebe5f2346d@intel.com> <20191028124554.GF5015@sirena.co.uk>
 <c5faf16d-892e-b36e-b448-9c59c2051b9e@redhat.com>
In-Reply-To: <c5faf16d-892e-b36e-b448-9c59c2051b9e@redhat.com>
From:   Andrey Zhizhikin <andrey.z@gmail.com>
Date:   Mon, 28 Oct 2019 16:01:50 +0100
Message-ID: <CAHtQpK5ocb8mqnf2dwcT7hQ9f8rQLtkHJsPppDWgfRPitJk6_Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] add regulator driver and mfd cell for Intel Cherry
 Trail Whiskey Cove PMIC
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lgirdwood@gmail.com, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Mon, Oct 28, 2019 at 2:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 28-10-2019 13:45, Mark Brown wrote:
> > On Mon, Oct 28, 2019 at 02:41:46PM +0200, Adrian Hunter wrote:
> >> On 25/10/19 10:55 AM, Andy Shevchenko wrote:
> >
> >>> Since it's about UHS/SD, Cc to Adrian as well.
> >
> >> My only concern is that the driver might conflict with ACPI methods trying
> >> to do the same thing, e.g. there is one ACPI SDHC instance from GPDWin DSDT
> >> with code like this:
>
> Oh, right that is a very good point.
>
> > That's certainly what's idiomatic for ACPI (though machine specific
> > quirks are too!).  The safe thing to do would be to only register the
> > supply on systems where we know there's no ACPI method.
>
> Right, so as I mentioned before Andrey told me about the evaluation
> board he is using I was aware of only 3 Cherry Trail devices using
> the Whiskey Cove PMIC. The GPD win, the GPD pocket and the Lenovo
> Yoga book. I've checked the DSDT of all 3 and all 3 of them offer
> voltage control through the Intel _DSM method for voltage control.
>
> I've also actually tested this on the GPD win and 1.8V signalling
> works fine there without needing Andrey's patch.

Thanks a lot for checking this one out! At least this proves now that
the only platform affected is in fact Intel Aero board, and the patch
as it is might not be necessary to accommodate for all CHT-based
products with Whiskey Cove.

>
> So it seems that Andrey's patch should only be active on his
> dev-board, as actual production hardware ships with the _DSM method.
>
> I believe that the best solution is for the Whiskey Cove MFD driver:
> drivers/mfd/intel_soc_pmic_chtwc.c
>
> To only register the new cell on Andrey's evaluation board model
> (based in a DMI match I guess). Another option would be to do
> the DMI check in the regulator driver, but that would mean
> udev will needlessly modprobe the regulator driver on production
> hardware, so doing it in the MFD driver and not registering the cell
> seems best,

I tend to lean to a solution to perform a DMI check in MFD rather than
in the regulator driver, since this would keep the regulator
more-or-less agnostic to the where it is running on.

Or maybe it would even make more sense to create a board-specific hook
(like it was suggested for vqmmc voltage and sdmmc ACPI d of
consumer), and then only register a cell for Aero match? This would
actually keep the regulator consumer and mfd cell together and would
not allow the device-specific code to leak into generic driver
implementation. In this case I'd go with mfd_add_cell() if I get a DMI
match and register a vqmmc consumer in there.

In that case, can you please tell me what you think about it and if
the drivers/acpi/acpi_lpss.c would still be an appropriate location to
put this code to?

Thanks a lot!

>
> Regards,
>
> Hans
>


--
Regards,
Andrey.
