Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02523C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF18321882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z7E4cVp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfKGTSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:18:52 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41973 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfKGTSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:18:51 -0500
Received: by mail-pl1-f195.google.com with SMTP id d29so2181310plj.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 11:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R0mhpIm1j25C2kw80c9DHmkkE8Y3evymZD3gEVrQAkg=;
        b=z7E4cVp/HfrOA+qGSQdCZ/PiQcee5McJBxFzRama+hH6/8ueZCeNSNuEz7SBRwJ234
         XyAFns5qi15Ir0lFWxcW8l5km8vP4x4Fuhd48lPh9/5M77mOziUmpraNJrxa9mcIDpqP
         BLGXC5rRidq6+kv7KCtEXwKdhGH7ciTPV+NZGOGMlXb6cTCW186VmsoQFM83nUWeyb4D
         bi3DQJcL8o/WIXNHe7c2Z09BKNpdlU8PB0fm+bbOiuwgiPwv3FQeop3b6FBR/SAVqEm5
         RmlcIWLqToe4I07UwcE5QTqiEgLnUOXz2F3iSOuOJwIDNrYOlbJ94HY11m/dzov8gVRD
         bm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R0mhpIm1j25C2kw80c9DHmkkE8Y3evymZD3gEVrQAkg=;
        b=R2+aLLUNecq6ZRvozx7EvAc997tr1nQSZd4MX9AMUiKmIgJh6TqbPBSbBlanS7F8QV
         v+g7jMvHL1p+pG51nsTwFKniGeZKPhNxUgUAXSXZJhuimvZP4oL1NmOuxVc4qyMLKimE
         aFxWMiII6SDpEc/0Sp3zmB0eihB3x9+6W/vb2dva6veg1c1b9s5M62MIQjLHhNmIqTZP
         G778RUDmjBZQz319cEUriRzc4KKLn1izLURPZ43zhjzOC19X8Uw0P6rb+XDsalF9qrwf
         QIk1RGlmvFTrR4gDJ5KbqT6jtclUcX0B6fOLeT0hk69Fg1dUgfs24BZuhM1Pwzn/PUN8
         bxkA==
X-Gm-Message-State: APjAAAWuGhliOohazmnJ/M/N98yRVHvqL2GFYHQ+FSHVyJNqJ9FAuiDe
        okBL5+kq6QuQGNI0+ID6iqUG2lYcjTM=
X-Google-Smtp-Source: APXvYqx2JnV7B6JJR5oh0bzeifXm/ms893hSMnqApMaef/8UdCzPJF3YzIRNZjUUA1BAjEAS2yLUog==
X-Received: by 2002:a17:902:8a8b:: with SMTP id p11mr5547042plo.152.1573154329932;
        Thu, 07 Nov 2019 11:18:49 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m67sm2920759pje.32.2019.11.07.11.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 11:18:48 -0800 (PST)
Date:   Thu, 7 Nov 2019 11:18:46 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Elliot Berman <eberman@codeaurora.org>
Cc:     saiprakash.ranjan@codeaurora.org, agross@kernel.org,
        tsoni@codeaurora.org, sidgup@codeaurora.org,
        psodagud@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/17] firmware: qcom_scm-64: Improve SMC convention
 detection
Message-ID: <20191107191846.GA3907604@builder>
References: <1572917256-24205-1-git-send-email-eberman@codeaurora.org>
 <1572917256-24205-10-git-send-email-eberman@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572917256-24205-10-git-send-email-eberman@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04 Nov 17:27 PST 2019, Elliot Berman wrote:

> - Use enum to describe SMC convention.
> - Improve SMC convention detection to use __qcom_scm_is_call_available
>   instead of circumventing qcom_scm_call_smccc.
> - Improve SMC convention detection to check that SMCCC-32 works, instead
>   of just assuming it does of SMCCC-64 does not.

I was about to tell you that your list represent individual changes, but
I think you should rewrite the commit message instead. Something like:

"""
Improve the calling convention detection to use
__qcom_scm_is_call_available() and not blindly assume 32-bit mode if
the checks fails.
"""

> 
> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> ---
>  drivers/firmware/qcom_scm-64.c | 42 ++++++++++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
> index f79b0dc..2579246 100644
> --- a/drivers/firmware/qcom_scm-64.c
> +++ b/drivers/firmware/qcom_scm-64.c
> @@ -58,7 +58,13 @@ struct arm_smccc_args {
>  	unsigned long a[8];
>  };
>  
> -static u64 qcom_smccc_convention = -1;
> +enum qcom_smc_convention {
> +	SMC_CONVENTION_UNKNOWN,
> +	SMC_CONVENTION_ARM_32,
> +	SMC_CONVENTION_ARM_64,
> +};
> +
> +static enum qcom_smc_convention qcom_smc_convention = SMC_CONVENTION_UNKNOWN;
>  static DEFINE_MUTEX(qcom_scm_lock);
>  
>  #define QCOM_SCM_EBUSY_WAIT_MS 30
> @@ -103,7 +109,9 @@ static int ___qcom_scm_call_smccc(struct device *dev,
>  
>  	smc.a[0] = ARM_SMCCC_CALL_VAL(
>  		atomic ? ARM_SMCCC_FAST_CALL : ARM_SMCCC_STD_CALL,
> -		qcom_smccc_convention,

Use a local variable instead of using a ternary operator in the middle
of the arguments.

> +		(qcom_smc_convention == SMC_CONVENTION_ARM_64) ?
> +			ARM_SMCCC_SMC_64 :
> +			ARM_SMCCC_SMC_32,

Here SMC_CONVENTION_UNKNOWN would mean ARM_SMCCC_SMC_32...

>  		desc->owner,
>  		SMCCC_FUNCNUM(desc->svc, desc->cmd));
>  	smc.a[1] = desc->arginfo;
> @@ -117,7 +125,7 @@ static int ___qcom_scm_call_smccc(struct device *dev,
>  		if (!args_virt)
>  			return -ENOMEM;
>  
> -		if (qcom_smccc_convention == ARM_SMCCC_SMC_32) {
> +		if (qcom_smc_convention == SMC_CONVENTION_ARM_32) {

...but here it would mean ARM_SMCCC_SMC_64.

>  			__le32 *args = args_virt;
>  
>  			for (i = 0; i < SMCCC_N_EXT_ARGS; i++)
> @@ -583,19 +591,17 @@ int __qcom_scm_qsmmu500_wait_safe_toggle(struct device *dev, bool en)
>  
>  void __qcom_scm_init(void)
>  {
> -	u64 cmd;
> -	struct arm_smccc_res res;
> -	u32 function = SMCCC_FUNCNUM(QCOM_SCM_SVC_INFO, QCOM_SCM_INFO_IS_CALL_AVAIL);
> -
> -	/* First try a SMC64 call */
> -	cmd = ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64,
> -				 ARM_SMCCC_OWNER_SIP, function);
> -
> -	arm_smccc_smc(cmd, QCOM_SCM_ARGS(1), cmd & (~BIT(ARM_SMCCC_TYPE_SHIFT)),
> -		      0, 0, 0, 0, 0, &res);
> -
> -	if (!res.a0 && res.a1)
> -		qcom_smccc_convention = ARM_SMCCC_SMC_64;
> -	else
> -		qcom_smccc_convention = ARM_SMCCC_SMC_32;
> +	qcom_smc_convention = SMC_CONVENTION_ARM_64;
> +	if (__qcom_scm_is_call_available(NULL, QCOM_SCM_SVC_INFO,
> +			QCOM_SCM_INFO_IS_CALL_AVAIL) == 1)
> +		goto out;
> +
> +	qcom_smc_convention = SMC_CONVENTION_ARM_32;
> +	if (__qcom_scm_is_call_available(NULL, QCOM_SCM_SVC_INFO,
> +			QCOM_SCM_INFO_IS_CALL_AVAIL) == 1)
> +		goto out;
> +
> +	qcom_smc_convention = SMC_CONVENTION_UNKNOWN;

If above two tests can be considered reliable I would suggest that you
fail hard here instead.

And if so I think you should postpone the introduction of the enum until
you actually need it to represent the legacy mode.

Regards,
Bjorn

> +out:
> +	pr_debug("QCOM SCM SMC Convention: %d\n", qcom_smc_convention);
>  }
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
