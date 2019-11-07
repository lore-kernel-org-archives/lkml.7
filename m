Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4017BC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063DD2087E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SDzAUlK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387972AbfKGLGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 06:06:08 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35507 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfKGLGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:06:07 -0500
Received: by mail-lf1-f65.google.com with SMTP id y6so1278455lfj.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 03:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9gtlTin+00E64HhGraEWeRmlFe8OE5QOZpkTpU0Z+MM=;
        b=SDzAUlK65SJ+iY6ZrvmE36CDvTD2wsiRdpMpR4C2iT7oYMkq7fQC5LG7Sox+q04j9t
         7omCnz1ia+t4dRTId0xMy0/S+9Ns7s0R+SWLc6ENY8tFDsA+z3YBo1rvS7AyRATDP4Lx
         JwfwgujKOkmqGFUXon8MmzWIGNAM11MhYBUjRk9bXqtq2gREvDTJqkf5qp/rDxDxeHcG
         t0lkCNr5PodmVLco1lWwUBsB56dsErRZj3aEZ37bPDrgcBDGT17j3WcxalH+g5NTYCI7
         DwSdG0IN76RlOwERSt11Tj6pUQC871YN/v1CEOd4QnGEYxulwcrmtQMW8JTIpg3hyNjN
         9pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9gtlTin+00E64HhGraEWeRmlFe8OE5QOZpkTpU0Z+MM=;
        b=grc4QEbA7XmOi8vs86XeRA7gJMWJizkn6NdcFCbSkY+fhtzO7vdIXiLlV9kpkGfLig
         LK6/d5vbaW+BD29nKiSBsGhvgxV3BUvFQAArkaE9nyVmXlYEwYXmXPyZzMvN8u4ReYQ2
         XtVc6h8sxOjCffB5XHQX3DltwS6gDLDuySKWcuZXxrrPltXORbkTmEm+IGyCq6r2I2L3
         2r9cRjUJLFRvXFiVETRhYhqy7TSCh6pKQGUCVqHogWuTOertlkVfnK61ikZtFiRV5q/n
         5oVegRMSRl3QVKYhcDpftTYwgf0f5fn+RODnErHZGotPsbDn80Kf8LUz7lgkxGxwZ9O7
         PGtA==
X-Gm-Message-State: APjAAAVUDhwZD1fMU66YU1QjZT/OhgDfV7TOyCKrn/B0pbedt2uxWHIW
        Shx83ZUWEofyPMAI8Pum5ltWEmoaFGQ=
X-Google-Smtp-Source: APXvYqwQPIFVgxvw48/U+Nj8sHpu5wsOuh8x/5UwZVW7SmDR31NSl7928vcrdGZ59b6fkEP7eLZw+g==
X-Received: by 2002:a05:6512:75:: with SMTP id i21mr1951816lfo.180.1573124765855;
        Thu, 07 Nov 2019 03:06:05 -0800 (PST)
Received: from jax (h-48-81.A175.priv.bahnhof.se. [94.254.48.81])
        by smtp.gmail.com with ESMTPSA id 4sm834976lfa.95.2019.11.07.03.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Nov 2019 03:06:05 -0800 (PST)
Date:   Thu, 7 Nov 2019 12:06:03 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Volodymyr_Babchuk@epam.com, tee-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, etienne.carriere@linaro.org
Subject: Re: [PATCH] tee: optee: Fix dynamic shm pool allocations
Message-ID: <20191107110603.GA8790@jax>
References: <1572527274-21925-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1572527274-21925-1-git-send-email-sumit.garg@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On Thu, Oct 31, 2019 at 06:37:54PM +0530, Sumit Garg wrote:
> In case of dynamic shared memory pool, kernel memory allocated using
> dmabuf_mgr pool needs to be registered with OP-TEE prior to its usage
> during optee_open_session() or optee_invoke_func().
> 
> So fix dmabuf_mgr pool allocations via an additional call to
> optee_shm_register().
> 
> Fixes: 9733b072a12a ("optee: allow to work without static shared memory")
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Looks good, I'm picking this up. Etienne told me has tested this on some
of his hardware so I'll add:
Tested-by: Etienne Carriere <etienne.carriere@linaro.org>

Thanks,
Jens

> ---
> 
> Depends on patch: https://lkml.org/lkml/2019/7/30/506 that adds support
> to allow registration of kernel buffers with OP-TEE.
> 
>  drivers/tee/optee/shm_pool.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
> index de1d9b8..0332a53 100644
> --- a/drivers/tee/optee/shm_pool.c
> +++ b/drivers/tee/optee/shm_pool.c
> @@ -17,6 +17,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
>  {
>  	unsigned int order = get_order(size);
>  	struct page *page;
> +	int rc = 0;
>  
>  	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
>  	if (!page)
> @@ -26,12 +27,21 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
>  	shm->paddr = page_to_phys(page);
>  	shm->size = PAGE_SIZE << order;
>  
> -	return 0;
> +	if (shm->flags & TEE_SHM_DMA_BUF) {
> +		shm->flags |= TEE_SHM_REGISTER;
> +		rc = optee_shm_register(shm->ctx, shm, &page, 1 << order,
> +					(unsigned long)shm->kaddr);
> +	}
> +
> +	return rc;
>  }
>  
>  static void pool_op_free(struct tee_shm_pool_mgr *poolm,
>  			 struct tee_shm *shm)
>  {
> +	if (shm->flags & TEE_SHM_DMA_BUF)
> +		optee_shm_unregister(shm->ctx, shm);
> +
>  	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
>  	shm->kaddr = NULL;
>  }
> -- 
> 2.7.4
> 
