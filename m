Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BC6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089FA2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IHLLSyts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbfCZR6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:58:02 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35442 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732176AbfCZR6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:58:01 -0400
Received: by mail-vs1-f65.google.com with SMTP id e1so8201313vsp.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iwv8IpZKD8oh0+94JIm2Vj5brdUcDB1zd1xCYJrhdio=;
        b=IHLLSytsP01dCd9oOU38yMPnzA5b3E/BOZ4LTJFL67WJU9y3Jh/ZGj7ED4JjFBGHAv
         JmrH80pU/M5rSkoE4xu15+F7ruc1gnFO0AWXsWZVjpbg9ZA4TLJ1K3GiPTilBilvGHST
         /USajAzj3kJBJGrMbiVvAwQUMZk3FCuaOWmBmMPI5bY1UQsuCCyyGQvELUfPsJm9lI9K
         3ntzaiavkmZ4QZfkR/D0w53KJhFxY6iMN5bnHcIU75Kd7LwiVeLnB9q7ZpVfHGCprPis
         +G9DSuhnjXaVEFoWc7NLdzb7pHfQC63/rOBwilTOX9jn+1MMPZqgxU7EOqzmJk9Zzc/5
         YGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iwv8IpZKD8oh0+94JIm2Vj5brdUcDB1zd1xCYJrhdio=;
        b=Sg+7+XIxR8BdP9QCd6fe5RF/BYBIxei0mJYOuZgRJwVO5OPNn1f+IUwRF6c4XUuTJG
         s0s0XWKS5zHmcG95KfNUf4SofpmA23lACne66sPcuxOprBcfbp+zqltSY0SsDZLgp16M
         hsxChbKek3jCY5tGMfQ+JqdvNf30D4wSUXJZ6tPVvFdZ1Jts1y4wpLeQgpMjhWU/R017
         Wk6tVL/Nywb34pmupRNfwfuG6vrMrdvVYuacE7Hp8AQsX99VNdaEzmrG2wCrD+RXDGH9
         +su95Yx7POaf7RuYe/JvLRqraTjVlzrjCL2Qx+/qGge1e+G0M5mZjhpjN5R5GmgdfFrC
         5T2g==
X-Gm-Message-State: APjAAAXsD7nd679UbhnEjAb/x/WI/rfi9eJ/X+pwALRQVY/w67A6/53B
        CA1MvO/CJ/JEzFd1AMV9LnlnJ1y+iNBU8Vh2kUpQiA==
X-Google-Smtp-Source: APXvYqz0M4QoQ1wIgHYrlHfenjWhjK7hGQA4ocaYCiIwsDjNkxmHyOxHIKwX/9/Jv04Ym5Tal8BogTN0wcCP8rMiCnE=
X-Received: by 2002:a67:ec03:: with SMTP id d3mr12210270vso.165.1553623079650;
 Tue, 26 Mar 2019 10:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <1553591470-31419-1-git-send-email-ludovic.Barre@st.com>
In-Reply-To: <1553591470-31419-1-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Mar 2019 18:57:22 +0100
Message-ID: <CAPDyKFpvN5ZV-mh5tw8LJCHqtEg7tKTfYOpGXfPpMaBVOkg6-g@mail.gmail.com>
Subject: Re: [PATCH V3 0/5] mmc: mmci: add get_datactrl_cfg callback
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 at 10:11, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch series adds get_datactrl_cfg callback in mmci_host_ops
> to allow to get datactrl configuration specific at variant.
>
> change V3:
> -keep the common functions in mmci_start_data. define
> function used by some variants like an helper
> (example mmci_dctrl_blks used by mmci and sdmmc).
> -To be consistent rename callback for ux500v2
>
> change V2:
> -This V2 has been rebased on
> "mmc: mmci: Cleanup some variant related code" series
> -add helpers functions to define default datactrl value,
> each variant could use these helpers to define datactrl
> and adds their specific bits.
> -use static in qcom and stm32
> -regroup mmci_(ux500v2)variant_init in header file
> to avoid checkpatch warning:
> "WARNING: externs should be avoided in .c files"
> -remove unused variant properties:
>  "datactrl_dpsm_enable"
>  "blksz_datactrl16"
>  "blksz_datactrl4"
>
> Ludovic Barre (5):
>   mmc: mmci: add get_datactrl_cfg callback and helper functions
>   mmc: mmci: define get_dctrl_cfg for legacy variant
>   mmc: mmci: qcom: define get_dctrl_cfg
>   mmc: mmci: stm32: define get_dctrl_cfg
>   mmc: mmci: replace blksz_datactrlXX by get_datactrl_cfg callback
>
>  drivers/mmc/host/mmci.c             | 57 ++++++++++++++++---------------------
>  drivers/mmc/host/mmci.h             | 21 +++++++++-----
>  drivers/mmc/host/mmci_qcom_dml.c    |  6 ++++
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 18 ++++++++++++
>  4 files changed, 63 insertions(+), 39 deletions(-)
>
> --
> 2.7.4
>

Overall I think think this is step in right direction, nice work!

However, I also think there are more things that should be moved from
mmci_start_data() into the new ->get_datactrl_cfg() ops, such as the
SDIO things and the DDR mode things. Although, let's consider that as
improvements that can be made on top.

Besides the little comment I had on patch2, this looks good to me.

Kind regards
Uffe
