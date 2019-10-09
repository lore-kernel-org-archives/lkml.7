Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4550C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA0721835
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BccNwjKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbfJIJM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:12:57 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46218 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfJIJM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:12:56 -0400
Received: by mail-ua1-f68.google.com with SMTP id m21so522185ual.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 02:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p1GmngvaE0ei9mnU0CMOs2O9a2/80q1j0u6r2u5SeZc=;
        b=BccNwjKJUEGqADR82Dz9D/6hW+muC5tovZ4TZzhwUcNnNClOKsj/TwIl0wYjsBc6x/
         k1jtHRsZBJkB5XEBmk3c3UjCkpbbJEm71c44rBeHs/1RinFqBdS/F2PzyJWDllL97ZWq
         R36grS6Yw8KUikd970xY+zw1tW0efxzzxuwQj++jIOgnM40NPOcZT1j0GIHNir/gUb9D
         SsbIN4DTBuySQXcqwM56bQmkLUurSE8OGIOQjpx5TF3imZWJgl5h8U/i/wbheVJOR3uU
         XV1QEGFlVmSwqtsGm4UUlvuHWl+RqT5TEvnUXoXnM54OWXZ+iKW12DFa69CWmIskhgBS
         w/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p1GmngvaE0ei9mnU0CMOs2O9a2/80q1j0u6r2u5SeZc=;
        b=Og7XL8/RkFaEdsQbCBZftC6+C4a1eLN7Tuu6PZRjZjm/fEiL59vZgmc+u46yW4FSx5
         qIhQJlPzhpoq54p/sD5j9N6PoXa3hmiVf4C3YY3nWEf6DNuh6Um5QamfENhkOQC2F3S5
         iYamvr8SoDrWCDVm3AylhvrywLj2hjSfKto1gUhY0hy9BxcXJizUCNuAIoZaiBqV77f/
         Vc/UeEqGJT5vYr1WCqESWgKhLz16a1qDsjTgDZhk3Ipm5EPmb1cXgto9eH3Oc8/uvdjO
         kb3eMZLYw+mS+kZjyZAKFdvBqo0J5Pe3sHi2VPk6uz4tuiwpitp9ricqauEQo4jW7tUS
         Ereg==
X-Gm-Message-State: APjAAAUF+9xRcMraVc97+ZJsGjIv1LXE5iUCRLatf6qMJnuKg+04Cp4z
        9edsMxwgaR8gAow4tzV7N93zUI/xwPqDdWiEwrtb5w==
X-Google-Smtp-Source: APXvYqzHUvKtG9TlAFWzdGLKFE3B3LLPRPS/NhDVFx+CEadl3quKcUNTlMODJCYW2p+AVM5OUZYunx3BcWwMwDCc9Ds=
X-Received: by 2002:ab0:331a:: with SMTP id r26mr1234478uao.104.1570612375253;
 Wed, 09 Oct 2019 02:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191009012818.32763-1-vadivel.muruganx.ramuthevar@linux.intel.com>
In-Reply-To: <20191009012818.32763-1-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Oct 2019 11:12:19 +0200
Message-ID: <CAPDyKFqDB_aOikZYSDEvQKF3PsD=AXq0PZJTj8AUAH0XaGj8Eg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: sdhci-of-arasan: Add Support for Intel LGM SDXC
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2019 at 03:28, Ramuthevar,Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
> The current arasan sdhci PHY configuration isn't compatible
> with the PHY on Intel's LGM(Lightning Mountain) SoC devices.
>
> Therefore, add a new compatible, to adapt the Intel's LGM
> SDXC PHY with arasan-sdhc controller to configure the PHY.
>
> Linux code base : V5.4-rc1
>
> Ramuthevar Vadivel Murugan (2):
>   dt-bindings: mmc: sdhci-of-arasan: Add new compatible for Intel LGM
>     SDXC
>   mmc: sdhci-of-arasan: Add Support for Intel LGM SDXC
>
> changes from v1:
>  -  commit message updated
>  -  Acked-by tag added
>
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 17 +++++++++++++++++
>  drivers/mmc/host/sdhci-of-arasan.c                     | 15 +++++++++++++++
>  2 files changed, 32 insertions(+)

Applied for next, thanks!

Kind regards
Uffe
