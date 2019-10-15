Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E9FC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F642089C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAFaP7ai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfJOJg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 05:36:27 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34894 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfJOJg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:36:27 -0400
Received: by mail-yb1-f195.google.com with SMTP id i6so1948624ybe.2;
        Tue, 15 Oct 2019 02:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iMrIAnZ82+rBIfraJTHtx7CjmsFJKaDtLSbFOzwjTXE=;
        b=BAFaP7aiq5gaPqOXng6TMHCql16AL4AFgl/Ejp3CUchGQwSKQfszAhzzzSYft1g+Au
         wXKXNKpIVW4gbP/z/8XCCYi0piqNvBZ5K87ZITK8rHCNUPgV71PzYzf/lzI04N3v04R0
         AFO739QhqbEbQldEQBXF5xF0eOgFgAvg/O8ZNzkWCczS2gfDS0DiheutwA59ZjDJh5DF
         Wax26kW6RPj7B/JCgYzZxl/Zyv4ga/kmXr++znOZLPWHwNnSmLhQPJl0M7/yXqfwkqGL
         xz/9M0V+2jCusklQLCnkwfSHFA2S18BsdfUwAQ34M6LX5XLdSaKy6dKQROBIRUQ0lued
         NoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iMrIAnZ82+rBIfraJTHtx7CjmsFJKaDtLSbFOzwjTXE=;
        b=dmBooSGQsk4AQ/SkiNuA5hNUchT8WoUlQKpACx547mqKjjsP2ob4u99JCwb2tKSBlu
         9LunFHEPH9nfOFl6fjc2PvfLnfQKSxTvrVQePHBVlmr6YTjrv64XwFPBn5pGcZbFv+je
         vD1+EaqlyWGjZDNhm5XCLF/D9ppYaNTrWXbJvcX0GQReHqITu88UmoVrXXx7pdGNaV4D
         3DYBmvZYL78VlYN2EH3SsxrzNNvekGsu1XDl4lQ4fAYSzx/bZgnlTumyD6i13GeEu7of
         bNQjAHLM33TY97b7GVNJcYeAdmiHWSaRz14KLBzwImkWkbSMsq83u5vBmWbhjTlH9cuZ
         A+gg==
X-Gm-Message-State: APjAAAXdlt5ZRPWrklC+pNTMYnRZmunUuMm9+DqanmzLfxP/x4qCZofR
        Zj0ZHvZlNRLmdfFTWsurqvaDiRoFYewgbsN0fS0blA==
X-Google-Smtp-Source: APXvYqzfBkWPsmhmg21XCDLG9UYkB1oSENrt2pQtpaUbfuRqWjAfwiBnCv2x3+R8EmW7I7Sm1/xRSnskoDfK7ldkr3M=
X-Received: by 2002:a25:7909:: with SMTP id u9mr24585102ybc.33.1571132185981;
 Tue, 15 Oct 2019 02:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190830125436.16959-1-ganapat@localhost.localdomain> <CAKTKpr43RyG0fTp3nOQP--F80JYD1aCHEU5TJNZCK8LPCLfswQ@mail.gmail.com>
In-Reply-To: <CAKTKpr43RyG0fTp3nOQP--F80JYD1aCHEU5TJNZCK8LPCLfswQ@mail.gmail.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Tue, 15 Oct 2019 15:06:14 +0530
Message-ID: <CAKTKpr7r2v8K6WLThvO8jBXjv7FiFbgFOG5McsW3FnqgVoRXqA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Add CCPI2 PMU support
To:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>,
        Jan Glauber <jglauber@marvell.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Sun, Oct 13, 2019 at 10:45 PM Ganapatrao Kulkarni <gklkml16@gmail.com> wrote:
>
> Hi Will, Mark,
>
> On Fri, Aug 30, 2019 at 6:24 PM ganapat <gklkml16@gmail.com> wrote:
> >
> > From: Ganapatrao Kulkarni <gkulkarni@marvell.com>
> >
> > Add Cavium Coherent Processor Interconnect (CCPI2) PMU
> > support in ThunderX2 Uncore driver.
> >
> > v5:
> >         Fixed minor bug of v4 (timer callback fuction
> >         was getting initialized to NULL for all PMUs).
> >
> > v4:
> >         Update with review comments [2].
> >         Changed Counter read to 2 word read since single dword read is misbhehaving(hw issue).
> >
> > [2] https://lkml.org/lkml/2019/7/23/231
> >
> > v3: Rebased to 5.3-rc1
> >
> > v2: Updated with review comments [1]
> >
> > [1] https://lkml.org/lkml/2019/6/14/965
> >
> > v1: initial patch
> >
> >
> > Ganapatrao Kulkarni (2):
> >   Documentation: perf: Update documentation for ThunderX2 PMU uncore
> >     driver
> >   drivers/perf: Add CCPI2 PMU support in ThunderX2 UNCORE driver.
> >
> >  .../admin-guide/perf/thunderx2-pmu.rst        |  20 +-
> >  drivers/perf/thunderx2_pmu.c                  | 267 +++++++++++++++---
> >  2 files changed, 245 insertions(+), 42 deletions(-)
> >
> > --
> > 2.17.1
> >
>
> Any comments on this patchset?

If no further comments, can you please queue it to next?

Thanks,
Ganapat

>
> Thanks,
> Ganapat
