Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB36C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C0820659
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOKrX6o4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbfGPSSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:18:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46162 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387934AbfGPSSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:18:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so21949364wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 11:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFVmE96hZiN7HFPIypSQJMgA2zK7b8H91G9uqg1FHEs=;
        b=DOKrX6o4spGobtmQUSvLtGjdjPvmkyaEcIN6+s/3r75DYK5AKxdVcU+k5PxjSRV8xy
         5iOuMps9R+LM74CmLIEd87XsZrdn+OG5XfaQvWuZ7ZpaO0uoJkIDNHmMcqRJHol2mxT9
         T/sPQT63t4BMrcyfuOYpBCuwdXaqtY9XEqpoYB2SF7CIk3zS/nE7xITKKXRh8ifkUE+C
         EFWCy0NYShMZaiJpg0gIrxY/1n7yrs9oLnZj7oKK/8XOUOjdslkcLjMvvCY0N8N4cXiV
         i39JLrIPcmjpUMFuagvy3fYgFbmOQikNOgXUv1VbaJZ+/sNGDUOjnaE3ch6IptOn/PQ4
         A3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFVmE96hZiN7HFPIypSQJMgA2zK7b8H91G9uqg1FHEs=;
        b=BQkVttRLuGqlz1dD423EkjTHLT2dkvdPRZgXNnyb4JjqjM7ilkQ7x9jPGd2etcgZu3
         bvoXoHjIietMIvTyn8yEgVu2rsV+GrjiEYUy3rd5cr3gmzYJKiinkfdnbG80qSqACsV0
         woziwjw62hhbbvc0w2B+Km0OF/nqZE5w7qJm9P+pWd/Y77NRDPmPEiLcNiWLoOlsErJ3
         9SAa+hfTlAKOnrW4hace9hY1zNi5AHMy4I4ZjY81RIhaQyxBUBNmWTr3EFz+WQ/WAMd2
         Ne+oz+qcySml91ZfyiJh3kF80VtjDO1zMI3HcMdcxjLX+4GwdD4uB2uvPQDL6WSrrp8w
         klRw==
X-Gm-Message-State: APjAAAUOfxipP8OjMRJKbOlVLl373qzPTGvG3UxDy1VK4ASWCKNM+jAr
        ly1EL5F+bpKqJ+uKQLuEUKBCgHV5lg4UiP7VZlk=
X-Google-Smtp-Source: APXvYqyCHu81CG+PlVEBK87dHXvH5rkHK7MX4ndta4/qYTrZXZ/FWuDy2Iub9ZvZrFwYlv5BeuYJpJIqnwV60yzFP2w=
X-Received: by 2002:a5d:6ccd:: with SMTP id c13mr32875978wrc.4.1563301085015;
 Tue, 16 Jul 2019 11:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <1563300606-28434-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
In-Reply-To: <1563300606-28434-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 16 Jul 2019 14:17:52 -0400
Message-ID: <CADnq5_NvBrRd61=a5XxvVKMs_+_JgBK8ALh_CgOTiG2ZVCEGKQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Fix EEH during kexec
To:     KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>
Cc:     Chunming Zhou <David1.Zhou@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 2:15 PM KyleMahlkuch
<kmahlkuc@linux.vnet.ibm.com> wrote:
>
> During kexec some adapters hit an EEH since they are not properly
> shut down in the radeon_pci_shutdown() function. Adding
> radeon_suspend_kms() fixes this issue.
>
> Since radeon.h is now included in radeon_drv.c radeon_init() needs
> a new name. I chose radeon_initl(). This can be changed if there is
> another suggestion for a name.
>
> Signed-off-by: Kyle Mahlkuch <Kyle.Mahlkuch at ibm.com>
> ---
>  drivers/gpu/drm/radeon/radeon_drv.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index 2e96c88..550f9b0 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -32,6 +32,7 @@
>  #include <drm/drmP.h>
>  #include <drm/radeon_drm.h>
>  #include "radeon_drv.h"
> +#include "radeon.h"
>
>  #include <drm/drm_pciids.h>
>  #include <linux/console.h>
> @@ -344,11 +345,21 @@ static int radeon_pci_probe(struct pci_dev *pdev,
>  static void
>  radeon_pci_shutdown(struct pci_dev *pdev)
>  {
> +       struct drm_device *ddev = pci_get_drvdata(pdev);
> +       struct radeon_device *rdev = ddev->dev_private;
> +
>         /* if we are running in a VM, make sure the device
>          * torn down properly on reboot/shutdown
>          */
>         if (radeon_device_is_virtual())
>                 radeon_pci_remove(pdev);
> +
> +       /* Some adapters need to be suspended before a
> +       * shutdown occurs in order to prevent an error
> +       * during kexec.
> +       */
> +       if (rdev->family == CHIP_CAICOS)

You really should be suspending for all asics, not just CAICOS,
otherwise, you may have engines in use.

Alex

> +               radeon_suspend_kms(ddev, true, true, false);
>  }
>
>  static int radeon_pmops_suspend(struct device *dev)
> @@ -589,7 +600,7 @@ static long radeon_kms_compat_ioctl(struct file *filp, unsigned int cmd, unsigne
>         .driver.pm = &radeon_pm_ops,
>  };
>
> -static int __init radeon_init(void)
> +static int __init radeon_initl(void)
>  {
>         if (vgacon_text_force() && radeon_modeset == -1) {
>                 DRM_INFO("VGACON disable radeon kernel modesetting.\n");
> @@ -621,7 +632,7 @@ static void __exit radeon_exit(void)
>         radeon_unregister_atpx_handler();
>  }
>
> -module_init(radeon_init);
> +module_init(radeon_initl);
>  module_exit(radeon_exit);
>
>  MODULE_AUTHOR(DRIVER_AUTHOR);
> --
> 1.8.3.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
