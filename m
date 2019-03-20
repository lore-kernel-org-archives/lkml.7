Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7FFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295052184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553066531;
	bh=wjlPGvObJppWxDU+1KOukyxfd/bETKdwwdcEW4b+0H4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wJrKXwZvLSH0jMdMKM3SJnzSwUKQepAvZe7LgW15RQS2679FK08SokvPy47K3EwgM
	 /q0GxgLi7lnIEohtY2IBqBsDe/Za/VGDrILK1CSfqxRATJvfuoQLtuewrgLbg500md
	 BYioxE0hH6ALozmFAbwcR0Y6m+ursZIgZ+kuD8sE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfCTHWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 03:22:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfCTHWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 03:22:09 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B2C921841;
        Wed, 20 Mar 2019 07:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553066528;
        bh=wjlPGvObJppWxDU+1KOukyxfd/bETKdwwdcEW4b+0H4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vs/ot4AagNi1x/g7pbQHXIgd7K4TuGKxVAJxMw/CCZXh80ERYOSwC5dXk0JKJijl9
         Y6vDjuAhu+rzBUcM91mNk/iiWKk2+aRFQuSai6eAQWdVzTE0bZnS+9DFiLbzslf6R9
         pHzR6LME3NtevfG2S1OcDt1C6aK6hRp3Zd0W5rO0=
Date:   Wed, 20 Mar 2019 08:22:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     George Hilliard <thirtythreeforty@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/11] staging: mt7621-mmc: Initialize completions a
 single time during probe
Message-ID: <20190320072206.GB1914@kroah.com>
References: <20190319022012.11051-1-thirtythreeforty@gmail.com>
 <20190319022012.11051-7-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319022012.11051-7-thirtythreeforty@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 08:20:07PM -0600, George Hilliard wrote:
> The module was initializing completions whenever it was going to wait on
> them, and not when the completion was allocated.  This is incorrect
> according to the completion docs:
> 
>     Calling init_completion() on the same completion object twice is
>     most likely a bug [...]
> 
> Re-initialization is also unnecessary because the module never uses
> complete_all().  Fix this by only ever initializing the completion a
> single time.
> 
> Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
> ---
>  drivers/staging/mt7621-mmc/sd.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
> index 89fbc0a1dec7..c272aa780719 100644
> --- a/drivers/staging/mt7621-mmc/sd.c
> +++ b/drivers/staging/mt7621-mmc/sd.c
> @@ -467,7 +467,9 @@ static unsigned int msdc_command_start(struct msdc_host   *host,
>  	host->cmd     = cmd;
>  	host->cmd_rsp = resp;
>  
> -	init_completion(&host->cmd_done);
> +	// The completion should have been consumed by the previous command
> +	// response handler, because the mmc requests should be serialized
> +	BUG_ON(completion_done(&host->cmd_done));

Adding new BUG_ON() calls is not ok.  That crashes the machine and will
break everyone.  If this really is a potential error that could happen,
then handle it.  If not, then do not even put this there, it's not
needed.

All of the BUG_ON() entries need to be removed in the end from this code
anyway.

thanks,

greg k-h
