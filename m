Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37928C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033582087C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564314281;
	bh=WZpRKoQ5Dv6s/bne2ljPJOtmE1tQaa8adajYT1OKEWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RgyrvK2v191yk2ncpy1X/g3198IvBr39Ms60SVBuq+iEZ9dgc9DUYNmIsEJRCMo45
	 BKENZKLq2rAfG40thXt6CmwLQ2ARy9Rii2nN+Si+7oVV/A55IPojdG5EZVrOfxohml
	 8NL9b1HFAy06xVDP1+KXdAUGA6clpi4bdL556JRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfG1Loj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 07:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfG1Loj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 07:44:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35FD22075B;
        Sun, 28 Jul 2019 11:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564314277;
        bh=WZpRKoQ5Dv6s/bne2ljPJOtmE1tQaa8adajYT1OKEWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RWHU2gtrIhQqIvQ+4rR7CfCa3+KkqEJxjDlA8ziYD2AIhm8iQi83HOK8zLgbxndfE
         hyKsJ8T9dHKL2N4CDbZsv+ugrAoDdjMn6+sstvyHhZ7h+GBbGZ+tNqTjiH1ppFCv/i
         +y4alahLh/SIvKuhgKwoCSC1QOlvXHG51A0fvqQ8=
Date:   Sun, 28 Jul 2019 13:44:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Subject: Re: [PATCH 9/9] habanalabs: allow multiple processes to open FD
Message-ID: <20190728114435.GB12033@kroah.com>
References: <20190728112818.30397-1-oded.gabbay@gmail.com>
 <20190728112818.30397-10-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728112818.30397-10-oded.gabbay@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 02:28:18PM +0300, Oded Gabbay wrote:
> This patch removes the limitation of a single process that can open the
> device.
> 
> Now, there is no limitation on the number of processes that can open the
> device and have a valid FD.
> 
> However, only a single process can perform compute operations. This is
> enforced by allowing only a single process to have a compute context.
> 
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> ---
>  drivers/misc/habanalabs/context.c          | 100 +++++++++++++++------
>  drivers/misc/habanalabs/device.c           |  18 ++--
>  drivers/misc/habanalabs/habanalabs.h       |   1 -
>  drivers/misc/habanalabs/habanalabs_drv.c   |   8 --
>  drivers/misc/habanalabs/habanalabs_ioctl.c |   7 +-
>  5 files changed, 85 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
> index 57bbe59da9b6..f64220fc3a55 100644
> --- a/drivers/misc/habanalabs/context.c
> +++ b/drivers/misc/habanalabs/context.c
> @@ -56,7 +56,7 @@ void hl_ctx_do_release(struct kref *ref)
>  	kfree(ctx);
>  }
>  
> -int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
> +static int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
>  {
>  	struct hl_ctx_mgr *mgr = &hpriv->ctx_mgr;
>  	struct hl_ctx *ctx;
> @@ -89,9 +89,6 @@ int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
>  	/* TODO: remove for multiple contexts per process */
>  	hpriv->ctx = ctx;
>  
> -	/* TODO: remove the following line for multiple process support */
> -	hdev->compute_ctx = ctx;
> -
>  	return 0;
>  
>  remove_from_idr:
> @@ -206,13 +203,22 @@ bool hl_ctx_is_valid(struct hl_fpriv *hpriv, bool requires_compute_ctx)
>  	int rc;
>  
>  	/* First thing, to minimize latency impact, check if context exists.
> -	 * Also check if it matches the requirements. If so, exit immediately
> +	 * This is relevant for the "steady state", where a process context
> +	 * already exists, and we want to minimize the latency in command
> +	 * submissions. In that case, we want to see if we can quickly exit
> +	 * with a valid answer.
> +	 *
> +	 * If a context doesn't exists, we must grab the mutex. Otherwise,
> +	 * there can be nasty races in case of multi-threaded application.
> +	 *
> +	 * So, if the context exists and we don't need a compute context,
> +	 * that's fine. If it exists and the context we have is the compute
> +	 * context, that's also fine. Other then that, we can't check anything
> +	 * without the mutex.
>  	 */
> -	if (hpriv->ctx) {
> -		if ((requires_compute_ctx) && (hdev->compute_ctx != hpriv->ctx))
> -			return false;
> +	if ((hpriv->ctx) && ((!requires_compute_ctx) ||
> +					(hdev->compute_ctx == hpriv->ctx)))
>  		return true;
> -	}
>  
>  	mutex_lock(&hdev->lazy_ctx_creation_lock);
>  
> @@ -222,35 +228,73 @@ bool hl_ctx_is_valid(struct hl_fpriv *hpriv, bool requires_compute_ctx)
>  	 * creation of a context
>  	 */
>  	if (hpriv->ctx) {
> -		if ((requires_compute_ctx) && (hdev->compute_ctx != hpriv->ctx))
> +		if ((!requires_compute_ctx) ||
> +					(hdev->compute_ctx == hpriv->ctx))
> +			goto unlock_mutex;
> +
> +		if (hdev->compute_ctx) {
>  			valid = false;
> -		goto unlock_mutex;
> -	}
> +			goto unlock_mutex;
> +		}
>  
> -	/* If we already have a compute context, there is no point
> -	 * of creating one in case we are called from ioctl that needs
> -	 * a compute context
> -	 */
> -	if ((hdev->compute_ctx) && (requires_compute_ctx)) {
> +		/* If we reached here, it means we have a non-compute context,
> +		 * but there is no compute context on the device. Therefore,
> +		 * we can try to "upgrade" the existing context to a compute
> +		 * context
> +		 */
> +		dev_dbg_ratelimited(hdev->dev,
> +				"Non-compute context %d exists\n",
> +				hpriv->ctx->asid);
> +
> +	} else if ((hdev->compute_ctx) && (requires_compute_ctx)) {
> +
> +		/* If we already have a compute context in the device, there is
> +		 * no point of creating one in case we are called from ioctl
> +		 * that needs a compute context
> +		 */
>  		dev_err(hdev->dev,
>  			"Can't create new compute context as one already exists\n");
>  		valid = false;
>  		goto unlock_mutex;
> -	}
> +	} else {
> +		/* If we reached here it is because there isn't a context for
> +		 * the process AND there is no compute context or compute
> +		 * context wasn't required. In any case, must create a context
> +		 * for the process
> +		 */
>  
> -	rc = hl_ctx_create(hdev, hpriv);
> -	if (rc) {
> -		dev_err(hdev->dev, "Failed to create context %d\n", rc);
> -		valid = false;
> -		goto unlock_mutex;
> +		rc = hl_ctx_create(hdev, hpriv);
> +		if (rc) {
> +			dev_err(hdev->dev, "Failed to create context %d\n", rc);
> +			valid = false;
> +			goto unlock_mutex;
> +		}
> +
> +		dev_dbg_ratelimited(hdev->dev, "Created context %d\n",
> +					hpriv->ctx->asid);
>  	}
>  
> -	/* Device is IDLE at this point so it is legal to change PLLs.
> -	 * There is no need to check anything because if the PLL is
> -	 * already HIGH, the set function will return without doing
> -	 * anything
> +	/* If we reached here then either we have a new context, or we can
> +	 * upgrade a non-compute context to a compute context. Do the upgrade
> +	 * only if the caller required a compute context
>  	 */
> -	hl_device_set_frequency(hdev, PLL_HIGH);
> +	if (requires_compute_ctx) {
> +		WARN(hdev->compute_ctx,
> +			"Compute context exists but driver is setting a new one");

This will trigger syzbot and will reboot machines that have
'panic-on-warn' set (i.e. all cloud systems).  So be _VERY_ careful
about this.

If a user can trigger this, do not use WARN(), that's not what it is
for.

thanks,

greg k-h
