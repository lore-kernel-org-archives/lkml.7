Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93971C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1A92086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbfI3IfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 04:35:11 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:60509 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbfI3IfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 04:35:11 -0400
Received: from [192.168.2.10] ([46.9.232.237])
        by smtp-cloud7.xs4all.net with ESMTPA
        id Er97ickak9D4hEr9AiKwJr; Mon, 30 Sep 2019 10:35:09 +0200
Subject: Re: [Patch 07/16] media: ti-vpe: vpe: fix a v4l2-compliance failure
 causing a kernel panic
To:     Benoit Parrot <bparrot@ti.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190927183650.31345-1-bparrot@ti.com>
 <20190927183650.31345-8-bparrot@ti.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <1a7c5929-15f1-8f04-1212-42f064654742@xs4all.nl>
Date:   Mon, 30 Sep 2019 10:35:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190927183650.31345-8-bparrot@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPpSIcYiSAgzWnPTLjqebCnZzwLOTGR29IhC1Xy1FZFqcZI+bgnIcCkzy/Xw8wyJnezhiG2+4BRHkrWkv/+Ps5qEYxzxijeoIS8WFAIHr6635UWy5mk4
 o9xUOXz5UzJa60TCCO3xrXJ+htn93ySXbL/n51im3Zo2GnoP6MAFp6lCs0+n03P1MWhPqzJrv3M1mw/tcYSfyAHYSTF0+3cAAyQ9LFcXMdZleIJAOECCUtU4
 inn62VIPhUVZGLMoZyytEXgk4SQewxyl/5UfB0ZQ704ZRHg2xxIQ35T6Rl9NnUJ9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/19 8:36 PM, Benoit Parrot wrote:
> v4l2-compliance fails with this message:
> 
>    warn: v4l2-test-formats.cpp(717): \
>    	TRY_FMT cannot handle an invalid pixelformat.
>    test VIDIOC_TRY_FMT: FAIL
> 
> This causes the following kernel panic:
> 
> Unable to handle kernel paging request at virtual address 56595561
> pgd = ecd80e00
> *pgd=00000000
> Internal error: Oops: 205 [#1] PREEMPT SMP ARM
> ...
> CPU: 0 PID: 930 Comm: v4l2-compliance Not tainted \
> 	4.14.62-01715-gc8cd67f49a19 #1
> Hardware name: Generic DRA72X (Flattened Device Tree)
> task: ece44d80 task.stack: ecc6e000
> PC is at __vpe_try_fmt+0x18c/0x2a8 [ti_vpe]
> LR is at 0x8
> 
> Because the driver fails to properly check the 'num_planes' values for
> proper ranges it ends up accessing out of bound data causing the kernel
> panic.
> 
> Since this driver only handle single or dual plane pixel format, make
> sure the provided value does not exceed 2 planes.
> 
> Signed-off-by: Benoit Parrot <bparrot@ti.com>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/media/platform/ti-vpe/vpe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/ti-vpe/vpe.c b/drivers/media/platform/ti-vpe/vpe.c
> index bbbf11174e16..1278d457f753 100644
> --- a/drivers/media/platform/ti-vpe/vpe.c
> +++ b/drivers/media/platform/ti-vpe/vpe.c
> @@ -1650,7 +1650,7 @@ static int __vpe_try_fmt(struct vpe_ctx *ctx, struct v4l2_format *f,
>  			      &pix->height, MIN_H, MAX_H, H_ALIGN,
>  			      S_ALIGN);
>  
> -	if (!pix->num_planes)
> +	if (!pix->num_planes || pix->num_planes > 2)
>  		pix->num_planes = fmt->coplanar ? 2 : 1;
>  	else if (pix->num_planes > 1 && !fmt->coplanar)
>  		pix->num_planes = 1;
> 

This looks weird.

Why not just unconditionally do:

	pix->num_planes = fmt->coplanar ? 2 : 1;

Regards,

	Hans
