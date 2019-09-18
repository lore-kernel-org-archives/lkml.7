Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BA3C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DA221D79
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568837599;
	bh=7yqTiFhnfOQD1ehV4j3dV3361bQH6KOjLCmrP9XuYao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CUTAVaW412L+im4s2zp219T9T7mtwqnqfS4+A0zERNunUz53wSAqtzpmMNc9PhfWG
	 2S/+0BP+rTUiwF1LLd6RTOmtQf5nN7GnGmJomRRKLYLMM4BY5C1FFMNMmwQxq2RoB3
	 ExBTsNfyhXBFc0XxLf64wFnsGUsXZO4iautFUfWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391181AbfIRUNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:13:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391137AbfIRUNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:13:18 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6F3021BE5;
        Wed, 18 Sep 2019 20:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568837596;
        bh=7yqTiFhnfOQD1ehV4j3dV3361bQH6KOjLCmrP9XuYao=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JlSwulvYPbZcQ+Kx888pCMj/MpNfLeCJBzzVzKM5RgftKgq6k71CdfOnqLUo9c7v2
         zaRIwbkhoyGSeG9Ok/bo6UpgUj5JM8xcoOORRd4RDTt+Uv+WA9x+dWc/dNRazg+RE6
         fZH2fI/pqosb98SZEuYG16sh8Y6wBh1hFuZdcXk0=
Received: by mail-qt1-f175.google.com with SMTP id n7so1327947qtb.6;
        Wed, 18 Sep 2019 13:13:16 -0700 (PDT)
X-Gm-Message-State: APjAAAVWA/bSjuIL9eKGR67EXJKuca7+p+/1dwNBPKuRaUvuxVx4e0Fa
        paJaFEopBlOMaLAvIee5AxVRocj+jnB+72CF9g==
X-Google-Smtp-Source: APXvYqzp8jEBWLktbjqa8bVQ9eRqJy+dpg6cUJktk5xlfJC86kD0oRlkwkg/pklVSZjObNEm5xalq1A+S1M86ezXcdE=
X-Received: by 2002:ac8:100d:: with SMTP id z13mr6081504qti.224.1568837595963;
 Wed, 18 Sep 2019 13:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190918184656.7633-1-rananta@codeaurora.org>
In-Reply-To: <20190918184656.7633-1-rananta@codeaurora.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 18 Sep 2019 15:13:04 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ2WeW0JHSHZuvo9bbc7JSFBr_qCuOp97i=b6Q+OPY7Cg@mail.gmail.com>
Message-ID: <CAL_JsqJ2WeW0JHSHZuvo9bbc7JSFBr_qCuOp97i=b6Q+OPY7Cg@mail.gmail.com>
Subject: Re: [PATCH] of: Add of_get_memory_prop()
To:     Raghavendra Rao Ananta <rananta@codeaurora.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Trilok Soni <tsoni@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 1:47 PM Raghavendra Rao Ananta
<rananta@codeaurora.org> wrote:
>
> On some embedded systems, the '/memory' dt-property gets updated
> by the bootloader (for example, the DDR configuration) and then
> gets passed onto the kernel. The device drivers may have to read
> the properties at runtime to make decisions. Hence, add
> of_get_memory_prop() for the device drivers to query the requested

Function name doesn't match. Device drivers don't need to access the FDT.

> properties.
>
> Signed-off-by: Raghavendra Rao Ananta <rananta@codeaurora.org>
> ---
>  drivers/of/fdt.c       | 27 +++++++++++++++++++++++++++
>  include/linux/of_fdt.h |  1 +
>  2 files changed, 28 insertions(+)

We don't add kernel api's without users.

>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 223d617ecfe1..925cf2852433 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -79,6 +79,33 @@ void __init of_fdt_limit_memory(int limit)
>         }
>  }
>
> +/**
> + * of_fdt_get_memory_prop - Return the requested property from the /memory node
> + *
> + * On match, returns a non-zero positive value which represents the property
> + * value. Otherwise returns -ENOENT.
> + */
> +int of_fdt_get_memory_prop(const char *pname)
> +{
> +       int memory;
> +       int len;
> +       fdt32_t *prop = NULL;
> +
> +       if (!pname)
> +               return -EINVAL;
> +
> +       memory = fdt_path_offset(initial_boot_params, "/memory");

Memory nodes should have a unit-address, so this won't work frequently.

> +       if (memory > 0)
> +               prop = fdt_getprop_w(initial_boot_params, memory,
> +                                 pname, &len);
> +
> +       if (!prop || len != sizeof(u32))
> +               return -ENOENT;
> +
> +       return fdt32_to_cpu(*prop);
> +}
> +EXPORT_SYMBOL_GPL(of_fdt_get_memory_prop);
> +
>  static bool of_fdt_device_is_available(const void *blob, unsigned long node)
>  {
>         const char *status = fdt_getprop(blob, node, "status", NULL);
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index acf820e88952..537f29373358 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -38,6 +38,7 @@ extern char __dtb_end[];
>  /* Other Prototypes */
>  extern u64 of_flat_dt_translate_address(unsigned long node);
>  extern void of_fdt_limit_memory(int limit);
> +extern int of_fdt_get_memory_prop(const char *pname);
>  #endif /* CONFIG_OF_FLATTREE */
>
>  #ifdef CONFIG_OF_EARLY_FLATTREE
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
