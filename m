Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E5DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2355F233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sA3b4HdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389209AbfHWIAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:00:33 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42147 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730532AbfHWIAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:00:32 -0400
Received: by mail-lj1-f194.google.com with SMTP id l14so7999145ljj.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 01:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2MWurloFC424CUmSqLbHj0wb/3z06n1cb9tNRKzCOz0=;
        b=sA3b4HdX77h7s/fsgrnjxNpZZL2Q2H0A0yDHqxZ97wKFl/4wY6a1hIV5EQoqmrzZ7r
         f4Z8cqeST9COrJKBqhuaiYdi+KUCmgfbGSP1wKpdmxquge83gpeW3HfaT5SCIGS5uwVG
         3veKuafvjamg3UGf5XlzSwsesSMNOTzddh4Ge5Tqp+I26zHMONWLgzNiAq0o81va1Jc1
         emEV0eUjqLBewyOer5y+Dho936IyFhHQSxCZlZqIw1KZGcbRpXPMFujKyY+ryczpp+Yx
         sISvmhOjokZhZ62yOeO8PFUTc2yZ4Hf2TWU69qgzlCyG7Oq+xQhaGlB5ijax6S+LsHQL
         jClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2MWurloFC424CUmSqLbHj0wb/3z06n1cb9tNRKzCOz0=;
        b=UP9otYVFihio/TTLfK873/On/ZrDUGJo/3GUU5Sax64G6gT1B4VGbbg5HdgFo55QRk
         GItVdtusUmNjGR6mqIYuFdG6FdVjE2nSxd5tzS8aosRJtP1J8u7uYpSpM3lGEIekYYrC
         CFumrDrBITMHq+EOaItKagZVFmNK5FLoaV0Kei3/Ddde5AfC7hXnho6Xc2JMsaRhPi7V
         N4bzwY0oSX65eOlvic9nojlFSFoACOinyCbSykMgSmqTRBAgmiayLHstWHOh9c2GK+O9
         oYAVfkmdEFK18c/0SQWu2s113XJOsqW27mgT3qwJVyjpi4ij0gNU1+GMCpMAwFrfSxJn
         Jq2A==
X-Gm-Message-State: APjAAAVIOLWFv3z3caik/OwBEm+2sqvpZspa9IYPKxljDggZ3EL7LRTg
        Z6ABc8IpW4sSAxO8jpLEIjp7Du15z8Yx5/R3Mui+jQ==
X-Google-Smtp-Source: APXvYqzLQ5ClEUlmAOPmQjblokk+7eUHmNQEQGStJEPG0CbEku6phix8tVMaf7PE4m+a0XscjlciF/e0C/PJmTAj7dk=
X-Received: by 2002:a2e:781a:: with SMTP id t26mr2091021ljc.28.1566547230567;
 Fri, 23 Aug 2019 01:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190814123512.6017-1-vkoul@kernel.org> <20190814123512.6017-3-vkoul@kernel.org>
In-Reply-To: <20190814123512.6017-3-vkoul@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Aug 2019 10:00:19 +0200
Message-ID: <CACRpkdbANSzMbO2dDGrfFK=KP_ZCkoaOA7xG4zirhzo7hHG_ag@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: pinctrl: qcom-pmic-gpio: Add pm8150l support
To:     Vinod Koul <vkoul@kernel.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 2:36 PM Vinod Koul <vkoul@kernel.org> wrote:

> Add support for the PM8150l GPIO support to the Qualcomm PMIC GPIO
> binding.
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Patch applied.

Yours,
Linus Walleij
