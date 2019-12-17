Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8301C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775DC2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SWfYOp7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfLQUi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:38:27 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36532 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbfLQUiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:38:25 -0500
Received: by mail-io1-f66.google.com with SMTP id r13so2331071ioa.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 12:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bf4DW07ux663sZ7zB+kziR4YNNMjqy9A2bO2qaVQs7c=;
        b=SWfYOp7v2Gbzvj0oex2xBcjnDjxUg4jBwLcNA8Lj7Y20hF7uJS8Z+wqqD+6oKZME9U
         3p6Hh+fBlmoE58Y8glJzGHG3nV2ShrZXJI8oFnXr40yYSDt+Y/Yu67GPHgbuOPgKcRLa
         F3Wu2wWaSCDep6oSq/EtkLx/PZFaVr9IF38mE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bf4DW07ux663sZ7zB+kziR4YNNMjqy9A2bO2qaVQs7c=;
        b=kjazMDecidOxAKvIwLYRua3Nd0dXwp0rohaoarfqk31stHhSu6XxjsY3pUcLLanTpZ
         +28wxL0IDooSnWk4WNqe+7/9SFVeWqtT/FjPTV9AFzy7t2SmxhF3p51KgSzC2ljVFqYf
         dyW4ALchNcUDoBIuj7EJqEuO/u2fGreIa64Du0enXfC8Fuknl9q5MV3jcyaaiOg2XM/2
         zg95MUK3tC8WWVFl6cJm4S+gz+wiW2xN0oT/yOL6Zz/sMN1VHhJiIBvL2ERuVLHgDJBW
         1nJMCBV9XXp7GJn+TdYIE4T93eRTQ3NJvp4wM4JGKOkOABJmjd6ffrPrHQWnbzVkYDl+
         K7nQ==
X-Gm-Message-State: APjAAAVX+fIzBm4qlgclumPhv1akZX4PN9t0E35RKvjQjGqbVOO1/RFB
        kxW/vuwuC5nYGepSbhI++sJi4WDCP54=
X-Google-Smtp-Source: APXvYqyzlR1mG8qeAxWQ5PjT/akYar32p3aiXrGxb+FqfyV/aEyDw35oOtYoAPL0bmplBR3pZheyHg==
X-Received: by 2002:a6b:b20a:: with SMTP id b10mr5416831iof.87.1576615104405;
        Tue, 17 Dec 2019 12:38:24 -0800 (PST)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id z22sm1892392ioe.47.2019.12.17.12.38.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 12:38:22 -0800 (PST)
Received: by mail-il1-f179.google.com with SMTP id v15so2268152iln.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 12:38:22 -0800 (PST)
X-Received: by 2002:a92:ca90:: with SMTP id t16mr4548825ilo.218.1576615101966;
 Tue, 17 Dec 2019 12:38:21 -0800 (PST)
MIME-Version: 1.0
References: <1572419178-5750-1-git-send-email-mkshah@codeaurora.org> <1572419178-5750-3-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1572419178-5750-3-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 17 Dec 2019 12:38:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wkte6aEy_dbNDBgAFimJd6kRPXN1v05K94qoVOaHiCzQ@mail.gmail.com>
Message-ID: <CAD=FV=Wkte6aEy_dbNDBgAFimJd6kRPXN1v05K94qoVOaHiCzQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7180: Add wakeup parent for TLMM
To:     Maulik Shah <mkshah@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        LinusW <linus.walleij@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn / Andy,

On Wed, Oct 30, 2019 at 12:07 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Specify wakeup parent irqchip for sc7180 TLMM.
>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 1 +
>  1 file changed, 1 insertion(+)

I see that Linus W. applied patch #1:

https://lore.kernel.org/r/CACRpkdY9ETQRHn7x2D2XVLZ810Uo1cPQxMBqTy5LnrORRNjTVw@mail.gmail.com

...so I think this patch is ready to go.

FWIW, feel free to add:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
