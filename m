Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24009C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20AD2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AbAsisv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388450AbfJDR4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:56:37 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45652 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbfJDR4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:56:37 -0400
Received: by mail-qk1-f194.google.com with SMTP id z67so6562432qkb.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 10:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3LFbYySXRieLEJyyVRoIwjcY2D+c5wrknoXBmUitFnw=;
        b=AbAsisv3FHbRR0lsJYZ9oQG43Vu+7dGo274iB1Il7P+bxD8//2SZo4NQJKmvbyDONX
         hLBljjQfUtX+VGpYJqlDB3qo/BFX8464PuxpPmPAC9Q5piAgoqhFHm8vXdYt29uOaq77
         6ho4tyTYKnzYnzd0mmaWuu4iTQW+hYNOPdd0rYAeAEiu+i5EbFGnPIRfUCZKAt91GNl6
         mHD4M9OjlZ2Mbno8eLQ5IjW3VTvWMCwwf/Cvt/s2NpQPjTS4I++SMU0qs4L49LgpcKFL
         ieOXrSsOw5ba9ES2Ng2Ql8FcqLZgf3Gd/C6Z7TJ1TL7rM9VtS/ysFBRzU/cwrMXDhNzH
         DMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3LFbYySXRieLEJyyVRoIwjcY2D+c5wrknoXBmUitFnw=;
        b=KYk063sLSO2TEoM17mNRVgWwkDM3Il0KfOTDjSW7rOw3rATYORRM4nH8kRHsb7owna
         3SbZNgo2dKPCftfNdV2/ohg7SBs+s8kcYhRVXPgNcqF3rn8XPtUcGpqRLqAlej0nk9Rx
         mydRXadt6qrkHeVQYocNTGrdnq9GNWRJyR+saUYpZrAZO+JL2qSv0JAcE2OIhWHHm9l7
         1FLIsM6BO0z3ROkxHZ+GD+TIlh5wlbVzz+3YdjpBanPZwTBbQEJ8Vszl/h5vYH9wR8K8
         s3d3xH5zZLduYS/56bLofXPKwPn/7V91nwMBUTcXrCAu1erCzuLvQ5Z2Q5ADP8GCMpd6
         tGUg==
X-Gm-Message-State: APjAAAXZ2FyFy5yyah1lGHA9y7sMfMDnHX6HWgXhfy+Qh0QvfTjLxxv7
        Ne3t3UyAbiBcONww4cbU1MQeAw==
X-Google-Smtp-Source: APXvYqzBwRVA8oi/0dMXCy0A3Xz41BH+1nImbdcYUmahvkitUo5BAxwOf1g89cv3b+k0ru5UIItkYg==
X-Received: by 2002:a37:6650:: with SMTP id a77mr11503520qkc.65.1570211795959;
        Fri, 04 Oct 2019 10:56:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id h68sm3223165qkd.35.2019.10.04.10.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 10:56:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iGRog-0006GM-Tq; Fri, 04 Oct 2019 14:56:34 -0300
Date:   Fri, 4 Oct 2019 14:56:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dledford@redhat.com, leon@kernel.org, parav@mellanox.com,
        majd@mellanox.com, markz@mellanox.com, swise@opengridcomputing.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Fix an error handling path in
 'res_get_common_doit()'
Message-ID: <20191004175634.GA24049@ziepe.ca>
References: <20190818091044.8845-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818091044.8845-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 11:10:44AM +0200, Christophe JAILLET wrote:
> According to surrounding error paths, it is likely that 'goto err_get;' is
> expected here. Otherwise, a call to 'rdma_restrack_put(res);' would be
> missing.
> 
> Fixes: c5dfe0ea6ffa ("RDMA/nldev: Add resource tracker doit callback")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/core/nldev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
