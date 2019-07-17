Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F553C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784022173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q5qzlnCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfGQPni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 11:43:38 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41475 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfGQPnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 11:43:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id d24so24109314ljg.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 08:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3jbOpJGViEoMZ/z1uklXsD0i54r1S51I050v7ZKNFBk=;
        b=q5qzlnCIimWC3UjOSITeeOXZCWpKBXlqKRVFQtULyVwTJBMXe291radTFmBCIOilo2
         rdufUMyO5g6sAT8Hny4/l/4T3ClB9Ox0fRDYQXzp+22fH24Xy/LfnWjZDlZOvtZx+s6t
         TdaZ9T6zjMZSU//SZ4bpGc37NhFZv/gpXGsZerE1y5w12nSA9savGldFQhS/x1c3DKM5
         q2DEO2JT52mEPuNlJwMtQNpepUdYfiytpmtMazVZ+7m9Hx23a7wioBqqEh6C57wftVfs
         oBxa4smkhe+cX+SXaTHhdRrm7gDnWqscQGkgAOM7YrCK5dJ//s0hNZZCKNloaYU9Eh6G
         MeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3jbOpJGViEoMZ/z1uklXsD0i54r1S51I050v7ZKNFBk=;
        b=sdnc5gt+62MRApOkR20XNArM4/fowioVvJ4TMxPMJp8LWPRnovQHV2kCxAj9126CpX
         +9rU7AJxH6r9Pns+Dzdf/0hk2k1/ogntl7MghSs3bZQS+lJkZtn35ZApT8W4VJYKvLYP
         cEo4mPRQtOUtBPjZ193X+KjvMFQCkypTb0FuzJGmhiiSRGb+6csO5yulic5svD4ickCZ
         geXA7hBeGOX8MWAlcU/g1//OgIIO0UL1Wsa5DtH1Ypkq3jmRReTcBDwnyQ92QlZX6afW
         hh9RTHl7ejdUeRBfnnAKbgVnet4AEIJkUBxRd9GU0/Ll/yw+FGYRqNT118abmWvWb2Mw
         fxog==
X-Gm-Message-State: APjAAAVrERcJeN9H3yfHJ00kIXdctlZum/I24hKH6gg2UxG5Xkf+7524
        GoV6/GhLzElktaqEw7pek0Q7RA==
X-Google-Smtp-Source: APXvYqyZAR4Yyv15+5pV6jQjFoFXs2SGDZkyijDlK7U2XKITXcR4+JjlldiqrmNTezn72knRlJTbvQ==
X-Received: by 2002:a2e:800c:: with SMTP id j12mr21250044ljg.22.1563378215666;
        Wed, 17 Jul 2019 08:43:35 -0700 (PDT)
Received: from [192.168.28.181] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id g5sm4578700ljj.69.2019.07.17.08.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 08:43:34 -0700 (PDT)
Subject: Re: [PATCH v5 4/4] media: venus: Update core selection
To:     Aniket Masule <amasule@codeaurora.org>, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org
References: <1563253754-12003-1-git-send-email-amasule@codeaurora.org>
 <1563253754-12003-5-git-send-email-amasule@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <d9584a56-41a5-3e52-55d0-a02c5d59b823@linaro.org>
Date:   Wed, 17 Jul 2019 18:43:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1563253754-12003-5-git-send-email-amasule@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/16/19 8:09 AM, Aniket Masule wrote:
> Present core assignment is static. Introduced load balancing
> across the cores. Load on earch core is calculated and core
> with minimum load is assigned to given instance.
> 
> Signed-off-by: Aniket Masule <amasule@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c    | 69 +++++++++++++++++++++++---
>  drivers/media/platform/qcom/venus/helpers.h    |  2 +-
>  drivers/media/platform/qcom/venus/hfi_helper.h |  1 +
>  drivers/media/platform/qcom/venus/hfi_parser.h |  5 ++
>  drivers/media/platform/qcom/venus/vdec.c       |  2 +-
>  drivers/media/platform/qcom/venus/venc.c       |  2 +-
>  6 files changed, 72 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index edf403d..d479793 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -26,6 +26,7 @@
>  #include "helpers.h"
>  #include "hfi_helper.h"
>  #include "hfi_venus_io.h"
> +#include "hfi_parser.h"
>  
>  struct intbuf {
>  	struct list_head list;
> @@ -331,6 +332,24 @@ static u32 load_per_instance(struct venus_inst *inst)
>  	return mbs * inst->fps;
>  }
>  
> +static u32 load_per_core(struct venus_core *core, u32 core_id)
> +{
> +	struct venus_inst *inst = NULL;
> +	u32 mbs_per_sec = 0, load = 0;
> +
> +	mutex_lock(&core->lock);
> +	list_for_each_entry(inst, &core->instances, list) {
> +		if (inst->clk_data.core_id != core_id)
> +			continue;
> +
> +		mbs_per_sec = load_per_instance(inst);
> +		load = mbs_per_sec * inst->clk_data.codec_freq_data->vpp_freq;

shouldn't this be load +=  mbs_per_sec * vpp_freq ? We need to calculate
load for every instance on this core_id.

> +	}
> +	mutex_unlock(&core->lock);
> +
> +	return load;
> +}
> +

<cut>

-- 
regards,
Stan
