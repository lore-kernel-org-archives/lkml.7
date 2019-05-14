Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393FEC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179E621537
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfENOFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:05:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39690 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfENOFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:05:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id w8so16946351wrl.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 07:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HFrxKRJ5HNStlbUTQZyFY7J10wCh/Ba3Wo5fQJBjPyQ=;
        b=X77tEROxxbLYGWSepATLl9EWhfd3VvsZ2I7tR6Uv7g198SzPvYfxZ0u5v6OXAwfm/Y
         eW8LHZmPRMux34pblc+RaLPqQuxboZa5Mf4z0+bOJBbnAsTVzsw61UMb8fMQe/kVcDCn
         6AzG9BkQmw9sGWGsBaXgmKSxaM1JoodoVZ5VeGeuTRKpWkKDXfMK6BAzmeKli+JcsNA1
         mOzEMsD2Po99PZz+wvNVqB2z85Z+ZO8GcXmkamq6bMf/cURSwPvkHdHVZa4ro2OVa2nv
         q3POge33kJo8TJbdEpkUK4EE9aP+Cgq9v4W19mHPZ2RhUGquKtHYx5w6Zt4NPuhfJRO9
         0OQQ==
X-Gm-Message-State: APjAAAX2PJcKiz8pGF8+zorr/SxaWKsVH1HWuOW4iJVHQWax6U2xJTV4
        tru0aPdWY4IRcrkQuZw+35RmcsLtYVc=
X-Google-Smtp-Source: APXvYqw125K8xwI4XsobgwXdSL1K0hlf2aXA2HtrmE4RRFWiK7i4AUBOj5YqSNVzCFCZhGhmte/4UQ==
X-Received: by 2002:adf:eb44:: with SMTP id u4mr22038936wrn.83.1557842751050;
        Tue, 14 May 2019 07:05:51 -0700 (PDT)
Received: from linux.home (2a01cb05850ddf00045dd60e6368f84b.ipv6.abo.wanadoo.fr. [2a01:cb05:850d:df00:45d:d60e:6368:f84b])
        by smtp.gmail.com with ESMTPSA id x187sm3488139wmb.33.2019.05.14.07.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 07:05:50 -0700 (PDT)
Date:   Tue, 14 May 2019 16:05:48 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, paulus@samba.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] ppp: deflate: Fix possible crash in deflate_init
Message-ID: <20190514140547.GA25993@linux.home>
References: <20190514074300.42588-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514074300.42588-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 03:43:00PM +0800, YueHaibing wrote:
> 
> If ppp_deflate fails to register in deflate_init,
> module initialization failed out, however
> ppp_deflate_draft may has been regiestred and not
> unregistered before return.
> Then the seconed modprobe will trigger crash like this.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ppp/ppp_deflate.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ppp/ppp_deflate.c b/drivers/net/ppp/ppp_deflate.c
> index b5edc7f..2829efe 100644
> --- a/drivers/net/ppp/ppp_deflate.c
> +++ b/drivers/net/ppp/ppp_deflate.c
> @@ -610,12 +610,16 @@ static void z_incomp(void *arg, unsigned char *ibuf, int icnt)
>  
>  static int __init deflate_init(void)
>  {
> -        int answer = ppp_register_compressor(&ppp_deflate);
> -        if (answer == 0)
> -                printk(KERN_INFO
> -		       "PPP Deflate Compression module registered\n");
> +	int answer;
> +
> +	answer = ppp_register_compressor(&ppp_deflate);
> +	if (answer)
> +		return answer;
> +
> +	pr_info("PPP Deflate Compression module registered\n");
>  	ppp_register_compressor(&ppp_deflate_draft);
> -        return answer;
> +
> +	return 0;
>  }
>  
I'd be cleaner to also check for ppp_deflate_draft registration failure
IMHO (and print the log line only if both compressors get registered
successfully).
