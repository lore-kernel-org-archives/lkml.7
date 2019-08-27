Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3EAC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C962173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m3fjzn0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfH0Nrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:47:33 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36356 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfH0Nrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:47:32 -0400
Received: by mail-vs1-f66.google.com with SMTP id y16so13490169vsc.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 06:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IPQYrv4BEVdVy6rwgRtH4GhcTMxzFg15QggsylhIIPs=;
        b=m3fjzn0i0Q8f5nrO6+S3Ud8xp0u5R2TY61vWm5o63x1ntJ+n2TtXHHYBd0cWkbhNAg
         SsL/gDXdqe+eYw5ukeaZmqwS0mB5QEuoVwFIU4kOJR8hVh/szp55kFxNmT4Rh2rsMc1b
         fCtMgID+67KH0ZfkzfcjbHym6yv4meB8n/MO7NEz6NW2rS+b5gABuIWCzp4yRxZj+EDm
         EIaA65c60gQjERUfx6TEG6pmtpeSWKVZLUdWqLj5cunS+5B0aHPOYXczQLvSBMfreoGo
         2MEOhMCyHUfvaQPvggzyXejyChUpR3aRx2YbF37NhBSXWp18MnyySkCvN/iPLu1cxiPs
         GKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPQYrv4BEVdVy6rwgRtH4GhcTMxzFg15QggsylhIIPs=;
        b=A6q4Wg07hvRmh37IMw8ZFypjwFYPYB70hPrPZa5h69U0oMNSR2E2VylRedFB3tUmhv
         IujZmm6Ywh5Eb9v0jl3gGMBE0zVcPGfK5hQxOUEVr9u/rYOZzyH5WPTexcc214qHUb5w
         86gQNW9rEn06Ec42/qmXnFQ3exDSQzVwBiEnkj4a/XOgouNu5PvlzZ02S6EilayaixVc
         Huj2G0LWV94KKWKBD3mNITRv6UPR+22v0URpRi1gaNAFyaikoSG7XzcGwfxfjGxf7E9v
         KoZQ/wpzluB6KiROxVtF7CQcS8Xs5Ai2epFkXW0kIZlkODpggQcjngGx2WN5w1GCAEks
         0GLQ==
X-Gm-Message-State: APjAAAWd4iffdG5puN4J3eqYnt4gs2seLamRbCRJf+92wu1Yat1EjoeY
        bEwRc95u9fQ7e/XjkCzsNWbZgZh/XRU19H9jw02IIw==
X-Google-Smtp-Source: APXvYqxj3tnsaHq8DgViGsAoJo9rw8QwkeZH6ZUISBOvBLXIBdN1U29SC597LP2qvis6MuTgFBGdgzDX0uchvgR7WCg=
X-Received: by 2002:a67:fe4e:: with SMTP id m14mr14244540vsr.34.1566913651835;
 Tue, 27 Aug 2019 06:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190826031830.30931-1-zhang.lyra@gmail.com>
In-Reply-To: <20190826031830.30931-1-zhang.lyra@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Aug 2019 15:46:55 +0200
Message-ID: <CAPDyKFrpvtS9mHO7xN=cbrMHWN+ydPw08mF9oXtNW-TOMsP7Ew@mail.gmail.com>
Subject: Re: [PATCH 0/5] a few fixes for sprd's sd host controller
To:     Chunyan Zhang <zhang.lyra@gmail.com>
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

On Mon, 26 Aug 2019 at 05:18, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> With this patch-set, both sd card and mmc can be setup.  This patch-set was
> verified on Unisoc's Whale2 and another mobile phone platform SC9863A.
>
> Chunyan Zhang (5):
>   mmc: sdhci-sprd: fixed incorrect clock divider
>   mmc: sdhci: sprd: add get_ro hook function
>   mmc: sdhci: sprd: add SDHCI_QUIRK2_PRESET_VALUE_BROKEN
>   mms: sdhci: sprd: add SDHCI_QUIRK_BROKEN_CARD_DETECTION
>   mmc: sdhci: sprd: clear the UHS-I modes read from registers
>
>  drivers/mmc/host/sdhci-sprd.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>
> --
> 2.20.1
>

Looks like the entire series should be tagged for stable and having
the same fixes tag as patch1. No?

Kind regards
Uffe
