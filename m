Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D33AC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A38020833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfFQOnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:43:16 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38868 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfFQOnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:43:15 -0400
Received: by mail-qt1-f193.google.com with SMTP id n11so10972721qtl.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 07:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lxS/dzQw4wkh+Z+PAMdqgR2Kw5xVW/ETkqpwQQdohjY=;
        b=ljprHZEpLa9112ezwyAP2vlqgDkYJmYsVIVTJemAnJZygpYkgW/l7zTZegXhEC9AO3
         kX87aAIJQ1KsW96yiY4+ZSA+TtWzYoS4QW+qEvEmJblkeYEaWXjQAbDBCvHDacll+00a
         +BDpMc5Bl972xqcuuZSZPYb34Ykd/7zPiQDFV2d3v2UA2a89l0/Cy/gaK8E/lQvgFMwm
         Je1PMDe7f0A+73wWaXA1LKeozRLJzn0XM6/Rdu67+iWWj2onASAFNGZbiI03sSqueuNo
         8SPMOviFoei698qboyyFUTi8w+FfDQykluBnU3GCjQX78jHXLOIIimGds/lVQ+jtSope
         eBsA==
X-Gm-Message-State: APjAAAXx3XfTfFdpitdfXyA5gwajpFMYFAlkxolFk8uyqu7xEX8k+4e9
        iDypIuDb/G7ulXhGfD98vBysTw==
X-Google-Smtp-Source: APXvYqwavvGjRNDaa71vDWp/7KVZgO3Ghhc2s0zA1b8b++lVdLmzk98FDf0R90PixvOg24leSYkxow==
X-Received: by 2002:a0c:b5dd:: with SMTP id o29mr21771848qvf.85.1560782594646;
        Mon, 17 Jun 2019 07:43:14 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net. [100.0.197.103])
        by smtp.gmail.com with ESMTPSA id s44sm8410210qtc.8.2019.06.17.07.43.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 07:43:13 -0700 (PDT)
Date:   Mon, 17 Jun 2019 10:43:12 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        huhai@kylinos.cn
Subject: Re: [PATCH net-next] vhost_net: disable zerocopy by default
Message-ID: <20190617104301-mutt-send-email-mst@kernel.org>
References: <20190617092054.12299-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617092054.12299-1-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 05:20:54AM -0400, Jason Wang wrote:
> Vhost_net was known to suffer from HOL[1] issues which is not easy to
> fix. Several downstream disable the feature by default. What's more,
> the datapath was split and datacopy path got the support of batching
> and XDP support recently which makes it faster than zerocopy part for
> small packets transmission.
> 
> It looks to me that disable zerocopy by default is more
> appropriate. It cold be enabled by default again in the future if we
> fix the above issues.
> 
> [1] https://patchwork.kernel.org/patch/3787671/
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vhost/net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 2d9df786a9d3..21e0805e5e60 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -36,7 +36,7 @@
>  
>  #include "vhost.h"
>  
> -static int experimental_zcopytx = 1;
> +static int experimental_zcopytx = 0;
>  module_param(experimental_zcopytx, int, 0444);
>  MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero Copy TX;"
>  		                       " 1 -Enable; 0 - Disable");
> -- 
> 2.18.1
