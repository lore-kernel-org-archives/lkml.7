Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A57BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E88E20838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhpNoJrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387560AbfHASsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:48:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42008 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730581AbfHASsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:48:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so24767047wrr.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 11:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/1PThvG6HlNQK6DZeGkXSIrzDFc8NG/LOsqd0jFoLTs=;
        b=OhpNoJrVXXDwaXFnI8nQSCARSV1633spNLaslFPex/U5plfzLdkVjbnISss8H7DW6X
         RZtSdHvsNyoP3KKjd7aoWnfE9hTkvd8TE0cO3Vh14XhFooLXJwQLR9qaM+e+aW1tvJFf
         x3ShfhY/WYqfcGGuX7ntSoq4YwASuE332J/qFxWMWka/fMbIk6YTT6hp8aOmSZEnG5ir
         fLhdHbiqlGxo+qOKdyVWpo9Ju0/1iLazPNY8nobyt2CJUokt3iDcN7UaYzx2EF4NQJeP
         ft2TlMAGGhJoG+rgELk6GwvmNwOjn5dNZi7ostTmBeg2AJf3NmxYMYjNT6ItXfSw4173
         Z7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1PThvG6HlNQK6DZeGkXSIrzDFc8NG/LOsqd0jFoLTs=;
        b=kdKVTwcz9YLNC3TFHGx64FRVWzXlkyXYrB8IkFW5rtmXwxdFQYQl7jl6+g86B1vIC1
         AUBUbtXoOm6SIIW0eY37V2kAUjE3k50m3zg30kRw/C7s0wfvDJIlirmuL31BDcHQH1ZO
         ov92mda4pZ1XhhdVovdpuPddRHAytudfltKNG/kGg325a+7rSFr33XMumn8Xl2savba6
         VrD7fZI1vXgwEHhuU2aCxA78uKSbjZRksE/7t3sw/oyaUVVIugtAQFqUk/Lvi/hg+hbS
         OsMLxnmb7OkC0QKprbvxlMJTIvBBm9xVkSvdNycevHuAgH6Fj0hgjCr4XuDb8B7KtP/W
         9AKg==
X-Gm-Message-State: APjAAAVL812ab61pbhsko362WjZufm4jtT922vxixd2JS/kh3/60uty3
        aRIooSGx8C+2gKMKOAd0rjfzHBHuvyDHYiZoucZXOw==
X-Google-Smtp-Source: APXvYqzyjPOP/M4nzCf9frNXULtHsd9YACMerhFOzyQLIozgb7vZo9gEuVEGQRrsvi54xWC3bANM0N2tA2yc1YF+UPo=
X-Received: by 2002:adf:a299:: with SMTP id s25mr134433701wra.74.1564685332159;
 Thu, 01 Aug 2019 11:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <1564611032-10016-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
In-Reply-To: <1564611032-10016-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 1 Aug 2019 14:48:39 -0400
Message-ID: <CADnq5_P6Hm-zQmfgpmY3MF4h7C9jVAnXmW5NvMGQkmzMyHF53Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon: Fix EEH during kexec
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

On Thu, Aug 1, 2019 at 2:01 PM KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com> wrote:
>
> During kexec some adapters hit an EEH since they are not properly
> shut down in the radeon_pci_shutdown() function. Adding
> radeon_suspend_kms() fixes this issue.
>
> Signed-off-by: Kyle Mahlkuch <Kyle.Mahlkuch at ibm.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_drv.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index a6cbe11..15d7beb 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -349,11 +349,19 @@ static int radeon_pci_probe(struct pci_dev *pdev,
>  static void
>  radeon_pci_shutdown(struct pci_dev *pdev)
>  {
> +       struct drm_device *ddev = pci_get_drvdata(pdev);
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
> +       radeon_suspend_kms(ddev, true, true, false);
>  }
>
>  static int radeon_pmops_suspend(struct device *dev)
> --
> 1.8.3.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
