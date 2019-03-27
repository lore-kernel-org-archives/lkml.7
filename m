Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D807C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A2521734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Iu1xVql2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbfC0NVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:21:18 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35959 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728790AbfC0NVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:21:16 -0400
Received: by mail-qk1-f194.google.com with SMTP id k130so9830022qke.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 06:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/YUY44nb2TuzMCKHRCV2l8M53lZ4I7S6kZp9uFIRQTA=;
        b=Iu1xVql2YZ5DXnDM4qC47SVqTjqRG/jbU/lh7HjWHIwaWFhqqc/4y6jqRUxF+elCKT
         FZeqiUVOWrOuRd3dGY83bSa0g+EuODRC2DQLI8uxMrrzU5zc2gHhTZH6GR0LcYx+oqAI
         tntClAlYkCAqL1XR4Wr0QxTI4r3PZcYR4vDbqOoWrZOH5me+QSu+xggrv/xxV3osOoog
         Yw3Isg3i4VC2KvHxP1sm5vIsAS005o0Stp4NY530s5m+CYhTeEYvjaJmHdkoaQF7vtHq
         4sjtIwOlZn/xoPAUggSMQW7e4xauUkghChxPFj8zVkpT8H/4hsEfM7qT2GyBVMH/JSIy
         NVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/YUY44nb2TuzMCKHRCV2l8M53lZ4I7S6kZp9uFIRQTA=;
        b=M4YyREErte4XpsIMtUbfcrUyfvvQcQVf5h/YBJk8eBPTkrg7jh1OxFL66rexoULR0m
         dROQWAn0JqovmM20vtBgvXCI/UG/1UezwmBYPA+WOUClyg+zCHb2W6QYddyeYturlcVU
         BX+CQYNL2Ax6hPrRfwFKMF3ip7KEiwhmbl99f/P+0D8ov5FZ5Z++dLkbGDsQA3eUCyMU
         L/0vvNwhCVwO9IBHSwK5iveTEmx3KWBg9U5EsediWtNVB3zbySqAa08BubWOqFRxAHNb
         ZatOykwPIe59fJ6S/1mY6QU7bZmhY5qJfus770Xt34S0s02hSO7jNPn6bCYsQdln1pY0
         5BPQ==
X-Gm-Message-State: APjAAAXlcIcuXvCsRasac3T7HD5n/A7ojQtVHjDyy7GjZqZTU6kzqqz5
        a15AoKSgQdr+vX7cFqqLWO5VFA==
X-Google-Smtp-Source: APXvYqyBmZK9WMgZ6TFUiK5070lrSz5Cqc8P5J/GuhQkcppkPFTTyYSXDN/Uwbu+2fK15GJNht5yKw==
X-Received: by 2002:a37:59c7:: with SMTP id n190mr27956994qkb.142.1553692875322;
        Wed, 27 Mar 2019 06:21:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id c18sm5290364qkk.1.2019.03.27.06.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 06:21:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1h98UU-0003QH-1u; Wed, 27 Mar 2019 10:21:14 -0300
Date:   Wed, 27 Mar 2019 10:21:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/iser: remove uninitialized variable len
Message-ID: <20190327132114.GA13128@ziepe.ca>
References: <20190316230512.8933-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316230512.8933-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 11:05:12PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable len is not being inintialized and the uninitialized
> value is being returned. However, this return path is never reached
> because the default case in the switch statement returns -ENOSYS.
> Clean up the code by replacing the return -ENOSYS with a break
> for the default case and returning -ENOSYS at the end of the
> function.  This allows len to be removed.  Also remove redundant
> break that follows a return statement.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/infiniband/ulp/iser/iscsi_iser.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Applied to for-next

Thanks,
Jason
