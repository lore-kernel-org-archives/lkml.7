Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CA7C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7952082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ELlAvSoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfLQH1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 02:27:34 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:47009 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfLQH1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:27:34 -0500
Received: by mail-lf1-f65.google.com with SMTP id f15so6175519lfl.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 23:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kUuj8ktJfIrmR7FZT0cIqqoclUKcXuEIFZ2/fzt7Vt0=;
        b=ELlAvSoFULYLV2YY7DKSTwdBDeIDXmHV4cSrX+Ae2nq2buWIrvz3Le9LXe+of/c4bS
         WaHLFoPwll4yf7HQjMcNft2328L4u7WaHxb3vpPsGrT1ZQDDR+kW+aQsXscmO9/4nzDZ
         aTqCkHL9wAmFugCGudp5E/gUbofHfqa9DUBhOzhmpkfmXmdtrDtMhT4B6A6yLt4XLdp9
         AMur1eGXTeQbhT09EBx9ub1aFRfpQhkX4cBeHBmAoDwyjN8IHle8dcXwFtWGhmWpQB4c
         8CMH0aWvoNJZohdjnA5uGM81JplDFvJtMEEpZEpr7M3oHZFKZ/g0VOT2eLwIWt+KFtnr
         m3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kUuj8ktJfIrmR7FZT0cIqqoclUKcXuEIFZ2/fzt7Vt0=;
        b=dH9jHLBj/SBvEaVy8xQ/5gch4Q30ZZ8703Rt8swJ5SeFinpl32NMB/MAvZFv4mHFlY
         53P3BtGQsXqfkHLBe5K1epHAXQCSmimEnTJzVPTwVAQW60ZZjmtcW2N7i/VW5SYGByLb
         ZXDAWRMJ2GanXaTxnBN+6YV02Tjbb9Y8f6nK9fJQYPm5lIpglpdU/eW7hKp8pREs9mSu
         SDRyAPlcEosUDBqof0yZEsHEL6C6eISfHqgP/aSPCNrTh2MFdVzam+NCr0j8jlPrMySR
         aRH4x5YEfeTHkmMimW4rzkj7ESkpgO2J5vo2DuOYFwZRsn1eEPWlmQKT6VMpOiw3pKEU
         oqEA==
X-Gm-Message-State: APjAAAVua/ihINLzoBVLXl/frOLHwKZUyqa8Upo/qQISQTW0q7H0Pb7s
        iMkbMLWm1nZyNu2a3H5ZhUpZHw==
X-Google-Smtp-Source: APXvYqwOHZqJdY4XpnGy7NipdYvDsVdAOfTXW5cphY/LRA2IhvYVItFMdNaQA8q2UwVW2i1t7G0H1Q==
X-Received: by 2002:ac2:5503:: with SMTP id j3mr1862369lfk.104.1576567652233;
        Mon, 16 Dec 2019 23:27:32 -0800 (PST)
Received: from jax (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id c12sm10231185lfp.58.2019.12.16.23.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Dec 2019 23:27:31 -0800 (PST)
Date:   Tue, 17 Dec 2019 08:27:29 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     tee-dev@lists.linaro.org, Volodymyr_Babchuk@epam.com,
        jerome@forissier.org, etienne.carriere@linaro.org,
        vincent.t.cao@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] optee: Fix multi page dynamic shm pool alloc
Message-ID: <20191217072729.GA9507@jax>
References: <1574147666-19356-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1574147666-19356-1-git-send-email-sumit.garg@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On Tue, Nov 19, 2019 at 12:44:26PM +0530, Sumit Garg wrote:
> optee_shm_register() expected pages to be passed as an array of page
> pointers rather than as an array of contiguous pages. So fix that via
> correctly passing pages as per expectation.
> 
> Fixes: a249dd200d03 ("tee: optee: Fix dynamic shm pool allocations")
> Reported-by: Vincent Cao <vincent.t.cao@intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Tested-by: Vincent Cao <vincent.t.cao@intel.com>
> ---
>  drivers/tee/optee/shm_pool.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
> index 0332a53..85aa5bb 100644
> --- a/drivers/tee/optee/shm_pool.c
> +++ b/drivers/tee/optee/shm_pool.c
> @@ -28,8 +28,20 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
>  	shm->size = PAGE_SIZE << order;
>  
>  	if (shm->flags & TEE_SHM_DMA_BUF) {
> +		unsigned int nr_pages = 1 << order, i;
> +		struct page **pages;
> +
> +		pages = kcalloc(nr_pages, sizeof(pages), GFP_KERNEL);
> +		if (!pages)
> +			return -ENOMEM;
> +
> +		for (i = 0; i < nr_pages; i++) {
> +			pages[i] = page;
> +			page++;
> +		}
> +
>  		shm->flags |= TEE_SHM_REGISTER;
> -		rc = optee_shm_register(shm->ctx, shm, &page, 1 << order,
> +		rc = optee_shm_register(shm->ctx, shm, pages, nr_pages,
>  					(unsigned long)shm->kaddr);
>  	}

Apoligies for the later reply. It seems that this will leak memory.
The pointer pages isn't freed after the call to optee_shm_register().

Thanks,
Jens
