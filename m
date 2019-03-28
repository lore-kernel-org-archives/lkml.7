Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791E0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424F8204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ftTM0IlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfC1MxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:53:01 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35509 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1MxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:53:00 -0400
Received: by mail-vs1-f68.google.com with SMTP id e1so12023687vsp.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 05:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=duo/c250JChm6mqM1MNw1FqeN96tWQQN0w0eSCV3lHM=;
        b=ftTM0IlPnRd1aD7beNQ4NNOiZ3FnT8SMtslpFrbFbWrtETAVqQdKA5vLaaFBIaos3q
         4iCCGUZkZGlYhQwFTlBmxBWwHzkihuxW4VZQbX4jLnHHKtyBjETIthkECxLCG8dVgld6
         ednEQWQKu/wOqxVZQRqGQ9hl9g55KqifOuObStO6xQGZ8Fvp5dRwoNqeYjgbeWcOVwNo
         l8TBwMxQ+0wjw0JrVyDSFQE9rpzs+f/sTEUsD4xJGe6rCWnCGJ/LyqGIwLNjI/6Bxu2v
         Rh6VFpFzzMdbCLlGE8F+sQ5/i7/1dHaqxsKAgGdDfFTKnGPwfwg6lL3i5zW0SHolxoMp
         TBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=duo/c250JChm6mqM1MNw1FqeN96tWQQN0w0eSCV3lHM=;
        b=PMI2VGqiLr4snQhCkHv6piazH9hdh1RAyJBrhS93ITv5SgRnXOItPxljTCERaNSbGB
         zAKH+Bb3DSD3zq8xx9utPv769x+OsYUhxU0aBIQEi/2gDzIHJtOTayXFW6mZAAy2ETS7
         JW46PZNvIcMF2tx8QmPZYY++dibWOmqeT54eVcbSEeR7AoKbDQZ1OgdlEw/6PsTc9Q5r
         HBDXENOIBJhywDdpjVKx9P08ZHwfBr2b9ZpAKfcJshYxXJYKd/MoxAKeO/nb7FatLO1O
         md7BgSVpT+61uxYo1v/I2eXSm33L4Qhjt3OPmj6egvKWWqpzlNOKM8ao+fb8SQIk0WBh
         9oGA==
X-Gm-Message-State: APjAAAVtoaUR/UWOoOUSH95oWt09+1EfV43/X5nWSVrCDy1dvjuZoK7Q
        UyD11I0+xwYG2IfMjCw6nrjhKfYdGU1XXX1PWm5cQQ==
X-Google-Smtp-Source: APXvYqy+foB4vW4WH+lM/lGreEKBpmXCKfQdQcWUVEXim0Mrr0evbgx8zMEjwNay7UggN1F4Ie2klRNuGcEHdksIKfI=
X-Received: by 2002:a67:e451:: with SMTP id n17mr979230vsm.35.1553777579061;
 Thu, 28 Mar 2019 05:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <1553677532-3539-1-git-send-email-ludovic.Barre@st.com>
In-Reply-To: <1553677532-3539-1-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 Mar 2019 13:52:23 +0100
Message-ID: <CAPDyKFqi0FwUuB56GQPRtuioNeFSSg-QdtWzk4S6BDnuYbfeAg@mail.gmail.com>
Subject: Re: [PATCH V4 0/5] mmc: mmci: add get_datactrl_cfg callback
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

On Wed, 27 Mar 2019 at 10:05, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch series adds get_datactrl_cfg callback in mmci_host_ops
> to allow to get datactrl configuration specific at variant.
>
> change V4:
> -keep mmci and ux500v2 variant init in the c file.
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
>  drivers/mmc/host/mmci.c             | 56 +++++++++++++++++--------------------
>  drivers/mmc/host/mmci.h             | 18 +++++++-----
>  drivers/mmc/host/mmci_qcom_dml.c    |  6 ++++
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 18 ++++++++++++
>  4 files changed, 61 insertions(+), 37 deletions(-)
>
> --
> 2.7.4
>

Applied for next, thanks!

Kind regards
Uffe
