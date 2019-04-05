Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3C2C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEEF5206DD
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbfDEO7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:59:13 -0400
Received: from ns.iliad.fr ([212.27.33.1]:37836 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfDEO7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:59:12 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id C0CF12195A;
        Fri,  5 Apr 2019 16:59:10 +0200 (CEST)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id ACB2D21959;
        Fri,  5 Apr 2019 16:59:10 +0200 (CEST)
Subject: Re: [PATCH v3 1/9] soc: qcom: rpmpd: fixup rpmpd set performance
 state
To:     Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20190327123832.11566-1-sibis@codeaurora.org>
 <20190327123832.11566-2-sibis@codeaurora.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <ac4c39f0-3ab2-7930-7d37-c132e5a7a764@free.fr>
Date:   Fri, 5 Apr 2019 16:59:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327123832.11566-2-sibis@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Fri Apr  5 16:59:11 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2019 13:38, Sibi Sankar wrote:

> Remoteproc q6v5-mss does set_performace_state with INT_MAX on

Remoteproc q6v5-mss calls set_performance_state()

> rpmpd. This is currently ignored since it is greater than the
> max supported state. Fixup rpmpd state to max if the required
> state is greater than all the supported states.
> 
> Fixes: 075d3db8d10d ("Add support for the .set_performace_state() and
> .opp_to_performance_state()")
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

AFAIU, the Fixes tag should be on a single line, and quote the commit subject.
(And no blank line between Fixes and Signed-off-by tags.)

Fixes: 075d3db8d10d ("soc: qcom: rpmpd: Add support for get/set performance state")

> ---
>  drivers/soc/qcom/rpmpd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
> index 005326050c23..235d01870dd8 100644
> --- a/drivers/soc/qcom/rpmpd.c
> +++ b/drivers/soc/qcom/rpmpd.c
> @@ -226,7 +226,7 @@ static int rpmpd_set_performance(struct generic_pm_domain *domain,
>  	struct rpmpd *pd = domain_to_rpmpd(domain);
>  
>  	if (state > MAX_RPMPD_STATE)
> -		goto out;
> +		state = MAX_RPMPD_STATE;
>  
>  	mutex_lock(&rpmpd_lock);
>  

With these two nits taken care of:

Reviewed-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Regards.
