Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46459C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB8B206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Qd94B83a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfCDUZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:25:26 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34396 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfCDUZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:25:25 -0500
Received: by mail-qt1-f195.google.com with SMTP id w4so6591813qtc.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 12:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KY7KU5D7s/4N07qle8i0t2b+HVxiLNLS/j6v5x5g/4Y=;
        b=Qd94B83aqaZfQG6Niso73OopWk9TAvbzENO9ti66h+g3hYhmxK1CCBVNvVGjZfKeiY
         UDGoLO/BMHOvZi1JbjCOrljrAJQkQIapO/vDGxFIZtou+b8eMtw5JAQXjjneM+Ytsi+H
         TG/k6gxEhq802aINwe/mR+qMJo8v38lfgKowm9nUG+6Fnp1N1RCEU94zlRM7M4q1OhOp
         e0SzSWwR3zLWAKftGJfLv1pi8BMpF3MOEkprsP+n7mUABWR9ffnEVZG7jEKcFhjC0Dy1
         LGyXjNqOiLoVGBmVTQ/hHc89HnNbquCClCB5ulKtVNoblUGcr2NVuArOASPjNX1Tgbhw
         iw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KY7KU5D7s/4N07qle8i0t2b+HVxiLNLS/j6v5x5g/4Y=;
        b=aGzVFt/opRrciXLjQ+MuUd9KZizEiiCSuqyjGRDzivvyKXeKorzLC149mUkKqTdUGA
         Ls0McbS8ucmUCwFkdng1p4JzUaZFIib+YxT0KPUUncs2dQx0QwseW6wl95G1sAaY+zXt
         HA6FBI4WCsgXgunwf73+2MCBqUOthVbAZvT6ty9PlZRN1f2BhRZBIuN4Kf97RNZQ9/kg
         F8OIqpTAsobfCPPHNXTQbCKpRx2LThsggaL/WV3qiKVNokI1G78DS96RIajXQltpqGVD
         vI+cRa+49O6JivfpxPp0TGxHrOlFuxKY0xZWIdyRyuJ4aR1OJt2MHBQP85mtBL76rA66
         rkGA==
X-Gm-Message-State: APjAAAUhAoRuT5qHN3pK0wvS/aGWExOSD+fYQ4uXJBD/QrFDfAOAvFwT
        HVRAkJ1IMZC35uSLyGfg3bqxhNeNWiE=
X-Google-Smtp-Source: APXvYqzKGcAZ472ztXbWbDy58gt0vT7hlb0O+9sxeFB1MgfOWCVAN/hZV0M5VhIclu0HNdKSTkzipg==
X-Received: by 2002:ac8:2e19:: with SMTP id r25mr16068257qta.0.1551731124692;
        Mon, 04 Mar 2019 12:25:24 -0800 (PST)
Received: from ziepe.ca ([24.137.65.181])
        by smtp.gmail.com with ESMTPSA id d51sm4651207qta.31.2019.03.04.12.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 12:25:24 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1h0u9K-0003h3-Vl; Mon, 04 Mar 2019 16:25:22 -0400
Date:   Mon, 4 Mar 2019 16:25:22 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     oulijun@huawei.com, xavier.huwei@huawei.com, dledford@redhat.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/hns: Use GFP_ATOMIC in hns_roce_v2_modify_qp
Message-ID: <20190304202522.GA14163@ziepe.ca>
References: <20190304025620.27224-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304025620.27224-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 10:56:20AM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> In commit 0425e3e6e0c7, hns_roce_v2_modify_qp called inside
> spinlock which using GFP_KERNEL, it may sleep with holding
> the spinlock, so we should use GFP_ATOMIC instead.
> 
> Fixes: 0425e3e6e0c7 ("RDMA/hns: Support flush cqe for hip08 in kernel space")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
