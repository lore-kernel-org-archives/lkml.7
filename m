Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF20BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEB221916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553264395;
	bh=Od4Q0EdlKiuaKntWgiKYJ+qxHG65baKr3t/YYOJ5D/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v4pBUqEn5J10xclyHPF356E/8jN4nqsK9NeSSQPE/FEg9A9BYy9yjAHs0J0QuoD44
	 7HOeQrUn3sqCbtdL9p+aUk+Sy+LLpxEwrpYs9l0nlo1eXotaXNV5i3tDPA0SOXKrCp
	 vH6Q6Ngg7Z3sj3BnKE6SzxSti8p4KeEMdB4rXxyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfCVOTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbfCVOTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:19:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51930218FC;
        Fri, 22 Mar 2019 14:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553264392;
        bh=Od4Q0EdlKiuaKntWgiKYJ+qxHG65baKr3t/YYOJ5D/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rIpJh4IFP0Dabi/CligCKES/9HrbVHSX1z8BmqLwR0s+2AGHxwA8LmbMmpvoZDlhF
         DWRBbzCt79wtNiCIRO1pUQlLqiJWBAwmqfZJiKPD2ddXrUBsqzIx73A/LuxTnG8XWg
         SnpM6ddxO2xk6FW/qamt5mMi6Fg6BLq2Rc9NkuUs=
Date:   Fri, 22 Mar 2019 15:19:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     George Hilliard <thirtythreeforty@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] staging: mt7621-mmc: Initialize completions a
 single time during probe
Message-ID: <20190322141949.GA23722@kroah.com>
References: <20190320224204.10243-1-thirtythreeforty@gmail.com>
 <20190320224204.10243-3-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320224204.10243-3-thirtythreeforty@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 04:42:04PM -0600, George Hilliard wrote:
> The module was initializing completions whenever it was going to wait on
> them, and not when the completion was allocated.  This is incorrect
> according to the completion docs:
> 
>     Calling init_completion() on the same completion object twice is
>     most likely a bug [...]
> 
> Re-initialization is also unnecessary because the module never uses
> complete_all().  Fix this by only ever initializing the completion a
> single time, and log if the completions are not consumed as intended
> (this is not a fatal problem, but should not go unnoticed).
> 
> Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
> ---
> v2: Rebased v1
> v3: Removed BUG_ON() calls, and politely log; this failure won't kill us
> 
>  drivers/staging/mt7621-mmc/sd.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
> index ff01872ab972..139533606863 100644
> --- a/drivers/staging/mt7621-mmc/sd.c
> +++ b/drivers/staging/mt7621-mmc/sd.c
> @@ -466,7 +466,10 @@ static unsigned int msdc_command_start(struct msdc_host   *host,
>  	host->cmd     = cmd;
>  	host->cmd_rsp = resp;
>  
> -	init_completion(&host->cmd_done);
> +	// The completion should have been consumed by the previous command
> +	// response handler, because the mmc requests should be serialized
> +	if(completion_done(&host->cmd_done))
> +		dev_err(mmc_dev(host->mmc), "previous command was not handled\n");

Proper coding style please :(

