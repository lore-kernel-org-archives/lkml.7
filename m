Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBA6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26352173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553877000;
	bh=vP6jZWHkF3aU4lu37Xd88jf5bS0qm3A+g9Mw907l1Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ikkd0WRgskY6Fl7ebUDVBRPPT46KYke6+3dylLRj8FaCPgPGFEQFuXzpaf3qvg5J5
	 zNQuQM5QuliayDR5Y5xe7uMJOaOnJbwFURLVcjixZ36s9XdpKrL7C5gvPxTHfpHJKK
	 5GGsCP+Zd5v6BMGh9f5mOFlyyfkXDEEDm3Dtk7QQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbfC2Q37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728815AbfC2Q37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:29:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6DD32173C;
        Fri, 29 Mar 2019 16:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553876998;
        bh=vP6jZWHkF3aU4lu37Xd88jf5bS0qm3A+g9Mw907l1Z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C0J3BeoQAO82rSar7jb6O+Q3kB0gy74nDPAMT7mR8uwjlklU3/jknq1BWoawDLDDm
         Qkhj44xdBuR9rzpehYN8VJ8J34/14WvobkL4kbrn2nt/+eqJJ9xGp/uXbDJ/9x8rht
         isT/E2JylyN6ak3EgW7f9f6755w/2L0SXuhXELz8=
Date:   Fri, 29 Mar 2019 17:29:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] habanalabs: improve error messages
Message-ID: <20190329162955.GA10386@kroah.com>
References: <20190328071313.5306-1-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328071313.5306-1-oded.gabbay@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 09:13:13AM +0200, Oded Gabbay wrote:
> This patch improves two error messages to help the user to
> better understand what error occurred.
> 
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> ---
>  drivers/misc/habanalabs/command_submission.c | 3 ++-
>  drivers/misc/habanalabs/memory.c             | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
> index f908643f871f..02c48da0b645 100644
> --- a/drivers/misc/habanalabs/command_submission.c
> +++ b/drivers/misc/habanalabs/command_submission.c
> @@ -261,7 +261,8 @@ static void cs_timedout(struct work_struct *work)
>  	ctx_asid = cs->ctx->asid;
>  
>  	/* TODO: add information about last signaled seq and last emitted seq */
> -	dev_err(hdev->dev, "CS %d.%llu got stuck!\n", ctx_asid, cs->sequence);
> +	dev_err(hdev->dev, "User %d command submission %llu got stuck!\n",
> +		ctx_asid, cs->sequence);
>  
>  	cs_put(cs);
>  
> diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
> index ce1fda40a8b8..39788b1cf8d0 100644
> --- a/drivers/misc/habanalabs/memory.c
> +++ b/drivers/misc/habanalabs/memory.c
> @@ -109,7 +109,7 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
>  							page_size);
>  			if (!phys_pg_pack->pages[i]) {
>  				dev_err(hdev->dev,
> -					"ioctl failed to allocate page\n");
> +					"Failed to allocate device memory (out of memory)\n");

No need for a message at all here, right?  The core should have already
told you you had a problem.

greg k-h
