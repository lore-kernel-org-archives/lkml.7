Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95D1C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8973F218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uf8+ffjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388883AbfIIWeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:34:23 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39069 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388553AbfIIWeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 18:34:22 -0400
Received: by mail-vs1-f67.google.com with SMTP id y62so9914520vsb.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 15:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7Qp29xzD8VvJiLxwfvacqSffZ0ENSm28PrjV0lzFoM=;
        b=Uf8+ffjXXmM2NbLvr4C9kbLqYl6no1tOg1R0W5/8jQvZmMtKAL9gZmXrcKn+WUfsGG
         xSC+CCOMfTRj3Ib76ParYaXGiCIcG5CSqey5aRt4HDJKBrnI3FBE+QafrOTVgUZZpfx7
         53DTzNdr0sq6u+04sJtZYmJWFJZ1h3j24/hhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7Qp29xzD8VvJiLxwfvacqSffZ0ENSm28PrjV0lzFoM=;
        b=Qop99+tm/iMtwTZcUIRKGUVu90cppcrCZleN2mxY0ltMrkNInQP+0HfRhgM4p4mVgy
         D3rYpjU2h4kbL5Io2ze/kcDGR3+znTD98qNfPn84gGQDIxTg8wtwTGrm1T4wb2xHFg4s
         hicay3CkVQfnRd2EgExIm36QnZ1OrtMEsHr6xPC+ZTu8hTFF4DNey3/SP8MVPoeiRvwk
         ngnJYIe2gN2DcULKH3k3JpbF3AJ2Cie2U5sQUd8djHvcnBOqTmIO2rIu3a8shFeT6bOq
         c2/5FjEIls/VRjppdV64UZKPBq5FwreDvFToIb2nep7O3Be+J3cS945QkBHx8LHdNllQ
         PTqA==
X-Gm-Message-State: APjAAAXzSmqzDf6WMI7h1h4sf2Hs0ND+8XaydP7p8v4mUqYATrRd+RYH
        cKhCezNtTfYPNQvCNI15UBGHmxq33+E=
X-Google-Smtp-Source: APXvYqyR/TClFA+UqQ7wAmts1EhBl0Gz55lhFWYthlKvIvu5etocaTDFH9+WlZzQ7qdvc3GuJp+SoA==
X-Received: by 2002:a67:328f:: with SMTP id y137mr14536345vsy.199.1568068461290;
        Mon, 09 Sep 2019 15:34:21 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id w66sm6084321vkh.15.2019.09.09.15.34.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2019 15:34:20 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id v10so6681400vsc.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 15:34:19 -0700 (PDT)
X-Received: by 2002:a67:2981:: with SMTP id p123mr2608309vsp.121.1568068459597;
 Mon, 09 Sep 2019 15:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190908101236.2802-1-ulf.hansson@linaro.org> <20190908101236.2802-7-ulf.hansson@linaro.org>
In-Reply-To: <20190908101236.2802-7-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Sep 2019 15:34:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UM5_FzEuS5AfvA94_gKw5aog2VKDtZrnRiA_gAz+bq+A@mail.gmail.com>
Message-ID: <CAD=FV=UM5_FzEuS5AfvA94_gKw5aog2VKDtZrnRiA_gAz+bq+A@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] mmc: core: Clarify that the ->ack_sdio_irq()
 callback is mandatory
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
> For the MMC_CAP2_SDIO_IRQ_NOTHREAD case and when using sdio_signal_irq(),
> the ->ack_sdio_irq() is already mandatory, which was not the case for those
> host drivers that called sdio_run_irqs() directly.
>
> As there are no longer any drivers calling sdio_run_irqs(), let's clarify
> the code by dropping the unnecessary check and explicitly state that the
> callback is mandatory in the header file.
>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio_irq.c | 3 +--
>  include/linux/mmc/host.h    | 1 +
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
