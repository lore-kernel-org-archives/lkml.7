Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E160C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 00:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4AD2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 00:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LU714YqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfHMABL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 20:01:11 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43228 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfHMABL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 20:01:11 -0400
Received: by mail-ot1-f65.google.com with SMTP id e12so21546493otp.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 17:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p0AOP8Yrv517oAy+z8eqLHkuVHbpsfARBIOBtFI/77c=;
        b=LU714YqX04T/rSPqkdb6Ol4GUQwirBOxZ+RaJpDqpnZ3De8cWn89fh2tpY9q2j8PjS
         jRScNjNowTA7zwXbksqAVnHRNngjRWV27t/Tj4ju3zjjj5DA3AzbEGoQuzed54XFTRdG
         A4BnUqtlaeB16i7acPoPc1tivM2osDm+fDmUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p0AOP8Yrv517oAy+z8eqLHkuVHbpsfARBIOBtFI/77c=;
        b=FbK3nAuTdgPkBlA82aGJzg106Im1fM0g0CoSuLenedRznZ0ONL+q1Q7kukwp0tNY4W
         kMScD6X5VatDL1AFxspbPWBoDbFx++w6GKQo8YhmzqU3jZj5DtaDWx0hvYe4IeNvhAKL
         Gvwx2W8HLlriFYIUpXQt8vvB0paCFBHWPUuLcRQJtdncfutBCRl9O9SCWHp1KryopFq+
         rfAawaH/0rW+Wwdu6MzUXNuQXfTI/sUd5uw3rcvSTmXt2p0NBMZSQfNkkf0nAYTdxdSo
         0KoBB914L6O056tOZkbR9UQli8QWjyNrzFB76NpBZ2btm74gmm0ET+xAqUxirlCKcp+K
         Jstg==
X-Gm-Message-State: APjAAAXAlws0ScbCeT468G7zc8HZTDtsKIIusR/8YyDC1zknePv+A8P0
        spz3dTqOc4WTAQvyI6mTwfwlgVeRIzA=
X-Google-Smtp-Source: APXvYqxLrQKUQf131R/bMB/Ei3eHAiUBInx9irHinNYpBsEf2jjDwzMNOQb/UQUyn5bReyzwDAM/Ew==
X-Received: by 2002:a9d:6f09:: with SMTP id n9mr29378047otq.335.1565654470360;
        Mon, 12 Aug 2019 17:01:10 -0700 (PDT)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com. [209.85.210.44])
        by smtp.gmail.com with ESMTPSA id s24sm12364969otd.81.2019.08.12.17.01.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 17:01:09 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id c34so25818080otb.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 17:01:09 -0700 (PDT)
X-Received: by 2002:a6b:cac2:: with SMTP id a185mr6294914iog.142.1565654468939;
 Mon, 12 Aug 2019 17:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190805124935.819068648@linuxfoundation.org> <20190805124936.105953796@linuxfoundation.org>
 <20190805144506.GB24265@amd>
In-Reply-To: <20190805144506.GB24265@amd>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 12 Aug 2019 17:01:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XwEOcgWope5=s2oPAUFXhc082kaaaBRGATM8gGsT-cAA@mail.gmail.com>
Message-ID: <CAD=FV=XwEOcgWope5=s2oPAUFXhc082kaaaBRGATM8gGsT-cAA@mail.gmail.com>
Subject: Re: [PATCH 4.19 03/74] ARM: dts: rockchip: Make rk3288-veyron-mickeys
 emmc work again
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 5, 2019 at 7:45 AM Pavel Machek <pavel@denx.de> wrote:
>
> On Mon 2019-08-05 15:02:16, Greg Kroah-Hartman wrote:
> > [ Upstream commit 99fa066710f75f18f4d9a5bc5f6a711968a581d5 ]
> >
> > When I try to boot rk3288-veyron-mickey I totally fail to make the
> > eMMC work.  Specifically my logs (on Chrome OS 4.19):
> >
> >   mmc_host mmc1: card is non-removable.
> >   mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
> >   mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
> >   mmc1: switch to bus width 8 failed
> >   mmc1: switch to bus width 4 failed
> >   mmc1: new high speed MMC card at address 0001
> >   mmcblk1: mmc1:0001 HAG2e 14.7 GiB
> >   mmcblk1boot0: mmc1:0001 HAG2e partition 1 4.00 MiB
> >   mmcblk1boot1: mmc1:0001 HAG2e partition 2 4.00 MiB
> >   mmcblk1rpmb: mmc1:0001 HAG2e partition 3 4.00 MiB, chardev (243:0)
> >   mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
> >   mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
> >   mmc1: switch to bus width 8 failed
> >   mmc1: switch to bus width 4 failed
> >   mmc1: tried to HW reset card, got error -110
> >   mmcblk1: error -110 requesting status
> >   mmcblk1: recovery failed!
> >   print_req_error: I/O error, dev mmcblk1, sector 0
> >   ...
> >
> > When I remove the '/delete-property/mmc-hs200-1_8v' then everything is
> > hunky dory.
> >
> > That line comes from the original submission of the mickey dts
> > upstream, so presumably at the time the HS200 was failing and just
> > enumerating things as a high speed device was fine.  ...or maybe it's
> > just that some mickey devices work when enumerating at "high speed",
> > just not mine?
> >
> > In any case, hs200 seems good now.  Let's turn it on.
>
> Ok, so this was tested in v4.19; good. But AFAICT it is queued to
> 4.14, too... which may not be good idea unless it was tested there...?
>
> Plus.. if this fixes stuff, that there are other configurations in the
> dts that do not work. Should they be disabled or something?

In general I don't have a good answer for you, but:

* The fact that nobody noticed that things were pretty broken here
implies that probably nobody is regularly testing mickey on upstream
and presumably nobody is testing mickey on stable, so likely it
doesn't matter a whole lot.

* The original mickey dts was from "Thu Dec 3 16:55:40 2015 +0100"
based upon kernel 4.4.  That means there were 10 kernel revisions
between it at 4.14.  If I had to guess without testing, I'd guess that
4.14 is still better off with this patch than without.

-Doug
