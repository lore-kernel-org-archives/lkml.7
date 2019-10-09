Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCD4C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297F6206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XMrdMa5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfJISAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 14:00:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42744 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730546AbfJISAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 14:00:12 -0400
Received: by mail-lf1-f67.google.com with SMTP id c195so2324958lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 11:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YmeJKDAW2I1yruAY3lk0iKjTiIjTCk6xnz0bx6eLJkE=;
        b=XMrdMa5P0q1bpVT/YQRnvcSKOWRUN0f0eZRKmI7S0MK6/Uf2O8KITsEALxVxHVbbh8
         WSVOOol/gviCdzpPsJeQZ9KYe4hJRDsZlXKOFRkUAnyHfVoTY9JKZbRSz68oJQxnIngB
         IFJB85PFJahGQ+uE43aCf5Huxucwr1DomVkeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YmeJKDAW2I1yruAY3lk0iKjTiIjTCk6xnz0bx6eLJkE=;
        b=dfY7B46zolRZhrEBJpNl81ItkEEDng549sKCtYuZnTX194uyfP8UqE9LVR57agw6og
         3b3ELJ2Hxy49goTL+rErDtYOtQhqnE/gxiuVJzlvM6hoN8S+iGPS0Cyoq6Tgyo8o3msA
         8L1XSiHiNqEssPBzGxr8ws2MY2Ejlzu8rh83zhc/tlUpHTj0YbaUFbpcF3QO6suhwfou
         YupoZxspAra4sQ4TTG+iw2E7dZtkLHFdRErU9ge7m4TcpURmrA8knhKIuzmlpJH9hlKK
         fYioZYd0GIJGYjOU+9N54tvQA2vIpCNAEp/f6Z/tDrSPe1TJANIRtZyLYFRsHhoNO+BP
         3KNQ==
X-Gm-Message-State: APjAAAUzU5OKPgt/NtPKAbj2olFRT0uUjUZuV2xZoMUeseqbcp0JmmcY
        ZVjveMlOTmjD8DfEu0/Uc2eW0WPgMuU=
X-Google-Smtp-Source: APXvYqzQNEcQGtT6f8ztK1aLHuGjVSEHsYcnNETnj+XgS9m7g3cQhxlpe19FI2CkLOaTikFOhC/Sow==
X-Received: by 2002:ac2:4c99:: with SMTP id d25mr3102638lfl.112.1570644009117;
        Wed, 09 Oct 2019 11:00:09 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id h5sm661250ljf.83.2019.10.09.11.00.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 11:00:08 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id m13so3389811ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 11:00:08 -0700 (PDT)
X-Received: by 2002:a2e:584b:: with SMTP id x11mr3244996ljd.36.1570644007544;
 Wed, 09 Oct 2019 11:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191008234505.222991-1-swboyd@chromium.org> <20191008235504.GN63675@minitux>
 <5d9d3ed4.1c69fb81.5a936.2b18@mx.google.com> <CAE=gft6SmWH3-Td-mZZPn-3=EzwexEdYTR00z5NCP-X1sspihA@mail.gmail.com>
 <20191009174622.GN6390@tuxbook-pro>
In-Reply-To: <20191009174622.GN6390@tuxbook-pro>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 9 Oct 2019 10:59:30 -0700
X-Gmail-Original-Message-ID: <CAE=gft53-N+kWZKQO6YRAT0NBX_zrGYkqTUWOGrK2mT5Krf+3w@mail.gmail.com>
Message-ID: <CAE=gft53-N+kWZKQO6YRAT0NBX_zrGYkqTUWOGrK2mT5Krf+3w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Avoid regmap debugfs collisions in qcom llcc driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 10:46 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Wed 09 Oct 09:01 PDT 2019, Evan Green wrote:
>
> > On Tue, Oct 8, 2019 at 6:58 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Bjorn Andersson (2019-10-08 16:55:04)
> > > > On Tue 08 Oct 16:45 PDT 2019, Stephen Boyd wrote:
> > > > >     @@ drivers/soc/qcom/llcc-slice.c
> > > > >
> > > > >       static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
> > > > >
> > > > >     --static const struct regmap_config llcc_regmap_config = {
> > > > >     +-static struct regmap_config llcc_regmap_config = {
> > > > >      -        .reg_bits = 32,
> > > > >      -        .reg_stride = 4,
> > > > >      -        .val_bits = 32,
> > > > >     @@ drivers/soc/qcom/llcc-slice.c: static struct regmap *qcom_llcc_init_mmio(struct
> > > > >       {
> > > > >               struct resource *res;
> > > > >               void __iomem *base;
> > > > >     -+        static struct regmap_config llcc_regmap_config = {
> > > > >     ++        struct regmap_config llcc_regmap_config = {
> > > >
> > > > Now that this isn't static I like the end result better. Not sure about
> > > > the need for splitting it in two patches, but if Evan is happy I'll take
> > > > it.
> > > >
> > >
> > > Well I split it into bug fix and micro-optimization so backport choices
> > > can be made. But yeah, I hope Evan is happy enough to provide a
> > > reviewed-by tag!
> >
> > It's definitely better without the static local since it no longer has
> > the cognitive trap, but I still don't really get why we're messing
> > with the global v. local aspect of it. We're now inconsistent with
> > every other caller of this function, and for what exactly? We've
> > traded some data space for a call to memset() and some instructions. I
> > would have thought anecdotally that memory was the cheaper thing (ie
> > cpu speeds stopped increasing awhile ago, but memory is still getting
> > cheaper).
> >
>
> The reason for making the structure local is because it's being modified
> per instance, meaning it would still work as long as
> qcom_llcc_init_mmio() is never called concurrently for two llcc
> instances. But the correctness outweighs the performance degradation of
> setting it up on the stack in my view.
>

I hadn't considered the concurrency aspect of the change, since I had
anchored myself on the static local. I'm convinced. Might be worth
mentioning that in the commit message.

For the series:
Reviewed-by: Evan Green <evgreen@chromium.org>
