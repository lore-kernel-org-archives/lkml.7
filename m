Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE20C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 16:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75107214C6
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 16:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAmZERqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfFHQLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 12:11:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33478 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfFHQLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 12:11:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so5081116wru.0;
        Sat, 08 Jun 2019 09:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y4PnFWfBk6Xs11lqTRjbODydzKCSY590i30A9Lot5Po=;
        b=ZAmZERqkcjVMhfBvtyGFlFVF7SfDPsPuVflNUIMDgFTJKZJH/jgsCCC97PPGBZfcae
         47taAPkdlEjs/Zk6jUPAL0ji4LENFSoa4stjQq9EkhalfPmCJnnYccFU3ZUzRLxcNXZY
         2ATP8LI8TiBy5RwtfCWihhAfk/Vqbrwa1vn3ZKESDCc97hdQotM4hwrUdmQ2fv0rhuRD
         apK5TK+Ett7TTuOgQxiweqe5qdtVTx+zq5n6I67jZi+9Bv7P1KtwwbemV92DuJkuUng0
         VygrfeVunrTxxH3esjmZ9JsLhAYt2A2gb4yuRXJZXalJKdC0Af1VtioblEte9xw1eLjZ
         AHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y4PnFWfBk6Xs11lqTRjbODydzKCSY590i30A9Lot5Po=;
        b=GalOrJ+kKm9X/EiigyJ8eoGCyAz9bSJxwkZBz25q20iJsj+3//gLOkUat8M/TLWlEF
         0x4n0aduCZo6a1YwADz4EsqW7j4JCsDyttZo2lBQefqsQ7QXVqJWWleLVI7qgoR36ehM
         8RnbvPmJJQ1VkshTpifZUuQ/+EkW18N+0kc0Rr20TBetfHfMWZoYDEfYpQlT2ICv+Cbp
         TX6dr7gb0fwmmNlrfZoNSVhUGbXve8yX8j4AcFcAesONM6NB/7e6W0PXzx5vma1GVY05
         8PxCdWfCzYkv4rENuWuwABm9ycxQ+NmJm25w/ix6z8Or4Zud52brJR0pAB4o6DXrWz+d
         VSAg==
X-Gm-Message-State: APjAAAWOCDHFiyJrbz7tG36QOGur18ls1NEQCbdRMkLSvNwuQeWrQzjD
        PvQ9PpUvdfS+8WHZX3iuoO4=
X-Google-Smtp-Source: APXvYqyAnGtd2Yb+NKLvwxiQu5fqoK6BlLJG3wKiocP5POoNMrCLHscr/cDFU70tlB5weRBukFTltw==
X-Received: by 2002:a5d:514d:: with SMTP id u13mr21348654wrt.77.1560010312591;
        Sat, 08 Jun 2019 09:11:52 -0700 (PDT)
Received: from zhanggen-UX430UQ ([108.61.173.19])
        by smtp.gmail.com with ESMTPSA id b2sm7403881wrp.72.2019.06.08.09.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 09:11:52 -0700 (PDT)
Date:   Sun, 9 Jun 2019 00:11:44 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     jassisinghbrar@gmail.com
Cc:     thierry.reding@gmail.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] tegra-hsp: fix a missing-check bug in
 tegra_hsp_doorbell_create()
Message-ID: <20190608161144.GA4090@zhanggen-UX430UQ>
References: <20190530011920.GA6490@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530011920.GA6490@zhanggen-UX430UQ>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 09:19:20AM +0800, Gen Zhang wrote:
> In tegra_hsp_doorbell_create(), 'db->name' is allocated by 
> devm_kstrdup_const(). It returns NULL when fails. So 'db->name' should
> be checked.
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
> index 11fc9fd..b613c46 100644
> --- a/drivers/mailbox/tegra-hsp.c
> +++ b/drivers/mailbox/tegra-hsp.c
> @@ -292,6 +292,8 @@ tegra_hsp_doorbell_create(struct tegra_hsp *hsp, const char *name,
>  	db->channel.hsp = hsp;
>  
>  	db->name = devm_kstrdup_const(hsp->dev, name, GFP_KERNEL);
> +	if (!db->name)
> +		return ERR_PTR(-ENOMEM);
>  	db->master = master;
>  	db->index = index;
>  
> ---
Can anyone look into this patch? It's acked by Thierry Reding 
<treding@nvidia.com>.

Thanks
Gen
