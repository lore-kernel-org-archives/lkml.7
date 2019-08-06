Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4116C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DDC20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJ09HMiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbfHFNEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:04:48 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41322 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfHFNEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:04:48 -0400
Received: by mail-lj1-f194.google.com with SMTP id d24so82166596ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 06:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VSP7ertTaGliFxnzQE6UZ8P7kDdh7xHsv7HJAdC4s/g=;
        b=hJ09HMiyWFDdzVON9hsczrI8lwxd4BGK2p5ZiM1qSz3r2CZVJt698v4TipIfzs08xp
         FRm/+H/QMELlqo3dO2vQM+p2Hctehj6MpcypAFq7HAg8Igvdx5GmcdiFrUPMYboPigjG
         bLwFEk1sKaAvqez/V1NxBL1JD9KDxGbupOQqk2UjBlKsGcg0EbDtzIIF8l6pNIbOqCds
         iUJsDD57mZEb/MmCL6F9Go8fYRk+NiY8xsUkpULQXTMdis/OO7s5Kayr5Km80/pYxEVW
         I4HrSaKNu1id/oWV9R0gLzaRt4zhprNKaWIFA7WSEAZu7dCHiqJdR5cTW5Mq7ZKPn+RO
         yKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VSP7ertTaGliFxnzQE6UZ8P7kDdh7xHsv7HJAdC4s/g=;
        b=R6KbClXayWkZ0HpCJiRZvf7xtvTDMN+5img4velQmb1t4J0h9IAMjPDXaoGtX+H9wy
         Pyx73UWQR6L/v5hiiySMli5s1NR18eRF18th9WctOJtyJ7emRR2Dzcuzz0NKeEI5wMx3
         Na75pbVfmoQkfv2nwip0MrNmV7hD+03+qtNKCddz8NJizpcjHB60PCR65ah1NRXv4su1
         WwbEc2wbIIkAzof+iqJxtmha6spIFWIp34p3BZr3de0ZYQj8qWuB/SkwmWfsJmXEyJY/
         FOIjiXMcbqntEebrLntiksiyHU72lT9byiinoOUfSY3ZPrwBWd/7m9iJMOzBczt4AmnO
         HFiA==
X-Gm-Message-State: APjAAAWiZa5Six7WbyP1q5zJ+nidwfRSg1uSbKmdgFOO0cTYRmBdL6vZ
        rftSqzitsGjS3WXjYff9RAmJ7OVDKjyKV5ft66MMmQ==
X-Google-Smtp-Source: APXvYqz7NqTp54GWvw+RS4Sq+oN/CGJLpirazWc5j1osUTFej5ZizfAcNEnwUaljPcS/O8sXI0XIjz6KzmkCh13Z0NY=
X-Received: by 2002:a2e:9048:: with SMTP id n8mr1761330ljg.37.1565096686312;
 Tue, 06 Aug 2019 06:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190803133436.15016-1-rfried.dev@gmail.com>
In-Reply-To: <20190803133436.15016-1-rfried.dev@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 6 Aug 2019 15:04:34 +0200
Message-ID: <CACRpkdYEdQdk62bWJ2=i2Mbvpz3kwL=9bnMoxksFsTgAHRh68w@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Take MUX usage into account
To:     Ramon Fried <rfried.dev@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 3, 2019 at 3:34 PM Ramon Fried <rfried.dev@gmail.com> wrote:

> From: Stefan Wahren <stefan.wahren@i2se.com>
>
> The user space like gpioinfo only see the GPIO usage but not the
> MUX usage (e.g. I2C or SPI usage) of a pin. As a user we want to know which
> pin is free/safe to use. So take the MUX usage of strict pinmux controllers
> into account to get a more realistic view for ioctl GPIO_GET_LINEINFO_IOCTL.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Tested-By: Ramon Fried <rfried.dev@gmail.com>
> Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
> ---
> Sending Stefan's RFC as patch, as I tested it and it seems to work,
> additionally, an accompanying fix was made by me to gpiolibd to fix a
> display error of the actual result:
> https://patchwork.ozlabs.org/patch/1139923/

This is mostly fine, some style nits so I fixed it up when
applying.

Yours,
Linus Walleij
