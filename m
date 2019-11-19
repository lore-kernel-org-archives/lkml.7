Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEDCC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D1A21852
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Krb1OidY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfKSOwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:52:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42995 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbfKSOwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:52:10 -0500
Received: by mail-lj1-f194.google.com with SMTP id n5so23647038ljc.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 06:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yqb0rkinvnzVxsR16s0DvySApOjrl6R+PT2Tv3AwCuQ=;
        b=Krb1OidY+jIOCRMHX0376ZSV9SJGf/bkadTG+k7yzJiYfM8/OZUrPbsHA2qx7Hh7u9
         BlD6DBG51uCKeMj2RsnffcZMQfx8lg8Y1P75xjhiqY2ubZSik/BRMA1scOpsllxqiSj1
         pGFElwRxjYt1QUWiZxwFy1uysySfIgzMuDlnkgVhkQ1UTDrkDxTMysXfIN7qp6pR9LPD
         hc5EMHcWNF/ZhclLFpOv3TFmIPoeq40Lg4UEVtQI6NG199vB/0lyBRR+8hxcMY3KMnRu
         HGVupab+psS5dFxKl9qQGHfMHmLmaOa4GcOBPwtTlVYuKpP6uRx5YEQPwfPZxCn3j/xs
         REbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yqb0rkinvnzVxsR16s0DvySApOjrl6R+PT2Tv3AwCuQ=;
        b=SRolEyPrvqwUss+gVII/5eTb5YxiNNTVS+RI2egQAvn4Yz5SZ0dReoEFUOEpHXgmqS
         HIzZmHK8mQHzTGWi//bDlXVqrDrHha5tL/d5dN7yowREkqDcCggPo5DBOdbvkAnflEuc
         ImGu3EPtiCg/DlVrR5VGE4nPIsnP6K3+uMDQDpT43RMSnCMDgIsSXKKK+z6ZoSip2fui
         mMC0NGAgQoUDvm17gqnKgbcxcE6VqfZUj7wXIZQvMpt2OI0Gc4FfxU7uDs7LjzX0rwSg
         LiIItbnFwCq8TBo9eepSx6htQu7EfLaVWSBBE0Or55bHnxN8e94fsK/TekXfZjUtiYWr
         bI5Q==
X-Gm-Message-State: APjAAAWwf5kswsexJNVVQXVxB95nGp6Sb7CJmrdqEnr93AAZWHJnvpnh
        PnSMUcLoQKxwmJYolb89oj1+CVfoxq8le+krA/wLNQ==
X-Google-Smtp-Source: APXvYqyrJt5cT9l3Z4fNcoLZnVIbrnYb0eYCPsuJ1H4+NpxJM1ojKC8zDKW4wGHoxq9Q3I8PkV9qxBmveRjuWw+hDa4=
X-Received: by 2002:a2e:8597:: with SMTP id b23mr4342291lji.218.1574175128085;
 Tue, 19 Nov 2019 06:52:08 -0800 (PST)
MIME-Version: 1.0
References: <1573855915-9841-1-git-send-email-ilina@codeaurora.org> <1573855915-9841-9-git-send-email-ilina@codeaurora.org>
In-Reply-To: <1573855915-9841-9-git-send-email-ilina@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 Nov 2019 15:51:54 +0100
Message-ID: <CACRpkdYix=G1nYHgdzCKR9WzwchHtJ6N_UUi3R_+sz8UFHmLUg@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] drivers: pinctrl: msm: setup GPIO chip in hierarchy
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Marc Zyngier <maz@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 11:17 PM Lina Iyer <ilina@codeaurora.org> wrote:

> Some GPIOs are marked as wakeup capable and are routed to another
> interrupt controller that is an always-domain and can detect interrupts
> even when most of the SoC is powered off. The wakeup interrupt
> controller wakes up the GIC and replays the interrupt at the GIC.
>
> Setup the TLMM irqchip in hierarchy with the wakeup interrupt controller
> and ensure the wakeup GPIOs are handled correctly.
>
> Co-developed-by: Maulik Shah <mkshah@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
