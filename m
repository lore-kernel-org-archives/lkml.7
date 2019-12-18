Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4DBC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1F721775
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mQD2jRcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfLRAiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:38:19 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43289 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfLRAiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:38:19 -0500
Received: by mail-pf1-f196.google.com with SMTP id h14so181072pfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 16:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O9LKmCrSfekDRKRmwYMDfwn6SO/uEcONKVfMOLd0LkI=;
        b=mQD2jRcxk81WP9PHEab5PH8OdOP3Rfgoe4rGhUnly8thYDvAUfYl7NyJ+/OIh6TdpK
         hDXW8sWAmg+ZMFpKT/+igrEtlVUIT/lfldNMZ6/Qpp8CJ47XNdHiXu8Ri4IrX18n+eTN
         cBClbAz4QPkbqNWHfs1Skk/OYoqhzanuqXchaqjsxWXzcqwp6HbXRHNFoCyw5eRrjvgD
         tb0ofqNt0MKaaYzbijywqibF8fW90mDBoigSdKq/WjuHO+7YeRPQj4UX9twm3tVKa90O
         NtswaA6n4kZL+eNT+UhfPgW6iOntUlvNOgIpV+RfgraiI1lfQ/3TDuOHDqMaMJi6A470
         8zZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O9LKmCrSfekDRKRmwYMDfwn6SO/uEcONKVfMOLd0LkI=;
        b=NQ7E/Q7pL+Oc7MJ6+S0CQdC6aOt2msn0Ws0a1shQ9rwkYSJ979vdhVa3C0AqZqs4bt
         2GNfTXmJfkVGxkQHFBKLMMe1UlUTFal2dreYNnaXAwOtqtrVbQMIAbYC4aY8RLc6kK5V
         7uum+6ls1OU8u5/RA9dblhuokIKV1LKjWfZ4+B5O4revfBBegz4xkXJsZNW2gSwxekw8
         GYBqTNOwDwmStmuXQorhgutaq1gp2LpfKnV8FpukPO4BNIt6jS/wSzROBZ0ny+icYsXj
         SbJEpnErHOCm9lPsvpPG9aK59CQ06gfd0QAewHdBPaj4U5A20c5ZyAn7ls80KWz4MtBf
         CGZQ==
X-Gm-Message-State: APjAAAV9SmeNlkPgrY/B/g9eYJOo5R6ZaogRe/Ff1Lyx9aD61bRNQ8QJ
        5p1ad7jxsp6DMf0npUcdzRy/NA==
X-Google-Smtp-Source: APXvYqzmNrwOOON/i4tkQmY/ZlIS1dGrOqEzBVCgMVWSZVnbpPqDbCrh3XO2sWRSEsZQUx1LzO4M9Q==
X-Received: by 2002:a62:1cd6:: with SMTP id c205mr605856pfc.179.1576629498300;
        Tue, 17 Dec 2019 16:38:18 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id q21sm235110pff.105.2019.12.17.16.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Dec 2019 16:38:17 -0800 (PST)
Date:   Tue, 17 Dec 2019 17:38:15 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>
Subject: Re: [PATCHv3 05/15] remoteproc/omap: Add the rproc ops .da_to_va()
 implementation
Message-ID: <20191218003815.GC16271@xps15>
References: <20191213125537.11509-1-t-kristo@ti.com>
 <20191213125537.11509-6-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213125537.11509-6-t-kristo@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 02:55:27PM +0200, Tero Kristo wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> An implementation for the rproc ops .da_to_va() has been added
> that provides the address translation between device addresses
> to kernel virtual addresses for internal RAMs present on that
> particular remote processor device. The implementation provides
> the translations based on the addresses parsed and stored during
> the probe.
> 
> This ops gets invoked by the exported rproc_da_to_va() function
> and allows the remoteproc core's ELF loader to be able to load
> program data directly into the internal memories.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/remoteproc/omap_remoteproc.c | 39 ++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
> index 844703507a74..28f14e24b389 100644
> --- a/drivers/remoteproc/omap_remoteproc.c
> +++ b/drivers/remoteproc/omap_remoteproc.c
> @@ -232,10 +232,49 @@ static int omap_rproc_stop(struct rproc *rproc)
>  	return 0;
>  }
>  
> +/**
> + * omap_rproc_da_to_va() - internal memory translation helper
> + * @rproc: remote processor to apply the address translation for
> + * @da: device address to translate
> + * @len: length of the memory buffer
> + *
> + * Custom function implementing the rproc .da_to_va ops to provide address
> + * translation (device address to kernel virtual address) for internal RAMs
> + * present in a DSP or IPU device). The translated addresses can be used
> + * either by the remoteproc core for loading, or by any rpmsg bus drivers.
> + * Returns the translated virtual address in kernel memory space, or NULL
> + * in failure.
> + */
> +static void *omap_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
> +{
> +	struct omap_rproc *oproc = rproc->priv;
> +	int i;
> +	u32 offset;
> +
> +	if (len <= 0)
> +		return NULL;
> +
> +	if (!oproc->num_mems)
> +		return NULL;
> +
> +	for (i = 0; i < oproc->num_mems; i++) {
> +		if (da >= oproc->mem[i].dev_addr && da + len <=

Shouldn't this be '<' rather than '<=' ?

> +		    oproc->mem[i].dev_addr +  oproc->mem[i].size) {

One space too many after the '+' .

> +			offset = da -  oproc->mem[i].dev_addr;

One space too many after then '-' .

> +			/* __force to make sparse happy with type conversion */
> +			return (__force void *)(oproc->mem[i].cpu_addr +
> +						offset);
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
>  static const struct rproc_ops omap_rproc_ops = {
>  	.start		= omap_rproc_start,
>  	.stop		= omap_rproc_stop,
>  	.kick		= omap_rproc_kick,
> +	.da_to_va	= omap_rproc_da_to_va,
>  };
>  
>  static const char * const ipu_mem_names[] = {
> -- 
> 2.17.1
> 
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
