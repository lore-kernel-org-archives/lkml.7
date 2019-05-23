Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EC4C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340112133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558615308;
	bh=uLiCmPuCEnBoRJ3UmlA97AkB8XpLW5+DYpKD1xKSb+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bV4EhqQu46aHeNSuSzv3M9EwFd1VUrJtGQn/60zbqGE2y89wfTYyEZHjLNU6qhMGv
	 FL77OJ4D7sldlsW0ypvFErSWG3ADZiEfZSco6ji+rrFckM6DOvq0L1hoAB6fiMb5+E
	 3UPzenG4LqDi8NfHs6R9eUjXiIjcce5q63/eFwek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbfEWMlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:41:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729698AbfEWMlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:41:46 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00F0D21019;
        Thu, 23 May 2019 12:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558615305;
        bh=uLiCmPuCEnBoRJ3UmlA97AkB8XpLW5+DYpKD1xKSb+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sf0qK/JbYPEsgAwjfRune+wYwde36fZsui36KPpmdbm1RdfARGuZbwLLji5pVlPsl
         3MSGG+NpjYNqc0sb0RVXqyjl2y7B6SIcG3pU0pdAg2vzsBEy6kqXGUcFjP8wC8eC2j
         m37q0iGfLMCyCLVYAZQhMeZfXqnws9ShXKpDZePs=
Date:   Thu, 23 May 2019 20:40:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] soc: imx: soc-imx8: Avoid unnecessary of_node_put()
 in error handling
Message-ID: <20190523124044.GT9261@dragon>
References: <1558430013-18346-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558430013-18346-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 09:18:43AM +0000, Anson Huang wrote:
> of_node_put() is called after of_match_node() successfully called,
> then in the following error handling, of_node_put() is called again
> which is unnecessary, this patch adjusts the location of of_node_put()
> to avoid such scenario.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Again, there are '=20' in the patch content and I cannot apply it.

Shawn

> ---
>  drivers/soc/imx/soc-imx8.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
> index b1bd8e2..944add2 100644
> --- a/drivers/soc/imx/soc-imx8.c
> +++ b/drivers/soc/imx/soc-imx8.c
> @@ -86,8 +86,6 @@ static int __init imx8_soc_init(void)
>  	if (!id)
>  		goto free_soc;
>  
> -	of_node_put(root);
> -
>  	data = id->data;
>  	if (data) {
>  		soc_dev_attr->soc_id = data->name;
> @@ -106,6 +104,8 @@ static int __init imx8_soc_init(void)
>  	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
>  		platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
>  
> +	of_node_put(root);
> +
>  	return 0;
>  
>  free_rev:
> -- 
> 2.7.4
> 
