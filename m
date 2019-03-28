Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11105C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD90B206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfC1PaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:30:22 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:37150 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726150AbfC1PaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:30:22 -0400
Received: from [IPv6:2001:420:44c1:2579:7126:11db:5076:31b1] ([IPv6:2001:420:44c1:2579:7126:11db:5076:31b1])
        by smtp-cloud7.xs4all.net with ESMTPA
        id 9Wyuh7NHwNG8z9WyyhpthT; Thu, 28 Mar 2019 16:30:20 +0100
Subject: Re: [PATCH] media: renesas-ceu: fix a potential NULL pointer
 dereference
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Jacopo Mondi <jacopo@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190309071424.3600-1-kjlu@umn.edu>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <b25c59ef-0762-a474-3c3e-b07b4fbd5f74@xs4all.nl>
Date:   Thu, 28 Mar 2019 16:30:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190309071424.3600-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFBZQIe4Hz7j4icCh5/N31nZXv68JcnQrIs82G3X1uVvWMeFxDnkY3+qbBAxHOHueiRDK06WDSD3sqgWsQ4IG1Dz0ONluZKrfe6ejZhFW7ROp2qwAiJj
 rijMyIUU5O6W54BWIIiI3M3iHBe8GWEIoXYFHAzX4CCVAp+o51pDPT3p8ujwzrv7R7KgeKbUBtdCtSyXDd4wkqXvLVIvh8DzlmeSgAM+rSHI4zMcBAgD4luf
 YKha22AbwXIx/6MK8F3QI/Ce4qb4d5sVylmGa0+mawB4lJpfv4dMapUlX6feNxgkbtBpkguTjIYqr1j0YLdnA9hrkEMT23kk2pfLGr+8EDraKnSo1UJnhH1/
 GluVl/7fgLtH0YT6PWzaEziE33Pehht3Z4o3epAaRAbzJfI3Mrfif0OoaqH6FYkJm1WpUH0LmSbazE4LaKycl+Q5ncmuNMYaSF0e3YB03Km6aSRUgU/t9RIW
 Du0XPvb6tH4c1tPs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/19 8:14 AM, Kangjie Lu wrote:
> In case of_match_device cannot find a match, the check returns
> -EINVAL to avoid a potential NULL pointer dereference
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/media/platform/renesas-ceu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/renesas-ceu.c b/drivers/media/platform/renesas-ceu.c
> index 150196f7cf96..4aa807c0b6c7 100644
> --- a/drivers/media/platform/renesas-ceu.c
> +++ b/drivers/media/platform/renesas-ceu.c
> @@ -1682,7 +1682,10 @@ static int ceu_probe(struct platform_device *pdev)
>  
>  	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
>  		ceu_data = of_match_device(ceu_of_match, dev)->data;
> -		num_subdevs = ceu_parse_dt(ceudev);

A far as I can tell ceu_parse_dt will never return 0.

I'm dropping this patch.

Regards,

	Hans

> +		if (unlikely(!ceu_data))
> +			num_subdevs = -EINVAL;
> +		else
> +			num_subdevs = ceu_parse_dt(ceudev);
>  	} else if (dev->platform_data) {
>  		/* Assume SH4 if booting with platform data. */
>  		ceu_data = &ceu_data_sh4;
> 

