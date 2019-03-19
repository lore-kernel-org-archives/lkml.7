Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D813CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A770F20700
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfCSQnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:43:42 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37261 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfCSQnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:43:42 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1h6Hpx-0006hq-D6; Tue, 19 Mar 2019 17:43:37 +0100
Message-ID: <1553013817.6482.8.camel@pengutronix.de>
Subject: Re: [PATCH 3/5] reset: Add acquire/release support for arrays
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Mar 2019 17:43:37 +0100
In-Reply-To: <20190221152557.8534-3-thierry.reding@gmail.com>
References: <20190221152557.8534-1-thierry.reding@gmail.com>
         <20190221152557.8534-3-thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-21 at 16:25 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Add implementations that apply acquire and release operations to all
> reset controls part of a reset control array.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

> ---
>  drivers/reset/core.c  | 36 +++++++++++++++++++++++++++++++++++-
>  include/linux/reset.h |  6 ++++++
>  2 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index f94da91c22af..81ea77cba123 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -245,6 +245,34 @@ static int reset_control_array_deassert(struct reset_control_array *resets)
>  	return ret;
>  }
>  
> +static int reset_control_array_acquire(struct reset_control_array *resets)
> +{
> +	unsigned int i;
> +	int err;
> +
> +	for (i = 0; i < resets->num_rstcs; i++) {
> +		err = reset_control_acquire(resets->rstc[i]);
> +		if (err < 0)
> +			goto release;
> +	}

This could be done under a single mutex lock by extracting a free
version of of reset_control_acquire. Just an idea though, not sure if
that would have any measurable benefit.

regards
Philipp
