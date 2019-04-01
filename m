Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647C5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D18020828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fegv65Ra";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Aq2AVUjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfDAM6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:58:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54222 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfDAM6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:58:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8101060DB4; Mon,  1 Apr 2019 12:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554123513;
        bh=0xBviVaKUkBKrNXhOKl9/B2D7F7Hvk6JBKoH6gWQgAI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fegv65RauP3mvAwkxn/DQJvFP60vTsvZQSTIyk5WCAc8wSPqQrNx2ZItYtdWJsJkh
         b4iIW9Jv16Ol1VEdvMldfJ5rPpoIqof7I9Z48lQ9QKs0gapz2xflBfVYk5ZldGb+5q
         hMjJq3NDF4M7EOMJdQkyIMevE/vRgUnG+R71ArOM=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 39E2A6072E;
        Mon,  1 Apr 2019 12:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554123511;
        bh=0xBviVaKUkBKrNXhOKl9/B2D7F7Hvk6JBKoH6gWQgAI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Aq2AVUjlx1eiMCK6IvbMyXH7sHC8eCOeMlN4EqXeDjQkxlgcuqAIzn46LQ/Cl007r
         yAoO8ElXJD3J7oSQf12i7GOqponJPVUE9XTIbU5WXJYbzfFi3bBuUoGVa93WSEtA6g
         112SyV0xYWjzWI4Hl6Zg7V+eso+bUwE9mED6TUrU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 39E2A6072E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 07/12] drm: omapdrm: add missing of_node_put after
 of_device_is_available
To:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     kernel-janitors@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr>
 <1550928043-14889-8-git-send-email-Julia.Lawall@lip6.fr>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <572cbf04-d97a-9807-75b5-2cf6f752667b@codeaurora.org>
Date:   Mon, 1 Apr 2019 18:28:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1550928043-14889-8-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/23/2019 6:50 PM, Julia Lawall wrote:
> Add an of_node_put when a tested device node is not available.
>
> The semantic patch that fixes this problem is as follows
> (http://coccinelle.lip6.fr):
>
> // <smpl>
> @@
> identifier f;
> local idexpression e;
> expression x;
> @@
>
> e = f(...);
> ... when != of_node_put(e)
>      when != x = e
>      when != e = x
>      when any
> if (<+...of_device_is_available(e)...+>) {
>    ... when != of_node_put(e)
> (
>    return e;
> |
> + of_node_put(e);
>    return ...;
> )
> }
> // </smpl>
>
> Fixes: f2dd36ac9974c ("OMAPDSS: move 'compatible' converter to omapdss driver")
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

>
> ---
>   drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff -u -p a/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c b/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
> --- a/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
> +++ b/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
> @@ -192,8 +192,10 @@ static int __init omapdss_boot_init(void
>   
>   	dss = of_find_matching_node(NULL, omapdss_of_match);
>   
> -	if (dss == NULL || !of_device_is_available(dss))
> +	if (dss == NULL || !of_device_is_available(dss)) {
> +		of_node_put(dss);
>   		return 0;
> +	}
>   
>   	omapdss_walk_device(dss, true);
>   
>
