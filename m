Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5B8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799252070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VMA/pZDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbfCZRrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:47:22 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34341 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfCZRrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:47:22 -0400
Received: by mail-vs1-f65.google.com with SMTP id t78so8189459vsc.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EIFnF00FXcKh4R12Re75dzeYfsQJnCgr66XgIp88zsI=;
        b=VMA/pZDRrCdm7/w9/Vblo8cq+lCbyJIt0n3mQZfUbtOfcJ/Ivd1nUmIppdDmzPf8No
         AU+OIqpyXEr9h29bgUflWddF8EWYAay0XCYShxY68RYyrP62E5FwuOjEeT8Y/HiRXlbG
         89rbhO72KRx8PthKyP4CeraSjvPaEk+lfVhVin348BcP3/4NfMufPYBNA0y+VQqwaGng
         IzfpD2H8FnNVEZSgQwDHXzQTFC/iSX04GsB52etnrBgcGVn/pBpn2r2OwoxEIJ5TONU2
         oH0hNFZWZE966rhqLvt+FXC68otS67RBoZWz3+bLVyXs1DP4JUEmdKqFmL/reqnfYiCL
         Wryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EIFnF00FXcKh4R12Re75dzeYfsQJnCgr66XgIp88zsI=;
        b=Tk6HIqMUGMdcHIDUQ3IZ15s374gx8fYoy+d85qpfKiONCifAAOYxOlWCFFg9MjNwOK
         2cJAfaVT/ZpmGlxxPoY1z2zSLOwz20izN7WDFU5CUEEPwpy+1B12dedOGzr8a2+Vac9j
         LZ/dyhfGqEtPf0Law06lRThb2TbDU7DZ95jD8AEaPGeICE28oiwlLLeHdXQFf7fQvsza
         BaWb4HpPFuKmKo7tCvQBZSOh3ln6kXwCcbHVx7n+Qb2/HV63hNpj0me7/vgVDPChny4D
         Gw+bqjm8m7SkzImbG5+mEV9cNtDjRQoN2OnpMPqooMNxcEp2CnzRj1pGqSZv0iUj1Nul
         tx2A==
X-Gm-Message-State: APjAAAUddv1EtwG4PQ9ZWcWAamRnrup2QUvy6DmD1KgwcAbIP1rLcthT
        vq9BbjdQ9wHk4vKtuhUWA2g222iah2qYuy4AeZ7iFQ==
X-Google-Smtp-Source: APXvYqy+5k+FVlSzRhUXpy0jaRbd0varJIa4ZozwHcRbhQ0nuUadT3DXh1XhUJbc2kACQudkW9yPZwbQ6WN/LaGLdcE=
X-Received: by 2002:a67:e451:: with SMTP id n17mr19156822vsm.35.1553622441370;
 Tue, 26 Mar 2019 10:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <1553591470-31419-1-git-send-email-ludovic.Barre@st.com> <1553591470-31419-3-git-send-email-ludovic.Barre@st.com>
In-Reply-To: <1553591470-31419-3-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Mar 2019 18:46:44 +0100
Message-ID: <CAPDyKFoOugNTxN_g8Co1pBMkTku6+zMU40vqo-e0pZt+1rs9cw@mail.gmail.com>
Subject: Re: [PATCH V3 2/5] mmc: mmci: define get_dctrl_cfg for legacy variant
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
> This patch defines get_dctrl_cfg callback for legacy variants
> whatever DMA_ENGINE configuration.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 31 +++++++++++++++++++++++--------
>  drivers/mmc/host/mmci.h |  3 +++
>  2 files changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 9e6a2c1..4041e36 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -46,12 +46,6 @@
>
>  #define DRIVER_NAME "mmci-pl18x"
>
> -#ifdef CONFIG_DMA_ENGINE
> -static void mmci_variant_init(struct mmci_host *host);
> -#else
> -static inline void mmci_variant_init(struct mmci_host *host) {}
> -#endif

Looks like you are moving the declaration to the header file. I would
rather keep it here as there is no point in sharing to another c-file
(at least not yet). The same applies for the new ux500v2 init
function.

Other than that, this looks good to me!

Kind regards
Uffe
