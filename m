Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671A5C06511
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCF121721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANePV6iG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbfGANzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 09:55:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34929 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbfGANzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 09:55:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id x25so13325096ljh.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 06:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GDqlS+iTEVHotTd99IcnQ2mj3jUGLi7G64t1i3CAPUM=;
        b=ANePV6iGdESy7GaaZwaMRe543+rV4IinPY75cCZGjtlCHn2KEBA+sQiXngBae9Fx2k
         z4xN6FEReyFt8TCKbnnOvMuNbGAZ0b51/zy4uAcibk+NxuFA9hcSU5pcAk5xOZUMWV+2
         o8UwPbL8ydAm+etpVjqRVFqxopJpiwSzCg5ZQx1e5NLlwNjjCg71Fy298T5wES+atB7V
         KXvMaw4cKEILd+e5dfjlzRIeq8Pv+kijFr8QPGng0ZtDRMtfsEin32kJA3/mFi00CRJW
         fW61HBWjgSY8YXoTc0bsMmevvMBuvzUzEa081bGDGQ7tKu9qYvAaigfRbaTw8alGR/2V
         +/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GDqlS+iTEVHotTd99IcnQ2mj3jUGLi7G64t1i3CAPUM=;
        b=c2XTi+nrNHGxO/x1RNg6yMuDP3zMJDE/5PWgentmJvnLcCmze0E8YZ46AVoZ652rBm
         TfsNSzN0+cGtk8afyRxkMNN//fORGGfcHNW9wJTNgujPT4r7Jdj3WpKyZYLUWl0Y+DAW
         cmCdMnL7kjnN9w2AOBmmVAcwVmr+gvsVYfIoUhwRPCsuGMA5PWrbTRoET5AakSergurn
         fOMh0DBrNkpE8CRisk6Ymtd4N3ykVAcY+2bbGHqAt6GgzREa6C6Cq+scTqIj6s37jgai
         vDva+1ZfDgviSBDfHLAKn4BLl29lDv/XdvrJiPLgemOyBqGJoU/2kN41cw08GAmK8awm
         d3IQ==
X-Gm-Message-State: APjAAAX3pX7WxD/BByYV1pMOyC43cBQI6KR4533wDeP34CDB29lCTV6w
        mbdvTrXeI5CDagKoqsOXRdiZ69bBt2I=
X-Google-Smtp-Source: APXvYqwlEhzuDfkZtWLw6k6i4EtwipJ+2QR5CjUOBwdS66jnC+HePX9Zt7SgUdP+w9Errj27tFVyZQ==
X-Received: by 2002:a2e:9cd4:: with SMTP id g20mr12509939ljj.205.1561989304568;
        Mon, 01 Jul 2019 06:55:04 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id l25sm3221678lja.76.2019.07.01.06.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 06:55:03 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] media: venus: Add interface for load per core
To:     Aniket Masule <amasule@codeaurora.org>, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org
References: <1561480044-11834-1-git-send-email-amasule@codeaurora.org>
 <1561480044-11834-4-git-send-email-amasule@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <87d41362-d86f-8da4-30ca-06390c9ceeff@linaro.org>
Date:   Mon, 1 Jul 2019 16:55:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1561480044-11834-4-git-send-email-amasule@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aniket,

On 6/25/19 7:27 PM, Aniket Masule wrote:
> Add and interface to calculate load per core. Also,
> add an interface to get maximum cores available with
> video. This interface is preparation for updating core
> selection.
> 
> Signed-off-by: Aniket Masule <amasule@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c    | 19 +++++++++++++++++++
>  drivers/media/platform/qcom/venus/hfi_helper.h |  1 +
>  drivers/media/platform/qcom/venus/hfi_parser.h |  5 +++++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index e1a0247..b79e83a 100644
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

Please squash this patch with the next one where load_per_core() is used
to avoid compiler warnings.

-- 
regards,
Stan
