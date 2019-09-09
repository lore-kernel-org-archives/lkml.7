Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4502C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EC4218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bPBDmsaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388434AbfIIWdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:33:05 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46191 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729858AbfIIWdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 18:33:05 -0400
Received: by mail-vs1-f65.google.com with SMTP id z14so9897839vsz.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 15:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z6vf48QEjz8Sz6LLhjmSSSD9RkuuyFccpcd9mtNGMf8=;
        b=bPBDmsaqenLPEt1pVbouKW4aBIyDJuSdenKbkcFvtDSEnThgUxOJEfhX9ZuBx1+Ar+
         SvPPIIHa2+VvpLU0/RiU1ADuWcBI4xYXB2NVEqYPQc0jLqq+kXQ2DDQHYYQGUlCnjkEp
         zv+CWoPz/QdwYLOpGK5xrN2kCw9cY1EWNjvS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z6vf48QEjz8Sz6LLhjmSSSD9RkuuyFccpcd9mtNGMf8=;
        b=oqQzfZp3WELGkYBJ9pl76JSMbVXrodl0vQKrtyMy143IUefDc2WkydPiR9LVrU0E7v
         6vQuR1KZ2inFzb41FqHoXXNOlMDkaN28WQAkaLBsQqyrqHHWILAU1i8QLZcRt/aHNfsa
         UDfN1NFMPC3+n1Lv89uGVU65mh18sppcSgdri8sxZcFUXxYY1421v0brb5uUbII74INU
         0IPdp4Gc+QVLJTTCbTSsPj2RPsbJ/Xfw/Ji+Ho1N6SeZ6gL5uJHZkIZsofpMiafxtmoY
         u/5i9uKqNvGi5EvBqc/8f5ppZNtDQnWsoFkNPTeEbjp5Hd0gBzvODuoxA8s9S3VN3CW7
         IDvg==
X-Gm-Message-State: APjAAAVc64GiW7yjFQA2JpfF7C0TkiiTTtRwh0fjnbN6pxCJ14P0fc6o
        /n7OiaC6DDL508WR+AS/VBa+TQkRuqo=
X-Google-Smtp-Source: APXvYqx/qRfE9uJHnTISdZOQPWdN51Y0xRl0VgjQqbEA0QxOu3AI0ehkMHhTG4uY4mujJHDM/Tfc8Q==
X-Received: by 2002:a67:db8e:: with SMTP id f14mr13902608vsk.198.1568068383938;
        Mon, 09 Sep 2019 15:33:03 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id b207sm6322879vka.12.2019.09.09.15.33.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2019 15:33:03 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id f25so4903030uap.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 15:33:02 -0700 (PDT)
X-Received: by 2002:ab0:2eab:: with SMTP id y11mr12640675uay.0.1568068382471;
 Mon, 09 Sep 2019 15:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190908101236.2802-1-ulf.hansson@linaro.org> <20190908101236.2802-5-ulf.hansson@linaro.org>
In-Reply-To: <20190908101236.2802-5-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Sep 2019 15:32:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WhJ_wL181sWUZoKKaQWnZUDkkG=QovJsugsBVOzAOi9Q@mail.gmail.com>
Message-ID: <CAD=FV=WhJ_wL181sWUZoKKaQWnZUDkkG=QovJsugsBVOzAOi9Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] mmc: core: Move code to get pending SDIO IRQs to
 a function
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
> From: Matthias Kaehlcke <mka@chromium.org>
>
> To improve code quality, let's move the code that gets pending SDIO IRQs
> from process_sdio_pending_irqs() into a dedicated function.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> [Ulf: Converted function into static]
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio_irq.c | 46 ++++++++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 16 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
