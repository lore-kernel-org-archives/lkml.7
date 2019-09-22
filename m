Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8234C4360D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 01:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC7620820
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 01:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="0LmxKIpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfIVBkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 21:40:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40175 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfIVBkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 21:40:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so4906901pll.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2019 18:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=177ZzAjoIgDgnCCK8nYWSRhj8BQr+f15lPzkBrbWBhA=;
        b=0LmxKIppIYx7DzQ0C8cXh4gWETi4Lq5LodkNZzpDfvQzQIW9yNMHDwmRPCGfnpDMLe
         NNwxeK5fQOkWxmJpqJ2fgmfNoEAuH+mq6UP7Z3H0J+dnXSQja0mmlnRRpWZ3USy4RpFD
         wAFy/yFMsbh7lM+f89YoOYQd5f4AcXiUmWzFRnFD1RuvdS11N16G+NPMMN5nfQg1/8wH
         Lf1VKW5b1M/6bSpRPZODVBKl0Rjp5c1+8Hr/tK5galmGxMzODQLElDBvIHKBd0HM5B2r
         qO2pjppyP1Cu5E3tDK5Dcx6Wss3208K7SKYwK4NrqQFMaFjGoEiLU2roRfvir+c+c6lP
         RNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=177ZzAjoIgDgnCCK8nYWSRhj8BQr+f15lPzkBrbWBhA=;
        b=If+CrVEEcJyId70a9AomQkh7EHBKdMw0uIVV4qwri2KnWQQz1GUQs9yTJrjMjqbZg4
         lKXHWcN6KbXhcbpJpkLrzAH94XvCShE5m2Y2iIetJfnOE2oYa8uNl2FMjpjWSDID7/xl
         av9JNTGcd8bGk2hkhjziqC6J5x/aV/r2um2AIgsCoMgZ7VRTjbYr/MdM28Fqy0S2hITn
         ghvGKhL73C6g3D/kTbgkGh0lbvEHFgZlSUcCMBgKIE8GNJj9iwu2+R1EstVQ2/nnOUP/
         WQFiurgL8osJ37eHNaumEoQ/mIwTcO3XSb9Vo8QGQ29WA7m6IDHnHaGAlagacEVt2Myo
         6mrw==
X-Gm-Message-State: APjAAAXvnD5skkflqHfC5vlyThyl8BNTNTK2plc5f+vlclTgm4Dv3JtI
        20+Y0yAW49Ffj6AU+VmuL9KIVQ==
X-Google-Smtp-Source: APXvYqxXM2bTfTf+yClgZ7bQUj3KLAV8EzipGbeXHLxkPLfNV7QGFhc805wCEU0fwqyBof3jcFyIoQ==
X-Received: by 2002:a17:902:ba82:: with SMTP id k2mr24138304pls.293.1569116412382;
        Sat, 21 Sep 2019 18:40:12 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id x68sm8797538pfd.183.2019.09.21.18.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 18:40:12 -0700 (PDT)
Date:   Sat, 21 Sep 2019 18:40:09 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Allen Pais <allen.pais@oracle.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/fjes: fix a potential NULL pointer
 dereference
Message-ID: <20190921184009.32edfa43@cakuba.netronome.com>
In-Reply-To: <1568824395-4162-1-git-send-email-allen.pais@oracle.com>
References: <1568824395-4162-1-git-send-email-allen.pais@oracle.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019 22:03:15 +0530, Allen Pais wrote:
> alloc_workqueue is not checked for errors and as a result,
> a potential NULL dereference could occur.
> 
> Signed-off-by: Allen Pais <allen.pais@oracle.com>

If I'm looking at this right you are jumping to err_free_netdev without
setting the err variable. It must had been set to 0 from the return of
fjes_sw_init(). This means we will free the netdev, and return 0. This 
means probe will not fail and driver's remove function will be run
at some point. fjes_remove it will try to free the netdev again.

Looks like there's another existing bug here in that the work queues
are not free when something fails in fjes_probe, just the netdev.

Once you untangle that, and before you post a v2, could you please try
to identify which commit introduced the regression and provide an
appropriate "Fixes" tag?

> diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
> index bbbc1dc..2d04104 100644
> --- a/drivers/net/fjes/fjes_main.c
> +++ b/drivers/net/fjes/fjes_main.c
> @@ -1237,8 +1237,15 @@ static int fjes_probe(struct platform_device *plat_dev)
>  	adapter->open_guard = false;
>  
>  	adapter->txrx_wq = alloc_workqueue(DRV_NAME "/txrx", WQ_MEM_RECLAIM, 0);
> +	if (unlikely(!adapter->txrx_wq))
> +		goto err_free_netdev;
> +
>  	adapter->control_wq = alloc_workqueue(DRV_NAME "/control",
>  					      WQ_MEM_RECLAIM, 0);
> +	if (unlikely(!adapter->control_wq)) {
> +		destroy_workqueue(adapter->txrx_wq);
> +		goto err_free_netdev;
> +	}
>  
>  	INIT_WORK(&adapter->tx_stall_task, fjes_tx_stall_task);
>  	INIT_WORK(&adapter->raise_intr_rxdata_task,

