Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92CDC76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914122190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PKEx1YJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfGVP3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:29:50 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45277 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbfGVP3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:29:49 -0400
Received: by mail-vs1-f68.google.com with SMTP id h28so26361166vsl.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 08:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u1HHQwKS52S4EmuUPfeZPTFm+/hCi45AhWYKrSPj4Ik=;
        b=PKEx1YJP9uBCjqrN8BTLCJ8yorJ1CWA8nCOsypDBggKEVh6cZW2dDj9M5qoBDcK03o
         2dgoX6+CmZpTwev504V0IKArMx0poQZxpHmid3PiIDy5julUSwmV9ogKGjQHP5v30MD5
         0HZrz4L154NL2rDqEPdMi9fve68QaP/4lUrsZKC7+0N21OT1ERT5FxCmktDkPj5y8f6+
         4fYEqHdDiu1H8rKuSLGcN0DIJwWh0Y+r75sru7bFyTe+30i7Zu6SK7VYbnP0vi97Sd2o
         YxUb3srfhRym5Q26NpDq+OAlp9dAm6RCAU3HIippeC51SyjXrnMb3ivMD3Y6zdP1z90N
         46JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u1HHQwKS52S4EmuUPfeZPTFm+/hCi45AhWYKrSPj4Ik=;
        b=LAy30th69A5cYONZscG7ohMorOycdJ+V5YMTQF1mp2T7yI8Lp8hPH3occAdSt7lhmz
         lfBTh9oZUwYYBYi5jTpCHrt2GAks0FHiFn86ru6vOL8wL0R1+RuF+yVmUqlLhkLabHtp
         kLoaP352M94KawI1u5RQgymNsy5Oc95BN4QDz01qDnqHa7DfoRh38AcRoRuUsO5U1z43
         f9nWO6QY5Diq+mkyF+aDDIckRV20XCgW0BeXqL5yu4yVvsJS5/oxDwnK/iPy/fHfLz5Q
         uLjos0W2+y0ZDcANZ/YCUJXArDgHGs3uN5E9mX3Ad99BgElG08/eYqmedBP46DuF91eC
         gtNg==
X-Gm-Message-State: APjAAAX89RCKdu6THg3T3qAkyA73BwF0TDGYmPVmPVlUvLcVrEHb3wB1
        LxRufsK8oB10XAQUxzNwpKM/7A==
X-Google-Smtp-Source: APXvYqyXO5C/K9eycLxYIaN49TgoiszJjgK7Uyy5dAXmdHDosJ2JGqbxsPHDn/jrOxi5PtTDpwLJ7A==
X-Received: by 2002:a67:f713:: with SMTP id m19mr601509vso.183.1563809388836;
        Mon, 22 Jul 2019 08:29:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id t200sm15801789vke.5.2019.07.22.08.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 08:29:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hpaG3-0004rf-Qk; Mon, 22 Jul 2019 12:29:47 -0300
Date:   Mon, 22 Jul 2019 12:29:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Cc:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] Pass the return value of kref_put further
Message-ID: <20190722152947.GF7607@ziepe.ca>
References: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
 <20190722151426.5266-8-mplaneta@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722151426.5266-8-mplaneta@os.inf.tu-dresden.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 05:14:23PM +0200, Maksym Planeta wrote:
> Used in a later patch.
> 
> Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
>  drivers/infiniband/sw/rxe/rxe_pool.c | 3 ++-
>  drivers/infiniband/sw/rxe/rxe_pool.h | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 30a887cf9200..711d7d7f3692 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -541,7 +541,7 @@ static void rxe_dummy_release(struct kref *kref)
>  {
>  }
>  
> -void rxe_drop_ref(struct rxe_pool_entry *pelem)
> +int rxe_drop_ref(struct rxe_pool_entry *pelem)
>  {
>  	int res;
>  	struct rxe_pool *pool = pelem->pool;
> @@ -553,4 +553,5 @@ void rxe_drop_ref(struct rxe_pool_entry *pelem)
>  	if (res) {
>  		rxe_elem_release(&pelem->ref_cnt);
>  	}
> +	return res;
>  }

Using the return value of kref_put at all is super sketchy. Are you
sure this is actually a kref usage pattern?

Why would this be needed?

Jason
