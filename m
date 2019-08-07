Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5874BC32754
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 12:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBE921BF6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 12:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SyTkcf8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387896AbfHGMon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 08:44:43 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44533 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbfHGMom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 08:44:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so85315945ljc.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 05:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qAcXQ74wnq9lBV8xI9DKWSAH0H5RLjm/S1lKOmaMBg=;
        b=SyTkcf8dDd/qJ1huE2tGq5vti9WUJZR3c6pp88zP25SXfE+qr2KqpJJ9EnCu/6TW0i
         pi/EIkp0XiLke82zXZTC9ZdinmSM5ek00WFxEbo5FcJDxK4L82VQk2N+LlNRyXQnq2g4
         Sf69bBUT7mBcpzqievikQZqqrefRNeLI/r3CF3jMQ1dO2+cFCJrGhkaJIbrwe6egMhHv
         jYN2htDTwwTy1gjLmP5I8KWpk1BoxLQyIBVZCC7Fn+JaAOzLSh2vy/7Tr0ovkid1ZQAJ
         UZGx886EoY98kJdFo+JuBpTVWRCnmp5zRNE3mNzGeRp719fnJ8K8BU0xtAIKh3XexF47
         YZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qAcXQ74wnq9lBV8xI9DKWSAH0H5RLjm/S1lKOmaMBg=;
        b=Nnthj6sLjc0Ee+i+pnkqNFEBdASfzsmMwRmwyaHEUybjiJCcg0huSWeBIMBU6OG/86
         cJFaoEonFNQAxeDRIqh/TO3mo+OCEV4xMEbL5fDtU2TTPz2GmPn3lFul8ylSK6y8jc/i
         8FANEegQKz/awBbcXtY+47GdxqhGZHvh/EESU7pu57tOmzQuDykp78wOHDCLWVQjBz/o
         O/k+uN5IrOnxI4LmZXMJEgUbm8LZhLB/r1k+C7+1NszqlxVwbVnjvSNpJiq86HaJUFai
         cqPLDWq++VCD5Kr7GTx+xgkNR1i+vCumaOnpCef/0fUl5xt4XZtic/KF+v+RuyAtwL57
         f3mA==
X-Gm-Message-State: APjAAAWWOlXrKVxaKVAm7QrotU/t7LccrCBncWipa8TeY9S0Gy9T1pUH
        J37W7we1jeh+7mBW7iUNpqKFJWAFM5fylqW03B1txw6m
X-Google-Smtp-Source: APXvYqw0QLiekY2Wd3n7wub8yhIsoTVDzI2YudUSicPG1Sk8vAgOz3VhLcQ5SkSAoa5cDuQiW4DnULWNGV5eM841Z+Y=
X-Received: by 2002:a2e:2c14:: with SMTP id s20mr4756592ljs.54.1565181880879;
 Wed, 07 Aug 2019 05:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190806060536.18094-1-rnayak@codeaurora.org> <20190806060536.18094-2-rnayak@codeaurora.org>
In-Reply-To: <20190806060536.18094-2-rnayak@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Aug 2019 14:44:29 +0200
Message-ID: <CACRpkdbUqZ+Jz1c2eS1s4Hen5mzDfrkN_Hn=U_0u3nOo43bCAw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pinctrl: qcom: Add SC7180 pinctrl driver
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jitendra Sharma <shajit@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 8:05 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:

> From: Jitendra Sharma <shajit@codeaurora.org>
>
> Add initial pinctrl driver to support pin configuration with
> pinctrl framework for SC7180
>
> Signed-off-by: Jitendra Sharma <shajit@codeaurora.org>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> [rnayak: modify to use upstream tile support
>          sort and squash some functions]
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>

Patch applied!

Yours,
Linus Walleij
