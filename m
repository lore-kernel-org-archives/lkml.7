Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBF6C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 13:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D518D20700
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 13:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576416215;
	bh=4tGPYkuxPTpOdbb/QW42LFPnNQac6MY1+pL3a6Y/DIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QwIffZBoNZCpMORm+si35yLy/MA2IlZva3T1lC5eCSynHfX9tbjk0czOazr/HRRw5
	 wU4UErvunKjjnyHKWBidpABpdNNcOEVgKeQv0Z+jfiML8Nz43RSBiyQnij9YmGRFkQ
	 kpXxnabXz0pX43+tGCXLHjUG7yTfHVZvc3jjC8TI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfLONXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 08:23:34 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46517 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfLONXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 08:23:34 -0500
Received: by mail-lj1-f196.google.com with SMTP id z17so3738411ljk.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 05:23:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wKN8mIsg/R7quM4J88wTjTIbvv7hHpY6p+oL8f957Ck=;
        b=kZU+mvb389SMfWlzzNnOdZ7OGkOIPZ3vV9CzMXcpDrsAjQdTp/qNREB/me44OqEb2g
         XesTovZoCIheWUe5rwxwdjCUHL9xwYGole24GXLkA39ZJ7/VkF45mO2/e5Hfg/Db15mo
         xFbA5xVoqoun3BWPnwgFSJjJoX99vDk/qwId/Eukf1QeGql4DXmSoqZGwv5LBM5Av8/V
         iB0l4zx67ccIAusUVNeC0Ft95yJoGom0vhmH0aFx6ShGRXZvvc2Lr1sD/WQwfPeI0+Je
         XL4oQpYbeSN0cUCNQfq+SGdTMiWNjMILZ1LMGBQI4+fGm8SnwTPLoRYyv6kKEaKSgjah
         3O5Q==
X-Gm-Message-State: APjAAAWqS9QuRZkNcQsLNNHfAC0RpidQuVC3rz+Aj1QVoa3+HFQwxYcz
        ssLBCqAPKOyJkLUCms7I6hg=
X-Google-Smtp-Source: APXvYqzFdhKzSCWN74Hit25VXnCNnvPg9PoK+RYpGGMVaSkBshbVO8vSRMuOeJppCUledf6woj42vQ==
X-Received: by 2002:a2e:9987:: with SMTP id w7mr16205373lji.107.1576416212445;
        Sun, 15 Dec 2019 05:23:32 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id q13sm9438126ljj.63.2019.12.15.05.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 05:23:31 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1igTru-00022d-5q; Sun, 15 Dec 2019 14:23:30 +0100
Date:   Sun, 15 Dec 2019 14:23:30 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sandhya Bankar <bankarsandhya512@gmail.com>,
        Hildo Guillardi =?iso-8859-1?Q?J=FAnior?= <hildogjr@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        emamd001@umn.edu
Subject: Re: [PATCH] staging: rtl8192e: rtllib_module: Fix memory leak in
 alloc_rtllib
Message-ID: <20191215132330.GB10631@localhost>
References: <20191214230603.15603-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191214230603.15603-1-navid.emamdoost@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2019 at 05:05:58PM -0600, Navid Emamdoost wrote:
> In the implementation of alloc_rtllib() the allocated dev is leaked in
> case of ieee->pHTInfo allocation failure. Release via free_netdev(dev).
> 
> Fixes: 6869a11bff1d ("Staging: rtl8192e: Use !x instead of x == NULL")

This is not the commit that introduced this issue.

> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtllib_module.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
> index 64d9feee1f39..18d898714c5c 100644
> --- a/drivers/staging/rtl8192e/rtllib_module.c
> +++ b/drivers/staging/rtl8192e/rtllib_module.c
> @@ -125,7 +125,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
>  
>  	ieee->pHTInfo = kzalloc(sizeof(struct rt_hi_throughput), GFP_KERNEL);
>  	if (!ieee->pHTInfo)
> -		return NULL;
> +		goto failed;

And you're still leaking ieee->networks and possibly a bunch of other
allocations here. You need to call at least rtllib_networks_free() in
the error path.

>  
>  	HTUpdateDefaultSetting(ieee);
>  	HTInitializeHTInfo(ieee);

Johan
