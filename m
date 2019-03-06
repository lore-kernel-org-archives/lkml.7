Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D3FC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E34B2075B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fCP/wRgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfCFBfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 20:35:37 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:56019 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfCFBfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 20:35:37 -0500
Received: by mail-it1-f194.google.com with SMTP id z131so7092275itf.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 17:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nnH5gTz+dmOUwUqdWQFZb+nIuHdSODZLbf2vioXCAnk=;
        b=fCP/wRgIYLeiTmFflgsjdwwp0QsBmy7GKbkTMNUOTJN3bUEiQK5DVFEB7vr0vLRi3f
         +FA4NcDElVBKw69oVPwkI9Q8bCo8TQHlIw2YfWd4UxOAm1MHrBA4B54FXVURqogfRZY4
         M50OogYNM13dMbHJZnx4IH69KvHbBup6d/KoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nnH5gTz+dmOUwUqdWQFZb+nIuHdSODZLbf2vioXCAnk=;
        b=WkrLfAUr6qtZgOZ5URNXAojoXUOjcuU8XJf/pz5DEIvsxW+kZEsoY7MDmUFNkZoL+l
         5YkwNtJJI3nMZWb2N8DF2qwUCyjLl86VVCADsvertnMPxbbksAkB5BQWMFVuBjNo5PoE
         rCRJdGN5g0KciTLbzF3B30HqPy6QFkdskEXfqqia6EZtUKr3NhMxrZEIkSzWGZD4WZIF
         LF98/Mnd6d05UCFK8csJ6CQER+8u9yoqYYVD+rkgnuv+Rj5B3FZgiKkqrbWIf6ERAL/m
         yTSjbBBlHNnmx7faxRa55gsONcvUdAvqY3vsAwFr9COtp+T4mr80DcwDOzXxdic1nkKg
         IM4w==
X-Gm-Message-State: APjAAAUfLHok/+aRUF7nMQyN+1NnNFXIwUHLkcfoht3TTNPH2PYOiyzh
        5xsjj8D+V4mf43cL4ml8ZoUQH22W8x639c4RfxKf+GTH
X-Google-Smtp-Source: APXvYqxej0lhInzne5NXHvBkXSEhPEAZJNAeSRcEpKwOs9nJoEQyJXn9c82lVv/8xPPEFiqnHi+itxduPEsOPHOWRTY=
X-Received: by 2002:a24:38c:: with SMTP id e134mr764476ite.24.1551836136101;
 Tue, 05 Mar 2019 17:35:36 -0800 (PST)
MIME-Version: 1.0
References: <20190305044936.22267-1-dbasehore@chromium.org>
 <20190305044936.22267-2-dbasehore@chromium.org> <155181177527.20095.15680753964583935841@swboyd.mtv.corp.google.com>
In-Reply-To: <155181177527.20095.15680753964583935841@swboyd.mtv.corp.google.com>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Tue, 5 Mar 2019 17:35:24 -0800
Message-ID: <CAGAzgso9-1j2XDsHQn+RbSTtV8Vqideu_nG=2qCJD94iyaxFFQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] clk: Remove recursion in clk_core_{prepare,enable}()
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-doc@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        aisheng.dong@nxp.com, mchehab+samsung@kernel.org,
        Jonathan Corbet <corbet@lwn.net>, jbrunet@baylibre.com,
        Stephen Boyd <sboyd@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 10:49 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Derek Basehore (2019-03-04 20:49:31)
> > From: Stephen Boyd <sboyd@codeaurora.org>
> >
> > Enabling and preparing clocks can be written quite naturally with
> > recursion. We start at some point in the tree and recurse up the
> > tree to find the oldest parent clk that needs to be enabled or
> > prepared. Then we enable/prepare and return to the caller, going
> > back to the clk we started at and enabling/preparing along the
> > way. This also unroll the recursion in unprepare,disable which can
> > just be done in the order of walking up the clk tree.
> >
> > The problem is recursion isn't great for kernel code where we
> > have a limited stack size. Furthermore, we may be calling this
> > code inside clk_set_rate() which also has recursion in it, so
> > we're really not looking good if we encounter a tall clk tree.
> >
> > Let's create a stack instead by looping over the parent chain and
> > collecting clks of interest. Then the enable/prepare becomes as
> > simple as iterating over that list and calling enable.
> >
> > Modified verison of https://lore.kernel.org/patchwork/patch/814369/
> > -Fixed kernel warning
> > -unrolled recursion in unprepare/disable too
> >
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > ---
>
> From the original post:
>
> "I have some vague fear that this may not work if a clk op is framework
> reentrant and attemps to call consumer clk APIs from within the clk ops.
> If the reentrant call tries to add a clk that's already in the list then
> we'll corrupt the list. Ugh."
>
> Do we have this sort of problem here? Or are you certain that we don't
> have clks that prepare or enable something that is already in the
> process of being prepared or enabled?

I can look into whether anything's doing this and add a WARN_ON which
returns an error if we ever hit that case. If this is happening on
some platform, we'd want to correct that anyways.

>
