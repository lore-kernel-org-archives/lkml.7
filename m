Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56896C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E42C20674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfDWO6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:58:13 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:56529 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfDWO6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:58:11 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 03CDA3C00C1;
        Tue, 23 Apr 2019 16:58:09 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dTI8U-6u9sHw; Tue, 23 Apr 2019 16:58:02 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 507E93C0034;
        Tue, 23 Apr 2019 16:58:02 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 23 Apr
 2019 16:58:02 +0200
Date:   Tue, 23 Apr 2019 16:57:59 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Jiada Wang <jiada_wang@mentor.com>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <horms+renesas@verge.net.au>,
        <niklas.soderlund+renesas@ragnatech.se>, <geert+renesas@glider.be>,
        <sergei.shtylyov@cogentembedded.com>,
        <marek.vasut+renesas@gmail.com>,
        <kuninori.morimoto.gx@renesas.com>, <hien.dang.eb@renesas.com>,
        <fabrizio.castro@bp.renesas.com>, <dien.pham.ry@renesas.com>,
        <biju.das@bp.renesas.com>, <george_davis@mentor.com>,
        <joshua_frkuska@mentor.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <rosca.eugeniu@gmail.com>
Subject: Re: [PATCH v3 1/2] thermal: rcar_gen3_thermal: fix interrupt type
Message-ID: <20190423145759.GA29037@vmlxhi-102.adit-jv.com>
References: <20190423141414.24264-1-jiada_wang@mentor.com>
 <20190423141414.24264-2-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190423141414.24264-2-jiada_wang@mentor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiada,

On Tue, Apr 23, 2019 at 11:14:13PM +0900, Jiada Wang wrote:
> Currently IRQF_SHARED type interrupt line is allocated, but it
> is not appropriate, as the interrupt line isn't shared between
> different devices, instead IRQF_ONESHOT is the proper type.
> 
> By changing interrupt type to IRQF_ONESHOT, now irq handler is
> no longer needed, as clear of interrupt status can be done in
> threaded interrupt context.
> 
> Because IRQF_ONESHOT type interrupt line is kept disabled until
> the threaded handler has been run, so there is no need to protect
> read/write of REG_GEN3_IRQSTR with lock.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> ---
>  drivers/thermal/rcar_gen3_thermal.c | 34 +++++------------------------
>  1 file changed, 6 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index 88fa41cf16e8..ebbaef5a3cf1 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -231,39 +231,17 @@ static void rcar_thermal_irq_set(struct rcar_gen3_thermal_priv *priv, bool on)
>  static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
>  {
>  	struct rcar_gen3_thermal_priv *priv = data;
> +	int i;
>  	u32 status;
> -	int i, ret = IRQ_HANDLED;

nit: why not keeping 'int i' on the same line?

>  
> -	spin_lock(&priv->lock);
[..]
> -	spin_unlock(&priv->lock);
[..]
> -	spin_lock_irqsave(&priv->lock, flags);
[..]
> -	spin_unlock_irqrestore(&priv->lock, flags);
[..]

FWIW, after applying the patch, the 'spinlock_t lock' member of
'struct rcar_gen3_thermal_priv' is no longer used in the driver, except
to initialize it in probe. Is there any usage expected in future or
should it be zapped?

-- 
Best regards,
Eugeniu.
