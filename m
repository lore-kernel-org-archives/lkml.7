Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC95C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6131D20733
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zNhA6sQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfLPIUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 03:20:10 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39635 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfLPIUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 03:20:10 -0500
Received: by mail-ua1-f67.google.com with SMTP id q22so1768128uam.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 00:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ejdI6l2MpiYe782h59jIGE5FMUmgtUe4qzVwYNXmww=;
        b=zNhA6sQIvrirlHCC9+lV8lwZmYIThF6Cb5/e10jRvCda1SodrIGyW+1y1FRxISYeqt
         ymjut6ALn0lrVMeyzd0+Wq5TK73LF/UmbntZSTE9+HDYoHZzjMkMfFVWskPN3ePSbaSm
         Rhp5nBqj+mVFO+JZSBBZsmiMg46Xoa7lxa0A4zIzuj9RLdtazLXsimA1mhiYn+Byk2ic
         ZfEAwaDeDohDz18BHRUzfZHvQkhnPUaTP/eCjcihcbpl2twLfFUvg3T9/WvkDqfekzIo
         lY5jMNMerytVgatLCjJcUkR14W9DYj/i3K7Xmj6dJsVsLnQ3SkDBa+d2qyALhl9Fw0TW
         FChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ejdI6l2MpiYe782h59jIGE5FMUmgtUe4qzVwYNXmww=;
        b=r1ro+2XeMQFiP5xjHt2+BztFamXzxJftoPLoMWC3GgERwyQsgbib7+F/pMb36X+Ccs
         pUrstN/TqLUQPpu4aPb4zPN0Sf2qgETI2sbr8Gg+87w5D9FShMJ874nk5PEJLbR5ZR/c
         sNawRg0yWTEKXdpOZAM9hP1fB/b++OKb6nhMriEP39kpD79XnHw6HwgAn8k4roupD2Cy
         R1yrBaWZb8a7bzKYnIH3G4MFlDMJMIsM+TIIgt3gnllJHVERM2VhDvD0hXu0LiM933by
         O65Udc2th3WA45XiREn3NrRL8/LEVFbVLx8Z7Cp7PWvYkTKXt9pkZ5Kof4RAL76xfjL4
         gUUA==
X-Gm-Message-State: APjAAAXZc6asX9qbEy0/OAenzSQ0T9vSR++woWto5pn3g2dFv2AsmFdV
        wORlfR5EpQBzZ36z0jBsk1bMCeBgUpQzVUxgVOKAWw==
X-Google-Smtp-Source: APXvYqyMIA/7VP13JucpywWenFRwuvJQzwyVI4uVwVCF1oD8d8lLCXdxOD2nx2LY/dqipJEgihXFLTAgCEdx8FIQays=
X-Received: by 2002:ab0:32ce:: with SMTP id f14mr5108941uao.54.1576484409083;
 Mon, 16 Dec 2019 00:20:09 -0800 (PST)
MIME-Version: 1.0
References: <1572419178-5750-1-git-send-email-mkshah@codeaurora.org> <1572419178-5750-2-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1572419178-5750-2-git-send-email-mkshah@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Dec 2019 09:19:58 +0100
Message-ID: <CACRpkdZtbViGmGr=L3C4ibx3RVvB0tsv6JamvOPzo2mRmfk1FQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: qcom: sc7180: Add GPIO wakeup interrupt map
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 8:07 AM Maulik Shah <mkshah@codeaurora.org> wrote:

> GPIOs that can be configured as wakeup sources, have their
> interrupt lines routed to PDC interrupt controller.
>
> Provide the interrupt map of the GPIO to its wakeup capable
> interrupt parent.
>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>

Patch applied for v5.6 with the ACKs!

Yours,
Linus Walleij
