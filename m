Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB15C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67352173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="MA7imn2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfH1Rj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:39:26 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42975 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1Rj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:39:26 -0400
Received: by mail-yw1-f68.google.com with SMTP id i207so173012ywc.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 10:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qFpGxWkuqJvzGEyaIhW5jLfEJosqdgJDRUmrRBBeYNs=;
        b=MA7imn2ncsnCHudQTmqQ5VNmGP5xmFYdXGG3IQLhQSRJBwKfS7igz5Tj3J25Zl9xza
         KU3CGRXXNayp++1iMedSJO1s4CBH6XYix460Ds56VGq3d0ZwGI9EzPhh9sUG6keZGuLx
         rm+4kkgsTNggulY9ExRns+6vzU/YZE/bfWtXM6GUBPHYmbbMbHwEcNlCVNhMrxXGQyek
         jeNBueGjMnKw9Pri3cmDJAiLZPSVg6XfDKQuq7UGs46jHubFTsyYZVGC1d4LYX0ubV0C
         Nf0nom5s1riI86vEeEhTPzf3lNPNtewKpqTGthpXeceEptS+Pv92dEukR9Va11d7uU/V
         irIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qFpGxWkuqJvzGEyaIhW5jLfEJosqdgJDRUmrRBBeYNs=;
        b=IQcxqeNOt5+aPRNtWH/n1jVs6CfALcLXHoKv5Y+ZONJAfyIFkNQeq/92KLzzaLsXsN
         VN3kg3hydmqRqXTG+RKOw4kRKkL/qvB7WS7g3P2uLVC3Y7hEApFwChPppVo/tNaZzFam
         0p2a7evCatZaMXmd4fNa/ccrrUz7nnRl9xysF02oXWkCTs8CdXi55kZOCGp+HgQnUpyA
         ifLhM14SkT8cNXP+lOFQ4NFQKO447U6Q/Mx4H+slOYlA53dhQisUnm4OPlm/BRaH4J21
         kxyk/IYgKxoRKRIQGtS3DGV5D91Nl3orRgidyNLrR7tPaqpv4/4ZvfkVSTxUFOmJV0Q2
         6oug==
X-Gm-Message-State: APjAAAWXkDoKcOHrZFv/ToKFVj+1+WOl0HdhAXkxURJqLXy4N7Lt6PPy
        135PLjLYgcK7MJbXylJk0U+EPw==
X-Google-Smtp-Source: APXvYqyrVae82GONg6G6xNXh2GuQpBKNgcXrFoQjXLJtaTK9ENwDFPeV9rgnIhlfcztUqTBdkROW9Q==
X-Received: by 2002:a81:2e0b:: with SMTP id u11mr3819761ywu.219.1567013965380;
        Wed, 28 Aug 2019 10:39:25 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id d186sm614964ywf.28.2019.08.28.10.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 10:39:24 -0700 (PDT)
Date:   Wed, 28 Aug 2019 13:39:24 -0400
From:   Sean Paul <sean@poorly.run>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bruce Wang <bzwang@chromium.org>,
        Jayant Shekhar <jshekhar@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: remove stray "\n"
Message-ID: <20190828173924.GD218215@art_vandelay>
References: <20190827211016.18070-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827211016.18070-1-robdclark@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 02:10:09PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> The extra line-break in traces was annoying me.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h
> index 765484437d11..eecfe9b3199e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h
> @@ -392,7 +392,7 @@ TRACE_EVENT(dpu_enc_rc,
>  		__entry->rc_state = rc_state;
>  		__assign_str(stage_str, stage);
>  	),
> -	TP_printk("%s: id:%u, sw_event:%d, idle_pc_supported:%s, rc_state:%d\n",
> +	TP_printk("%s: id:%u, sw_event:%d, idle_pc_supported:%s, rc_state:%d",
>  		  __get_str(stage_str), __entry->drm_id, __entry->sw_event,
>  		  __entry->idle_pc_supported ? "true" : "false",
>  		  __entry->rc_state)
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
