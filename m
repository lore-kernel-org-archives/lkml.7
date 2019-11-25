Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB74C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 02:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C600A20718
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 02:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="gH4v+ctB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfKYCVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 21:21:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36237 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfKYCVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 21:21:35 -0500
Received: by mail-pf1-f195.google.com with SMTP id b19so6607348pfd.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2019 18:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=0Slbk7FHKESeFqcEuY8H04LKnF7/drC0hQa4BJ/FDvg=;
        b=gH4v+ctBIPNMcQL86nKHecbkeJwpsrU/V3M2WbEfwawz+TRk/u6ND6wuIqXpt6t8t9
         5a5Y8zWBllvB5EANzgYSeR2+KsJsQpZHsYDqW6ELNTnyBqgwqfYnJV81PgeJHndccNjb
         igkz2bEdeFgZfOcnb6h1x+XIoXWn6FI84lA6bN1lHNmcLKElj1bRzDzmn2PTws27jfdL
         BOiw0PZjJ/8lC5NygqkGOJUbJujon5jBOxkEwQiI166JObmhx3FlUyiMuhAgBVrF0BLl
         WwsjasT/v0ktfcRkUltnpCnu/xXr4ShmWiNVv8KMI2qPFPar2t1eB/8WW9JAV8PxD6R1
         QsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=0Slbk7FHKESeFqcEuY8H04LKnF7/drC0hQa4BJ/FDvg=;
        b=LQojJ898z9gZe1X0LOkg1pS/nDnU098JgVqxsbiaOEnDGCO1bNwKPHuolRoqDymR8M
         ScPlSnkTP7GmHuIpryRoL9tD+qGyctihyOvRye6/bWRMCfT0yax6b5+4rik7MJJ2WMCL
         g89MIsGfINSwAQvHU0yi1Z1mYpk2okRsSQIa+pX+Z9A3Zg9H0y+pTemZFTzrQLK30vdL
         K7jPxFNz7S7Cbnqrr+O7qu1Oxj8j/6SgERgOgKujXYkJtC8yvjatWJ6m9IfTpDtTsT4I
         W/6mVUy7RNrUnp9nfM7z6fnMpS85cG88gPx5XtHsQ5I0fDZk7mnwWL6D1SjBdf0agBp6
         CcQQ==
X-Gm-Message-State: APjAAAXW9z/E7RQV2YoQqjw+zkGcpvrm1osSv+P9JNfQkeqIir4/7nJD
        Y3TGWDSHDARFxuX6/jes0gnKHg==
X-Google-Smtp-Source: APXvYqy2NXWAYVFU4lF8cJY4DfT9esmtA2nl94dpzBrdQ+ER0JKUb0rxNsKuqL7Yn5+iqaTu/PgtcQ==
X-Received: by 2002:a63:6705:: with SMTP id b5mr30162797pgc.23.1574648494395;
        Sun, 24 Nov 2019 18:21:34 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id x2sm5822449pgc.67.2019.11.24.18.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 18:21:34 -0800 (PST)
Date:   Sun, 24 Nov 2019 18:21:28 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: macb: add missed tasklet_kill
Message-ID: <20191124182113.481f984b@cakuba.netronome.com>
In-Reply-To: <20191123141918.16239-1-hslester96@gmail.com>
References: <20191123141918.16239-1-hslester96@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Nov 2019 22:19:18 +0800, Chuhong Yuan wrote:
> This driver forgets to kill tasklet in remove.
> Add the call to fix it.
> 
> Fixes: 032dc41ba6e2 ("net: macb: Handle HRESP error")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

I think this leaves a race condition, as far as I can tell
tasklet_kill() just kills the currently scheduled tasklet,
but doesn't prevent it from being scheduled again. If the 
interrupt fires just after the tasklet_kill() call the tasklet
will be scheduled back in. I think you'd need to mask the interrupt 
(through the IDR register?) or just put the tasklet_kill() call after
unregister_netdev(), because AFAICT closing the netdev disables all
irqs.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 1e1b774e1953..2ec416098fa3 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4383,6 +4383,7 @@ static int macb_remove(struct platform_device *pdev)
>  
>  	if (dev) {
>  		bp = netdev_priv(dev);
> +		tasklet_kill(&bp->hresp_err_tasklet);
>  		if (dev->phydev)
>  			phy_disconnect(dev->phydev);
>  		mdiobus_unregister(bp->mii_bus);

