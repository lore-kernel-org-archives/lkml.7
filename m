Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86684C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5533C2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553647571;
	bh=VnGM0s5kqmuXW+KOcnWFx1TyYj0DnTnhE/my1+oM1cA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vwN3AEOOugARC/FwZ9JXPdwSiLLEi+OzCJTH+ZmU1hMi2pIseWqR5Wc/1Dmf29OxI
	 y6Xh9NZc2u7vJQIhlYZclZ7XQTQt0GqrA+vVfhorPEvrLRo8e7zeuytAm3hkFuQ7me
	 oMzlto3/XwKRSL1ksFTUCERXAcSGtTb+rnXcfSd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbfC0AqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:46:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730333AbfC0AqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:46:09 -0400
Received: from localhost (mobile-166-137-177-030.mycingular.net [166.137.177.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F41342082F;
        Wed, 27 Mar 2019 00:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553647568;
        bh=VnGM0s5kqmuXW+KOcnWFx1TyYj0DnTnhE/my1+oM1cA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nMgJMuai1zofqgzM+DacllOwm5Uo9cbD+nLxlWK5LiS/c6OWWO7N8WpWwas4Noue+
         ROO8+QIFuYfXUxwstauDm9aPj7sPwJrjOPL+MAHOnlj6X12UXRocgkG+pWbDcg0aWN
         5kuoFNrxrKvdKrJfY4BvfKB6+gVZ5QFwklr2exwI=
Date:   Wed, 27 Mar 2019 09:46:03 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     George Hilliard <thirtythreeforty@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] staging: mt7621-mmc: Initialize completions a
 single time during probe
Message-ID: <20190327004603.GA28785@kroah.com>
References: <20190326152139.18609-1-thirtythreeforty@gmail.com>
 <20190326152139.18609-3-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326152139.18609-3-thirtythreeforty@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 09:21:39AM -0600, George Hilliard wrote:
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
> v2: rewrite of v1
> v3: Remove BUG_ON() calls
> v4: Indent style fixup
> 
>  drivers/staging/mt7621-mmc/sd.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
> index e346167754bd..ed63bd3ba6cc 100644
> --- a/drivers/staging/mt7621-mmc/sd.c
> +++ b/drivers/staging/mt7621-mmc/sd.c
> @@ -466,7 +466,11 @@ static unsigned int msdc_command_start(struct msdc_host   *host,
>  	host->cmd     = cmd;
>  	host->cmd_rsp = resp;
>  
> -	init_completion(&host->cmd_done);
> +	// The completion should have been consumed by the previous command
> +	// response handler, because the mmc requests should be serialized
> +	if(completion_done(&host->cmd_done))

Did you run your patch through checkpatch.pl?  It should have reported
an error here :(

