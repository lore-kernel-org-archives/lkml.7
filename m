Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937AEC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6589720821
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAXU6pu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391568AbfGWSuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:50:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51997 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfGWSuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:50:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so39542422wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 11:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CN2tNXbOxjbGVP/EEYoEmk5JyHi0LtwAS7W9SVzRNG0=;
        b=KAXU6pu0tAbxDMLV1cJDWvfmDYD8RIG2WS3SfSd5DPuUuu8GNdjCctsnUg1uif5Fyo
         ZYz30/FBDWDBLLO3QC/qK/PdfZUwzWXdCpslxmR/sefWX9AEws38Qp228HuYG6g5KwPU
         +jj5uwlD6rLl2yV5JQMVmWjBEtqmrieVliTkLCNp1kgEuqS2ov6VOW03XdOJqrbnSqfR
         98eKhk5xrHpzMBs+fNlJllfa1LgL/yz+nDT8Y/0dkC0SBZwtgip2TbGkZ3h0Vivg95ow
         BZdXTOla2IkdQbzWuMyg1e0Exnjv1RnYJDCGtjND7ZLdExg/mhAoWx560qkZg7ISvStE
         zxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CN2tNXbOxjbGVP/EEYoEmk5JyHi0LtwAS7W9SVzRNG0=;
        b=lt3ABcUxcUmqhspvrPZGXZEZ16lfForGkjQc+HpfAilmNLjjixokjkiH0A3Innyd7A
         YOMDoGdzAOVjVWjTHvgYtaYScpjcIxURuqF05TjIPHdCQiigSS8G93k/jDnb7TWqN4O1
         5OezhWNLEhRUqJC7H/yHbPCGv144Ukjaa6sKEBuwrPX9O2ZOnAFnY0RVTV+klT1gFW/b
         ZKcW4FwsPO07PsIkPZ+bn0t40WRFzFtG0jj3k8b6ElxQcJ8F0UF0uUs8nyWsnu/HCBLn
         2ExpzIJ7sGlN0QykO8C7wwrQMkirNmyT63C7HCu9lZEq8sUYrxqXxHKUCUS0j+3t/a47
         aYCg==
X-Gm-Message-State: APjAAAWkhoAdvpKXZSXJUtPUW7eyyNZHq89N+jhYTdeKLrVnDlH+eYx9
        9ibjyQPkciiFYRNfs0GXhVJrMtGABb4xu3XQs22KDQ==
X-Google-Smtp-Source: APXvYqyF2orFVVIC2XK+vfV7OwNetJLVQX8lPzD2VkkTWWNfz0kNi6p3M8QDQi8vD79GXJc8LC3AdHGkATw0J3Ub3mE=
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr66210938wmc.34.1563907807023;
 Tue, 23 Jul 2019 11:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190723111008.10955-1-hslester96@gmail.com>
In-Reply-To: <20190723111008.10955-1-hslester96@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 23 Jul 2019 14:49:55 -0400
Message-ID: <CADnq5_O3R1KFRZK3CSKbNNzwYH+qkNSX_icb678KRJ0Ak+UTLg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Use dev_get_drvdata where possible
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
>  drivers/gpu/drm/radeon/radeon_drv.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index a6cbe11f79c6..b2bb74d5bffb 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -358,15 +358,13 @@ radeon_pci_shutdown(struct pci_dev *pdev)
>
>  static int radeon_pmops_suspend(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -       struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
>         return radeon_suspend_kms(drm_dev, true, true, false);
>  }
>
>  static int radeon_pmops_resume(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -       struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
>
>         /* GPU comes up enabled by the bios on resume */
>         if (radeon_is_px(drm_dev)) {
> @@ -380,15 +378,13 @@ static int radeon_pmops_resume(struct device *dev)
>
>  static int radeon_pmops_freeze(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -       struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
>         return radeon_suspend_kms(drm_dev, false, true, true);
>  }
>
>  static int radeon_pmops_thaw(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -       struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
>         return radeon_resume_kms(drm_dev, false, true);
>  }
>
> @@ -447,8 +443,7 @@ static int radeon_pmops_runtime_resume(struct device *dev)
>
>  static int radeon_pmops_runtime_idle(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -       struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +       struct drm_device *drm_dev = dev_get_drvdata(dev);
>         struct drm_crtc *crtc;
>
>         if (!radeon_is_px(drm_dev)) {
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
