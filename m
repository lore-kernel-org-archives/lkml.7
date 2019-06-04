Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B082C28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742402064A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559627418;
	bh=6pJxXDhunaU05disWJij71yT3C7+q3muGfwv90tuWo4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eWMkAK8i+/VWT1WpIMAQn2PMfp4ClAPShn0XhAerRkTanj0V4sPu9nO7eBlL8wmjF
	 ZnktDOmj+EVhfj3gB8UMHns0m3gOkqI2M6i70gHXCkffb2JaXjOjk1KUNUy9+8I0OF
	 g7b6spfG0xBKjD8IYxvOrVGHGkIJjBL2j3OnMfV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfFDFuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 01:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfFDFuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 01:50:17 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97E732064A;
        Tue,  4 Jun 2019 05:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559627415;
        bh=6pJxXDhunaU05disWJij71yT3C7+q3muGfwv90tuWo4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iqAhl4YBQP0Nn6w3xOTrY0YuLNVq3JgdWzAMZlqZSB+1oL9YXG7AOTZyANpzXZODk
         yzZo0zvmUI/lNOJ6Uj7Btnxw5Y5mjUv38qo3KIG+C3kEXGv5z7bKNKkIQThp1oB45S
         NUpxUsIKRAzx/ushYV42GJSXmQvs2iAf/xDouoL0=
Received: by mail-wm1-f47.google.com with SMTP id f10so13435426wmb.1;
        Mon, 03 Jun 2019 22:50:15 -0700 (PDT)
X-Gm-Message-State: APjAAAUfQsBTQCIqXSg4ttUIHYD2aul1u1fu0SBNSey3pds+ACpFIID9
        XWGf30oHwgHnDuUwVmNxOkacoZlgY8Cz7CVLyf4=
X-Google-Smtp-Source: APXvYqwKGJHh0ntjQgNiGL/j64qTKgLXFRql1Lr9kdThNL4/Ysi2b7nspk8shhQppQLzt2KIFQQbnaE5UZaLmQhqoAg=
X-Received: by 2002:a1c:3c8a:: with SMTP id j132mr4542669wma.172.1559627414252;
 Mon, 03 Jun 2019 22:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559614824.git.han_mao@c-sky.com> <40e0b27c342458360f9f30ef16026cb63e792850.1559614824.git.han_mao@c-sky.com>
In-Reply-To: <40e0b27c342458360f9f30ef16026cb63e792850.1559614824.git.han_mao@c-sky.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 4 Jun 2019 13:50:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTV5byJkCU4Z-NMvD+W8K7J56mmYNaXdchb+z-rbQm+1w@mail.gmail.com>
Message-ID: <CAJF2gTTV5byJkCU4Z-NMvD+W8K7J56mmYNaXdchb+z-rbQm+1w@mail.gmail.com>
Subject: Re: [PATCH V4 1/6] csky: Init pmu as a device
To:     Mao Han <han_mao@c-sky.com>
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mao,

On Tue, Jun 4, 2019 at 10:25 AM Mao Han <han_mao@c-sky.com> wrote:
>
> This patch change the csky pmu initialization from arch init to
> device init. The pmu can be configued with information from
> device tree(pmu device name, irq number and etc.).
>
> Signed-off-by: Mao Han <han_mao@c-sky.com>
> Cc: Guo Ren <guoren@kernel.org>
> ---
>  arch/csky/kernel/perf_event.c | 58 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
> index 376c972..c022acc 100644
> --- a/arch/csky/kernel/perf_event.c
> +++ b/arch/csky/kernel/perf_event.c
> @@ -21,6 +21,8 @@ struct csky_pmu_t {
>         uint32_t        hpcr;
>  } csky_pmu;
>
> +typedef int (*csky_pmu_init)(struct csky_pmu_t *);
Is the type of csky_pmu_init() the same with init_hw_perf_events ?

And I also think you should remove the hook style, because there
is only one init for the driver.

> +
>  #define cprgr(reg)                             \
>  ({                                             \
>         unsigned int tmp;                       \
> @@ -1028,4 +1030,58 @@ int __init init_hw_perf_events(void)
>
>         return perf_pmu_register(&csky_pmu.pmu, "cpu", PERF_TYPE_RAW);
>  }
> -arch_initcall(init_hw_perf_events);
> +
> +int csky_pmu_device_probe(struct platform_device *pdev,
> +                         const struct of_device_id *of_table)
> +{
> +       const struct of_device_id *of_id;
> +       csky_pmu_init init_fn;
> +       struct device_node *node = pdev->dev.of_node;
> +       int ret = -ENODEV;
> +

> +       of_id = of_match_node(of_table, pdev->dev.of_node);
> +       if (node && of_id) {
> +               init_fn = of_id->data;
> +               ret = init_fn(&csky_pmu);
> +       }
Ditto, all 7 lines above should be removed and use directly like:
            ret = init_hw_perf_events();

> +       if (ret) {
> +               pr_notice("[perf] failed to probe PMU!\n");
> +               return ret;
> +       }
> +
> +       return ret;
> +}
> +
> +const static struct of_device_id csky_pmu_of_device_ids[] = {
> +       {.compatible = "csky,csky-pmu", .data = init_hw_perf_events},
Ditto, Nothing for .data.

Best Regards
 Guo Ren
