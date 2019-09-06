Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3DEC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9B121848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394987AbfIFP64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:58:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40156 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfIFP64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:58:56 -0400
Received: by mail-qt1-f193.google.com with SMTP id g4so7576689qtq.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 08:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7auWns/CTnLbzbVxcfsLhjzFCtCS8/hOZ420FTFpzQQ=;
        b=QYI7NjYNcT/dXMdB2Uzz6HsIs1qh+MxpFhIUJwwAVXjnZH0/uL3/lFMdpP8LrSeFQX
         ZGVJBv05ZCcwHx/knaBSD2fIdtqeYmzMouxG+nvgwFpXaFuWqo06KF308GzarzXk3UTR
         HGh0+rxK9lSxpqKkPhi/tZw+9ykO4ykF3tm007tlD2iEqizaGnUAka+XobYj+lN4gqSW
         Ip9Sjto7JHGjbF5rUgipAU8BYCiVwub0NaEkS6/oGdcGM4DK++XrDFJhCv0BNHafoxH2
         1qNtJvVwor1HkdMfSqHzhzLQYM9cUsnWdbBJyAcLqPNo5D5Rce6DegsZ9Xw7yOaHhrCR
         6ibw==
X-Gm-Message-State: APjAAAXyHw5a8D11MwtMeGdATOpBIIGhF969fQrAwtqe8+0jfmcMGXgr
        OuZTYatNyGcKB1rHQ7u1XTcIasM1o2NYghXAB3A=
X-Google-Smtp-Source: APXvYqwq+7xHbY917VB85V/NY5F1YjF8CbB5+I8o7pGnKxj+SP6ugGUW2leXjZAH+AchzM9rBGkpsGai69cSD+Ma62s=
X-Received: by 2002:ad4:4529:: with SMTP id l9mr1355846qvu.45.1567785534799;
 Fri, 06 Sep 2019 08:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190906151551.1192788-1-arnd@arndb.de> <20150686-f14c-389b-7345-699cee191116@ti.com>
In-Reply-To: <20150686-f14c-389b-7345-699cee191116@ti.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 Sep 2019 17:58:38 +0200
Message-ID: <CAK8P3a3ByLmeQirVNEumSMGhzs7XFRZujudE81WQhvhLEZprdw@mail.gmail.com>
Subject: Re: [PATCH] iommu: omap: mark pm functions __maybe_unused
To:     Suman Anna <s-anna@ti.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>,
        Tero Kristo <t-kristo@ti.com>, Will Deacon <will@kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 5:24 PM Suman Anna <s-anna@ti.com> wrote:
>
> Hi Arnd,
>
> On 9/6/19 10:15 AM, Arnd Bergmann wrote:
> > The runtime_pm functions are unused when CONFIG_PM is disabled:
> >
> > drivers/iommu/omap-iommu.c:1022:12: error: unused function 'omap_iommu_runtime_suspend' [-Werror,-Wunused-function]
> > static int omap_iommu_runtime_suspend(struct device *dev)
> > drivers/iommu/omap-iommu.c:1064:12: error: unused function 'omap_iommu_runtime_resume' [-Werror,-Wunused-function]
> > static int omap_iommu_runtime_resume(struct device *dev)
> >
> > Mark them as __maybe_unused to let gcc silently drop them
> > instead of warning.
>
> Curious, what defconfig is this? OMAP drivers won't be functional in
> general without pm_runtime, so CONFIG_PM is mandatory. But from just a
> CONFIG_PM option point of view, agree with the patch.

I did some randconfig builds for testing the stuff I merged for 5.4.
I don't think there are any defconfigs without CONFIG_PM.

      Arnd
