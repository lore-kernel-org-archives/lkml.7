Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF52C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AE3205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e5PTHPzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbfGOQBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 12:01:01 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34454 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731074AbfGOQBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 12:01:01 -0400
Received: by mail-lf1-f68.google.com with SMTP id b29so4129663lfq.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 09:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jG4VdXmMyoFpVc6NE61bUixbe9slfFe01xROPhYpMig=;
        b=e5PTHPzJ994GNrOlaHnu48Kx8anQPqPS+EE773SxOJVUZ/SYAuvGcwf8gdsTmOC+uW
         6pQdRNNPUSnorHQJeyfyIJ4SQyRQhrT6N6HVWQoa8NYljURxsNcAUd8rnlkJVPsT2V7Y
         adM/O1IBhBvTw/kJxUc+/sHbrAaqXuqtvDRI8UN74N1+AGDrUiecIXZRqsVY02GuP9Sm
         Gbe67YjBkXNaTkWph3pf7vm01CpMn4DNnOHYqwbW1A9mA5NXdpI9RWf0GAxjuoDNKh4V
         npdUlFUBKhNyUms2UrEFu+XvmGG3ySH5mCdHydaDo07riYRjgGalP3VlGFU5edXYrKbi
         Ibrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jG4VdXmMyoFpVc6NE61bUixbe9slfFe01xROPhYpMig=;
        b=g6y1JSleVInE4O/ytg5+hep4DlwzMeI7Gk6lswR+5OLsplimQl9ohcKYjh2w7WYAhd
         ojUhr33sIp6isWUiuPnbnBUDJgTVBdJ5Wx7ICUbu5hOYf2pwFYWgtBrBdG5kNEE8je1g
         1iSd0ew5rWNqVIpvkoqrEkncvav2dt4TT7Oo/tjqaaguH4KjWjzn76cWXAON+TeFixFj
         JCplkTNwI0IwAQajreT6fhxySy0WUYpkbkAET2sLBKUipl84KALWSplKqEjNT9MfMAY+
         T4kqJcTP15U22FU9IgPHiRt0MJOUHu6fANl191CZ/Pt01jaMKP4uIihL8z3Csq4mzybJ
         29mw==
X-Gm-Message-State: APjAAAVcSbSr3u37rNS3q831CvWZrWCpgSufBml2Y0kGxzfeilg+78Ia
        rzS9vwox78f/2nXkUIvlAoSdvA==
X-Google-Smtp-Source: APXvYqzpO/d721H8WmEWknLzWu8P2CBGQsu+CdgDvcYjaeYxVVcvsWqTCVaZyda1gLViNxrDs++qQQ==
X-Received: by 2002:ac2:5b49:: with SMTP id i9mr11725604lfp.116.1563206458930;
        Mon, 15 Jul 2019 09:00:58 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id w1sm2408001lfe.50.2019.07.15.09.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 09:00:58 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] media: venus: Update core selection
To:     Aniket Masule <amasule@codeaurora.org>, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org
References: <1562078787-516-1-git-send-email-amasule@codeaurora.org>
 <1562078787-516-5-git-send-email-amasule@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <66c52577-fae8-9b3d-ec1d-886b97897729@linaro.org>
Date:   Mon, 15 Jul 2019 19:00:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562078787-516-5-git-send-email-amasule@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/2/19 5:46 PM, Aniket Masule wrote:
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
> index 5726d86..321e9f7 100644
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
> +		if (!(inst->clk_data.core_id == core_id))

		if (inst->clk_data.core_id != core_id)

I guess will be more readable?

> +			continue;
> +
> +		mbs_per_sec = load_per_instance(inst);
> +		load = mbs_per_sec * inst->clk_data.codec_freq_data->vpp_freq;
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
