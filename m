Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0E2C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C4321537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQJH1aAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbfGHOqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:46:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41164 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731835AbfGHOqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:46:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so17423579wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 07:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n3HLCUd8QOG30rmFPo+WXx041U+vb6RrO6aQs4nZhYk=;
        b=RQJH1aAgjCGpr4PNUKxutJXmyNkUA0ohdUKjNEATxNli/8RFVo5NgPrgTI5D7k9IZ2
         1wnt4hXsFW45VqJrFC+E78dmOBCvKYcwj8Q2DUKj4UH3IMDlN8gcA5miaccmZFWeyY7V
         LHCcLKNJ+kT/giMgnxrhLExXj4fKzl7jtGdOgtRZe+zAT2SXfxo+C+HMFlCoem6qJUfO
         Nj3oJ3qJRW4meRSWKXakNyY3kgAIzG09evIzzPzMvAW9hp536pmbXVKi6mW3roRCbInL
         /I5ikg1Y7C8qP1kbMh5F3CJcuZUrevjyw8cETQ1nuSUR2nwYNR2K5yPsu8RFQowysNue
         PKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n3HLCUd8QOG30rmFPo+WXx041U+vb6RrO6aQs4nZhYk=;
        b=nX/tNf5Mk7o3fhzQrXJZ+4/QxNd5yPe6+/WltOMDczTaGURgyDmfPbEuz25bKxc/Ey
         Ez33ElfqJEsi8vcKFaFRHrf0HKWlddJCiEJGyGfPxNxNo6Mzs2Tz/3wMCGVmznSywwQA
         FQ2s3VvdvlNDGmDFmP6rUdtXJeHKjlqjVZQRpaeSxiWfPT+em+NAPf4t0/rje6sEsr1o
         ydOwRs3WvgUbLume8/KNsgvjxqJ7Zr0Tjt+T7iqG8KOGAby7K0E11NhHSociirXwb01y
         rY8ZwbAjLTg8U9nMFMhkGGDosXBegzOZxhkeWEHrHUI3k0Tumwi4mtinAXIhmUsl6z7c
         LCPQ==
X-Gm-Message-State: APjAAAUDpppq3ONls6nLnsfA8oP2ZiUuyxalUM9DJ+5zG/u5zJ1Y/UKK
        VzHjImyWRmHoeE0repHQRxvZ3gp+xHjDx0Zc8r0=
X-Google-Smtp-Source: APXvYqwy7CXBnQf465ytPZc6T2cfHHnn+vmSau3B7du6irnaP/QpA0b/Zm/sRvKnr5eSQfHAm+7WRV+WC7Os1RUgcYc=
X-Received: by 2002:a5d:6b11:: with SMTP id v17mr18947482wrw.323.1562597190541;
 Mon, 08 Jul 2019 07:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190708144205.2770771-1-arnd@arndb.de> <20190708144205.2770771-2-arnd@arndb.de>
In-Reply-To: <20190708144205.2770771-2-arnd@arndb.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 8 Jul 2019 10:46:19 -0400
Message-ID: <CADnq5_MFi1cGxo-AGMcGzY4nW8HAuX8SiPfAD=eRrdo0w-aoJQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] amdgpu: make SOC15/navi support conditional
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>, Evan Quan <evan.quan@amd.com>,
        Yong Zhao <Yong.Zhao@amd.com>, Amber Lin <Amber.Lin@amd.com>,
        Feifei Xu <Feifei.Xu@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        xinhui pan <xinhui.pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Emily Deng <Emily.Deng@amd.com>, Huang Rui <ray.huang@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Rex Zhu <Rex.Zhu@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shaoyun Liu <Shaoyun.Liu@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 10:42 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Enabling amdgpu but not CONFIG_DRM_AMD_DC leads to a warning:
>
> drivers/gpu/drm/amd/amdgpu/nv.c: In function 'nv_set_ip_blocks':
> drivers/gpu/drm/amd/amdgpu/nv.c:400:3: error: #warning "Enable CONFIG_DRM_AMD_DC for display support on navi." [-Werror=cpp]
>  # warning "Enable CONFIG_DRM_AMD_DC for display support on navi."
>    ^~~~~~~
> drivers/gpu/drm/amd/amdgpu/soc15.c: In function 'soc15_set_ip_blocks':
> drivers/gpu/drm/amd/amdgpu/soc15.c:653:3: error: #warning "Enable CONFIG_DRM_AMD_DC for display support on SOC15." [-Werror=cpp]
>
> However, CONFIG_DRM_AMD_DC can only be enabled on x86, so we
> cannot do that when building for other architectures.

DC is not limited to x86.  I can drop the warning if that is the concern.

Alex

>
> Add another Kconfig symbol to handle the SOC15 and navi, making
> sure that we implicitly enable DC.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/Kconfig         |  7 +++++
>  drivers/gpu/drm/amd/amdgpu/Makefile        | 32 +++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 ++
>  4 files changed, 33 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
> index a04f2fc7bf37..d7186dd88dbc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -24,6 +24,13 @@ config DRM_AMDGPU_CIK
>
>           radeon.cik_support=0 amdgpu.cik_support=1
>
> +config DRM_AMDGPU_SOC15
> +       bool "Enable amdgpu support for SOC15 parts"
> +       depends on DRM_AMDGPU
> +       select DRM_AMD_DC
> +       help
> +         Choose this option if you want to enable support for SOC15 asics.
> +
>  config DRM_AMDGPU_USERPTR
>         bool "Always enable userptr write support"
>         depends on DRM_AMDGPU
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 3f5329906fce..e95ae468eaa1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -64,9 +64,10 @@ amdgpu-$(CONFIG_DRM_AMDGPU_CIK)+= cik.o cik_ih.o kv_smc.o kv_dpm.o \
>
>  amdgpu-$(CONFIG_DRM_AMDGPU_SI)+= si.o gmc_v6_0.o gfx_v6_0.o si_ih.o si_dma.o dce_v6_0.o si_dpm.o si_smc.o
>
> -amdgpu-y += \
> -       vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
> -       vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o navi10_reg_init.o navi14_reg_init.o
> +amdgpu-y += vi.o mxgpu_vi.o emu_soc.o nbio_v7_4.o
> +
> +amdgpu-$(CONFIG_DRM_AMDGPU_SOC15) += gmc_v9_0.o nbio_v6_1.o soc15.o mxgpu_ai.o nbio_v7_0.o \
> +       vega10_reg_init.o vega20_reg_init.o nbio_v2_3.o nv.o navi10_reg_init.o navi14_reg_init.o
>
>  # add DF block
>  amdgpu-y += \
> @@ -77,7 +78,10 @@ amdgpu-y += \
>  amdgpu-y += \
>         gmc_v7_0.o \
>         gmc_v8_0.o \
> -       gfxhub_v1_0.o mmhub_v1_0.o gmc_v9_0.o gfxhub_v1_1.o \
> +       gfxhub_v1_0.o mmhub_v1_0.o gfxhub_v1_1.o
> +
> +amdgpu-$(CONFIG_DRM_AMDGPU_SOC15) += \
> +       gmc_v9_0.o \
>         gfxhub_v2_0.o mmhub_v2_0.o gmc_v10_0.o
>
>  # add IH block
> @@ -86,7 +90,9 @@ amdgpu-y += \
>         amdgpu_ih.o \
>         iceland_ih.o \
>         tonga_ih.o \
> -       cz_ih.o \
> +       cz_ih.o
> +
> +amdgpu-$(CONFIG_DRM_AMDGPU_SOC15) += \
>         vega10_ih.o \
>         navi10_ih.o
>
> @@ -111,7 +117,9 @@ amdgpu-y += \
>  amdgpu-y += \
>         amdgpu_gfx.o \
>         amdgpu_rlc.o \
> -       gfx_v8_0.o \
> +       gfx_v8_0.o
> +
> +amdgpu-$(CONFIG_DRM_AMDGPU_SOC15) += \
>         gfx_v9_0.o \
>         gfx_v10_0.o
>
> @@ -119,12 +127,14 @@ amdgpu-y += \
>  amdgpu-y += \
>         amdgpu_sdma.o \
>         sdma_v2_4.o \
> -       sdma_v3_0.o \
> +       sdma_v3_0.o
> +
> +amdgpu-$(CONFIG_DRM_AMDGPU_SOC15) += \
>         sdma_v4_0.o \
>         sdma_v5_0.o
>
>  # add MES block
> -amdgpu-y += \
> +amdgpu-$(CONFIG_DRM_AMDGPU_SOC15) += \
>         mes_v10_1.o
>
>  # add UVD block
> @@ -161,8 +171,10 @@ amdgpu-y += \
>          amdgpu_amdkfd_fence.o \
>          amdgpu_amdkfd_gpuvm.o \
>          amdgpu_amdkfd_gfx_v8.o \
> -        amdgpu_amdkfd_gfx_v9.o \
> -        amdgpu_amdkfd_gfx_v10.o
> +
> +amdgpu-$(CONFIG_DRM_AMDGPU_SOC15) += \
> +       amdgpu_amdkfd_gfx_v9.o \
> +       amdgpu_amdkfd_gfx_v10.o
>
>  ifneq ($(CONFIG_DRM_AMDGPU_CIK),)
>  amdgpu-y += amdgpu_amdkfd_gfx_v7.o
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 9fa4f25a3745..101d806ff996 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -81,6 +81,7 @@ void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev)
>         case CHIP_VEGAM:
>                 kfd2kgd = amdgpu_amdkfd_gfx_8_0_get_functions();
>                 break;
> +#ifdef CONFIG_DRM_AMDGPU_SOC15
>         case CHIP_VEGA10:
>         case CHIP_VEGA12:
>         case CHIP_VEGA20:
> @@ -90,6 +91,7 @@ void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev)
>         case CHIP_NAVI10:
>                 kfd2kgd = amdgpu_amdkfd_gfx_10_0_get_functions();
>                 break;
> +#endif
>         default:
>                 dev_info(adev->dev, "kfd not supported on this ASIC\n");
>                 return;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a02ccce7bf53..2a6447febcb0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1530,6 +1530,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>                         return r;
>                 break;
>  #endif
> +#ifdef CONFIG_DRM_AMDGPU_SOC15
>         case CHIP_VEGA10:
>         case CHIP_VEGA12:
>         case CHIP_VEGA20:
> @@ -1551,6 +1552,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>                 if (r)
>                         return r;
>                 break;
> +#endif
>         default:
>                 /* FIXME: not supported yet */
>                 return -EINVAL;
> --
> 2.20.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
