Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5E1C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D48E2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goSm3rbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbfGOQT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 12:19:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39774 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729533AbfGOQT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 12:19:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so17748424wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 09:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ynSIn8ZCqN1VPeaW/dGI1ybkuIDnGKn02iSRWw8L+LM=;
        b=goSm3rbbAg46n2BLSir9rsd3hIsrDJ2GPW58Q7tOSuINWkknY8W/hgybyA/eWMZh7t
         jmNoST5BX3A/vVV6NlGWWuKPJxQO7jAhuI5Ia/M+V/OzV0lF6Yb3LePSC+XIz0UCE4d1
         k2vIEGj1cUwBsaNz0vbYbXQxiU+OEWmvGR79qECsINHgnNTYshRxdrtBs6ykIn0YW47E
         n5PxabZ6EmdiT85hpzPS8xdsgLDxAsBvhzsu+nKlL20uU/CYaY4Ezl2YtwgPFl+oj5r1
         Y53xWN18Pq1kAWTk/ekSPNfq7yml/r3PkbCdTx0s59FM2VO+HStCvaTmmk/UrpcqgzPe
         409A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ynSIn8ZCqN1VPeaW/dGI1ybkuIDnGKn02iSRWw8L+LM=;
        b=bk6DYBeWLfbP0zTpPNukR5sK1gxg9YAnFT352zQ64YzO6r/kCpaJCyNzp2yy1aPRv/
         ZPcrkRen91YkYkZQu4XOFaK4t9IF3hAiwFM6t1KxSo4G/GfA6CdlRIO+TkzcR1dD0UMq
         iEC0W/+ZD/G4Gry6av7ENu/MxfiCVS4TZaeRe1lri8SkZ2Ko5JwECR0uBHa6wRhwy9xp
         WiEkj1jkJ95Z7qDxiN/Cxsq8fveN7aRuIuQtu6Ml1p3O0ueuCa3d9/+aH7sof3EGknkV
         GWNfOgMRsK5HbMPS+qnNPmxmNKiURAqZWVGu5GuAvMO5ObEVAQ7vgKFNl6KtlgaBwwHP
         CryA==
X-Gm-Message-State: APjAAAVaVC77A+DIo2VXx0aYgn7SjQ+SEd7cMKArmR43txNa2eXhMetB
        BtOK0oQNaobePIFUh2n3MgB9RBITrXL8YS4UYn8=
X-Google-Smtp-Source: APXvYqy9OYN0gLdXS1D1Pl/6JcJSiAMKZx3ANtd5gxugvPShy4Sl7kQAXfWVSROoNPZzw20eezdD4BKGB46LM4EoY4s=
X-Received: by 2002:a5d:6ccd:: with SMTP id c13mr25204311wrc.4.1563207594882;
 Mon, 15 Jul 2019 09:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190715031731.6421-1-huangfq.daxian@gmail.com>
In-Reply-To: <20190715031731.6421-1-huangfq.daxian@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 15 Jul 2019 12:19:43 -0400
Message-ID: <CADnq5_ODy9iAbB60CC4nFAPLx51jBh_KJCRWO9rdqzWPpP0FFQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/24] drm/amdgpu: remove memset after kzalloc
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 3:57 AM Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> kzalloc has already zeroed the memory during the allocation.
> So memset is unneeded.
>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

Applied. thanks!

Alex

> ---
> Changes in v3:
>   - Fix subject prefix: gpu/drm -> drm/amdgpu
>
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c       | 2 --
>  drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c | 2 --
>  drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c            | 2 --
>  drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c       | 2 --
>  drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c         | 2 --
>  5 files changed, 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index fd22b4474dbf..4e6da61d1a93 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -279,8 +279,6 @@ void *amdgpu_dm_irq_register_interrupt(struct amdgpu_device *adev,
>                 return DAL_INVALID_IRQ_HANDLER_IDX;
>         }
>
> -       memset(handler_data, 0, sizeof(*handler_data));
> -
>         init_handler_common_data(handler_data, ih, handler_args, &adev->dm);
>
>         irq_source = int_params->irq_source;
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
> index 1cd5a8b5cdc1..b760f95e7fa7 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/process_pptables_v1_0.c
> @@ -1067,8 +1067,6 @@ static int pp_tables_v1_0_initialize(struct pp_hwmgr *hwmgr)
>         PP_ASSERT_WITH_CODE((NULL != hwmgr->pptable),
>                             "Failed to allocate hwmgr->pptable!", return -ENOMEM);
>
> -       memset(hwmgr->pptable, 0x00, sizeof(struct phm_ppt_v1_information));
> -
>         powerplay_table = get_powerplay_table(hwmgr);
>
>         PP_ASSERT_WITH_CODE((NULL != powerplay_table),
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
> index 669bd0c2a16c..d55e264c5df5 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
> @@ -2702,8 +2702,6 @@ static int ci_initialize_mc_reg_table(struct pp_hwmgr *hwmgr)
>         cgs_write_register(hwmgr->device, mmMC_SEQ_PMG_CMD_MRS2_LP, cgs_read_register(hwmgr->device, mmMC_PMG_CMD_MRS2));
>         cgs_write_register(hwmgr->device, mmMC_SEQ_WR_CTL_2_LP, cgs_read_register(hwmgr->device, mmMC_SEQ_WR_CTL_2));
>
> -       memset(table, 0x00, sizeof(pp_atomctrl_mc_reg_table));
> -
>         result = atomctrl_initialize_mc_reg_table(hwmgr, module_index, table);
>
>         if (0 == result)
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
> index 375ccf6ff5f2..c123b4d9c621 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
> @@ -2631,8 +2631,6 @@ static int iceland_initialize_mc_reg_table(struct pp_hwmgr *hwmgr)
>         cgs_write_register(hwmgr->device, mmMC_SEQ_PMG_CMD_MRS2_LP, cgs_read_register(hwmgr->device, mmMC_PMG_CMD_MRS2));
>         cgs_write_register(hwmgr->device, mmMC_SEQ_WR_CTL_2_LP, cgs_read_register(hwmgr->device, mmMC_SEQ_WR_CTL_2));
>
> -       memset(table, 0x00, sizeof(pp_atomctrl_mc_reg_table));
> -
>         result = atomctrl_initialize_mc_reg_table(hwmgr, module_index, table);
>
>         if (0 == result)
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
> index 3ed6c5f1e5cf..60462c7211e3 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
> @@ -3114,8 +3114,6 @@ static int tonga_initialize_mc_reg_table(struct pp_hwmgr *hwmgr)
>         cgs_write_register(hwmgr->device, mmMC_SEQ_WR_CTL_2_LP,
>                         cgs_read_register(hwmgr->device, mmMC_SEQ_WR_CTL_2));
>
> -       memset(table, 0x00, sizeof(pp_atomctrl_mc_reg_table));
> -
>         result = atomctrl_initialize_mc_reg_table(hwmgr, module_index, table);
>
>         if (!result)
> --
> 2.11.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
