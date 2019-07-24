Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3108C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990B02081B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="emPr0+o1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392615AbfGXUWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:22:41 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45996 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387998AbfGXUWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:22:37 -0400
Received: by mail-io1-f66.google.com with SMTP id g20so92342410ioc.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 13:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W7b98j1DYhcpfb7OdCLFp27JFdB3a34V6jagTpBUbfA=;
        b=emPr0+o12gzDRDVdDGCZkDSc1awT8Sv7j4Y3PHnjX6+BEM8Ev916Ml6Ya5Ixn59rnj
         bYHRVD4vJpGgnK8uA8ZfT2527Pza1HUFVITP04fOwvVSTVtDbOhp0XyRD+J1U8RCZ7+q
         cQkjHaLlnu1CLlhPM31Ij364/ILIXnU5UveYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7b98j1DYhcpfb7OdCLFp27JFdB3a34V6jagTpBUbfA=;
        b=EJhukWEYvjRGds5jeM88kCZslB9biLExDO/bpSnJ/R9nMvC5LjHbn3TR/k3KhOzA5i
         1vNcyvQCkIX4SEmphGcLio7GBYYznUxAnxB8LiP1Ucm271ON/wRsVMG2Ij6OiRFb3nfX
         mrdrw5afpMwxgNPsrdcN9l+sQ7YaLXuQoYoBWlolqTjHp4C7hZEu985+MtYe6KrZVf2D
         GM2Sjorp8J+fV96RD7FNe3lI1hxSrYPtpDRNXB48YaKiiIWSvOA/7PtpG6Hqa0oWt81e
         KoRcSzPLvlU/s8Sc6q2nMDQIwkyXgqsoyvsal5jKRBJnaYcpILBeAL/yW6c2DarAHdbR
         82tg==
X-Gm-Message-State: APjAAAV5cuziJBaADJDDoq3zlX9711cK9aIv/fdBY3ZHPkDcOfONeWxw
        kedSWt1go5Gi9IIw+Sh0eqr5JCsUNEg=
X-Google-Smtp-Source: APXvYqwlkv5B3pC1YB3TDlo/J4En9R/atXwgpojRnd0vSAlSZ0ZHU/gIEB8fq4doZe2+F3qTrdAycA==
X-Received: by 2002:a5d:8253:: with SMTP id n19mr13481383ioo.80.1563999757043;
        Wed, 24 Jul 2019 13:22:37 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id p10sm64936237iob.54.2019.07.24.13.22.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 13:22:35 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id m24so92414301ioo.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 13:22:34 -0700 (PDT)
X-Received: by 2002:a5d:8ccc:: with SMTP id k12mr78564964iot.141.1563999754524;
 Wed, 24 Jul 2019 13:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190722193939.125578-3-dianders@chromium.org> <20190724113508.47A356021C@smtp.codeaurora.org>
In-Reply-To: <20190724113508.47A356021C@smtp.codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 24 Jul 2019 13:22:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WAsrBV9PzUz1qPzQru+AkOYZ5hsaWdhNYRTNqUfDeOmQ@mail.gmail.com>
Message-ID: <CAD=FV=WAsrBV9PzUz1qPzQru+AkOYZ5hsaWdhNYRTNqUfDeOmQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mwifiex: Make use of the new sdio_trigger_replug()
 API to reset
To:     Kalle Valo <kvalo@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Andreas Fenkart <afenkart@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        netdev <netdev@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Xinming Hu <huxinming820@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 24, 2019 at 4:35 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Douglas Anderson <dianders@chromium.org> wrote:
>
> > As described in the patch ("mmc: core: Add sdio_trigger_replug()
> > API"), the current mwifiex_sdio_card_reset() is broken in the cases
> > where we're running Bluetooth on a second SDIO func on the same card
> > as WiFi.  The problem goes away if we just use the
> > sdio_trigger_replug() API call.
> >
> > NOTE: Even though with this new solution there is less of a reason to
> > do our work from a workqueue (the unplug / plug mechanism we're using
> > is possible for a human to perform at any time so the stack is
> > supposed to handle it without it needing to be called from a special
> > context), we still need a workqueue because the Marvell reset function
> > could called from a context where sleeping is invalid and thus we
> > can't claim the host.  One example is Marvell's wakeup_timer_fn().
> >
> > Cc: Andreas Fenkart <afenkart@gmail.com>
> > Cc: Brian Norris <briannorris@chromium.org>
> > Fixes: b4336a282db8 ("mwifiex: sdio: reset adapter using mmc_hw_reset")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Reviewed-by: Brian Norris <briannorris@chromium.org>
>
> I assume this is going via some other tree so I'm dropping this from my
> queue. If I should apply this please resend once the dependency is in
> wireless-drivers-next.
>
> Patch set to Not Applicable.

Thanks.  For now I'll assume that Ulf will pick it up if/when he is
happy with patch #1 in this series.  Would you be willing to provide
your Ack on this patch to make it clear to Ulf you're OK with that?

-Doug
