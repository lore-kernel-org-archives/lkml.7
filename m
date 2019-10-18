Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8A2CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659E1222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442492AbfJRKP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 06:15:28 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53440 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389149AbfJRKP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:15:28 -0400
Received: from 79.184.255.51.ipv4.supernova.orange.pl (79.184.255.51) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 07025921cfe5987f; Fri, 18 Oct 2019 12:15:26 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Colin King <colin.king@canonical.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PNP: fix unintended sign extension on left shifts
Date:   Fri, 18 Oct 2019 12:15:26 +0200
Message-ID: <7928372.mU7jdBj7dM@kreacher>
In-Reply-To: <20191014131608.31335-1-colin.king@canonical.com>
References: <20191014131608.31335-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 14, 2019 3:16:08 PM CEST Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Shifting a u8 left will cause the value to be promoted to an integer. If
> the top bit of the u8 is set then the following conversion to a 64 bit
> resource_size_t will sign extend the value causing the upper 32 bits
> to be set in the result.
> 
> Fix this by casting the u8 value to a resource_size_t before the shift.
> Original commit is pre-git history.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/pnp/isapnp/core.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
> index 179b737280e1..c947b1673041 100644
> --- a/drivers/pnp/isapnp/core.c
> +++ b/drivers/pnp/isapnp/core.c
> @@ -511,10 +511,14 @@ static void __init isapnp_parse_mem32_resource(struct pnp_dev *dev,
>  	unsigned char flags;
>  
>  	isapnp_peek(tmp, size);
> -	min = (tmp[4] << 24) | (tmp[3] << 16) | (tmp[2] << 8) | tmp[1];
> -	max = (tmp[8] << 24) | (tmp[7] << 16) | (tmp[6] << 8) | tmp[5];
> -	align = (tmp[12] << 24) | (tmp[11] << 16) | (tmp[10] << 8) | tmp[9];
> -	len = (tmp[16] << 24) | (tmp[15] << 16) | (tmp[14] << 8) | tmp[13];
> +	min = ((resource_size_t)tmp[4] << 24) | (tmp[3] << 16) |
> +              (tmp[2] << 8) | tmp[1];
> +	max = ((resource_size_t)tmp[8] << 24) | (tmp[7] << 16) |
> +              (tmp[6] << 8) | tmp[5];
> +	align = ((resource_size_t)tmp[12] << 24) | (tmp[11] << 16) |
> +              (tmp[10] << 8) | tmp[9];
> +	len = ((resource_size_t)tmp[16] << 24) | (tmp[15] << 16) |
> +              (tmp[14] << 8) | tmp[13];
>  	flags = tmp[0];
>  	pnp_register_mem_resource(dev, option_flags,
>  				  min, max, align, len, flags);
> @@ -532,8 +536,10 @@ static void __init isapnp_parse_fixed_mem32_resource(struct pnp_dev *dev,
>  	unsigned char flags;
>  
>  	isapnp_peek(tmp, size);
> -	base = (tmp[4] << 24) | (tmp[3] << 16) | (tmp[2] << 8) | tmp[1];
> -	len = (tmp[8] << 24) | (tmp[7] << 16) | (tmp[6] << 8) | tmp[5];
> +	base = ((resource_size_t)tmp[4] << 24) | (tmp[3] << 16) |
> +	       (tmp[2] << 8) | tmp[1];
> +	len = ((resource_size_t)tmp[8] << 24) | (tmp[7] << 16) |
> +              (tmp[6] << 8) | tmp[5];
>  	flags = tmp[0];
>  	pnp_register_mem_resource(dev, option_flags, base, base, 0, len, flags);
>  }
> 

Can you please respin this with a CC to linux-acpi?




