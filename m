Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9135C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD73F206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573143759;
	bh=Oio7kQtxerBAH1J0SEEZ7FJadGkhHa9Xz6YhPgJ5zd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hHqfJPBzCzFn5VOv++hlctoSFnsQWriqo6bMxZA/wRMHAMBDYKIifCDj0ep/7ExPN
	 a9x542umKrae6ndud7fl3slWIrikqIEOALubRkMdn+rPyW9K2aIThFXFGs00/4HqVq
	 wmTV1XgPeoOmwsXE5ojy6QGi4aJb5/HvAjupqOes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbfKGQWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:22:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:37794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfKGQWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:22:38 -0500
Received: from localhost (unknown [106.200.239.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB9C2206DF;
        Thu,  7 Nov 2019 16:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573143757;
        bh=Oio7kQtxerBAH1J0SEEZ7FJadGkhHa9Xz6YhPgJ5zd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=adGw2qmmyG7GXaKq+0rJibG4qZtuelT0llPyIWXkJutu9GQ5ZCFBzzTlBFX/v92hv
         5ckQ0M6xtINa1eCql0X3n1b5Xqzhg9/SUUlE6qvWcYcWqZ8w8S0bZV3YHkkPcKRz7Y
         vFu7IJFbBRYxcfdEb5ZWzyy5h7MX1JHV/pmJs8T8=
Date:   Thu, 7 Nov 2019 21:52:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Elliot Berman <eberman@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, saiprakash.ranjan@codeaurora.org,
        agross@kernel.org, tsoni@codeaurora.org, sidgup@codeaurora.org,
        psodagud@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/17] firmware: qcom_scm: Rename macros and structures
Message-ID: <20191107162224.GN952516@vkoul-mobl>
References: <1572917256-24205-1-git-send-email-eberman@codeaurora.org>
 <1572917256-24205-2-git-send-email-eberman@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572917256-24205-2-git-send-email-eberman@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-11-19, 17:27, Elliot Berman wrote:
> - Rename legacy-specific structures and macros with "legacy_" prefix.
> - Rename smccc-specific structures and macros with "smccc_" prefix.
> - Flip calculation of SMCCC_N_EXT_ARGS to be a function of N_REG_ARGS
>   (not the other way around). N_REG_ARGS is fixed based off the SMC
>   instruction and shouldn't be computed from the SCM abstraction.
> - Move SMCCC_FUNCNUM closer to other smccc-specific macros.
> - Add LEGACY_FUNCNUM macro to qcom_scm-32.c

My preference is one change per patch :) That also makes it easier to
review!

> +#define LEGACY_FUNCNUM(s, c)  (((s) << 10) | ((c) & 0x3ff))
> +
>  /**
> - * struct qcom_scm_command - one SCM command buffer
> + * struct legacy_command - one SCM command buffer

can we keep the qcom_ tag in this?

>  /**
> - * struct qcom_scm_response - one SCM response buffer
> + * struct legacy_response - one SCM response buffer
>   * @len: total available memory for response
> - * @buf_offset: start of response data relative to start of qcom_scm_response
> + * @buf_offset: start of response data relative to start of legacy_response
>   * @is_complete: indicates if the command has finished processing
>   */
> -struct qcom_scm_response {
> +struct legacy_response {

here as well

> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index a729e05..40222b1 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -1,8 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Qualcomm SCM driver
> - *
> - * Copyright (c) 2010,2015, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2010,2015,2019 The Linux Foundation. All rights reserved.
>   * Copyright (C) 2015 Linaro Ltd.

I don't feel this belongs to this patch, please move it to patch
touching this file

-- 
~Vinod
