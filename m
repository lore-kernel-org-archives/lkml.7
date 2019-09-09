Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E57C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B2920863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GsssujDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388081AbfIIWc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:32:58 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46347 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729858AbfIIWc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 18:32:58 -0400
Received: by mail-ua1-f65.google.com with SMTP id k12so4874295uan.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 15:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U2/wdjSFx2+V/ddpY88+7IJ+97cajsbLNJq+vIVE05k=;
        b=GsssujDG2Jb1LEpkEswcOYwgHaexAs9/2blhp1bINcplff13C20hpT93h15JDcjMXC
         beaKFpQeCBOT0ojrnOjOUBbdawlhBx8SzkD31yx8g4SLZq/p82s1oLTzcx2JZkgC79YH
         d03hUr59Fiw2VWMX1DlmE9yUaxK3BgKf+aC7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2/wdjSFx2+V/ddpY88+7IJ+97cajsbLNJq+vIVE05k=;
        b=InZGBT6KetRVeHUxGJFaxG0XnTHeEjX5d3Qsgv8hZ1oWtPOuWRn9HyynKw6HLMXhqY
         Hyx/j0qzT1Pinlx7CjHuUcsRVriQC6B6iC836G60fWNfub5PP5+RpKvHAjfqy+XlhBsX
         eTQ+1PvGc7wu5Biawbbd7lzZvTjbjNvDDAeB2PuVUNFSuNiO0PgtOuFQQvCiDBaIkWbw
         weXJ2s9QbCctfLzUkC58rEOpbkXrK72NzlODr4yUyyv6LJc6Xf69SJq7BVPAW6nooywl
         RX8egoG0GNU7Zc4DzkE06HVuoM8Jb5d5P1l7CfFOkv7okUTNUFeqL68QJ53CXPlRAmt+
         30xQ==
X-Gm-Message-State: APjAAAWYcigB+rosM/a7803kJ2N1f85Xee4KNZzW8cYybXBoNr21cAMa
        gLjeLed4OVG0Dh6yepT46RNelZA/snM=
X-Google-Smtp-Source: APXvYqyZU6nBV7jxmvZExhng6EH3LQQW5Y+AkVR9RWSGGB6fpXOkE2lXsARJEk/XCTrWloXBPti9aQ==
X-Received: by 2002:ab0:6358:: with SMTP id f24mr10945067uap.72.1568068375638;
        Mon, 09 Sep 2019 15:32:55 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id m3sm3894014vka.1.2019.09.09.15.32.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2019 15:32:55 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id w16so4889586uap.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 15:32:54 -0700 (PDT)
X-Received: by 2002:a9f:24c4:: with SMTP id 62mr6002335uar.104.1568068374367;
 Mon, 09 Sep 2019 15:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190908101236.2802-1-ulf.hansson@linaro.org> <20190908101236.2802-3-ulf.hansson@linaro.org>
In-Reply-To: <20190908101236.2802-3-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Sep 2019 15:32:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V3gkAW6xLdi_yPkKzwZCMAgnmHKYi-jpXTzqS1+EU5fA@mail.gmail.com>
Message-ID: <CAD=FV=V3gkAW6xLdi_yPkKzwZCMAgnmHKYi-jpXTzqS1+EU5fA@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] mmc: dw_mmc: Re-store SDIO IRQs mask at system resume
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
> In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
> the driver. However, this still means dw_mci_runtime_suspend|resume() gets
> called during system suspend/resume, via pm_runtime_force_suspend|resume().
> This means during system suspend/resume, the register context of the dw_mmc
> device most likely loses its register context, even in cases when SDIO IRQs
> have been enabled.
>
> To re-enable the SDIO IRQs during system resume, the dw_mmc driver
> currently relies on the mmc core to re-enable the SDIO IRQs when it resumes
> the SDIO card, but this isn't the recommended solution. Instead, it's
> better to deal with this locally in the dw_mmc driver, so let's do that.
>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
