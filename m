Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513F5C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 04:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2095E222BF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 04:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="R4GUGaMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391673AbfIZExU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 00:53:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35741 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbfIZExU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 00:53:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so1058160pfw.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 21:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=AvvT6+5x9aQmxunKipMFtPcZ23KRsANwO+K/Uacrnq0=;
        b=R4GUGaMRIj8MyOeHz41O/SibI8vBjS8+jMvH0FKIqubgiyuS2YgSh55EnhJYBhJlAI
         3zzJrML+SB2ILjFGyDhL0dmrn+BwWSkCc5UtKVCjzD7ti7QIe1jfNzSQTdBTa1iB/DH/
         K6Lpy3E5itPFVuFDx/xGNinAex4jYjobSEdjDz6fQIK/mUxOTq8wY3+7yQtWujhmzTGi
         zn3cNhoRClSTQIbRrkKYs4FR4gBNdRsTrGNNYrdAkwFgiQQxrhbgh7c1USkKTimi8AAi
         LdwpLDIr6BTq2VpleuIiQwCbE0ZgRg67rP3wVEU/pbBnnXLWqfbRAPyo76WaWv2YU8u5
         ySOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=AvvT6+5x9aQmxunKipMFtPcZ23KRsANwO+K/Uacrnq0=;
        b=exDxTXar53EcPiEKxQ8cFmq1kemO3LJWJuUSll0xBa7DVgWRem2D09e6JL7lRtZAFO
         UYv1GfmnWoLAfVmLYJoZbOKOtM98Y/TmVSjUdBsXIeHSAt7bp5XLSYQH3+sYlEEHixMw
         rbmJg6t1v3rHRLKUWU6d6AGWCRKkr3EBHNQDbnTeQkX6GmMmLHVJUsV16DtfA5D2qyg+
         e1kBVGw15QtUw97g/LkwIVKN0EyZYTyo5kv4zdD3yKY1tpbA00mFNoRF4L/MTNzqO7T2
         uURo+KDkSjCPapBEvv51qgdvjJ/445A9lSemHLKlqVvP0jmlr7FgKuJeE9YA/78/k7ko
         qJGQ==
X-Gm-Message-State: APjAAAWCgDZx2qwjIQGcj4oWvs/lchvjj7WtNVCamoiOz1RVYbOWr5pR
        jlu1hE8c+1rhLW5r2QnW30QSZQ==
X-Google-Smtp-Source: APXvYqyHtXpA7TOjdAcCykvqAmfvyMsfymVvHG2bTz2l4CZubCgE29mxR2M7yEBP7gKFs8JcjyeOsQ==
X-Received: by 2002:a62:53c7:: with SMTP id h190mr1515668pfb.208.1569473599130;
        Wed, 25 Sep 2019 21:53:19 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id n21sm697029pjo.21.2019.09.25.21.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 21:53:18 -0700 (PDT)
Date:   Wed, 25 Sep 2019 21:53:14 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        "David S. Miller" <davem@davemloft.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        John Hurley <john.hurley@netronome.com>,
        Colin Ian King <colin.king@canonical.com>,
        oss-drivers@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: flow_offload: fix memory leak in
 nfp_abm_u32_knode_replace
Message-ID: <20190925215314.10cf291d@cakuba.netronome.com>
In-Reply-To: <20190926022240.3789-1-navid.emamdoost@gmail.com>
References: <20190925182846.69a261e8@cakuba.netronome.com>
        <20190926022240.3789-1-navid.emamdoost@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2019 21:22:35 -0500, Navid Emamdoost wrote:
> In nfp_abm_u32_knode_replace if the allocation for match fails it should
> go to the error handling instead of returning.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
> Changes in v2:
> 	- Reused err variable for erorr value returning.

Thanks, there's another goto up top. And I think subject prefix could
be "nfp: abm:", perhaps?

>  drivers/net/ethernet/netronome/nfp/abm/cls.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/abm/cls.c b/drivers/net/ethernet/netronome/nfp/abm/cls.c
> index 23ebddfb9532..b0cb9d201f7d 100644
> --- a/drivers/net/ethernet/netronome/nfp/abm/cls.c
> +++ b/drivers/net/ethernet/netronome/nfp/abm/cls.c
> @@ -198,14 +198,18 @@ nfp_abm_u32_knode_replace(struct nfp_abm_link *alink,
>  		if ((iter->val & cmask) == (val & cmask) &&
>  		    iter->band != knode->res->classid) {
>  			NL_SET_ERR_MSG_MOD(extack, "conflict with already offloaded filter");
> +			err = -EOPNOTSUPP;
>  			goto err_delete;
>  		}
>  	}
>  
>  	if (!match) {
>  		match = kzalloc(sizeof(*match), GFP_KERNEL);
> -		if (!match)
> -			return -ENOMEM;
> +		if (!match) {
> +			err = -ENOMEM;
> +			goto err_delete;
> +		}
> +
>  		list_add(&match->list, &alink->dscp_map);
>  	}
>  	match->handle = knode->handle;
> @@ -221,7 +225,7 @@ nfp_abm_u32_knode_replace(struct nfp_abm_link *alink,
>  
>  err_delete:
>  	nfp_abm_u32_knode_delete(alink, knode);
> -	return -EOPNOTSUPP;
> +	return err;
>  }
>  
>  static int nfp_abm_setup_tc_block_cb(enum tc_setup_type type,

