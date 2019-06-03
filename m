Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5ABC28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB56C27D78
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559550040;
	bh=qLktZ/xAZN5ys41FBxkXCqeVxojZg8wIlKavONty87o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0VWG1ApWTdgIyuRYS2b7S7CvX/RCQ9aHxRpVQe+Gub/lb74FzTHXasYOnJI7XkcTw
	 g2sLCFCboDapD7g6Ot6Uz/V/tDl0F+yjUYQcj0Slbx0NiXXqJNw+JSAp4SAQXqHf/N
	 vNc1bNWfoeYRzfkyj5qKFh7dYIrRqO9tGU7CYmoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfFCIUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:20:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfFCIUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:20:39 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B75727D78;
        Mon,  3 Jun 2019 08:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559550038;
        bh=qLktZ/xAZN5ys41FBxkXCqeVxojZg8wIlKavONty87o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YcZ3ngP0vHT2Op1WsjMRv4dHvU9Z8i8BQJSwycZjJRIaXi9qEh+4zXtMaiLwj2qda
         VT/CClNIvwGTHa+IGL0j7yvFaCFoN3TQ4g1ikQ2mA2IhVaGgsM5XLVNvTBeLfrub0k
         k3PfScbMqAxAmdUQzJfidtL9DbUBOnljuYIKUuW4=
Received: by mail-wm1-f50.google.com with SMTP id v22so10001983wml.1;
        Mon, 03 Jun 2019 01:20:38 -0700 (PDT)
X-Gm-Message-State: APjAAAUGLd0UtdvYYb4Is1p4cC2yV8J/pW7KCsQuBuwmSpvUKcC+kCa0
        0Cb4uGEZfkqG6LK3fpNjVvip01R9i61nI4q0Ih0=
X-Google-Smtp-Source: APXvYqzX1lDwJhZ+DqCWbB4fGZHRzXTHLJL0sTAwEcTWCMueUd+q2MSVmQ6/BomUzgcA5Ni7kaNCu33xXNyVTLDrujA=
X-Received: by 2002:a1c:6545:: with SMTP id z66mr1386253wmb.77.1559550037237;
 Mon, 03 Jun 2019 01:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559544301.git.han_mao@c-sky.com> <f7bfa540fb7492883c54b4e4a8c226fec69bc7fa.1559544301.git.han_mao@c-sky.com>
In-Reply-To: <f7bfa540fb7492883c54b4e4a8c226fec69bc7fa.1559544301.git.han_mao@c-sky.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 3 Jun 2019 16:20:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR=woyeq9+05qASs4pyjvUj7BHwyGY5Rex1ia7_dmdudA@mail.gmail.com>
Message-ID: <CAJF2gTR=woyeq9+05qASs4pyjvUj7BHwyGY5Rex1ia7_dmdudA@mail.gmail.com>
Subject: Re: [PATCH V3 2/6] csky: Add reg-io-width property for csky pmu
To:     Mao Han <han_mao@c-sky.com>
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mao,

Title Correct: csky: Add reg-io-width property for csky pmu
It's not a reg-io-width. I think it's a count-width, isn't it?

On Mon, Jun 3, 2019 at 2:47 PM Mao Han <han_mao@c-sky.com> wrote:
>
> csky pmu counter may have different io width. When the counter is smaller
Csky pmu counter ..., capitalize the first letter.

> then 64 bits and counter value is smaller than the old value, it will
> result to a extremely large delta value. So the sampled value should be
> extend to 64 bits to avoid this, the extension bits base on the
> reg-io-width property from dts.
>
> Signed-off-by: Mao Han <han_mao@c-sky.com>
> CC: Guo Ren <guoren@kernel.org>
Please correct to "Cc:"

> CC: linux-csky@vger.kernel.org
Remove it and don't add mailing list in commit msg, Cc means you want
who to pick up the patch.

> ---
>  arch/csky/kernel/perf_event.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
> index c022acc..f1b3cdf 100644
> --- a/arch/csky/kernel/perf_event.c
> +++ b/arch/csky/kernel/perf_event.c
> @@ -18,6 +18,7 @@ static void (*hw_raw_write_mapping[CSKY_PMU_MAX_EVENTS])(uint64_t val);
>
>  struct csky_pmu_t {
>         struct pmu      pmu;
> +       uint32_t        sign_extend;
Please use count_width here.

>         uint32_t        hpcr;
>  } csky_pmu;
>
> @@ -806,7 +807,13 @@ static void csky_perf_event_update(struct perf_event *event,
>                                    struct hw_perf_event *hwc)
>  {
>         uint64_t prev_raw_count = local64_read(&hwc->prev_count);
> -       uint64_t new_raw_count = hw_raw_read_mapping[hwc->idx]();
> +       /*
> +        * Extend count value to 64bit, otherwise delta calculation would
Sign extend count value to 64bit, ...

> +        * be incorrect when overflow occurs.
> +        */
> +       uint64_t new_raw_count = ((int64_t)hw_raw_read_mapping[hwc->idx]()
> +                                  << csky_pmu.sign_extend)
> +                                  >> csky_pmu.sign_extend;
Please use sign_extend64 in bitops.h.

+       uint64_t new_raw_count = ((int64_t)hw_raw_read_mapping[hwc->idx]()
+                                  << 64 - csky_pmu.count_width)
+                                  >> 64 - csky_pmu.count_width;

>         int64_t delta = new_raw_count - prev_raw_count;
>
>         /*
> @@ -1037,6 +1044,7 @@ int csky_pmu_device_probe(struct platform_device *pdev,
>         const struct of_device_id *of_id;
>         csky_pmu_init init_fn;
>         struct device_node *node = pdev->dev.of_node;
> +       int cnt_width;
Please remove.

>         int ret = -ENODEV;
>
>         of_id = of_match_node(of_table, pdev->dev.of_node);
> @@ -1045,6 +1053,12 @@ int csky_pmu_device_probe(struct platform_device *pdev,
>                 ret = init_fn(&csky_pmu);
>         }
>
> +       if (!of_property_read_u32(node, "reg-io-width", &cnt_width)) {
> +               csky_pmu.sign_extend = 64 - cnt_width;
63?
Please use count_width, see above.

> +       } else {
> +               csky_pmu.sign_extend = 16;
Please define a macro for define DEFAULT_COUNT_WIDTH 48 and change the
format like this:

       if (of_property_read_u32(node, "count-width", &csky_pmu.count_width))
               csky_pmu.count_width = DEFAULT_COUNT_WIDTH;

Best Regards


 Guo Ren
