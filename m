Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217D3C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 19:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEAD220828
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 19:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="SN8HwSqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfLWTrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 14:47:05 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46875 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfLWTrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 14:47:05 -0500
Received: by mail-ot1-f66.google.com with SMTP id k8so6192051otl.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 11:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zFugXbNXjuTa6MUeYElsmTqLleXZtVtXWa7qU/dvhHs=;
        b=SN8HwSqpq/VHn71r5rosiHbn3JAeoPbdRMlzYznGgDelpBcJ1uXQQzmcNQGLuoDJ/J
         DjgfzxVK2KrWxwM6Nhh7rwPitEWDF7dj3Q2VmEkNvKkPv58eyB81CCoHm5gHxvdSVaid
         IfACfR9Yy7bHPA9K1sNnL5ARUsWrgVcBrLGMjvXZHpucgPrCh8yEZOvHXMT/LAcMMLJY
         p9/6yDTWTNTnKmdfzt/aW0+jrLe5cT/AMPpBErNLjj3QA36jNpu/yn1vIUv5aCGLLqz1
         tGnpyDsiEw2aGsyzGL34leDVlBBvSp1A0Rvm9LaKcTEJPaoYXKHi0KETPdbHkzs+i8RJ
         XE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zFugXbNXjuTa6MUeYElsmTqLleXZtVtXWa7qU/dvhHs=;
        b=sr9g6pnV2CAPx8VWLhvoKmYTDENJgJSf9asztCJ+JUO+87i9s8FjQC8H+09zm0vLNV
         xHpnxAQsdkKvMZuR7QEssrPYT7ZyDGzyNZcTeyrFrBdhJ9KFShDX9rcAADHedBfuv+Ix
         uvlVreZKr086eEH+TLcFxox/VH7gO2AwPL/fUORaTT5v0m0dLPkPvTiRtoRDtUUc0wVT
         FjwmZMwqjPaKnLh6ruN5adgouG7Lu0jT89L4B54h7gcRx0bR+mSvNisKbVJaDIxh8jUN
         MGj3AYhFbAnHckAt0Rd9pU0QhyppHM0FJLsDXS2enVN+0orpENZQVDa2AG+cNO+vwi+w
         /Seg==
X-Gm-Message-State: APjAAAXT8j3+U8GJIQ6ILTvOiiDV7LgMMNGb7A8bYZtqcsJ/IQqwhv9t
        dTFko0Rh5yiHVpTA12yTfk18kXh0immLNC6c5Ye9nA==
X-Google-Smtp-Source: APXvYqyfMS95KOfmTenlUkjlprOqnr5a++lMI//c8tYJXN+PxN7viHyNmp3UYd9kVKO3vHUToL6ZZtVWwTDGUd7WYRU=
X-Received: by 2002:a9d:7852:: with SMTP id c18mr28016742otm.247.1577130424187;
 Mon, 23 Dec 2019 11:47:04 -0800 (PST)
MIME-Version: 1.0
References: <1577122577157232@kroah.com>
In-Reply-To: <1577122577157232@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 23 Dec 2019 11:46:53 -0800
Message-ID: <CAPcyv4jfpOX85GWgNTyugWksU=e-j=RhU_fcrcHBo4GMZ8_bhw@mail.gmail.com>
Subject: Re: Patch "tpm_tis: reserve chip for duration of tpm_tis_core_init"
 has been added to the 5.4-stable tree
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christian Bundy <christianbundy@fraction.io>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please drop the:

   Fixes: 5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing IRQ's")

...tag. I had asked Jarkko to do that here:

https://lore.kernel.org/r/CAPcyv4h60z889bfbiwvVhsj6MxmOPiPY8ZuPB_skxkZx-N+OGw@mail.gmail.com/

...but it didn't get picked up.

On Mon, Dec 23, 2019 at 9:37 AM <gregkh@linuxfoundation.org> wrote:
>
>
> This is a note to let you know that I've just added the patch titled
>
>     tpm_tis: reserve chip for duration of tpm_tis_core_init
>
> to the 5.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>      tpm_tis-reserve-chip-for-duration-of-tpm_tis_core_init.patch
> and it can be found in the queue-5.4 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
> From 21df4a8b6018b842d4db181a8b24166006bad3cd Mon Sep 17 00:00:00 2001
> From: Jerry Snitselaar <jsnitsel@redhat.com>
> Date: Wed, 11 Dec 2019 16:54:55 -0700
> Subject: tpm_tis: reserve chip for duration of tpm_tis_core_init
>
> From: Jerry Snitselaar <jsnitsel@redhat.com>
>
> commit 21df4a8b6018b842d4db181a8b24166006bad3cd upstream.
>
> Instead of repeatedly calling tpm_chip_start/tpm_chip_stop when
> issuing commands to the tpm during initialization, just reserve the
> chip after wait_startup, and release it when we are ready to call
> tpm_chip_register.
>
> Cc: Christian Bundy <christianbundy@fraction.io>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Cc: stable@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
> Fixes: 5b359c7c4372 ("tpm_tis_core: Turn on the TPM before probing IRQ's")
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
>  drivers/char/tpm/tpm_tis_core.c |   35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -899,13 +899,13 @@ int tpm_tis_core_init(struct device *dev
>
>         if (wait_startup(chip, 0) != 0) {
>                 rc = -ENODEV;
> -               goto out_err;
> +               goto err_start;
>         }
>
>         /* Take control of the TPM's interrupt hardware and shut it off */
>         rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>         if (rc < 0)
> -               goto out_err;
> +               goto err_start;
>
>         intmask |= TPM_INTF_CMD_READY_INT | TPM_INTF_LOCALITY_CHANGE_INT |
>                    TPM_INTF_DATA_AVAIL_INT | TPM_INTF_STS_VALID_INT;
> @@ -914,21 +914,21 @@ int tpm_tis_core_init(struct device *dev
>
>         rc = tpm_chip_start(chip);
>         if (rc)
> -               goto out_err;
> +               goto err_start;
> +
>         rc = tpm2_probe(chip);
> -       tpm_chip_stop(chip);
>         if (rc)
> -               goto out_err;
> +               goto err_probe;
>
>         rc = tpm_tis_read32(priv, TPM_DID_VID(0), &vendor);
>         if (rc < 0)
> -               goto out_err;
> +               goto err_probe;
>
>         priv->manufacturer_id = vendor;
>
>         rc = tpm_tis_read8(priv, TPM_RID(0), &rid);
>         if (rc < 0)
> -               goto out_err;
> +               goto err_probe;
>
>         dev_info(dev, "%s TPM (device-id 0x%X, rev-id %d)\n",
>                  (chip->flags & TPM_CHIP_FLAG_TPM2) ? "2.0" : "1.2",
> @@ -937,13 +937,13 @@ int tpm_tis_core_init(struct device *dev
>         probe = probe_itpm(chip);
>         if (probe < 0) {
>                 rc = -ENODEV;
> -               goto out_err;
> +               goto err_probe;
>         }
>
>         /* Figure out the capabilities */
>         rc = tpm_tis_read32(priv, TPM_INTF_CAPS(priv->locality), &intfcaps);
>         if (rc < 0)
> -               goto out_err;
> +               goto err_probe;
>
>         dev_dbg(dev, "TPM interface capabilities (0x%x):\n",
>                 intfcaps);
> @@ -977,10 +977,9 @@ int tpm_tis_core_init(struct device *dev
>                 if (tpm_get_timeouts(chip)) {
>                         dev_err(dev, "Could not get TPM timeouts and durations\n");
>                         rc = -ENODEV;
> -                       goto out_err;
> +                       goto err_probe;
>                 }
>
> -               tpm_chip_start(chip);
>                 chip->flags |= TPM_CHIP_FLAG_IRQ;
>                 if (irq) {
>                         tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
> @@ -991,18 +990,20 @@ int tpm_tis_core_init(struct device *dev
>                 } else {
>                         tpm_tis_probe_irq(chip, intmask);
>                 }
> -               tpm_chip_stop(chip);
>         }
>
> +       tpm_chip_stop(chip);
> +
>         rc = tpm_chip_register(chip);
>         if (rc)
> -               goto out_err;
> -
> -       if (chip->ops->clk_enable != NULL)
> -               chip->ops->clk_enable(chip, false);
> +               goto err_start;
>
>         return 0;
> -out_err:
> +
> +err_probe:
> +       tpm_chip_stop(chip);
> +
> +err_start:
>         if ((chip->ops != NULL) && (chip->ops->clk_enable != NULL))
>                 chip->ops->clk_enable(chip, false);
>
>
>
> Patches currently in stable-queue which might be from jsnitsel@redhat.com are
>
> queue-5.4/iommu-fix-kasan-use-after-free-in-iommu_insert_resv_region.patch
> queue-5.4/iommu-vt-d-fix-dmar-pte-read-access-not-set-error.patch
> queue-5.4/iommu-set-group-default-domain-before-creating-direct-mappings.patch
> queue-5.4/tpm_tis-reserve-chip-for-duration-of-tpm_tis_core_init.patch
> queue-5.4/iommu-vt-d-allocate-reserved-region-for-isa-with-correct-permission.patch
> queue-5.4/iommu-vt-d-set-isa-bridge-reserved-region-as-relaxable.patch
