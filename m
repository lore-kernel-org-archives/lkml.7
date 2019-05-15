Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1CEC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCEE20881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557927154;
	bh=MCLlnMYeW53HhmY5WWSEFrVzEQl1Xp/yHrS8rpGvcuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O84gvdjxbEEXPNM4dEzAAmgdegeH2JrgmTIMy2qM49XZyB18YlgPOI/WnFc5slmO9
	 /52G5hfSKjrwsYs51OFZw7ETKh//qiL53f5GyvpAJKWTX8YFFvYohs4UF/ul/SuCKv
	 EG39eeEFESCu0MBfN2rjINwFXA+TtRR2ZL+J6jJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfEONcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 09:32:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfEONcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:32:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 484092084E;
        Wed, 15 May 2019 13:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557927152;
        bh=MCLlnMYeW53HhmY5WWSEFrVzEQl1Xp/yHrS8rpGvcuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IuLlkS1cUynt/6DyffbQsWc4BkCmdrmjdw8LzQcbjr6q5yQM2l1ry7kttdbueqdBM
         XnBIYEfdTBn/2nTv6rfQAby0BqRFtsdw1V/WVOBnOQmYLXFR70IpDJnbg7Vx0fK/vt
         ip+jvWVxWHuB7GwlMkvr4KJ5+2124ZsfE0fVAKVg=
Date:   Wed, 15 May 2019 15:32:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     parna.naveenkumar@gmail.com
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bsr: do not use assignment in if condition
Message-ID: <20190515133230.GB5316@kroah.com>
References: <20190515131524.26679-1-parna.naveenkumar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515131524.26679-1-parna.naveenkumar@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 06:45:24PM +0530, parna.naveenkumar@gmail.com wrote:
> From: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
> 
> checkpatch.pl does not like assignment in if condition
> 
> Signed-off-by: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
> ---
>  drivers/char/bsr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/bsr.c b/drivers/char/bsr.c
> index a6cef548e01e..2b00748b83d2 100644
> --- a/drivers/char/bsr.c
> +++ b/drivers/char/bsr.c
> @@ -322,7 +322,8 @@ static int __init bsr_init(void)
>  		goto out_err_2;
>  	}
>  
> -	if ((ret = bsr_create_devs(np)) < 0) {
> +	ret = bsr_create_devs(np);
> +	if (ret  < 0) {

Checkpatch also probably does not like that if statement :(

