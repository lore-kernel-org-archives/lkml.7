Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769FAC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4167221773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMzPq4d2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbfDQUDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:03:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38233 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQUDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:03:38 -0400
Received: by mail-io1-f67.google.com with SMTP id v4so86500ioj.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 13:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tASHWYMDgs8WkuZjXBKWpqs0ibqOvHmjO6fsID6xnTI=;
        b=EMzPq4d22BP7qvTUx62qK0+jX3YNCZuPN6x9tZvu/Vr4QptBl+R1W4E5mTcCHh2wsV
         Un2TtGUQ8IgsPz35Ya6OAHBYGk7j33fPZ49IasYhraV8oX7DX3pfN59aGV/p6eemtR+y
         Q6HkCS1Zp19k6xHBKmQRcWuxDeBDl8DolPuCzy7PILkiMydAnJnSO6/u4maDa8kdrLwr
         5O/lWU5vqfuZLfcX4DzUezoj6YXwMU05eXUY2nMk/Dv4OKaTo6AGaoZPbFQXPRZaDKfM
         xz7FGDUt33leme83NCzVw+BirQRDMoPKqPImZVxd11AVhOi+15wzCoohVKnnpyGvZ4Uf
         Modg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tASHWYMDgs8WkuZjXBKWpqs0ibqOvHmjO6fsID6xnTI=;
        b=NfZW2NBEBMYbc6ukI/ezHmWvgyJOebKvgcJoFGDtGyPFILtHLHfaKhFKwepzA+ZpdM
         6iLV4EL4dOFEhRIVNsDmlcskpzI3SkOiud/5eZTpkYZkTeO83c/D46t47miZ25doaMuq
         OfnfrspI6bPGXkowLZRQggZ+Uc7ZMoYbzV6KcSl6pvQKhaEpNDVDjM4k6lj2MIfQoWH2
         5Jim9AM4CK6ktA7Mc7gibC1o9mTWm0KgZlDMe069QyXwf/ANEdQomGQu0fJHqqBEFurT
         wlsGasogA7c6EhyNtaD0FeaBopq80m8zPMgk3Z9qthuyOGypoGiOFLVvvWz64mvQt4RL
         1D2A==
X-Gm-Message-State: APjAAAU9tONFwb7Db2zM6Fl+GHXw8yMMZBJHEfgMSbEaOxLCEJja8qnL
        i8uX8w6B4neLBzWzBL48fVVfdv3F1thtN0fObNCBwg==
X-Google-Smtp-Source: APXvYqx0p5sc1yq1TttRNSpOV+vt9sFxFSH/LXDnPThuALTBuHnKbas6yvzRq9jZ6uZTBYSdVyA7e1Nqy85VpQaIViY=
X-Received: by 2002:a5d:96cb:: with SMTP id r11mr1162655iol.295.1555531417668;
 Wed, 17 Apr 2019 13:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com> <1555344260-12375-6-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1555344260-12375-6-git-send-email-suzuki.poulose@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 17 Apr 2019 14:03:26 -0600
Message-ID: <CANLsYkykMjiW3JAUr7vm4x2GAN=pDO1neThe-XuWrnTfH5RJyw@mail.gmail.com>
Subject: Re: [PATCH v2 05/36] coresight: tmc: Cleanup power management
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Robert Walker <robert.walker@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019 at 10:05, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Drop the power only if we were successful in probing the device.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index 647b6aa..c6a5462 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -432,8 +432,6 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>                 drvdata->size = readl_relaxed(drvdata->base + TMC_RSZ) * 4;
>         }
>
> -       pm_runtime_put(&adev->dev);
> -
>         desc.pdata = pdata;
>         desc.dev = dev;
>         desc.groups = coresight_tmc_groups;
> @@ -476,6 +474,8 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>         ret = misc_register(&drvdata->miscdev);
>         if (ret)
>                 coresight_unregister(drvdata->csdev);
> +       else
> +               pm_runtime_put(&adev->dev);
>  out:
>         return ret;
>  }

I have applied patches 1 to 5.

> --
> 2.7.4
>
