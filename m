Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A0CCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40AA2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mr6chvCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfJaNKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:10:00 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40976 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfJaNKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:10:00 -0400
Received: by mail-lj1-f194.google.com with SMTP id m9so6536623ljh.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 06:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cmIjifxfQFO4qz5rg6oFCVOlskasCOUJY89Sh1wUKqA=;
        b=Mr6chvCvRVakjGwvoHHxlAwMXVYm3belennAYVwYjO/WUN5xiXXuJVVrh9+QrHySfb
         dWtmuQf9RsidImxHV0irF1sEb3jHSmE6shp+5kRPKZss/AR3Xcdopc0YSGr/ocCeftmM
         jabCTuESp53lGoSTkVLizMWaenMOdM9/apHfrh+Zl2ZBSQCG0KRiqXxtvmK6b1QTcYLh
         /UygFySsC1lDSPtBB4Q1ZQKzAzAs7N/6wOEe5GpI+/pR0twFnbfwYSRAxGiotOahksQD
         pHQ6tHdxeULOYGgjfP9c12sVCITjJGtZFsV/P9ELM0GMplCmzDduSucqZSUJBECbUEaP
         W9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cmIjifxfQFO4qz5rg6oFCVOlskasCOUJY89Sh1wUKqA=;
        b=nQ2wbD9wpkw85yqmjsCKNOCt3B+qlM0xm5exRcrj7Ez8flaXnrg8aKeDPJavsG656w
         p2UdCs/nevAPdk8RZFtF9g5bXUzJA7YPDH4n2G4up2QGa/BmF7eM4H/N2qW4AyPu4WMs
         sjlEIza2H47CYACd+0En6v+8Iwj+hZIdRWsmwQVwtkxiIU72cZjC1+0RvGFSp9OFwrTp
         A96xeEz67zY0/0e22g9UZ4iDDLnWPAuud/AP4hJ3U/fkbhEwmnY3S/D6tZ+beVgb5HjN
         78mzAFlIrVTu/EftV22G+9p5BtJlmePQ4D3qv8Cr+XDAMQ65F+YoNCv+kC/2+VRXP+Qm
         eVUA==
X-Gm-Message-State: APjAAAWZ9xL/IFUXZ6zSk0hh1faa6x1M+PAwpEOfKvSuHEGGz20ahL4I
        pumEmJD7udCCHg6vxU2RT2o3MAWHqYDz54Yvcv5/eQ==
X-Google-Smtp-Source: APXvYqzamW+rtqDmKY2FbzJ3DbMXqbrERxVOgB64WOendcl8KqNVwHu0aJhKZMTruLpwCsMDnbuLBV114Lpjlb5ZDOs=
X-Received: by 2002:a05:651c:10e:: with SMTP id a14mr4027476ljb.177.1572527397261;
 Thu, 31 Oct 2019 06:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <1536345427-31425-1-git-send-email-volodymyr_babchuk@epam.com> <20190311130348.2157-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20190311130348.2157-1-volodymyr_babchuk@epam.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 31 Oct 2019 18:39:45 +0530
Message-ID: <CAFA6WYONU8YdJuFSX_Mv8soKgr57DeZT6j7ywJ2oni8vHs35ug@mail.gmail.com>
Subject: Re: [Tee-dev] [PATCH v3] optee: allow to work without static shared memory
To:     Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Volodymyr, Jens,

On Mon, 11 Mar 2019 at 18:34, Volodymyr Babchuk
<Volodymyr_Babchuk@epam.com> wrote:
>
> From: Volodymyr Babchuk <vlad.babchuk@gmail.com>
>
> On virtualized systems it is possible that OP-TEE will provide
> only dynamic shared memory support. So it is fine to boot
> without static SHM enabled if dymanic one is supported.
>
> Signed-off-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>
> ---

Is this patch well tested?

This patch seems to broke "tee_shm_alloc()" API for all kernel
internal / user-space clients in case dynamic shared memory is enabled
in OP-TEE (capability: OPTEE_SMC_SEC_CAP_DYNAMIC_SHM is set).

How are kernel buffers allocated from "dmabuf_mgr" as per this patch
registered with OP-TEE?

Note here that "priv_mgr" seems to work well as OP-TEE provides a hook
to map the buffers returned during RPC calls into registered shm
space.

I think the correct way to enable intended feature as per description
of the patch would be to add an additional call to
"optee_shm_register()" during allocation from "dmabuf_mgr". So I have
proposed a fix patch here [1]. Please have a look.

[1] https://lkml.org/lkml/2019/10/31/382

Regards,
Sumit

>
>  Changes from V2:
>   - rebased onto upstream
>
>  drivers/tee/optee/core.c | 80 ++++++++++++++++++++++++----------------
>  1 file changed, 49 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 0842b6e6af82..48963eab32f5 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -419,9 +419,35 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
>         return true;
>  }
>
> +static struct tee_shm_pool *optee_config_dyn_shm(void)
> +{
> +       struct tee_shm_pool_mgr *priv_mgr;
> +       struct tee_shm_pool_mgr *dmabuf_mgr;
> +       void *rc;
> +
> +       rc = optee_shm_pool_alloc_pages();
> +       if (IS_ERR(rc))
> +               return rc;
> +       priv_mgr = rc;
> +
> +       rc = optee_shm_pool_alloc_pages();
> +       if (IS_ERR(rc)) {
> +               tee_shm_pool_mgr_destroy(priv_mgr);
> +               return rc;
> +       }
> +       dmabuf_mgr = rc;
> +
> +       rc = tee_shm_pool_alloc(priv_mgr, dmabuf_mgr);
> +       if (IS_ERR(rc)) {
> +               tee_shm_pool_mgr_destroy(priv_mgr);
> +               tee_shm_pool_mgr_destroy(dmabuf_mgr);
> +       }
> +
> +       return rc;
> +}
> +
>  static struct tee_shm_pool *
> -optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm,
> -                         u32 sec_caps)
> +optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
>  {
>         union {
>                 struct arm_smccc_res smccc;
> @@ -436,10 +462,11 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm,
>         struct tee_shm_pool_mgr *priv_mgr;
>         struct tee_shm_pool_mgr *dmabuf_mgr;
>         void *rc;
> +       const int sz = OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
>
>         invoke_fn(OPTEE_SMC_GET_SHM_CONFIG, 0, 0, 0, 0, 0, 0, 0, &res.smccc);
>         if (res.result.status != OPTEE_SMC_RETURN_OK) {
> -               pr_info("shm service not available\n");
> +               pr_err("static shm service not available\n");
>                 return ERR_PTR(-ENOENT);
>         }
>
> @@ -465,28 +492,15 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm,
>         }
>         vaddr = (unsigned long)va;
>
> -       /*
> -        * If OP-TEE can work with unregistered SHM, we will use own pool
> -        * for private shm
> -        */
> -       if (sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM) {
> -               rc = optee_shm_pool_alloc_pages();
> -               if (IS_ERR(rc))
> -                       goto err_memunmap;
> -               priv_mgr = rc;
> -       } else {
> -               const size_t sz = OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
> -
> -               rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, sz,
> -                                                   3 /* 8 bytes aligned */);
> -               if (IS_ERR(rc))
> -                       goto err_memunmap;
> -               priv_mgr = rc;
> -
> -               vaddr += sz;
> -               paddr += sz;
> -               size -= sz;
> -       }
> +       rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, sz,
> +                                           3 /* 8 bytes aligned */);
> +       if (IS_ERR(rc))
> +               goto err_memunmap;
> +       priv_mgr = rc;
> +
> +       vaddr += sz;
> +       paddr += sz;
> +       size -= sz;
>
>         rc = tee_shm_pool_mgr_alloc_res_mem(vaddr, paddr, size, PAGE_SHIFT);
>         if (IS_ERR(rc))
> @@ -552,7 +566,7 @@ static optee_invoke_fn *get_invoke_func(struct device_node *np)
>  static struct optee *optee_probe(struct device_node *np)
>  {
>         optee_invoke_fn *invoke_fn;
> -       struct tee_shm_pool *pool;
> +       struct tee_shm_pool *pool = ERR_PTR(-EINVAL);
>         struct optee *optee = NULL;
>         void *memremaped_shm = NULL;
>         struct tee_device *teedev;
> @@ -581,13 +595,17 @@ static struct optee *optee_probe(struct device_node *np)
>         }
>
>         /*
> -        * We have no other option for shared memory, if secure world
> -        * doesn't have any reserved memory we can use we can't continue.
> +        * Try to use dynamic shared memory if possible
>          */
> -       if (!(sec_caps & OPTEE_SMC_SEC_CAP_HAVE_RESERVED_SHM))
> -               return ERR_PTR(-EINVAL);
> +       if (sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
> +               pool = optee_config_dyn_shm();
> +
> +       /*
> +        * If dynamic shared memory is not available or failed - try static one
> +        */
> +       if (IS_ERR(pool) && (sec_caps & OPTEE_SMC_SEC_CAP_HAVE_RESERVED_SHM))
> +               pool = optee_config_shm_memremap(invoke_fn, &memremaped_shm);
>
> -       pool = optee_config_shm_memremap(invoke_fn, &memremaped_shm, sec_caps);
>         if (IS_ERR(pool))
>                 return (void *)pool;
>
> --
> 2.21.0
> _______________________________________________
> Tee-dev mailing list
> Tee-dev@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/tee-dev
