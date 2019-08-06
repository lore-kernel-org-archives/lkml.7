Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DBEC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8398206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqSzf3Lo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfHFMXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 08:23:03 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39569 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfHFMXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:23:03 -0400
Received: by mail-ua1-f67.google.com with SMTP id j8so33532066uan.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 05:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+qkPzD5ZstkzXENQiQ7/WVVv/CJFX6ERUgX33y9U5XI=;
        b=rqSzf3LovTCT5TOlpnWglo2f2Hd6htoZ/VskGnovrHxK/kFejcxFbxb25PALTYXOJ3
         JOl3zQy0pgg5zMStaPBe5yFrUzaqOzQE+RWlMjxFitWjToVaIPldDQ3j3OZJeG9l+Mvt
         RadBV08QiaHMPuGqEZHAAxb7U7r5Z5fvvP9kkwyTZPitBWghsDxCMpN92bhuU60FX1Gy
         rXS7wVoKxVWni2wmE2AhH/9sgnnt2twDSW5zgZwA2DxxvL3CS94YMStvRagGXPooDVep
         OrU7t4zcYQKITXFHQksD3Rsss6yItvOpJksh6fhG8g0dOroWLTuHq94WFOKvcmmoPZrE
         SRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+qkPzD5ZstkzXENQiQ7/WVVv/CJFX6ERUgX33y9U5XI=;
        b=Te5mRNt/5QGcflDaI0QynhIoBRe/7arHlZ3JDVeVgtgkZIO4ahFCoy8gw/Zqb50cvj
         FmisfZ/u2kb8toYslZLfe/4QQXGOKIi/FaEJbeGxmcU0HMNmjDquqmNMaD6ndPF2o1kr
         93cHIcMMGz1XtQdVa37eMtc8eVSj+nH7oKgSEECcOTppySMtbK62S5eiQaAxKxDGPGBm
         SWzNLebP9mIVxX1hCbBYzuUPhvXMAH7VfZH0FDKX5jLPXfCg2/OUgxYHL/cN+IV1Y4Sz
         vPRQoon5LIQ6TpKLNe5MXHQffCzcka433tBhYbPrKC5RLLGdPqWZ5RIPPmszzOhQntcx
         oJYg==
X-Gm-Message-State: APjAAAXTWam0zTL6z+0QnMPYZBmg/mcoRD5y4jrRXsijOIei9ErPd4rM
        8LLDN5grmajAXks7uo8lLKhiZCe3Is5cvQ43B69sEQ==
X-Google-Smtp-Source: APXvYqwyewmYe2EQeOtkvvQKPf2zDyIH4a9R7T213GuGI+G3zVCz92qwLE506uJBwGfAndph54+bzSbu7V2MaqD7DCU=
X-Received: by 2002:ab0:20cc:: with SMTP id z12mr450898ual.32.1565094181929;
 Tue, 06 Aug 2019 05:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190806073743.31575-1-oshpigelman@habana.ai> <20190806073743.31575-2-oshpigelman@habana.ai>
In-Reply-To: <20190806073743.31575-2-oshpigelman@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 6 Aug 2019 15:22:35 +0300
Message-ID: <CAFCwf13UcH6=SY75HL7OSW_3GGpuNqP3dAUceE1eN5PHuAExOQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] habanalabs: improve security in Debug IOCTL
To:     Omer Shpigelman <oshpigelman@habana.ai>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 10:38 AM Omer Shpigelman <oshpigelman@habana.ai> wrote:
>
> This patch improves the security in the Debug IOCTL.
> It adds checks that:
> - The register index value is in the allowed range for all opcodes.
> - The event types number is in the allowed range in SPMU enable.
> - The events number is in the allowed range in SPMU disable.
>
> Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> ---
>  drivers/misc/habanalabs/goya/goya_coresight.c | 72 ++++++++++++++++---
>  1 file changed, 63 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/goya/goya_coresight.c b/drivers/misc/habanalabs/goya/goya_coresight.c
> index d7ec7ad84cc6..4f7ffc137ab7 100644
> --- a/drivers/misc/habanalabs/goya/goya_coresight.c
> +++ b/drivers/misc/habanalabs/goya/goya_coresight.c
> @@ -15,6 +15,12 @@
>
>  #define GOYA_PLDM_CORESIGHT_TIMEOUT_USEC       (CORESIGHT_TIMEOUT_USEC * 100)
>
> +#define SPMU_SECTION_SIZE              DMA_CH_0_CS_SPMU_MAX_OFFSET
> +#define SPMU_EVENT_TYPES_OFFSET                0x400
> +#define SPMU_MAX_EVENT_TYPES           ((SPMU_SECTION_SIZE - \
> +                                               SPMU_EVENT_TYPES_OFFSET) / 4)
> +#define SPMU_MAX_EVENTS                        (SPMU_SECTION_SIZE / 4)
> +
>  static u64 debug_stm_regs[GOYA_STM_LAST + 1] = {
>         [GOYA_STM_CPU]          = mmCPU_STM_BASE,
>         [GOYA_STM_DMA_CH_0_CS]  = mmDMA_CH_0_CS_STM_BASE,
> @@ -226,9 +232,16 @@ static int goya_config_stm(struct hl_device *hdev,
>                 struct hl_debug_params *params)
>  {
>         struct hl_debug_params_stm *input;
> -       u64 base_reg = debug_stm_regs[params->reg_idx] - CFG_BASE;
> +       u64 base_reg;
>         int rc;
>
> +       if (params->reg_idx >= ARRAY_SIZE(debug_stm_regs)) {
> +               dev_err(hdev->dev, "Invalid register index in STM\n");
> +               return -EINVAL;
> +       }
> +
> +       base_reg = debug_stm_regs[params->reg_idx] - CFG_BASE;
> +
>         WREG32(base_reg + 0xFB0, CORESIGHT_UNLOCK);
>
>         if (params->enable) {
> @@ -288,10 +301,17 @@ static int goya_config_etf(struct hl_device *hdev,
>                 struct hl_debug_params *params)
>  {
>         struct hl_debug_params_etf *input;
> -       u64 base_reg = debug_etf_regs[params->reg_idx] - CFG_BASE;
> +       u64 base_reg;
>         u32 val;
>         int rc;
>
> +       if (params->reg_idx >= ARRAY_SIZE(debug_etf_regs)) {
> +               dev_err(hdev->dev, "Invalid register index in ETF\n");
> +               return -EINVAL;
> +       }
> +
> +       base_reg = debug_etf_regs[params->reg_idx] - CFG_BASE;
> +
>         WREG32(base_reg + 0xFB0, CORESIGHT_UNLOCK);
>
>         val = RREG32(base_reg + 0x304);
> @@ -445,11 +465,18 @@ static int goya_config_etr(struct hl_device *hdev,
>  static int goya_config_funnel(struct hl_device *hdev,
>                 struct hl_debug_params *params)
>  {
> -       WREG32(debug_funnel_regs[params->reg_idx] - CFG_BASE + 0xFB0,
> -                       CORESIGHT_UNLOCK);
> +       u64 base_reg;
> +
> +       if (params->reg_idx >= ARRAY_SIZE(debug_funnel_regs)) {
> +               dev_err(hdev->dev, "Invalid register index in FUNNEL\n");
> +               return -EINVAL;
> +       }
>
> -       WREG32(debug_funnel_regs[params->reg_idx] - CFG_BASE,
> -                       params->enable ? 0x33F : 0);
> +       base_reg = debug_funnel_regs[params->reg_idx] - CFG_BASE;
> +
> +       WREG32(base_reg + 0xFB0, CORESIGHT_UNLOCK);
> +
> +       WREG32(base_reg, params->enable ? 0x33F : 0);
>
>         return 0;
>  }
> @@ -458,9 +485,16 @@ static int goya_config_bmon(struct hl_device *hdev,
>                 struct hl_debug_params *params)
>  {
>         struct hl_debug_params_bmon *input;
> -       u64 base_reg = debug_bmon_regs[params->reg_idx] - CFG_BASE;
> +       u64 base_reg;
>         u32 pcie_base = 0;
>
> +       if (params->reg_idx >= ARRAY_SIZE(debug_bmon_regs)) {
> +               dev_err(hdev->dev, "Invalid register index in BMON\n");
> +               return -EINVAL;
> +       }
> +
> +       base_reg = debug_bmon_regs[params->reg_idx] - CFG_BASE;
> +
>         WREG32(base_reg + 0x104, 1);
>
>         if (params->enable) {
> @@ -522,7 +556,7 @@ static int goya_config_bmon(struct hl_device *hdev,
>  static int goya_config_spmu(struct hl_device *hdev,
>                 struct hl_debug_params *params)
>  {
> -       u64 base_reg = debug_spmu_regs[params->reg_idx] - CFG_BASE;
> +       u64 base_reg;
>         struct hl_debug_params_spmu *input = params->input;
>         u64 *output;
>         u32 output_arr_len;
> @@ -531,6 +565,13 @@ static int goya_config_spmu(struct hl_device *hdev,
>         u32 cycle_cnt_idx;
>         int i;
>
> +       if (params->reg_idx >= ARRAY_SIZE(debug_spmu_regs)) {
> +               dev_err(hdev->dev, "Invalid register index in SPMU\n");
> +               return -EINVAL;
> +       }
> +
> +       base_reg = debug_spmu_regs[params->reg_idx] - CFG_BASE;
> +
>         if (params->enable) {
>                 input = params->input;
>
> @@ -543,11 +584,18 @@ static int goya_config_spmu(struct hl_device *hdev,
>                         return -EINVAL;
>                 }
>
> +               if (input->event_types_num > SPMU_MAX_EVENT_TYPES) {
> +                       dev_err(hdev->dev,
> +                               "too many event types values for SPMU enable\n");
> +                       return -EINVAL;
> +               }
> +
>                 WREG32(base_reg + 0xE04, 0x41013046);
>                 WREG32(base_reg + 0xE04, 0x41013040);
>
>                 for (i = 0 ; i < input->event_types_num ; i++)
> -                       WREG32(base_reg + 0x400 + i * 4, input->event_types[i]);
> +                       WREG32(base_reg + SPMU_EVENT_TYPES_OFFSET + i * 4,
> +                               input->event_types[i]);
>
>                 WREG32(base_reg + 0xE04, 0x41013041);
>                 WREG32(base_reg + 0xC00, 0x8000003F);
> @@ -567,6 +615,12 @@ static int goya_config_spmu(struct hl_device *hdev,
>                         return -EINVAL;
>                 }
>
> +               if (events_num > SPMU_MAX_EVENTS) {
> +                       dev_err(hdev->dev,
> +                               "too many events values for SPMU disable\n");
> +                       return -EINVAL;
> +               }
> +
>                 WREG32(base_reg + 0xE04, 0x41013040);
>
>                 for (i = 0 ; i < events_num ; i++)
> --
> 2.17.1
>

Both patches are:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
