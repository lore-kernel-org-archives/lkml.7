Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B84C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F242C206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="f6S2rAVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfKNPxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:53:19 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45930 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfKNPxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:53:18 -0500
Received: by mail-qt1-f195.google.com with SMTP id 30so7248363qtz.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 07:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ei+Lg4Zw6EdGj9wGd2lTbvXb4PRXvY0S2CQJq/u3m58=;
        b=f6S2rAVw2sC8DNXogYymtSpBW9HKuV5i9m7yY5suCgzi4X2qTIupQJsJUowOKfrEGJ
         5lpMFo9ZFTs2tW7jbmy1YZ27B8u9PSQFdfTuICwEKMoxomzo12Ih5a3uJsVIkrIxcztX
         YHL/hUlQ7nwQwJad/wAuFW42gZlf7i0l/3futpuacx9G92g27RE58ZsLLhbzLrCbNdII
         0llhml5MjXUVVE/mOIW0xTNZ9ZAmfZQF0+bugSjbBd1Vh8SieHvJ7OULXLn7mOgfhNa1
         uyjY7eVJMlQVshM+7bQLn+GNKQz+2nTqGmEVUqtnpec7YFg8roCrW3xl5+ojjyBaEcrp
         eJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ei+Lg4Zw6EdGj9wGd2lTbvXb4PRXvY0S2CQJq/u3m58=;
        b=OpHDHIZdzU6K7lqQEpA1LZr+VXRZ/CuzqRiqmHEWj1258IOUBqftcAnySpI6Haql6y
         QaXSvUqxu891J2CXW3wm/R0x9Hx5gSaFe0grzL7MhnzwvvtHwBi4L5pZqIH0ndF0jTvA
         lAnh3DZy++R+AU3Jo5J7TcB7O0/ezNj8Adsc+MptwMYBs5IMsGkflo9G+caN9HysPCjj
         LbJkiL91OANNShMd5gvtjo3EIX3GDHxFg7vzMBNNznors/5ZVSAwjBtCJihEy4ITZkhc
         b/UaL1ybQk0A57zzgiwRGwEikBfJnHA71pwuu+alduWnFCFBTbRtX2RXkZkAz8Yt4fUq
         bqtg==
X-Gm-Message-State: APjAAAXhhaeyfJX6IiPmPABtI7FloO0F2nWQyRmFOenqSHYV5iVTQylM
        0V2f1EB0u4FcoslSbkY1yraNxw==
X-Google-Smtp-Source: APXvYqwW73RaazZjrkxzpl91+XvAAIGBFH3Swkun6HTKfpi0+SGY7gMgP9d7aZU+ep/eApMfNnr4PQ==
X-Received: by 2002:ac8:1ad0:: with SMTP id h16mr9016940qtk.303.1573746797795;
        Thu, 14 Nov 2019 07:53:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id z3sm3329338qtu.83.2019.11.14.07.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2019 07:53:17 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iVHQq-0007Z8-O6; Thu, 14 Nov 2019 11:53:16 -0400
Date:   Thu, 14 Nov 2019 11:53:16 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pan Bian <bianpan2016@163.com>
Cc:     Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/i40iw: fix potential use after free
Message-ID: <20191114155316.GB29040@ziepe.ca>
References: <1573022651-37171-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573022651-37171-1-git-send-email-bianpan2016@163.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 02:44:11PM +0800, Pan Bian wrote:
> Release variable dst after logging dst->error to avoid possible use after
> free.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw_cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
