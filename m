Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0287C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E9F20645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inUiGlc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbfDBQ12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:27:28 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33917 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729007AbfDBQ12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:27:28 -0400
Received: by mail-qt1-f196.google.com with SMTP id k2so15996335qtm.1;
        Tue, 02 Apr 2019 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AmhQjPhlepSJBzpqVIJ4+Re3RyPtmtxRpUkaFMzFN0Q=;
        b=inUiGlc/Ka84mLsBRwIlQws/STMUM6NBYcnGHBPVQFV5jeuguag9ZAFUt2yF/TytnL
         dnUlGQfONm/70/YOoxRz484k+WMK36zzI3EJEDejvWvSj6qMUt8QzXiSXnzlW5XYO/gj
         b03SmOcbEKHDOzufhouFAG6lVPeJtHvk/qObDPbbVVB9UnNPqkYZZAnb3ldOgsy0TQgN
         87+K0n582HnZSVdtG9H5RdR6pWmD60151kycCU7ezyDGV/6sT4LjvPbDFVA2+omWQ8li
         0ud/KBJacFRzWKVI1HJ5zzZJ56FdBPWrk5Xt6l7a4fLwdZztal+ZnGT3rUNfP6++Cdja
         Q5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AmhQjPhlepSJBzpqVIJ4+Re3RyPtmtxRpUkaFMzFN0Q=;
        b=PlfNOZ26ST/jx4e/ePEh5I23tgVlklxf2HSZvxQeCof+Ff3/SDWSXpIHwMR3qosuBd
         S9hPrZjQX2zKOh3CNKM7exVhKxg6XhkBdal+zt2jxFxUvU8qYPRHkSWc/n/cng2FQjWn
         5fOvoVMYAAg6L/UiATdFpYYpgLr3Ar+AIpu2PPEDONUvJ3rRgnfZtet90RDCytUaJ/AB
         Vb8NZLHjjfK9uOrMZaCH5lBx+0Y4ZNK7QnfONXLOBTVtjKh0GoFQ+35m1Qx7qa2SUL+8
         vig/peIoMrkuf3BzLqOnUKtel1V/uZMpaoilXOr0HRzyKBHbFGH16UKTRmorjmfCF0w8
         hjbQ==
X-Gm-Message-State: APjAAAXc1AMUZJ7lwxM57AFP+RlhqKLPoAkuAQlulIF63mN9MinXKvj3
        5r74omB7oGj8Mc0s4XOqTrc=
X-Google-Smtp-Source: APXvYqyRAM9DAhlMTFC1vnynM41H6dYoYKHEGpak7tWJngH+xW3yOe2jTMHrsZaSDMPrs8iWt/OwtA==
X-Received: by 2002:ac8:544b:: with SMTP id d11mr48690683qtq.134.1554222447304;
        Tue, 02 Apr 2019 09:27:27 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id b9sm7358262qkk.41.2019.04.02.09.27.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Apr 2019 09:27:26 -0700 (PDT)
Date:   Tue, 2 Apr 2019 13:27:23 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-usp@googlegroups.com
Subject: Re: Work on iio: stating: frequency: ad9832
Message-ID: <20190402162723.d3x4wqr5oim7f6su@smtp.gmail.com>
References: <20190401142529.xgkqmndinctiro3l@smtp.gmail.com>
 <20190401171304.00005954@huawei.com>
 <CA+U=DsrFdfaQQkzFiEuA5yn=Vu0RGVirm+nBuMEaioZOrEhVzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+U=DsrFdfaQQkzFiEuA5yn=Vu0RGVirm+nBuMEaioZOrEhVzg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02, Alexandru Ardelean wrote:
> On Mon, Apr 1, 2019 at 7:13 PM Jonathan Cameron
> <jonathan.cameron@huawei.com> wrote:
> >
> > On Mon, 1 Apr 2019 11:25:29 -0300
> > Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> >
> > > Hello,
> > >
> > > I was looking for some work on staging: iio: ad9832 and made some
> > > observations while reading the driver.
> > >
> > > Apparently it had no devicetree documentation so I tried to elaborate
> > > one.
> > > It uses a platform_data variable to load external clock
> > > frequency (I tried to make it use linux's clock framework).
> > Good.
> >
> > > Some device attributes don't seem to be standardized on
> > > Documentation/ABI/testing/sysfs-bus-iio and there's no specific ABI
> > > for ad9832 nearby nor at staging/iio/Documentation. So maybe those
> > > missing ABI could be documented.
> > Beware. It's an old driver, so it may be that we actually want to change
> > it's ABI rather than documenting what is there (I have haven't looked!)
> >

OK, I'll take more time studying the device's datasheet to better     
understand the current ABI.

> 
> This one can actually be coupled a bit with the AD9834 driver.
> There's been some work on trying to move that one out of staging as well.
> 
> You can take a look at the patches sent for that driver.
> They should be find-able on patchwork
> https://patchwork.kernel.org/project/linux-iio/list/?series=&submitter=&state=*&q=ad9834&archive=both&delegate=
> 
> There are ideas worth borrowing from there.
> 
> The issue with the AD9834 [if i recall correctly] is that it doesn't
> quite fit the classical IIO channel model.
> Meaning, you can only activate the output of one channel at one moment
> in time, and not both.

OK, I'll have a look at it.

> 
> > > The device has to set some internal registers to operate correctly,
> > > AD9832_FREQXHM and AD9832_PHASEXH, would it be feasible to set iio
> > > chanels for this?
> >
> > What are they?  If they correspond to output channels in some sensible
> > way then maybe...
> >
> > > I couldn't understand why checkpatch.pl gave errors on IIO_DEV_ATTR_*
> > > macros. To me they seem to have no problem.
> > > Also it has that platform_data to be moved to include/linux/iio. Is
> > > there any special reason for it not being there already? Which are
> > > the criterions a platform_data need to satisfy to be put there?
> > A driver moving out of staging shouldn't have platform data. It needs
> > to be converted over to more modern mechanisms.   We don't have a problem
> > supporting platform data for devices that have old school device files
> > already in tree, but that shouldn't be the case for a driver in staging.
> >
> > Hence we can clean it up and move forward with just DT bindings.
> > >

Understood. Thanks for the explanation.

> > > I'm sending a patchset with some things I've already done.
> > Cool. I'll look at those later in the week if no one beats me to them.
> >
> > >
> > > Is there something else that could be done in this device driver?
> > > Please, tell if I've forgotten something.
> >
> > I'll take a look, but it may be a little while before I do.
> > Hopefully someone else gets there first!
> >
> > Jonathan
> >
> > >
> > > Any advice is welcome.
> > > Thanks,
> > >
> > > Marcelo
> >
> >

Thanks for the pieces of advice.

Marcelo
