Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD70CC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794CF20665
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559651226;
	bh=iaMFRIk0Y0W/DnigZZek04DJjtoqETqrBE8Yb9t2yls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TSg/ssfQs9fb5REGjG3ROsJRxbdvQYF8kgvBiaKyoh5f5bP/JWS52cccwjTntC5Ef
	 jVBkFVggscu/zAU0WM1kF/RadJpJEFSvVZr6txAo6Jkb21oyfWKoujz+VLPa6ItLNE
	 S6Itqbop8z2Ciu/yoy1lUl/BwSN/pNA1pxShXzr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfFDM1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:27:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbfFDM1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:27:05 -0400
Received: from localhost (unknown [117.99.94.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 250F420665;
        Tue,  4 Jun 2019 12:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559651224;
        bh=iaMFRIk0Y0W/DnigZZek04DJjtoqETqrBE8Yb9t2yls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O9748DDEH8P8t3FQitaeEc2OO+rCZXtahQC0U5bCHPWevGAQWCTFjH5frdl6hyWsv
         aw+dOC7KcxPplabgvltFxlX6ku2NvJjo6flv4/x1gPM4wB4JhnSzSIave4FmcLqrmi
         0RNkc7stgEXdCq1GCLR+2atcJgVlG7Ewr963Ofy4=
Date:   Tue, 4 Jun 2019 17:53:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Hook, Gary" <Gary.Hook@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: dmatest: timeout value of -1 should specify
 infinite wait
Message-ID: <20190604122356.GY15118@vkoul-mobl>
References: <155933183362.4916.15727271006977576552.stgit@sosrh3.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155933183362.4916.15727271006977576552.stgit@sosrh3.amd.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-05-19, 19:43, Hook, Gary wrote:
> The dmatest module parameter 'timeout' is documented as accepting a
> -1 to mean "infinite timeout". Change the parameter to to signed
> integer, and check the value to call the appropriate wait_event()
> function.
> 
> Signed-off-by: Gary R Hook <gary.hook@amd.com>
> ---
>  drivers/dma/dmatest.c |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index b96814a7dceb..28a237686578 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -63,7 +63,7 @@ MODULE_PARM_DESC(pq_sources,
>  		"Number of p+q source buffers (default: 3)");
>  
>  static int timeout = 3000;
> -module_param(timeout, uint, S_IRUGO | S_IWUSR);
> +module_param(timeout, int, S_IRUGO | S_IWUSR);
>  MODULE_PARM_DESC(timeout, "Transfer Timeout in msec (default: 3000), "
>  		 "Pass -1 for infinite timeout");
>  
> @@ -795,8 +795,13 @@ static int dmatest_func(void *data)
>  		}
>  		dma_async_issue_pending(chan);
>  
> -		wait_event_freezable_timeout(thread->done_wait, done->done,
> -					     msecs_to_jiffies(params->timeout));
> +		/* A timeout value of -1 means infinite wait */
> +		if (timeout == -1)
> +			wait_event_freezable(thread->done_wait, done->done);

well i am not too happy that we have a infinite wait and no way to
cancel, maybe remove this case?

> +		else
> +			wait_event_freezable_timeout(thread->done_wait,
> +					done->done,
> +					msecs_to_jiffies(params->timeout));
>  
>  		status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
>  
> 

-- 
~Vinod
