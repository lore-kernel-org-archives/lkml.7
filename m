Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB51BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C9322CF4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vcFH3PmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfHULjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 07:39:25 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:55264 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfHULjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 07:39:25 -0400
Received: from [192.168.0.20] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6C10333D;
        Wed, 21 Aug 2019 13:39:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1566387562;
        bh=GAq+49gNlQ0+5jt+SnoVFQqH/A1hRnn5GfyLB3dQbN4=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=vcFH3PmAnGrWXhHSjA1SmeQRQWfYz80wcYJuTJIuh3UeYf/tFHYuut0fHVFJV26Sf
         3ZwttZtDBI6IEBH64/zVrXakvfHAL5BIt9nm6ypygtYq1hTdnL1+qfMXbSXojmUPuo
         H2eN8cGGB7s8TPr3Ut51aJu60TNTPVdNpvBk9/9Q=
Reply-To: kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH] media: fdp1: Fix a memory leak bug
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FDP1" 
        <linux-media@vger.kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FDP1" 
        <linux-renesas-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1566107933-3355-1-git-send-email-wenwen@cs.uga.edu>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <5cb18e08-4e9b-6ca4-015a-fb21b4f7d504@ideasonboard.com>
Date:   Wed, 21 Aug 2019 12:39:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566107933-3355-1-git-send-email-wenwen@cs.uga.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wenwen,

On 18/08/2019 06:58, Wenwen Wang wrote:
> In fdp1_open(), 'ctx' is allocated through kzalloc(). However, it is not
> deallocated if v4l2_ctrl_new_std() fails, leading to a memory leak bug. To
> fix this issue, free 'ctx' before going to the 'done' label.
We could also free it up in the error path, with an if (ret) kfree(ctx);
and remove the kfree which is in the "if (IS_ERR(ctx->fh.m2m_ctx))" check.

But I think that doesn't gain much really. So this is ok by me... If you
prefer that method, then feel free to submit a v2,

Otherwise I think this is fine:

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>

> ---
>  drivers/media/platform/rcar_fdp1.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/rcar_fdp1.c b/drivers/media/platform/rcar_fdp1.c
> index 43aae9b..9e4b330 100644
> --- a/drivers/media/platform/rcar_fdp1.c
> +++ b/drivers/media/platform/rcar_fdp1.c
> @@ -2122,6 +2122,7 @@ static int fdp1_open(struct file *file)
>  	if (ctx->hdl.error) {
>  		ret = ctx->hdl.error;
>  		v4l2_ctrl_handler_free(&ctx->hdl);
> +		kfree(ctx);
>  		goto done;
>  	}
>  
> 

