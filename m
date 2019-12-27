Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E28FC2D0DA
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 12:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D963120CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 12:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5xeiJNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfL0MFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 07:05:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40734 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726354AbfL0MFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 07:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577448341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q5XXULvPBCdPqhDyApB0SLhznAFY7NUhBbt1TjCPMF0=;
        b=c5xeiJNIk2Xt1eNmXEZdOfEsrqPacHEpe1Vu6kIdLv3tb3QhaCwXi24YGCK8tYbkae6yF5
        Z/0IWjD8g+APBNo2ukKakPERPHeeWVKrxY+cp7iANHexydspF2XOlUcEW/7gQw4PnFqJYI
        6vEbxL3OroMAwY7CIjPyeGFqxDoW2sw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-RK0DHe2VOkKagDPiSD7irA-1; Fri, 27 Dec 2019 07:05:40 -0500
X-MC-Unique: RK0DHe2VOkKagDPiSD7irA-1
Received: by mail-wr1-f72.google.com with SMTP id f15so8369420wrr.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 04:05:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q5XXULvPBCdPqhDyApB0SLhznAFY7NUhBbt1TjCPMF0=;
        b=RiO5MzH8KT3/KJuBhk24qNwBkD9FcBxu7G0hTblPlc5Ocf6lFsCGnYkpkpdv+dCCAK
         9QQ+xk7hCB9mi5+Wny178MT1bCngqT/D1I1jcVVOcRtxkhLiLnNbSEM/dHt/mXIdpWRs
         8O9BDE0K5xZyftTFEAMi3qJB9a3HG0PoQZMvY3bpl03E6qJ5hSPUn6vhLoWQDB8iXeiW
         s3okbJpXdaAs2BvlLZWECONMfVCoqsMVi4fXd2qthX9mWxoNl+yFJ7n+KiwZJ4JnFkIR
         /mftkn4TQYuXXzX9G7XqQmPr4Y5o/nqEPZB9Q9nPpsns4qrLFp97h1CWWkufuOHUH6un
         ywuQ==
X-Gm-Message-State: APjAAAXTHvg3bXw2LhKqIeeSK19vcmlYPTw3dIRNa9LcBYy0XY6Ixpqg
        Z+D5+6G9qu5+38DdybJUzInAhpt/pSGETDASIKGsKC2uWacqf5QoIu1hSQIYUna4IyEx5gZQThP
        sVv9GYDWboyr8sj/OZIrJHWzk
X-Received: by 2002:adf:f850:: with SMTP id d16mr51411904wrq.161.1577448339561;
        Fri, 27 Dec 2019 04:05:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqxIUH/iXdbActUcnfV2oV6Gg5J5xnzokN2jSRLSiWh+2/KOUFQxi7yrQhQWMqgwNXmx/uukAw==
X-Received: by 2002:adf:f850:: with SMTP id d16mr51411867wrq.161.1577448339208;
        Fri, 27 Dec 2019 04:05:39 -0800 (PST)
Received: from linux-2.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id k13sm33967659wrx.59.2019.12.27.04.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 04:05:38 -0800 (PST)
Date:   Fri, 27 Dec 2019 13:05:36 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     paulus@samba.org, davem@davemloft.net, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ppp: Remove redundant BUG_ON() check in ppp_pernet
Message-ID: <20191227120536.GA32264@linux-2.home>
References: <1577243224-1923-1-git-send-email-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577243224-1923-1-git-send-email-vulab@iscas.ac.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 25, 2019 at 03:07:04AM +0000, Xu Wang wrote:
> Passing NULL to ppp_pernet causes a crash via BUG_ON.
> Dereferencing net in net_generic() also has the same effect.
> This patch removes the redundant BUG_ON check on the same parameter.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ppp/ppp_generic.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> index 3bf8a8b..22cc2cb 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c
> @@ -296,8 +296,6 @@ static struct class *ppp_class;
>  /* per net-namespace data */
>  static inline struct ppp_net *ppp_pernet(struct net *net)
>  {
> -	BUG_ON(!net);
> -
>  	return net_generic(net, ppp_net_id);
>  }
Acked-by: Guillaume Nault <gnault@redhat.com>

