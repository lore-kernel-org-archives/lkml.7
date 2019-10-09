Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BB9ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39E120679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c9Atcn/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbfJIQCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:02:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42125 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731706AbfJIQCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:02:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id y23so3021331lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 09:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17Y7y039jET7/TQrdZoED93OrqqyMRwnQxJ9vtZBzO8=;
        b=c9Atcn/EI08Kf2cBMOvlLq7SNQ707PZ6EdVeCazR/Dm8zc5uaCAs3UNj/GYvUqYqzJ
         aMXdTfRdgQTYmaPwcj4QiAuKEHKcxMD9ezuazTOGBACs29dqmx3rbJGAvaRpsxX26MTQ
         fdzuLGgOcX6EDmt6y6XBhXYz14ayEhIMnEfqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17Y7y039jET7/TQrdZoED93OrqqyMRwnQxJ9vtZBzO8=;
        b=O/ADUof4HfZeySOGs2cZyCQewYG7kmxlVGBreN4Vh3PvzTrViLfkHAZEPGuQngVY+e
         rm8ApNQP21VHYD2+I4lN0pFCNO7xKekXo4k/vy7DRG8/uX8c50mceXjHp9m/+YOoetke
         6fwTd1kSHq+dQaTC9fSQs7yodOGDn3+eHs4twIMvUR6yxqiMajr4M2vZAZoay4ZN7rZc
         zXoS2rp/ZiJF2QkKMlgCWtRfkH3bY3ILMzWprD2gXWtVdJ2XlEr7HqEwjBVqBUV7Dzun
         f2qufQIr4umw7lpKXpGUmfX7J4ZGxU5zkpKNV/8hFOCfUmUc7lzh19GRGfW3pSJXph9F
         dsAg==
X-Gm-Message-State: APjAAAWawGTxHD+LmPdn4Wmmarss8qTpg4EUQB2cId9GMQzAaAff7VgR
        rCWueRg1zcGqy7MzlF4YgcoN3rf8iSM=
X-Google-Smtp-Source: APXvYqwnworJRsEBTzFkOkGx/Hj9CljvEwQ/b7Wc9X4koqeEUbW2CNV6wZbJvz/M1aQ0ghMBUU6XnA==
X-Received: by 2002:a2e:9bd2:: with SMTP id w18mr2861800ljj.140.1570636921923;
        Wed, 09 Oct 2019 09:02:01 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id t22sm588882lfg.91.2019.10.09.09.02.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 09:02:00 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id l21so3063615lje.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 09:02:00 -0700 (PDT)
X-Received: by 2002:a2e:a41a:: with SMTP id p26mr2740656ljn.15.1570636919621;
 Wed, 09 Oct 2019 09:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191008234505.222991-1-swboyd@chromium.org> <20191008235504.GN63675@minitux>
 <5d9d3ed4.1c69fb81.5a936.2b18@mx.google.com>
In-Reply-To: <5d9d3ed4.1c69fb81.5a936.2b18@mx.google.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 9 Oct 2019 09:01:22 -0700
X-Gmail-Original-Message-ID: <CAE=gft6SmWH3-Td-mZZPn-3=EzwexEdYTR00z5NCP-X1sspihA@mail.gmail.com>
Message-ID: <CAE=gft6SmWH3-Td-mZZPn-3=EzwexEdYTR00z5NCP-X1sspihA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Avoid regmap debugfs collisions in qcom llcc driver
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 6:58 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Bjorn Andersson (2019-10-08 16:55:04)
> > On Tue 08 Oct 16:45 PDT 2019, Stephen Boyd wrote:
> > >     @@ drivers/soc/qcom/llcc-slice.c
> > >
> > >       static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
> > >
> > >     --static const struct regmap_config llcc_regmap_config = {
> > >     +-static struct regmap_config llcc_regmap_config = {
> > >      -        .reg_bits = 32,
> > >      -        .reg_stride = 4,
> > >      -        .val_bits = 32,
> > >     @@ drivers/soc/qcom/llcc-slice.c: static struct regmap *qcom_llcc_init_mmio(struct
> > >       {
> > >               struct resource *res;
> > >               void __iomem *base;
> > >     -+        static struct regmap_config llcc_regmap_config = {
> > >     ++        struct regmap_config llcc_regmap_config = {
> >
> > Now that this isn't static I like the end result better. Not sure about
> > the need for splitting it in two patches, but if Evan is happy I'll take
> > it.
> >
>
> Well I split it into bug fix and micro-optimization so backport choices
> can be made. But yeah, I hope Evan is happy enough to provide a
> reviewed-by tag!

It's definitely better without the static local since it no longer has
the cognitive trap, but I still don't really get why we're messing
with the global v. local aspect of it. We're now inconsistent with
every other caller of this function, and for what exactly? We've
traded some data space for a call to memset() and some instructions. I
would have thought anecdotally that memory was the cheaper thing (ie
cpu speeds stopped increasing awhile ago, but memory is still getting
cheaper).

But either way it's correct, so really it's fine if you ignore me :)
-Evan
