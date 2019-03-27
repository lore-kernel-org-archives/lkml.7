Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FD7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACDE2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553676475;
	bh=eY02d+ywyzOVGbFXM7e3Qu2CY5qffig2D5/u6xmdzT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ABhUsnu9TySJyE2bQU5cvm6eiMBiddcj9jF1HZeBZZ4mhgOGH5LfNQvTUJiTT3Iff
	 IKgoC+SUFQNPr9No1c2diChwAwy2xThzdu4EERrKZxilLaQlPJPx6tveJsrgHkHaTP
	 aFiWIuNl0V7CJorKJ2TXBpVldxMg4/gjqXOKVH2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732873AbfC0Iry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:47:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:47160 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726248AbfC0Irx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:47:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5EA3AAC6B;
        Wed, 27 Mar 2019 08:47:52 +0000 (UTC)
Date:   Wed, 27 Mar 2019 09:47:51 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vitaly Mayatskikh <v.mayatskih@gmail.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: zero vhost_vsock memory on allocation
Message-ID: <20190327084751.GB11927@dhcp22.suse.cz>
References: <1553648174-24913-1-git-send-email-v.mayatskih@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553648174-24913-1-git-send-email-v.mayatskih@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-03-19 20:56:14, Vitaly Mayatskikh wrote:
> This fixes OOPS when using under-initialized vhost_vsock object.
> 
> The code had a combo of kzalloc plus vmalloc as a fallback
> initially, but it has been replaced by plain kvmalloc in
> commit 6c5ab6511f71 ("mm: support __GFP_REPEAT in kvmalloc_node for >32kB")
> 
> OOPS is easy to reproduce with open/ioctl after trashing the RAM.

Sorry for the screw up, that was certainly not inteded effect of the
patch.

Fixes: 6c5ab6511f71 ("mm: support __GFP_REPEAT in kvmalloc_node for >32kB")
Cc: stable # 4.12+

> Signed-off-by: Vitaly Mayatskikh <v.mayatskih@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks for catching that.

> ---
>  drivers/vhost/vsock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index bb5fc0e..9e7cb13 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -512,7 +512,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>  	/* This struct is large and allocation could fail, fall back to vmalloc
>  	 * if there is no other way.
>  	 */
> -	vsock = kvmalloc(sizeof(*vsock), GFP_KERNEL | __GFP_RETRY_MAYFAIL);
> +	vsock = kvzalloc(sizeof(*vsock), GFP_KERNEL | __GFP_RETRY_MAYFAIL);
>  	if (!vsock)
>  		return -ENOMEM;
>  
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
