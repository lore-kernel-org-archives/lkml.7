Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EB6C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BB424A06
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559626559;
	bh=PAqyxlcPMXPOhPpJ/66+ZrkcT2K+hj21KEf8tPNqf6U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BmF7Uy8DPBGquzmrx3MrApNbiHkrKb+NIYo9FDVsLIYUvYyl4ukcFcp8+FQmOYhFC
	 vGYc3ImMEwGlg/2gxwcdXCrbHUbYUoAHrbCDHSjiFi+L7Ub+LbLGtk++24fSmDXee9
	 LiXY8DKMe2pthF5dX/tmuVpcFPctiSvbQm6l4sk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfFDFf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 01:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfFDFf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 01:35:58 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEB1324A06;
        Tue,  4 Jun 2019 05:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559626557;
        bh=PAqyxlcPMXPOhPpJ/66+ZrkcT2K+hj21KEf8tPNqf6U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W4JCBakbzjgQ2mqc3JuadrPa5arJmxqebHvG0/yREPCJ4gCe/ZOOwhsYH2eoZbcU6
         cpcEQHVzdogM6GxpAN6SurVacK0ymIIbt+RxDgAQuiAGOUwiQW97+hgN2sYcNzhhQe
         DvXmRieQJ++qkRM7BwRQRDqVxSfNGI/2WJBT/cuA=
Received: by mail-wr1-f54.google.com with SMTP id n4so11307841wrs.3;
        Mon, 03 Jun 2019 22:35:57 -0700 (PDT)
X-Gm-Message-State: APjAAAV61KEYMjx3wcRDSsR1oM5xTj0olj2mf2dIClxnsRopmbcwQwTY
        aZ7vmrMeisys9irNz9gyWZ4cDmEfxN224wIZwxs=
X-Google-Smtp-Source: APXvYqwNQKgDYTSwowooFV79LRn5k48lbuG2Jqr4kT6UcPT3+OnJ1DivoqRXRLaJCl5a+eTu9fODEiLS8O4SXsi9J2s=
X-Received: by 2002:adf:eb45:: with SMTP id u5mr1661342wrn.38.1559626556294;
 Mon, 03 Jun 2019 22:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559614824.git.han_mao@c-sky.com> <d38f72230b838419a1ef829dcb27373807d697b5.1559614824.git.han_mao@c-sky.com>
In-Reply-To: <d38f72230b838419a1ef829dcb27373807d697b5.1559614824.git.han_mao@c-sky.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 4 Jun 2019 13:35:45 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTKg_q6muyXMUW-5rUKOAnfQfY_suAKDJE3VbNHT4Vy9w@mail.gmail.com>
Message-ID: <CAJF2gTTKg_q6muyXMUW-5rUKOAnfQfY_suAKDJE3VbNHT4Vy9w@mail.gmail.com>
Subject: Re: [PATCH V4 2/6] csky: Add count-width property for csky pmu
To:     Mao Han <han_mao@c-sky.com>
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mao,

On Tue, Jun 4, 2019 at 10:25 AM Mao Han <han_mao@c-sky.com> wrote:
>
> The csky pmu counter may have different io width. When the counter is
> smaller then 64 bits and counter value is smaller than the old value, it
> will result to a extremely large delta value. So the sampled value should
> be extend to 64 bits to avoid this, the extension bits base on the
> count-width property from dts.
>
> Signed-off-by: Mao Han <han_mao@c-sky.com>
> Cc: Guo Ren <guoren@kernel.org>
> ---
>  arch/csky/kernel/perf_event.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
> index c022acc..36f7f20 100644
> --- a/arch/csky/kernel/perf_event.c
> +++ b/arch/csky/kernel/perf_event.c
> @@ -9,6 +9,7 @@
>  #include <linux/platform_device.h>
>
>  #define CSKY_PMU_MAX_EVENTS 32
> +#define DEFAULT_COUNT_WIDTH 48
>
>  #define HPCR           "<0, 0x0>"      /* PMU Control reg */
>  #define HPCNTENR       "<0, 0x4>"      /* Count Enable reg */
> @@ -18,6 +19,7 @@ static void (*hw_raw_write_mapping[CSKY_PMU_MAX_EVENTS])(uint64_t val);
>
>  struct csky_pmu_t {
>         struct pmu      pmu;
> +       uint32_t        count_width;
>         uint32_t        hpcr;
>  } csky_pmu;
>
> @@ -806,7 +808,12 @@ static void csky_perf_event_update(struct perf_event *event,
>                                    struct hw_perf_event *hwc)
>  {
>         uint64_t prev_raw_count = local64_read(&hwc->prev_count);
> -       uint64_t new_raw_count = hw_raw_read_mapping[hwc->idx]();
> +       /*
> +        * Sign extend count value to 64bit, otherwise delta calculation
> +        * would be incorrect when overflow occurs.
> +        */
> +       uint64_t new_raw_count = sign_extend64(
> +                       hw_raw_read_mapping[hwc->idx](), csky_pmu.count_width);
csky_pmu.count_width - 1 ? we need index here.

Best Regards
 Guo Ren
