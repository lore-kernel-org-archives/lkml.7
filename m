Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D23C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273C120821
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHdcACKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403839AbfGWSsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:48:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34662 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbfGWSsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:48:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so44313178wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 11:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LIXup0fVFWNf86/DVnHha31m2DWJ3Zw6X12AGN8eLZA=;
        b=oHdcACKPK/OVOvIbPpPDuS1Z9gmvTd1eQ0qLtJL6QJToRs78djHD1kV87A4mI4VdVI
         iVHKyScper77gwAvQatz4D0ofZBDWqK0cjPJPyt8oSc4uv1jpAKnY/lHROw6AunN6csn
         qdSdEWRgnwNRwlymecJhNTaiBoGRTUp2VbGPXRiml3PipaGvOhjWO+YIZ5GcTznU6baB
         qzhtinDaIGFYGgwwn5d95YeFQKaqVmvL7n8uZQAzXhh5cyz1ShYGATUewp/aBzR3CxMY
         aoXF7zXaLGyyQCPUT+JZYBzl1rDMwlHF2K5EVjAHc9p8F0YSlg0OCnfGW9f8oaU2e6Rz
         iihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LIXup0fVFWNf86/DVnHha31m2DWJ3Zw6X12AGN8eLZA=;
        b=LuR1h4+jO4KKei5PDXA7fAnk62RpWLgVkMpRGNTyaeGh3HbuyNLP6pz2EfpbhFsGnW
         mJTGFLbOXvG1CEGESeqOQsMI+XznADPUUZ4c6bKWybfH3Au768soRrzEG3G0zhSW32me
         kUG78gEjDJZZIPwiwDxGrGoAQ7IMscGsk+I/m3QY8waUMPMb0mVeyUfzGLRzfN1v3C4g
         b8usGGSpdXLytc74utsSzS0yPuFZYG8WFZomeRAyj3z03xe29EXr21t03Fs7BksNQiXF
         k1XHpevCvK4fKWqQgEGdEOaveaps40mshvkjYgAq4IJAM5zctdAAg0SoNH+7AShSVbd/
         80ug==
X-Gm-Message-State: APjAAAVPUZCxNhvFO1oB28JpcEGu9exrNbjaUQ56t1ZKQggnKe2Hnr7D
        hnKRnozZmf5eGikA1Yl7Hd9i32qIeGriLKR5DjQ=
X-Google-Smtp-Source: APXvYqz1JerMQNiG9+nU4ckH/5uEF5Rq8FAnFBLfDITDfzQH7v2qkrPMy4xlkOiEkhquFMr6Or+LY62Gb/nDkBD/mIE=
X-Received: by 2002:adf:a299:: with SMTP id s25mr75095757wra.74.1563907683302;
 Tue, 23 Jul 2019 11:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190723090449.27589-1-hslester96@gmail.com>
In-Reply-To: <20190723090449.27589-1-hslester96@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 23 Jul 2019 14:47:52 -0400
Message-ID: <CADnq5_Py-Bj0947A_aj4ORDyg6UA3R5y=3v5FLttzL6nBvixkA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Use dev_get_drvdata where possible
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 9:36 AM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 27 +++++++++----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index f2e8b4238efd..df82091a29d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1097,16 +1097,14 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
>
>  static int amdgpu_pmops_suspend(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
>
> -       struct drm_device *drm_dev = pci_get_drvdata(pdev);
>         return amdgpu_device_suspend(drm_dev, true, true);
>  }
>
>  static int amdgpu_pmops_resume(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -       struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
>
>         /* GPU comes up enabled by the bios on resume */
>         if (amdgpu_device_is_px(drm_dev)) {
> @@ -1120,33 +1118,29 @@ static int amdgpu_pmops_resume(struct device *dev)
>
>  static int amdgpu_pmops_freeze(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -
> -       struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
> +
>         return amdgpu_device_suspend(drm_dev, false, true);
>  }
>
>  static int amdgpu_pmops_thaw(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -
> -       struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
> +
>         return amdgpu_device_resume(drm_dev, false, true);
>  }
>
>  static int amdgpu_pmops_poweroff(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -
> -       struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
> +
>         return amdgpu_device_suspend(drm_dev, true, true);
>  }
>
>  static int amdgpu_pmops_restore(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
>
> -       struct drm_device *drm_dev = pci_get_drvdata(pdev);
>         return amdgpu_device_resume(drm_dev, false, true);
>  }
>
> @@ -1205,8 +1199,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>
>  static int amdgpu_pmops_runtime_idle(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -       struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
>         struct drm_crtc *crtc;
>
>         if (!amdgpu_device_is_px(drm_dev)) {
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
