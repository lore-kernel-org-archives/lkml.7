Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B9DC74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8301C2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MVdICNhH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfGJRbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 13:31:08 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37771 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfGJRbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 13:31:08 -0400
Received: by mail-qk1-f194.google.com with SMTP id d15so2539758qkl.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 10:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8+Z+WSR46UzvdkgC8wngfOT/tO+CDaDaSsIktLEucgI=;
        b=MVdICNhHcbnYzk3otHPJiYQfDbXtzsITjYTI/3VWaxA7oXrMn6xb0adaqhF2plGlxI
         sH2HDwrZXZqpo7aCKgw/iiyvyvjMtUwRCMbXFORSRnn/7cT+7fdxYuwv3mqLqnlZgfH2
         d/1JEgDtTepLx6BObkcSVaWLRonNfKSZNbz+kzjhELNU6duvv8DJ6IpOw/5b6U7nSOwQ
         Tzs7LMH5YJ5cHDSr31v/wrFoSNCeeRIfpr6QnS/XEekSMmgNMGrdf0Ym6lyoQDkOf2K+
         ArMo3plJByhTTrPCo3ll+3sr9YNhng/vjSH5Vk1qB+06KbJKQ8+GrL3ScU6lY9AnF0c8
         6++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8+Z+WSR46UzvdkgC8wngfOT/tO+CDaDaSsIktLEucgI=;
        b=K7tzLrJSSAdQb1itaV6CgphtZOM2vUy7oCLMiefSmeEE1/qf4+2DfpKZ3TrPjiroV8
         X/R+our3odyECH0jNU7nJpGREdpmdbzQC9GKW96lyl8Kn5P/ROm3Y4Amy5w9pEOeumBA
         mV7ryXJhn6E7tIE0HhEQxbK1+yJOZd68rGbBb+JAOiH89oVU/ivF1QWMgKRX8d0R2/9h
         VyLtCmJMUmlJGPN+DVMtcPqSlowm+060esDLWBFodMwed1R7+OLnqzzJBwC8dA+4JXip
         aRkzAP3hBpZ/0M50TvdqpmDmiB5wuD0/JubkJkskQsIZemB1wJ4XANoQfmkXRVpumNb6
         zlWw==
X-Gm-Message-State: APjAAAVL4As3ecG9ryr9LIHMjqF9hPammp0SgR7F3g2T/qySiljMy7t9
        7az16vXE2b7lEb2xhuYh77gQlw==
X-Google-Smtp-Source: APXvYqwI2WIlAb7R9IEvpSf0tNhf/yICx/qFaLx6or6pR/hNo3BQEUfoscFTvpNZSXyDhoR1ry+o8Q==
X-Received: by 2002:a37:a984:: with SMTP id s126mr24449341qke.267.1562779867024;
        Wed, 10 Jul 2019 10:31:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id k2sm1137334qtq.87.2019.07.10.10.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2019 10:31:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlGQr-0004Ce-J2; Wed, 10 Jul 2019 14:31:05 -0300
Date:   Wed, 10 Jul 2019 14:31:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>, dledford@redhat.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: Re: [PATCH] RDMA/siw: Print error code while kthread_create
 failed
Message-ID: <20190710173105.GE4051@ziepe.ca>
References: <20190710043554.GA7034@mtr-leonro.mtl.com>
 <20190710015009.57120-1-yuehaibing@huawei.com>
 <OFB29B4146.7E46891A-ON00258433.002BBAD4-00258433.002F6CB8@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFB29B4146.7E46891A-ON00258433.002BBAD4-00258433.002F6CB8@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 08:38:00AM +0000, Bernard Metzler wrote:

> Right, I agree with Leon. Better remove all those printouts. We
> already have a warning if we cannot start any thread. Also
> stopping those threads is not worth spamming the console. I just
> forgot to remove after Leon's comment. Would it be possible
> to apply the following?
> 
> Thanks a lot!
> Bernard.
> 
> From e4ca3d4dec86bb5731f8e3cb0cdd01e84b315d80 Mon Sep 17 00:00:00 2001
> From: Bernard Metzler <bmt@zurich.ibm.com>
> Date: Wed, 10 Jul 2019 10:03:17 +0200
> Subject: [PATCH] remove kthread create/destroy printouts
> 
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>  drivers/infiniband/sw/siw/siw_main.c  | 4 +---
>  drivers/infiniband/sw/siw/siw_qp_tx.c | 4 ----
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
> index fd2552a9091d..f55c4e80aea4 100644
> +++ b/drivers/infiniband/sw/siw/siw_main.c
> @@ -88,7 +88,7 @@ static void siw_device_cleanup(struct ib_device *base_dev)
>  
>  static int siw_create_tx_threads(void)
>  {
> -	int cpu, rv, assigned = 0;
> +	int cpu, assigned = 0;
>  
>  	for_each_online_cpu(cpu) {
>  		/* Skip HT cores */
> @@ -99,9 +99,7 @@ static int siw_create_tx_threads(void)
>  			kthread_create(siw_run_sq, (unsigned long *)(long)cpu,
>  				       "siw_tx/%d", cpu);
>  		if (IS_ERR(siw_tx_thread[cpu])) {
> -			rv = PTR_ERR(siw_tx_thread[cpu]);
>  			siw_tx_thread[cpu] = NULL;
> -			pr_info("Creating TX thread for CPU %d failed", cpu);
>  			continue;
>  		}
>  		kthread_bind(siw_tx_thread[cpu], cpu);
> diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
> index 2c3d250ee57c..fff02b56d38a 100644
> +++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
> @@ -1200,8 +1200,6 @@ int siw_run_sq(void *data)
>  	init_llist_head(&tx_task->active);
>  	init_waitqueue_head(&tx_task->waiting);
>  
> -	pr_info("Started siw TX thread on CPU %u\n", nr_cpu);
> -
>  	while (1) {
>  		struct llist_node *fifo_list = NULL;
>  
> @@ -1239,8 +1237,6 @@ int siw_run_sq(void *data)
>  			siw_sq_resume(qp);
>  		}
>  	}
> -	pr_info("Stopped siw TX thread on CPU %u\n", nr_cpu);
> -
>  	return 0;
>  }

Okay, I took this patch to for-next, thanks

Jason
  
