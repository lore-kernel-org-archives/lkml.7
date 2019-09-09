Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BAAC4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5D320863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hT7S2S3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389006AbfIIWea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:34:30 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45461 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388905AbfIIWe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 18:34:29 -0400
Received: by mail-ua1-f65.google.com with SMTP id j6so4879365uae.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 15:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9uKn57lFOcZJRC0waWtjBCYVHQrktLOwjpylqAIocBE=;
        b=hT7S2S3A5LRDDsAHmdxFXDuEqQuO8/hNDC6KOuDOvVekoEombOVU8xLQeyM47bKn1O
         rNW9mVx9vCfFumzrMoUNac6RM4UoMUPMMMhvICFRVk8gMI7yg1AB5eRnB5d3uO53034N
         tjqfLDf+VRf8bA0Y9TNXW35HiKT38bz1QOhuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9uKn57lFOcZJRC0waWtjBCYVHQrktLOwjpylqAIocBE=;
        b=uQ4ruzfHqJqZ8t/1uR3z2uEH/hXf11uV3es4AGLYQrVG0HlerXrv9Kedwf+KwfbmFR
         NKOFzBD0I1wLl81iErRdxh0xJsDYnJodpGCK8D67AqazKr7qzJU6ZMkWwkkyDEkLJcbE
         OOMEdovSZIiaHeHqI8KVutdKzqdisqbwwkZKuIlJnD6DlQ6IVsqecTZ2vgnNNgwzvZzh
         23S5D8SAFYpwQbOu1RlCsYuFXBWA/0HkE+Ct+kOiulLx5jwSUeoK8FWs5vA+Z1rfydP8
         DDF6GpbKmBTaqPouyRdoUrymcviwTWFYg7XmlyGYXur8WAYeJxARm3tSwoTT+WscbYZP
         tq7Q==
X-Gm-Message-State: APjAAAX+7HwUiYP7X3UedTOwAEauefGyrk/VBKhl0G0gqPPCBXG+GfCC
        EUpApjjmv5KHZCsErt83GHp1vUwZYnA=
X-Google-Smtp-Source: APXvYqy/9bcDexEQ4KKxXovS5fv81mHTijSSvzKSjJraU3YAp6CGixvhP3OKog5Ao4S8kstUqSVtdQ==
X-Received: by 2002:a9f:2404:: with SMTP id 4mr119865uaq.60.1568068468032;
        Mon, 09 Sep 2019 15:34:28 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id c5sm16485713vke.47.2019.09.09.15.34.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2019 15:34:27 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id b25so3114089vkk.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 15:34:27 -0700 (PDT)
X-Received: by 2002:a1f:5e4f:: with SMTP id s76mr1414955vkb.4.1568068466575;
 Mon, 09 Sep 2019 15:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190908101236.2802-1-ulf.hansson@linaro.org> <20190908101236.2802-9-ulf.hansson@linaro.org>
In-Reply-To: <20190908101236.2802-9-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Sep 2019 15:34:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U+eqnMX9TuyBhi7r_qjG39P9dtHHO9=PvKOvRKuoOvKw@mail.gmail.com>
Message-ID: <CAD=FV=U+eqnMX9TuyBhi7r_qjG39P9dtHHO9=PvKOvRKuoOvKw@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] mmc: core: Fixup processing of SDIO IRQs during
 system suspend/resume
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
> System suspend/resume of SDIO cards, with SDIO IRQs enabled and when using
> MMC_CAP2_SDIO_IRQ_NOTHREAD is unfortunate still suffering from a fragile
> behaviour. Some problems have been taken care of so far, but more issues
> remains.
>
> For example, calling the ->ack_sdio_irq() callback to let host drivers
> re-enable the SDIO IRQs is a bad idea, unless the IRQ have been consumed,
> which may not be the case during system suspend/resume. This may lead to
> that a host driver re-signals the same SDIO IRQ over and over again,
> causing a storm of IRQs and gives a ping-pong effect towards the
> sdio_irq_work().
>
> Moreover, calling the ->enable_sdio_irq() callback at system resume to
> re-enable already enabled SDIO IRQs for the host, causes the runtime PM
> count for some host drivers to become in-balanced. This then leads to the
> host to remain runtime resumed, no matter if it's needed or not.
>
> To fix these problems, let's check if process_sdio_pending_irqs() actually
> consumed the SDIO IRQ, before we continue to ack the IRQ by invoking the
> ->ack_sdio_irq() callback.
>
> Additionally, there should be no need to re-enable SDIO IRQs as the host
> driver already knows if they were enabled at system suspend, thus also
> whether it needs to re-enable them at system resume. For this reason, drop
> the call to ->enable_sdio_irq() during system resume.
>
> In regards to these changes there is yet another issue, which is when there
> is an SDIO IRQ being signaled by the host driver, but after the SDIO card
> has been system suspended. Currently these IRQs are just thrown away, while
> we should at least make sure to try to consume them when the SDIO card has
> been system resumed. Fix this by queueing a sdio_irq_work() after we system
> resumed the SDIO card.
>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
>         - Queue a sdio_irq_work() rather using sdio_signal_irq().
>
> ---
>  drivers/mmc/core/sdio.c     | 2 +-
>  drivers/mmc/core/sdio_irq.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
