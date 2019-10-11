Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90466C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6424821D56
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfJKGV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 02:21:56 -0400
Received: from regular1.263xmail.com ([211.150.70.205]:57576 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfJKGV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 02:21:56 -0400
Received: from localhost (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id AA6E6501;
        Fri, 11 Oct 2019 14:21:40 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.10.69] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P1498T139875987117824S1570774899902158_;
        Fri, 11 Oct 2019 14:21:41 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <05d49b8d9eedd73368abb06786516ead>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: ben.davis@arm.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v2 4/4] drm/komeda: Adds gamma and color-transform support
 for DOU-IPS
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "imirkin@alum.mit.edu" <imirkin@alum.mit.edu>
Cc:     nd <nd@arm.com>, Ayan Halder <Ayan.Halder@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ben Davis <Ben.Davis@arm.com>
References: <20191011054240.17782-1-james.qian.wang@arm.com>
 <20191011054240.17782-5-james.qian.wang@arm.com>
From:   "sandy.huang" <hjc@rock-chips.com>
Message-ID: <08492df8-11d9-c580-94f6-7868602c12c3@rock-chips.com>
Date:   Fri, 11 Oct 2019 14:21:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191011054240.17782-5-james.qian.wang@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2019/10/11 下午1:43, james qian wang (Arm Technology China) 写道:
> From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
>
> Adds gamma and color-transform support for DOU-IPS.
> Adds two caps members fgamma_coeffs and ctm_coeffs to komeda_improc_state.
> If color management changed, set gamma and color-transform accordingly.
>
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>   .../arm/display/komeda/d71/d71_component.c    | 24 +++++++++++++++++++
>   .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  2 ++
>   .../drm/arm/display/komeda/komeda_pipeline.h  |  3 +++
>   .../display/komeda/komeda_pipeline_state.c    |  6 +++++
>   4 files changed, 35 insertions(+)
>
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index c3d29c0b051b..e7e5a8e4430e 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -942,15 +942,39 @@ static int d71_merger_init(struct d71_dev *d71,
>   static void d71_improc_update(struct komeda_component *c,
>   			      struct komeda_component_state *state)
>   {
> +	struct drm_crtc_state *crtc_st = state->crtc->state;
>   	struct komeda_improc_state *st = to_improc_st(state);
> +	struct d71_pipeline *pipe = to_d71_pipeline(c->pipeline);
>   	u32 __iomem *reg = c->reg;
>   	u32 index;
> +	u32 mask = 0, ctrl = 0;
>   
>   	for_each_changed_input(state, index)
>   		malidp_write32(reg, BLK_INPUT_ID0 + index * 4,
>   			       to_d71_input_id(state, index));
>   
>   	malidp_write32(reg, BLK_SIZE, HV_SIZE(st->hsize, st->vsize));
> +
> +	if (crtc_st->color_mgmt_changed) {
> +		mask |= IPS_CTRL_FT | IPS_CTRL_RGB;
> +
> +		if (crtc_st->gamma_lut) {
> +			malidp_write_group(pipe->dou_ft_coeff_addr, FT_COEFF0,
> +					   KOMEDA_N_GAMMA_COEFFS,
> +					   st->fgamma_coeffs);
> +			ctrl |= IPS_CTRL_FT; /* enable gamma */
> +		}
> +
> +		if (crtc_st->ctm) {
> +			malidp_write_group(reg, IPS_RGB_RGB_COEFF0,
> +					   KOMEDA_N_CTM_COEFFS,
> +					   st->ctm_coeffs);
> +			ctrl |= IPS_CTRL_RGB; /* enable gamut */
> +		}
> +	}
> +
> +	if (mask)
> +		malidp_write32_mask(reg, BLK_CONTROL, mask, ctrl);
>   }
There is no need or no method to disable/bypass the gamma and gamut?
>   
>   static void d71_improc_dump(struct komeda_component *c, struct seq_file *sf)
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> index 9beeda04818b..406b9d0ca058 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -590,6 +590,8 @@ static int komeda_crtc_add(struct komeda_kms_dev *kms,
>   
>   	crtc->port = kcrtc->master->of_output_port;
>   
> +	drm_crtc_enable_color_mgmt(crtc, 0, true, KOMEDA_COLOR_LUT_SIZE);
> +
>   	return err;
>   }
>   
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> index b322f52ba8f2..c5ab8096c85d 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -11,6 +11,7 @@
>   #include <drm/drm_atomic.h>
>   #include <drm/drm_atomic_helper.h>
>   #include "malidp_utils.h"
> +#include "komeda_color_mgmt.h"
>   
>   #define KOMEDA_MAX_PIPELINES		2
>   #define KOMEDA_PIPELINE_MAX_LAYERS	4
> @@ -324,6 +325,8 @@ struct komeda_improc {
>   struct komeda_improc_state {
>   	struct komeda_component_state base;
>   	u16 hsize, vsize;
> +	u32 fgamma_coeffs[KOMEDA_N_GAMMA_COEFFS];
> +	u32 ctm_coeffs[KOMEDA_N_CTM_COEFFS];
>   };
>   
>   /* display timing controller */
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index 0ba9c6aa3708..4a40b37eb1a6 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -756,6 +756,12 @@ komeda_improc_validate(struct komeda_improc *improc,
>   	st->hsize = dflow->in_w;
>   	st->vsize = dflow->in_h;
>   
> +	if (kcrtc_st->base.color_mgmt_changed) {
> +		drm_lut_to_fgamma_coeffs(kcrtc_st->base.gamma_lut,
> +					 st->fgamma_coeffs);
> +		drm_ctm_to_coeffs(kcrtc_st->base.ctm, st->ctm_coeffs);
> +	}
> +
>   	komeda_component_add_input(&st->base, &dflow->input, 0);
>   	komeda_component_set_output(&dflow->input, &improc->base, 0);
>   


