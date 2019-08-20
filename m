Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBABAC41514
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02B723A53
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ct6Pi1cz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfHTICJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:02:09 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46621 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729181AbfHTICI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:02:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id f9so4213240ljc.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xz3riwOPHeLMjIKiRTAstl81PVMJRcr7E9ClEgdXbnQ=;
        b=Ct6Pi1czeTf9z6T+C4jDBSvH2xXBdPjMlt4G31y4frLXOxPWxz70z3myokApt18Gmj
         aqlUOOZ69sZxRzyrtB8KKbhVkTCkwbrsHBVifk/HGZ8Wk+2gd2Z5I4MLqUhbLbCr8Pix
         QCbAXnogekX7YC5d4HK3kN813oWiWpBcBSYkMAfOB0k2MclxV/IbWJbbCHgxsfWKdNMF
         4zFetviAWRbAL4ELynFuiL6aWnDdMsB/TP7cluyVG7nSslw8WONPhUzK4Ck9ONmwvYGs
         GSBYNUaFLLlesPmY6wPu9St514IVQbT3UbqQvypK9wfxV3hc0nvsR2duRzgUxLn02zh9
         i3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xz3riwOPHeLMjIKiRTAstl81PVMJRcr7E9ClEgdXbnQ=;
        b=DLS0WAgAyMNr/G+MrcBWrfMCR6lwrGAdv2jZ+mmDG53FtPIDEMuM78DmFevrXhXOoY
         MtjlI/2LOdiekYxIx0FdXLAVT0M8OUYn7b4XAO1WBNzdOsKR1qSgnkBGFTvny4BVH9ae
         FOPbARKMaq2nI47gPvfMlJfNmFj2sbDJ2YvY5ilUfoa4GgAscdJX4KxgLmVJyC7e5arh
         Kt4UY7gtdBVRG+i9++0npkq3CSgMpcWjeklBtRtPsOINXuPe8U9+XsKmEXTVWbJxEPSU
         Qy/J1Fl3Tx0yY+pZvxV4Nz1CN3ND31GWg6UCo74Msmrubs8A0PIV9fxrqpQVvUTCDVLB
         zBsA==
X-Gm-Message-State: APjAAAXmqJbvJB1P5X2o+nvZmrYDbIuqynXEm5OVwO9T5sdAGJX54KUz
        NDqDHOBXJFklAaVH40wGbU4ToPlKC1J9ngTQcFizgA==
X-Google-Smtp-Source: APXvYqztZtpJGLWma67jex9+6AlgTsze/ATXlXlMvWkex6LjcZ491q2g6dhhQIo1pZxfzYItT3p1fbH9boWIFmBn7oY=
X-Received: by 2002:a2e:b174:: with SMTP id a20mr12297799ljm.108.1566288126735;
 Tue, 20 Aug 2019 01:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <1566221225-5170-1-git-send-email-xuwei5@hisilicon.com>
In-Reply-To: <1566221225-5170-1-git-send-email-xuwei5@hisilicon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 20 Aug 2019 10:01:55 +0200
Message-ID: <CACRpkdZFwANp-+fSmPPENLoh2Za2-fyf+aZ0VK79AnyRJs1H3A@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: pl061: Fix the issue failed to register the ACPI interrtupion
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linuxarm <linuxarm@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>, jinying@hisilicon.com,
        Zhangyi ac <zhangyi.ac@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        Tangkunshan <tangkunshan@huawei.com>,
        huangdaode <huangdaode@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 3:29 PM Wei Xu <xuwei5@hisilicon.com> wrote:

> Invoke acpi_gpiochip_request_interrupts after the acpi data has been
> attached to the pl061 acpi node to register interruption.
>
> Otherwise it will be failed to register interruption for the ACPI case.
> Because in the gpiochip_add_data_with_key, acpi_gpiochip_add is invoked
> after gpiochip_add_irqchip but at that time the acpi data has not been
> attached yet.

We need to fix this problem in gpiochip_add_data_with_key() instead.

Yours,
Linus Walleij
