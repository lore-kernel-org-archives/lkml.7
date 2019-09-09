Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA822C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CFB218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Huvo2HD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388691AbfIIWeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:34:06 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37513 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfIIWeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 18:34:06 -0400
Received: by mail-vs1-f65.google.com with SMTP id q9so9940066vsl.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 15:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fyzZ7zehYhgdgW33H/RHHfH+ojER9btCEjhF4ZBw3xo=;
        b=Huvo2HD+Q6gGEUDmrk3hkHjLQMYrB+mDOOFw05wBWVYVgrnDpZyuCm1o6jZVpXUcjO
         94Fqu3QxrMZW0bWR4hTe2yFWxdgv/3CtTrIb+t/6uJnKoVTXytY/q4hZLJekXd2MpUpP
         owDDEleKbJRLcfA5ilYS7xr7ebYjy0mzIoZNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fyzZ7zehYhgdgW33H/RHHfH+ojER9btCEjhF4ZBw3xo=;
        b=VlSTkhgQAIGyk1J5zAziSuKm87xegdA/I/UIOwJ+ucLw0pH4D0B2twJivFV2gHXxip
         ZNTf6xS+9kYv5pFz5HpfpntoRpFAyzhFH8RmjowPn10sBEEVZqYdOYC4WQeu8VYqD2EG
         h97ZJBqO7NLA4hlYnukYXoptCImQldKuPZjYptvw9Sl5SE2UPYjBfVMciFZ5xbRHFo6e
         JNPUkcPObiXjC4CRwv3e8mDNBoBZBjVr9kons4nsrwci7KfqnbLrtCuRlI3HUBSPcccj
         vekqFjjQofFqVjzhhZFkqt5LRRqKqWbUOlgjStwIehMP84ryySE/+XA/nXDDed4U71Pv
         D6Tg==
X-Gm-Message-State: APjAAAUCPZwRJ3wkSLqEpMH/Vr6EI/PSO5DGOPkpBqimmPBaqBtSJmZL
        +OIe6jzkJWRNsQ1BrAIi1Yo7AZnSuMM=
X-Google-Smtp-Source: APXvYqx1xNotchyMowoExOxckz8nz7jtPdgP2esArV6a1QWikUT+uawE54fNgk1K7IVuhdiewCG+1Q==
X-Received: by 2002:a67:dc8d:: with SMTP id g13mr14080905vsk.2.1568068445194;
        Mon, 09 Sep 2019 15:34:05 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id b207sm6323491vka.12.2019.09.09.15.34.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2019 15:34:04 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id h23so4892939uao.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 15:34:04 -0700 (PDT)
X-Received: by 2002:ab0:2088:: with SMTP id r8mr12584681uak.90.1568068443932;
 Mon, 09 Sep 2019 15:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190908101236.2802-1-ulf.hansson@linaro.org> <20190908101236.2802-6-ulf.hansson@linaro.org>
In-Reply-To: <20190908101236.2802-6-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Sep 2019 15:33:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XixFRMaKV8z84aBSwZirfoFmy9PcXGaD4aPuyu0BQy-A@mail.gmail.com>
Message-ID: <CAD=FV=XixFRMaKV8z84aBSwZirfoFmy9PcXGaD4aPuyu0BQy-A@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] mmc: core: Clarify sdio_irq_pending flag for MMC_CAP2_SDIO_IRQ_NOTHREAD
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Sep 8, 2019 at 3:12 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The sdio_irq_pending flag is used to let host drivers indicate that it has
> signaled an IRQ. If that is the case and we only have a single SDIO func
> that have claimed an SDIO IRQ, our assumption is that we can avoid reading
> the SDIO_CCCR_INTx register and just call the SDIO func irq handler
> immediately. This makes sense, but the flag is set/cleared in a somewhat
> messy order, let's fix that up according to below.
>
> First, the flag is currently set in sdio_run_irqs(), which is executed as a
> work that was scheduled from sdio_signal_irq(). To make it more implicit
> that the host have signaled an IRQ, let's instead immediately set the flag
> in sdio_signal_irq(). This also makes the behavior consistent with host
> drivers that uses the legacy, mmc_signal_sdio_irq() API. This have no
> functional impact, because we don't expect host drivers to call
> sdio_signal_irq() until after the work (sdio_run_irqs()) have been executed
> anyways.
>
> Second, currently we never clears the flag when using the sdio_run_irqs()
> work, but only when using the sdio_irq_thread(). Let make the behavior

s/Let/Let's


> consistent, by moving the flag to be cleared inside the common
> process_sdio_pending_irqs() function. Additionally, tweak the behavior of
> the flag slightly, by avoiding to clear it unless we processed the SDIO
> IRQ. The purpose with this at this point, is to keep the information about
> whether there have been an SDIO IRQ signaled by the host, so at system
> resume we can decide to process it without reading the SDIO_CCCR_INTx
> register.
>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
>         - Re-wrote changelog.
>
> ---
>  drivers/mmc/core/sdio_irq.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
