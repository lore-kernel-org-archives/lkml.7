Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EBAC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723FA20863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j3UA/A27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbfIIWcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:32:48 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:46923 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729858AbfIIWcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 18:32:48 -0400
Received: by mail-vk1-f193.google.com with SMTP id s28so1323079vkm.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 15:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wkJ02h0fBo9r8kWdWdUhcb/UyWYGr8bXb4xIws2KF3U=;
        b=j3UA/A270TR5kmBN5gzV6Zua0L7zQb4G0yy8X8v7x3XMlDIps2dObWryhvUTyTpAq8
         Z0WDUJEM8OmEG72VL39C6rYuaQtXckBYNR1ZpZA9oxVvLziKNIEserbuwuo4JKo/7GJZ
         lETYNHvfUbACUjN+xn6tGJOsOvQqESw8cW6T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wkJ02h0fBo9r8kWdWdUhcb/UyWYGr8bXb4xIws2KF3U=;
        b=Dr1RT615H7yMcYEjisnZOWdcjuqbqpM7YFXZH3OW1A79KAM5BmDLrJrhEsJY2wHRZH
         Hb1qyx6OnFHCOGRdpWsOA3W/0h+h2FNtlOE1/inoJ0kJNlUz88Q/dwXbu2HVPZRftDr6
         ZMXhTeEg+eph7YRYaVQ7ysM0qdGjsgOegeg+y/rDd57TlbxN7Fnc6cqEOalylHP6QetP
         4gj10+g9vVRtpK3F7Vy6Jk/h6zxfgMddOC32nOTmNZXe+bXRFdhfHVSobjB7NSfsnfWP
         4+ys0/QQjm0zGdkKike5Rdvfn+LK6sGuiPRDaE3LIi896Qi/wjMV77PF/RvevedN5xlX
         UgSA==
X-Gm-Message-State: APjAAAUPC/GKD4Jy/RGal9xzasJe1dzaoVtABc94PpRnF5CLW7WAKmVw
        n1lrYU0pAZM0bx5PDDYL94WRivaDOzU=
X-Google-Smtp-Source: APXvYqxaP20jRtEKENXNJB+L/fup5dFUozKxy7ycuSNq1A3zwgbhtVyJakO+vQsQblIkSPJIXctTBQ==
X-Received: by 2002:a1f:b6ca:: with SMTP id g193mr5053927vkf.70.1568068365445;
        Mon, 09 Sep 2019 15:32:45 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id r25sm2435003vsi.6.2019.09.09.15.32.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2019 15:32:44 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id u18so4907884uap.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 15:32:44 -0700 (PDT)
X-Received: by 2002:a9f:3f8a:: with SMTP id k10mr12637508uaj.121.1568068363612;
 Mon, 09 Sep 2019 15:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190908101236.2802-1-ulf.hansson@linaro.org> <20190908101236.2802-2-ulf.hansson@linaro.org>
In-Reply-To: <20190908101236.2802-2-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Sep 2019 15:32:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XLsbvhPA4ap3nZCLk1fZiPHALvOv0=uh+jGZ-VY=xYEA@mail.gmail.com>
Message-ID: <CAD=FV=XLsbvhPA4ap3nZCLk1fZiPHALvOv0=uh+jGZ-VY=xYEA@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] mmc: core: Add helper function to indicate if
 SDIO IRQs is enabled
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
> To avoid each host driver supporting SDIO IRQs, from keeping track
> internally about if SDIO IRQs has been claimed, let's introduce a common
> helper function, sdio_irq_claimed().
>
> The function returns true if SDIO IRQs are claimed, via using the
> information about the number of claimed irqs. This is safe, even without
> any locks, as long as the helper function is called only from
> runtime/system suspend callbacks of the host driver.
>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
>         - Renamed function to sdio_irq_claimed().
>
> ---
>  include/linux/mmc/host.h | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
