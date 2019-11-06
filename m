Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85388C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E5320663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGSS6/NU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfKFGGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 01:06:44 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32964 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfKFGGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 01:06:43 -0500
Received: by mail-pg1-f194.google.com with SMTP id u23so16409529pgo.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 22:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fO9CrBS473r9XGUdz2X4YAYhNUAr7K3z7Xk6Z0Ias98=;
        b=kGSS6/NUHh/Fup/XJqoBe7jFEOS/vhjKWUgVhYRmZPp8vAgibEJRH+LeErMLdkJDx3
         EzQ2Wx7l9W5MDFG77PYGVDSBk9cJ8ET3GILuFwVMIG2mGrrgaXu4IS60yUyzyvvsyoZf
         +APwEWRSu1UJcUOmmH6ObV4Uqpq6LMHq9C4C+9NtSkjqcP1hnKI5wvA+eKGOVGE+ngSh
         IIf8XsRlCuHU1AD8xqXq0mq4SuHMceFUenOZELkEsp24HdiRHecs6U9ztWpsNKGMwvDV
         en7jQCnooWBjC/HBpnYG+LQEGzs8U7+r577jDwL4C+wpvihc3UWfQJGgH36ZIleCiaRs
         dngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fO9CrBS473r9XGUdz2X4YAYhNUAr7K3z7Xk6Z0Ias98=;
        b=C1DDgxtsYt33SqO5KGRX1ZVcpNhjHwlROxdfnF2K3wjh+1gHRplxFWiPesUZmQcBxW
         P1/boSLWOW4/AVX90EfU+aJA1eXTyBRrqsmEw2lBuVZ2s3DY/PTTcvmwjlbsHs4cC0A1
         l/ApieFbqEUvAxRZ5XC4vMm8bhVs6AKcwGkt5REijDjmLuB6762KLhCpRqm5KfP+24/G
         7PEPDWPO1bd3odsz0fKOcW4UAXI1K7QbEwWj9+KX/40bX3a2M+lr8/V9W9aKMVyFmv1/
         nOqZShJSQ7df0uL+RRI5rnmtTgqAQFnvX2k8HSJVWb9jdbm5/xB6fDOAuvVlzGz5bAPp
         Qa8w==
X-Gm-Message-State: APjAAAWIqDdyd/UE/uxN7C3GtQwixLygnMZfxHB7GNlKUF9fiPRCrBfD
        YvKmwBWBlPlsEz19T+9g3gPhqU9zSk0=
X-Google-Smtp-Source: APXvYqzu7WZCjQLQEg/l+E5HdBN9m1CmE4icYgrdQXZDWyNLvvUNorLU3uA/VqSewS4wkLAOvt7rQA==
X-Received: by 2002:a63:5d04:: with SMTP id r4mr945937pgb.22.1573020403012;
        Tue, 05 Nov 2019 22:06:43 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l33sm7283735pgb.79.2019.11.05.22.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 22:06:42 -0800 (PST)
Date:   Tue, 5 Nov 2019 22:06:40 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Elliot Berman <eberman@codeaurora.org>
Cc:     saiprakash.ranjan@codeaurora.org, agross@kernel.org,
        tsoni@codeaurora.org, sidgup@codeaurora.org,
        psodagud@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/17] firmware: qcom_scm: Remove unused
 qcom_scm_get_version
Message-ID: <20191106060640.GH586@tuxbook-pro>
References: <1572917256-24205-1-git-send-email-eberman@codeaurora.org>
 <1572917256-24205-5-git-send-email-eberman@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572917256-24205-5-git-send-email-eberman@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04 Nov 17:27 PST 2019, Elliot Berman wrote:

> Remove unused qcom_scm_get_version.
> 
> Signed-off-by: Elliot Berman <eberman@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/firmware/qcom_scm-32.c | 36 ------------------------------------
>  include/linux/qcom_scm.h       |  2 --
>  2 files changed, 38 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
> index b09fddf..b7f9f28 100644
> --- a/drivers/firmware/qcom_scm-32.c
> +++ b/drivers/firmware/qcom_scm-32.c
> @@ -291,42 +291,6 @@ static s32 qcom_scm_call_atomic2(u32 svc, u32 cmd, u32 arg1, u32 arg2)
>  	return r0;
>  }
>  
> -u32 qcom_scm_get_version(void)
> -{
> -	int context_id;
> -	static u32 version = -1;
> -	register u32 r0 asm("r0");
> -	register u32 r1 asm("r1");
> -
> -	if (version != -1)
> -		return version;
> -
> -	mutex_lock(&qcom_scm_lock);
> -
> -	r0 = 0x1 << 8;
> -	r1 = (u32)&context_id;
> -	do {
> -		asm volatile(
> -			__asmeq("%0", "r0")
> -			__asmeq("%1", "r1")
> -			__asmeq("%2", "r0")
> -			__asmeq("%3", "r1")
> -#ifdef REQUIRES_SEC
> -			".arch_extension sec\n"
> -#endif
> -			"smc	#0	@ switch to secure world\n"
> -			: "=r" (r0), "=r" (r1)
> -			: "r" (r0), "r" (r1)
> -			: "r2", "r3", "r12");
> -	} while (r0 == QCOM_SCM_INTERRUPTED);
> -
> -	version = r1;
> -	mutex_unlock(&qcom_scm_lock);
> -
> -	return version;
> -}
> -EXPORT_SYMBOL(qcom_scm_get_version);
> -
>  /**
>   * qcom_scm_set_cold_boot_addr() - Set the cold boot address for cpus
>   * @entry: Entry point function for the cpus
> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
> index f8b6525..05a1c7a 100644
> --- a/include/linux/qcom_scm.h
> +++ b/include/linux/qcom_scm.h
> @@ -59,7 +59,6 @@ extern bool qcom_scm_hdcp_available(void);
>  extern int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt,
>  			     u32 *resp);
>  extern int qcom_scm_qsmmu500_wait_safe_toggle(bool en);
> -extern u32 qcom_scm_get_version(void);
>  extern bool qcom_scm_is_available(void);
>  #else
>  
> @@ -101,7 +100,6 @@ static inline int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt,
>  				    u32 *resp) { return -ENODEV; }
>  static inline int qcom_scm_qsmmu500_wait_safe_toggle(bool en)
>  		{ return -ENODEV; }
> -static inline u32 qcom_scm_get_version(void) { return 0; }
>  static inline bool qcom_scm_is_available(void) { return false; }
>  #endif
>  #endif
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
