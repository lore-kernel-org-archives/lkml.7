Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDEEC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793AA20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DDK2lGeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfCGAOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:14:55 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45251 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCGAOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:14:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id v21so9932537pfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PUzbM1w33kgF2Apb2Ln4T2hpMUd459RNOQ0o3syzh8w=;
        b=DDK2lGeAb1hATcxmJfto6l/JRF6LP/7U0etDBV3FNoPIRhL8mMsnT0IBwX/BjAo6u1
         NfBLnq6+/7+D4W0P/FYkULau5j5qQwjT29s3uy6xq2N8hqKyTINfY9QD5U2JUf34EiB4
         Wq1TO97MdA4YkIXS3MWBabcdCutTdSqYmrnJqzot3KAxMyZ7b+JfOTbYNFCLKcmsYY5i
         2N9T1t/O28Ha7ZNgJjV1A0kc6AoUuc0zGVudcLNB9f48Zxyzb0QwdUqCs6XkjFIUypE0
         ZfejyBkxf0YXLPKUotr05b+b1U9SsZVRYLm6lQODpB1MzrKFqpVfw2tHh9yNmlppAuOg
         HhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PUzbM1w33kgF2Apb2Ln4T2hpMUd459RNOQ0o3syzh8w=;
        b=j5eAdCsOkFLDTVeOWjWXLHzNhCCfw03LnyprPxDQvAey8U28Q5AFJoUNHk2/Rl0/W4
         MPFpqC/m7oUXK4mMqzLdv0qeRaFc7m+urQMD2botFV3XgMnyYOAEM7ajKwlOmGmLUROe
         pIwFinzBQ43qDyldz+Xy/jnEvxd4nbU4nMgDMbHwoBBrN0NsRIMVyKP+jCJlwa14efHJ
         k83HidiaWUGdOUC8q0EiSYFlG+b6Eov9OhhT/Zbc9Lu0OM3S2z68g6+RP8RTU4xDSVof
         /G1jdfyuyIBoTJwOmmTUEq0WIbycYZtzj9yCsB/mPlX3Z5/Eti5BnKfq/fi7USd5ewNk
         rbHg==
X-Gm-Message-State: APjAAAUDnSfEsi9X/UJI10DjIFQjnW35Ht+/nEjYitys1oyN1dmtJqfo
        b/NzSj58AuBaFPCEbQNU3ZHi9A==
X-Google-Smtp-Source: APXvYqzN+iiMuTlNKEVoAmNC/pKewiC5NOrWHypWhUZ5QNYe5o730PD3tG/xiSdZODab1bXNUMDBWg==
X-Received: by 2002:a62:e216:: with SMTP id a22mr9878084pfi.20.1551917693903;
        Wed, 06 Mar 2019 16:14:53 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l79sm7934549pfb.102.2019.03.06.16.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 16:14:53 -0800 (PST)
Date:   Wed, 6 Mar 2019 16:15:42 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Chris Lew <clew@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        aneela@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: qmi: Change txn wait to non-interruptible
Message-ID: <20190307001542.GF27005@builder>
References: <20190222023339.30454-1-clew@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222023339.30454-1-clew@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21 Feb 18:33 PST 2019, Chris Lew wrote:

> Current QMI clients are not userspace facing, if their threads are
> signaled, they do not do any signal checking or propagate the
> ERESTARTSYS return code up. Remove the interruptible option so clients
> can finish their QMI transactions even if the thread is signaled.
> 
> Signed-off-by: Chris Lew <clew@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/soc/qcom/qmi_interface.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/qcom/qmi_interface.c b/drivers/soc/qcom/qmi_interface.c
> index c239a28e503f..f9e309f0acd3 100644
> --- a/drivers/soc/qcom/qmi_interface.c
> +++ b/drivers/soc/qcom/qmi_interface.c
> @@ -345,8 +345,7 @@ int qmi_txn_wait(struct qmi_txn *txn, unsigned long timeout)
>  	struct qmi_handle *qmi = txn->qmi;
>  	int ret;
>  
> -	ret = wait_for_completion_interruptible_timeout(&txn->completion,
> -							timeout);
> +	ret = wait_for_completion_timeout(&txn->completion, timeout);
>  
>  	mutex_lock(&qmi->txn_lock);
>  	mutex_lock(&txn->lock);
> @@ -354,9 +353,7 @@ int qmi_txn_wait(struct qmi_txn *txn, unsigned long timeout)
>  	mutex_unlock(&txn->lock);
>  	mutex_unlock(&qmi->txn_lock);
>  
> -	if (ret < 0)
> -		return ret;
> -	else if (ret == 0)
> +	if (ret == 0)
>  		return -ETIMEDOUT;
>  	else
>  		return txn->result;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
