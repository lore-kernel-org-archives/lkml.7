Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC673C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9712217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gE9aCLkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbfJCMS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 08:18:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42512 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfJCMS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:18:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id c195so1649347lfg.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 05:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gKFKePabTD1eOvwmyyZFiqnLejhQ9oKYDwkVZ0ztKVU=;
        b=gE9aCLkU+HUkyDWPPSzlObegTNQaCKpp8gn7md0zriecl039Tw4imgWwXthG0mDvz0
         eHIr/Hm/AU5HBvVr1y57VpLbkfURQluNd+9TPyHWCL6OZ2doM77HkAvkUgbY/h2tegkk
         lf+yO9lNMbutkV7xay82pr01OhMbpO2as93K7JzqQtlGNyk6fBHj8Dm+I0RQoWBOmDIw
         VvwmGvu6VTXyWEi1dUkDLbE0ibBEsUyMPE3Z17/PpKgit/zlgfLv/gfye8gLaBPNCF/D
         GIFFDZgBsW20y0DpffzVhDBBPsP2TM1IcKuf7azQY42hmk799WIKHd1aGbCC7SUX5qi4
         GTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKFKePabTD1eOvwmyyZFiqnLejhQ9oKYDwkVZ0ztKVU=;
        b=PxcE7U7OsXWj/ztiZlf8F2wzF6Ol5wAZKMxGbUg/+jR1jBU7ea5AVwyLL859wYj3Hy
         WHMOuM2so0SQFYO/TKg0zCxI3OGui+1z2o8xVbAnqHk+Or2oRc14eUcCYK288Guzc5jf
         yOfcvi/BNMtJPPyV8NdMiJCUQY3K2gNl7c4/TFkofkrjnS8mKdW4vxYxssThkPP2Co2u
         8odG2UANxXOViForoUNNS2mluA6f81Q/CPVCkAuTYrNYMNbkUTzv6K0sF3Al4zedNezf
         FqB5S18a7M6zWOSz2wYg/NZeFMob+tWVolelhvNLlF8CW8SlNoZBq/tpGv2oMXi3HKN7
         QB1g==
X-Gm-Message-State: APjAAAVxtwpvDkLZFDV4Hv2wjRoDEcs3ppz9fHjbTVudkEIkOOdrIPKI
        9zI0B91MATsMEjCcgUffyozIaOMRK6a76XhNVbJtvQ==
X-Google-Smtp-Source: APXvYqy4ldz+Wc1aAPF/pbz6ZO/x6cgivxofY8VD+reWEZ8AWkh8iIOzKT3mib7xlGScF5RKod4tsA82CwjBy/zOloo=
X-Received: by 2002:a19:48c3:: with SMTP id v186mr5595003lfa.141.1570105134340;
 Thu, 03 Oct 2019 05:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <1568411962-1022-1-git-send-email-ilina@codeaurora.org> <1568411962-1022-12-git-send-email-ilina@codeaurora.org>
In-Reply-To: <1568411962-1022-12-git-send-email-ilina@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 3 Oct 2019 14:18:42 +0200
Message-ID: <CACRpkdYErXVLAvwBoKhHiKZBOR3CSKYUrTPngb9pWJGBiKCyDg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 11/14] drivers: pinctrl: sdm845: add PDC wakeup
 interrupt map for GPIOs
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        mkshah@codeaurora.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 11:59 PM Lina Iyer <ilina@codeaurora.org> wrote:

> Add interrupt parents for wakeup capable GPIOs for Qualcomm SDM845 SoC.
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> Changes in RFC v2:
>         - Rearranged GPIO wakeup parent map

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
