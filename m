Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9E0C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6107720862
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aSzILZh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfEMUZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 16:25:11 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33775 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfEMUZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 16:25:11 -0400
Received: by mail-vs1-f68.google.com with SMTP id y6so8893645vsb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 13:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s5749hj+ec8qMiNkDdVTE/yv4EVBb0STJhROaexO/ow=;
        b=aSzILZh1B8qR6DUScwEycKF1nqIky18KqZ5ulbFuZ49/8VSCk0RfsYIyjXbmjOqY4+
         v5VrAMcifpVcmVKK415z2GAmJJupcK+NY5AMUX4LVVM+faq3TlPY441Jg0LvzmxT4Du8
         ghz0j7IS4/ptx8mgYUVFCZA4ip/zRO01nTshs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s5749hj+ec8qMiNkDdVTE/yv4EVBb0STJhROaexO/ow=;
        b=PCBOS7ga7WxtMjQQaVKq4Q8Qwok3Cu0y4wZfaRUwnCOZa4NnlSvi1ggPui5dENyrPW
         JnUMa1QzDnBACok6tLvT4A+irLFWove0chHujsANpwOtCI2bqY1QwW6lMATGqh2o3wNF
         tNf70ydiHRw3htNCHW3nxE0KwUfA878k6m/s7fAQJwr7+o74KAKHh7OHPL3zpgNfL9JR
         efEV7yjOHiKVNrTek/ibjtLvMG7bVGl7PPYVx0HnVX+R0j936N31+JElUjj8kOQidsV3
         2cZhqKNyT3K0OCfy/rFtkQL218AbOmDIR3ckDgr8SvaYzznAlLSmaErPENMLUtdWnX5P
         Iw8Q==
X-Gm-Message-State: APjAAAWHgQX81rJsFT629bcim51u1IQLIiqLYmjCESZs/W+e8cEw+Ryl
        DoqPGhVMs3RpjB9+BmWq5xC2smbd6RQ=
X-Google-Smtp-Source: APXvYqwKbymZZCC/0DYRltHOSKeFUthg9vHHROEbevKC33YmDD75ClKEMRZ9qslqTQGxs6YnqKTOeQ==
X-Received: by 2002:a67:14c6:: with SMTP id 189mr14949395vsu.203.1557779109882;
        Mon, 13 May 2019 13:25:09 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id h203sm9281959vke.30.2019.05.13.13.25.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 13:25:09 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id g187so8875274vsc.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 13:25:08 -0700 (PDT)
X-Received: by 2002:a67:79ca:: with SMTP id u193mr13859822vsc.20.1557779108576;
 Mon, 13 May 2019 13:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190510223437.84368-1-dianders@chromium.org> <20190510223437.84368-2-dianders@chromium.org>
 <20190512073301.GC21483@sirena.org.uk>
In-Reply-To: <20190512073301.GC21483@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 May 2019 13:24:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UBic4qywgYQFGEXx_frD9ZoRJX7XGgDbQCvb2CbkBa9w@mail.gmail.com>
Message-ID: <CAD=FV=UBic4qywgYQFGEXx_frD9ZoRJX7XGgDbQCvb2CbkBa9w@mail.gmail.com>
Subject: Re: [PATCH 1/4] spi: For controllers that need realtime always use
 the pump thread
To:     Mark Brown <broonie@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, May 12, 2019 at 10:05 AM Mark Brown <broonie@kernel.org> wrote:

> On Fri, May 10, 2019 at 03:34:34PM -0700, Douglas Anderson wrote:
> > If a controller specifies that it needs high priority for sending
> > messages we should always schedule our transfers on the thread.  If we
> > don't do this we'll do the transfer in the caller's context which
> > might not be very high priority.
>
> If performance is important you probably also want to avoid the context
> thrashing - executing in the calling context is generally a substantial
> performance boost.  I can see this causing problems further down the
> line when someone else turns up with a different requirement, perhaps in
> an application where the caller does actually have a raised priority
> themselves and just wanted to make sure that the thread wasn't lower
> than they are.  I guess it'd be nice if we could check what priority the
> calling thread has and make a decision based on that but there don't
> seem to be any facilities for doing that which I can see right now.

In my case performance is 2nd place to a transfer not getting
interrupted once started (so we don't break the 8ms rule of the EC).
My solution in v2 of my series is to take out the forcing in the case
that the controller wanted "rt" priority and then to add "force" to
the parameter name.  If someone wants rt priority for the thread but
doesn't want to force all transfers to the thread we can later add a
different parameter for that?

-Doug
