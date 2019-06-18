Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C709FC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6962084B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m+AzwmOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbfFRQqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:46:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37472 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbfFRQqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:46:42 -0400
Received: by mail-io1-f66.google.com with SMTP id e5so31474133iok.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 09:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwFihAPGP6wzOK+kBPKAQVi7liUgqZUIPSL5DDnHSPo=;
        b=m+AzwmOJvaqda0PA4A3kH50zB/aKuXYTJXIq2ncP7kss8pwIRCHarGkn0vn0qekVXg
         DMvb6pe/4kCyyxBZ0fX6xNUPYpe8TkJznF4Xt5mjwezAwrKDdVHPHi+iGXsTVh1P0fVZ
         Vqxp87twM29o0lYzD1QiCTokXsk0tq1+P/Gw/KhCbI2C3EuwnBd8nWLPjfxOimKybbu5
         EBdlMIp+hKFR9yU3ccN5od4zBL16bzc3l8xbpURoquyppmDLUFjdHZbKNucs4GoVV3eS
         RwEdZXgKKJ8mrz//9UiPKQTRkBIeWaeNORJngOoJEynz57Wh/WpkxK8md8YA59mWm5ok
         dELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwFihAPGP6wzOK+kBPKAQVi7liUgqZUIPSL5DDnHSPo=;
        b=NOuizTaGEae9+gnS0PhkkrGeysY/ijxU8LGFHhygMLkgkeQcLlQE8XRsoz6i1pd6fm
         tU1iyUzGeAvnjpKingqM8dxOCLAgevSbHeMEZdm3PMGmFfz2DbcJCYuivTP2LJ9PMz+E
         eeqgVoxVN5F5ST+q4tumUvUvLrWxPXDBcjVxMkNmDkrXI521Lj0cEyoorC9xNCl7w9D8
         2M5CleIpeKqlm0cmlQqEKyaYAywqHk7M3VzTpW95o9nt4nEqqaYFpNaXUgIJXemNV1N4
         zKb9ngMhNFkbDtJTeJCsSDTiHw1SqYpgpDh8bSP+ePzDv4DLZ0f+ocRCws5EAzdVvzr9
         OJbw==
X-Gm-Message-State: APjAAAX+ruscR4DcOS7fxnlfuJ79QDirRXsa3gTKq5Zc1VuBkrYk4P/e
        n9+O1G97VA7fDltxgGUbcHYMbzAw8FxURBwSyNolyQ==
X-Google-Smtp-Source: APXvYqwfP4H5Qtjk8/J7nRjXv99FeQJa7fltAX57cFgZoswJDUwAV1Fen3fMy8Mm2DooyBSWOFHO5G5QFo8XfTvex1M=
X-Received: by 2002:a02:1a86:: with SMTP id 128mr91068852jai.95.1560876401463;
 Tue, 18 Jun 2019 09:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190617115454.3226-1-lee.jones@linaro.org>
In-Reply-To: <20190617115454.3226-1-lee.jones@linaro.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 18 Jun 2019 18:46:29 +0200
Message-ID: <CAKv+Gu_qd9KrXHVSVHCoM42D8ACjU5onzFGJPTTBGOsVJpeayg@mail.gmail.com>
Subject: Re: [PATCH 1/1] scsi: ufs-qcom: Add support for platforms booting ACPI
To:     Lee Jones <lee.jones@linaro.org>
Cc:     agross@kernel.org, David Brown <david.brown@linaro.org>,
        alim.akhtar@samsung.com, avri.altman@wdc.com,
        pedrom.sousa@synopsys.com, jejb@linux.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-scsi@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jlhugo@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019 at 13:55, Lee Jones <lee.jones@linaro.org> wrote:
>
> New Qualcomm AArch64 based laptops are now available which use UFS
> as their primary data storage medium.  These devices are supplied
> with ACPI support out of the box.  This patch ensures the Qualcomm
> UFS driver will be bound when the "QCOM24A5" H/W device is
> advertised as present.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  drivers/scsi/ufs/ufs-qcom.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
> index 3aeadb14aae1..364af6a63e35 100644
> --- a/drivers/scsi/ufs/ufs-qcom.c
> +++ b/drivers/scsi/ufs/ufs-qcom.c
> @@ -12,6 +12,7 @@
>   *
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/time.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> @@ -164,6 +165,9 @@ static int ufs_qcom_init_lane_clks(struct ufs_qcom_host *host)
>         int err = 0;
>         struct device *dev = host->hba->dev;
>
> +       if (has_acpi_companion(dev))
> +               return 0;
> +
>         err = ufs_qcom_host_clk_get(dev, "rx_lane0_sync_clk",
>                                         &host->rx_l0_sync_clk, false);
>         if (err)
> @@ -1208,9 +1212,13 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>                         __func__, err);
>                 goto out_variant_clear;
>         } else if (IS_ERR(host->generic_phy)) {
> -               err = PTR_ERR(host->generic_phy);
> -               dev_err(dev, "%s: PHY get failed %d\n", __func__, err);
> -               goto out_variant_clear;
> +               if (has_acpi_companion(dev)) {
> +                       host->generic_phy = NULL;
> +               } else {
> +                       err = PTR_ERR(host->generic_phy);
> +                       dev_err(dev, "%s: PHY get failed %d\n", __func__, err);
> +                       goto out_variant_clear;
> +               }
>         }
>
>         err = ufs_qcom_bus_register(host);
> @@ -1680,6 +1688,14 @@ static const struct of_device_id ufs_qcom_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, ufs_qcom_of_match);
>
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id ufs_qcom_acpi_match[] = {
> +       { "QCOM24A5" },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(acpi, ufs_qcom_acpi_match);
> +#endif
> +
>  static const struct dev_pm_ops ufs_qcom_pm_ops = {
>         .suspend        = ufshcd_pltfrm_suspend,
>         .resume         = ufshcd_pltfrm_resume,
> @@ -1696,6 +1712,7 @@ static struct platform_driver ufs_qcom_pltform = {
>                 .name   = "ufshcd-qcom",
>                 .pm     = &ufs_qcom_pm_ops,
>                 .of_match_table = of_match_ptr(ufs_qcom_of_match),
> +               .acpi_match_table = ACPI_PTR(ufs_qcom_acpi_match),
>         },
>  };
>  module_platform_driver(ufs_qcom_pltform);
> --
> 2.17.1
>
