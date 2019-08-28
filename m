Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8F3C3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 02:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F1020856
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 02:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmBYSj7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfH1CBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 22:01:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40820 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfH1CBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 22:01:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id c3so735667wrd.7;
        Tue, 27 Aug 2019 19:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+2IzGJMnVQs5Qv7zLsgC3sxUxxrgX8laKLcrZIr1izM=;
        b=mmBYSj7lod3CKerFV4vxbNtOkgfWGARH6A/UeiefUS8sJB2kB2wapXaaAX37Xmk4ps
         KuqmNLKxtk/TYkRZLSg1YSJ5nCfXwCypneONzSVLQ7vUaYOxAzgT9Wo0rA74yiWUGN79
         +MMQZ68VX5lhpnPnsinrmXBSz3O9LiQVxguCe6bcSn/FzKH5h5de8a6s1zabky1axGL5
         gHTFe6mmLYNvqi0StMFNjZHVHLQM7lfr9WLbPEbX/d5pdOGf61/HV0eDUrY794ORVEvA
         z/3PiHifOC6F9ZbFi8ckUmJ+zSeXhD7SAfFUIrniUxh+hlPuT7zxyW3Pqr+SwYFnv/Z+
         qoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+2IzGJMnVQs5Qv7zLsgC3sxUxxrgX8laKLcrZIr1izM=;
        b=OyITUNYVWuzfnnnTqMJlTdsqu4kyv8k2YN0NCk6rDnZIlq38e4KpiDpNNWdl76DreV
         3iPIB4FnFCbMsYhbluWH7BlxkQUumtCPATVvwqUsTW2JVMtPWltf2c4ufksAND43L5Mb
         fP8F/pMvX/rn/4OpSOiPUu7M9DsPuYvGZPoS0C8o7FgGKXyZ+gBiqyNQX8bZhKMTOJhJ
         7xDbG8Lilg15Eq6XP59zIJO0dXYVbQHOXfo9Hf4yHMxIajOaAsAWmjX1V3LROh5fbcuy
         /NxS2SgHNRWuJMKz7NoTMCRp1tZLSbUSDkrXc/DVoPbWVqFUOrvZP5XsGBNMRYGaXREr
         KDrg==
X-Gm-Message-State: APjAAAXPzBsSxU6MCd1SwNgCNM792o1xLXIiqYpZ+2w1ulEEwev7THtk
        Z8VIgeF+TqQMdbem6ClQVHkj718feJ9qJtBW1kuqnQ==
X-Google-Smtp-Source: APXvYqx49JoFKyK0pkGtf3HWx2PBZwNLAnsw6lY61TOZ57xqgQF5cyfmdwL/o1tk5wLRe1TsFfoQ37aVOEhaVTICNbw=
X-Received: by 2002:a5d:610d:: with SMTP id v13mr1153885wrt.249.1566957710209;
 Tue, 27 Aug 2019 19:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190826031830.30931-1-zhang.lyra@gmail.com> <CAPDyKFrpvtS9mHO7xN=cbrMHWN+ydPw08mF9oXtNW-TOMsP7Ew@mail.gmail.com>
In-Reply-To: <CAPDyKFrpvtS9mHO7xN=cbrMHWN+ydPw08mF9oXtNW-TOMsP7Ew@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 28 Aug 2019 10:01:14 +0800
Message-ID: <CAAfSe-txS9MObU+ygxk5NA-FneDL7ftrDruvuou9PYhvXY0E=w@mail.gmail.com>
Subject: Re: [PATCH 0/5] a few fixes for sprd's sd host controller
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019 at 21:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 26 Aug 2019 at 05:18, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> >
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > With this patch-set, both sd card and mmc can be setup.  This patch-set was
> > verified on Unisoc's Whale2 and another mobile phone platform SC9863A.
> >
> > Chunyan Zhang (5):
> >   mmc: sdhci-sprd: fixed incorrect clock divider
> >   mmc: sdhci: sprd: add get_ro hook function
> >   mmc: sdhci: sprd: add SDHCI_QUIRK2_PRESET_VALUE_BROKEN
> >   mms: sdhci: sprd: add SDHCI_QUIRK_BROKEN_CARD_DETECTION
> >   mmc: sdhci: sprd: clear the UHS-I modes read from registers
> >
> >  drivers/mmc/host/sdhci-sprd.c | 30 +++++++++++++++++++++++++-----
> >  1 file changed, 25 insertions(+), 5 deletions(-)
> >
> > --
> > 2.20.1
> >
>
> Looks like the entire series should be tagged for stable and having
> the same fixes tag as patch1. No?

Ok.

>
> Kind regards
> Uffe
