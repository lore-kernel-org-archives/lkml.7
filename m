Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37069C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BEE21902
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CQT8REzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbfCUQ6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:58:15 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39716 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUQ6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:58:15 -0400
Received: by mail-vs1-f65.google.com with SMTP id g127so4093413vsd.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mvmfJ2GJzv+i0A+ojHx6zNfP9KkE7Bwa3nrNcMphWoQ=;
        b=CQT8REzbB+rCSoinQ/XhOthEPi+bgJrX00PEqD/NPnHoaXrOVsZQ0n93lyzGVKilYH
         55+TWbeCsML7FEHReiFH+VtXQ9ycbF1HZDEOrMo4CTeAiuZg1IG5qgQjk96bWDlPq+Mf
         Fdv5bWhizfBU73bZMR33fReE6QDNyFSELnRfwf07gxoTIhCDSs10N/V9wRf/4vRf+1++
         DGDBN56JT114tSBz0F9RpSjMLk9hq/Vr5xfXlvLXfP+FVIC1QdGKhiAT4JWgChTfdCbE
         qjGrgP5Km6RVGBLW5zzvF23rFWO1BGk3aNltrl1i6QsusssUSwTVx11o8tj3sw4WUWCS
         awug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mvmfJ2GJzv+i0A+ojHx6zNfP9KkE7Bwa3nrNcMphWoQ=;
        b=BbaYhF9Wuwy33k6L9qx5KVgjD4lvrBiMApMCVWwRXk94OZuZLJYekrTE1+H4U4zmyH
         ejtHD3eAgxU2yptecxuC/ZU3sO9L+oqSmjYQvQtnkw3ofwAad6mABlY/cNIBSCngd0ag
         4V3dQRgLglMyT8At9HR5YmWbbXKffEe5ckjyza39x6ZXNQ4/5KPP13urmJN4kcSsQEq6
         hOF53XHEWaUllOP07Qz2vU3Cu1eOVrvTxrt7S1VUfVrUANHB/7lxzj27hOPcOJqtZbDN
         3eKz5YAbLCjRXJAiwIW8cIzyc0JAAX+KQDWPaupaWfqlGuuGLJUX8m+P90aKb7vfafa+
         7Q2A==
X-Gm-Message-State: APjAAAWue8A6aIZmHmXC7civtgCe0HFmVnTqi+ijuwTgI7ftu3PdbXst
        kcp8xIUeQQUkIOEnPqgLBB+7+QfGojaMUuvQVXuGnA==
X-Google-Smtp-Source: APXvYqx+bwm42Zi68qUNXr6kE/gv75bBvbxKaAgXE+3DR7wX1ko2wXh0+VVu51np3tcHPZuQHGD7on7QckR16lnUhYg=
X-Received: by 2002:a05:6102:157:: with SMTP id a23mr2789034vsr.34.1553187494609;
 Thu, 21 Mar 2019 09:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <1551976742-4358-1-git-send-email-ludovic.Barre@st.com> <1551976742-4358-2-git-send-email-ludovic.Barre@st.com>
In-Reply-To: <1551976742-4358-2-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Mar 2019 17:57:38 +0100
Message-ID: <CAPDyKFq52dXPP+-peh82uCqTDFhmXvYWbTyncHDr_Oyo8Bd1VA@mail.gmail.com>
Subject: Re: [PATCH V2 1/6] mmc: mmci: add get_datactrl_cfg callback
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

On Thu, 7 Mar 2019 at 17:39, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch adds get_datactrl_cfg callback in mmci_host_ops
> to allow to get datactrl configuration specific at variant.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 6bde28c..a59049b 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -362,6 +362,7 @@ struct mmci_host_ops {
>                          bool next);
>         void (*unprep_data)(struct mmci_host *host, struct mmc_data *data,
>                             int err);
> +       u32 (*get_datactrl_cfg)(struct mmci_host *host);
>         void (*get_next_data)(struct mmci_host *host, struct mmc_data *data);
>         int (*dma_setup)(struct mmci_host *host);
>         void (*dma_release)(struct mmci_host *host);
> --
> 2.7.4
>

Perhaps squash this change with patch2, they seems to belong to each
other as they are both the preparation that is needed for the
following changes on top.

Kind regards
Uffe
