Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C750C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 03:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7932070D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 03:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBYI43Xl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfHEDrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 23:47:18 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32900 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfHEDrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 23:47:18 -0400
Received: by mail-io1-f68.google.com with SMTP id z3so23251240iog.0;
        Sun, 04 Aug 2019 20:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NdPVws2a6Dt8y874ce3RveAAw3TWAis9HKBWlXlAjvY=;
        b=OBYI43XlN/vZLhQ4I5ks3RXrtil8B+rCxmR8cwtZaowww5tDMI+Cxo2hbvdu8FHNLu
         BhH+YD93jhkSfrl75up6xGGlXrLaP9X1t6rqAOFVil8kLtPjDeioFzDMuFQajnlVdRXD
         vKwdzSfwVwamLFFT/rx74hSgj/FhZcXk1ZWlptrNGi2gPYAiI8KZnlTVm+14MmX9P5FS
         8gmxewjFS1UqvwscTQgGNwQ6bR3nt37XDvxJJmddgiuSkKN9VaXugpLVKDADofPFxIQ5
         7Buoec1ZXqzVleG6k7Fc8qYaTdsBGRUzReQ+BvUDuQso9RmWcnuP87fxacB0HDOaS4fH
         7G6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NdPVws2a6Dt8y874ce3RveAAw3TWAis9HKBWlXlAjvY=;
        b=QfI8NYeg4y/cjhevFWdUIet5tIckVy1PZIi1Kq0Hf/58phWCx2C52ig25prSKSU5XU
         8hxImQ7pQZ5k3ZvcOgx6/eeKX61RjoPKXZ0QQDqK7y/D3aL7uu21xmpwW5B0uzweuDiW
         ftuz9XpwdN3SH3ObEcx+TJU8zDaKeM/UscJ7Tq2xKFxFkuCioU9PoQd9FlmKDdjPVijd
         APLNtYFLgs1vbl7gTAoguBtlWfLTPKxt7mmSTX6g8/pCd1QyxgdDUu+peO/nr6FV337H
         9h9kR0XMrvgDza6JTXdVuZC+Y02OpyEcKAex3DhiCwePYZtX6uGlZy0VHvKvfDbb/uiw
         xcxA==
X-Gm-Message-State: APjAAAVbd0hbDRtY7AYDsGX9dCsYMBuAaSduLJ7P2YqXdQavC6GB/F7F
        7oZzdsaGUBdqmYV8a0JiY7x77mFh7TKEJyCdG8g=
X-Google-Smtp-Source: APXvYqxtnVLtg3Sb9+ZhAgKfKLHG6VNs+MEi642xPS4QqUS2THpCFZQ3F8/DSRihpUHBbfKShzmtrYIA9PT3Yz+Gpug=
X-Received: by 2002:a02:29ce:: with SMTP id p197mr19639555jap.139.1564976837286;
 Sun, 04 Aug 2019 20:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <1563873380-2003-1-git-send-email-gkulkarni@marvell.com> <CAKTKpr5kmG3k4b85Zf05Q9xXpxMNZJyzWN7RXqZdteYUdMkc6g@mail.gmail.com>
In-Reply-To: <CAKTKpr5kmG3k4b85Zf05Q9xXpxMNZJyzWN7RXqZdteYUdMkc6g@mail.gmail.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Mon, 5 Aug 2019 09:17:04 +0530
Message-ID: <CAKTKpr6QqvNQcm43res=3MtAYSsbj5NVwstfuQE3cdFjyo2eNQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add CCPI2 PMU support
To:     Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        "will@kernel.org" <will@kernel.org>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>,
        Jan Glauber <jglauber@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 4:24 PM Ganapatrao Kulkarni <gklkml16@gmail.com> wrote:
>
> Hi Will,
>
> Any comments to this patchset?

If no further comments, can it be queued please?
>
> On Tue, Jul 23, 2019 at 2:46 PM Ganapatrao Kulkarni
> <gkulkarni@marvell.com> wrote:
> >
> > Add Cavium Coherent Processor Interconnect (CCPI2) PMU
> > support in ThunderX2 Uncore driver.
> >
> > v3: Rebased to 5.3-rc1
> >
> > v2: Updated with review comments [1]
> >
> > [1] https://lkml.org/lkml/2019/6/14/965
> >
> > v1: initial patch
> >
> > Ganapatrao Kulkarni (2):
> >   Documentation: perf: Update documentation for ThunderX2 PMU uncore
> >     driver
> >   drivers/perf: Add CCPI2 PMU support in ThunderX2 UNCORE driver.
> >
> >  .../admin-guide/perf/thunderx2-pmu.rst        |  20 +-
> >  drivers/perf/thunderx2_pmu.c                  | 248 +++++++++++++++---
> >  2 files changed, 225 insertions(+), 43 deletions(-)
> >
> > --
> > 2.17.1
> >
>
> Thanks,
> Ganapat

Thanks,
Ganapat
