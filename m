Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCDAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC0B2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552822580;
	bh=IoxhbbuQzyOje3vvg4rrB06DSDhCLY9iaALdLTepVok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RoAo5UElBuCR/DHjsGFooe7bV0KRwrmPuVEQyXUkHnFHv9DJFqML49MGpQXbWIPa0
	 gr4TfVKuePB+GC2NPGPJgnwcWagP8/m/3rFhw3y5/wI34d6ScmKIJSTHiiF/2LNF3R
	 78eUc/oJC7GfcVaeqPStDAbEt5LzlQsrVypEuZqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfCQLgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 07:36:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbfCQLgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 07:36:18 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 686792086A;
        Sun, 17 Mar 2019 11:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552822577;
        bh=IoxhbbuQzyOje3vvg4rrB06DSDhCLY9iaALdLTepVok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qaZcE+QTXMiachiF1qzC09sRj49Qm3wlSjePMngykqCIRh4dwugOatVqetBp/W83Q
         JaEJzXJulgDHL3/gqUgAhyWJkWG9NAO3OV9nlxgDzk3/se1prVoUHn6BiFPKbbkjms
         MwIiiuPqhTMXidj4F338vFRfg5tb3kgdcPYecuK8=
Date:   Sun, 17 Mar 2019 12:36:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dominik Adamski <adamski.dominik@gmail.com>
Cc:     devel@driverdev.osuosl.org, Alex Elder <elder@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org
Subject: Re: [PATCH] staging: greybus: bundle.c fix comparison to NULL
Message-ID: <20190317113615.GA17880@kroah.com>
References: <20190304170636.4340-1-adamski.dominik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304170636.4340-1-adamski.dominik@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 06:06:36PM +0100, Dominik Adamski wrote:
> Fix checkpatch issue:
> Comparison to NULL could be written "!bundle->state"
> 
> Signed-off-by: Dominik Adamski <adamski.dominik@gmail.com>
> ---
>  drivers/staging/greybus/bundle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/bundle.c b/drivers/staging/greybus/bundle.c
> index e97b2b87ba47..3f702db9e098 100644
> --- a/drivers/staging/greybus/bundle.c
> +++ b/drivers/staging/greybus/bundle.c
> @@ -32,7 +32,7 @@ static ssize_t state_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct gb_bundle *bundle = to_gb_bundle(dev);
>  
> -	if (bundle->state == NULL)
> +	if (!bundle->state)
>  		return sprintf(buf, "\n");
>  
>  	return sprintf(buf, "%s\n", bundle->state);

This does not apply to my tree, please rebase and resend.

thanks,

greg k-h
