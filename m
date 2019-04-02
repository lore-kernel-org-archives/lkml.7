Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4E0C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBF020856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pA0wW09J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfDBHM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:12:59 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:43468 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfDBHM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:12:59 -0400
Received: by mail-oi1-f178.google.com with SMTP id t81so9571962oig.10;
        Tue, 02 Apr 2019 00:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PtHtrrEAGSaRk4ZD276zjB/V8XU0wRkcCQOwp7DHR4A=;
        b=pA0wW09JFXWMoEHm+Eynm9tKX9bfdpu/NzNOj1frGJ5jWhtejBPEKNtBzzrj8RBJdr
         SUndDezcgklNg9LamikTB9X0Jw+k9JXHIpnmqPzJ/eFv1zbawqYYBrxQsJT5jZq32z6X
         rtO3PA7GrU7pth4SHcWtQ+WJv8N9pfOMcKKMAk3hz1vS/BTt4BDmw68aeoxbelEtOZg2
         aNK224h5IEWecpsJdSTO1bqTitaC/1ec+QSYGJzdn37EmFsnkcnTZRhzTaAMs3EE2MdA
         ggs8gPMf3nxjN1kDELkY/qe/SnfsbS0DA4p+N81K75RhznXP8/8Yf7px6wmFAr3r8snb
         aeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PtHtrrEAGSaRk4ZD276zjB/V8XU0wRkcCQOwp7DHR4A=;
        b=ibVl5t6Hhw2PULCLmxN0JoaFLhUvKVAcZBF9DlYPUh4RlLmhahsrMvXTOWw4Nrc5zl
         YahoxB9S5KmZ7Uk4kmVGHVyEjiQr7xgOiulZf9K3cnG0J8rCAArYGiP0CJDmC5HPR/8S
         IJfJprXsxVMQE6cBW7/RaAVeTg7HiGK900kd6/pF0GCx85Xkp6iNWpPjUcZfSFDPBUyA
         uN5+aA7eKTHTcCLWpFHNcyCyrXooyGIltWXYcaG03DWxbOqDojOupMGIqc3aSVxVS4mq
         jonvc9PmBPdMd8ViYEKHB53M/kOE+Sc++IWyjR6MF7VWaN/qRC9JBaNFzU2IBMdqe1H6
         x8Xw==
X-Gm-Message-State: APjAAAVxFkeFKbMKc5SS+c9o8itGGGu83vrBM7iyrs+GvtzMKwJK0fpa
        UjAvLEQRQBXE3+tEzzlVYU6OFxadFIhCcRsN9YE=
X-Google-Smtp-Source: APXvYqzITGKIWejm+e6d8O7xCaoYdjc+KkXB1W28gu74sy6KZ7PNWKSk40D5XTmDg32gwUQ3Pv4QkfUJesLxImZPUaQ=
X-Received: by 2002:aca:5bd7:: with SMTP id p206mr16357188oib.128.1554189178712;
 Tue, 02 Apr 2019 00:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190401142529.xgkqmndinctiro3l@smtp.gmail.com> <20190401171304.00005954@huawei.com>
In-Reply-To: <20190401171304.00005954@huawei.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 2 Apr 2019 10:12:47 +0300
Message-ID: <CA+U=DsrFdfaQQkzFiEuA5yn=Vu0RGVirm+nBuMEaioZOrEhVzg@mail.gmail.com>
Subject: Re: Work on iio: stating: frequency: ad9832
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 7:13 PM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Mon, 1 Apr 2019 11:25:29 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
>
> > Hello,
> >
> > I was looking for some work on staging: iio: ad9832 and made some
> > observations while reading the driver.
> >
> > Apparently it had no devicetree documentation so I tried to elaborate
> > one.
> > It uses a platform_data variable to load external clock
> > frequency (I tried to make it use linux's clock framework).
> Good.
>
> > Some device attributes don't seem to be standardized on
> > Documentation/ABI/testing/sysfs-bus-iio and there's no specific ABI
> > for ad9832 nearby nor at staging/iio/Documentation. So maybe those
> > missing ABI could be documented.
> Beware. It's an old driver, so it may be that we actually want to change
> it's ABI rather than documenting what is there (I have haven't looked!)
>

This one can actually be coupled a bit with the AD9834 driver.
There's been some work on trying to move that one out of staging as well.

You can take a look at the patches sent for that driver.
They should be find-able on patchwork
https://patchwork.kernel.org/project/linux-iio/list/?series=&submitter=&state=*&q=ad9834&archive=both&delegate=

There are ideas worth borrowing from there.

The issue with the AD9834 [if i recall correctly] is that it doesn't
quite fit the classical IIO channel model.
Meaning, you can only activate the output of one channel at one moment
in time, and not both.

> > The device has to set some internal registers to operate correctly,
> > AD9832_FREQXHM and AD9832_PHASEXH, would it be feasible to set iio
> > chanels for this?
>
> What are they?  If they correspond to output channels in some sensible
> way then maybe...
>
> > I couldn't understand why checkpatch.pl gave errors on IIO_DEV_ATTR_*
> > macros. To me they seem to have no problem.
> > Also it has that platform_data to be moved to include/linux/iio. Is
> > there any special reason for it not being there already? Which are
> > the criterions a platform_data need to satisfy to be put there?
> A driver moving out of staging shouldn't have platform data. It needs
> to be converted over to more modern mechanisms.   We don't have a problem
> supporting platform data for devices that have old school device files
> already in tree, but that shouldn't be the case for a driver in staging.
>
> Hence we can clean it up and move forward with just DT bindings.
> >
> > I'm sending a patchset with some things I've already done.
> Cool. I'll look at those later in the week if no one beats me to them.
>
> >
> > Is there something else that could be done in this device driver?
> > Please, tell if I've forgotten something.
>
> I'll take a look, but it may be a little while before I do.
> Hopefully someone else gets there first!
>
> Jonathan
>
> >
> > Any advice is welcome.
> > Thanks,
> >
> > Marcelo
>
>
