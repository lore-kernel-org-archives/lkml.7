Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522E3C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C62208D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="fK8robB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfKSKwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 05:52:02 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44921 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfKSKwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 05:52:01 -0500
Received: by mail-vs1-f68.google.com with SMTP id j85so13861104vsd.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 02:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YzykAgzqBASxD+Sf3WzDkQESPdZCVRtMU0601lbZ+QA=;
        b=fK8robB6LDhqEsKEVJTuYw4VxW5gVbD04EykOxsoQeWS2+pZG42RtxQpE86dNn0lF5
         txSCEEd0BoMaBpM8BbQSay80/bW2VGVK1GVlJ8VCDZFWnI7VKnlznB48f7oeYkgX7qx6
         RrI7svDsdDbRY0k44Hf8Co5JNBj3v75ZcrLXTge66yU+SpFBBDuhiD6Kv1NMJ7GuJqs8
         C90yf3uFMXyBI7+2iOdD5al/4geQu+U818P64lUV3Ozr/nLBqKGZfpMAeKHapUprny3x
         XVI7qCHVVB3RCqcfBHPEILJ+IBd3Tt6Ekn+Du0aIp9sCen5AEsUd4wY7sIPGbb+fOoFb
         CNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YzykAgzqBASxD+Sf3WzDkQESPdZCVRtMU0601lbZ+QA=;
        b=drLMZQ913e6IFpsA3qJWaOHFh6ALwMGzmdAq6ll/wbcYH9z0bfnDa30rHlzkpOZLzx
         lILSNL1ysyd6Rfe3KbVIEKuNXSGWQlpJ6BduspQpJpq/Mydvicq85bEwjqO5KOHb359b
         bjKPHgtH9y3Jx/8oJiJl6N+pjdX+8ahd2NfJjVRaTo3l3DDWN/DsLCHSIYPu8qBZ3kw8
         b9qkN2EjjGtRHbiMRERtJtwe4cvK737jgJT5Q5i6SeOLrVtMs+jS/khm9AZmfQQLfMFz
         rgHr2C0rWtytC/aPxSxClz/NivY19WISWraAKfuiIotNdVCaDNBQ3U37Y80XFBDFXK53
         6Icg==
X-Gm-Message-State: APjAAAWsYIA7bRfHmTqIrBr5pjLk22juNmlNH2YtlBl2+fGfpZk3gAI4
        9cNrtnNN7k+A0mWnf9Nn7vLHaa7umW6+HJYh679RXw==
X-Google-Smtp-Source: APXvYqz8dwnzyEFExemdu3fSoWRusVa1ltsskcmAflNz2vv+Uy9nKgjrOxxmJZTp7vco8nmaBna14+AqpeNfM8gb8GA=
X-Received: by 2002:a67:eb91:: with SMTP id e17mr20497351vso.95.1574160720519;
 Tue, 19 Nov 2019 02:52:00 -0800 (PST)
MIME-Version: 1.0
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org> <1572979786-20361-5-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1572979786-20361-5-git-send-email-thara.gopinath@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 19 Nov 2019 16:21:49 +0530
Message-ID: <CAHLCerMqyAwbW3xCe2AgJ-Q=Knyf6kTcgJSK6s1E04d9Ydgj0g@mail.gmail.com>
Subject: Re: [Patch v5 4/6] sched/fair: update cpu_capcity to reflect thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, ionela.voinescu@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, qperret@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 12:20 AM Thara Gopinath
<thara.gopinath@linaro.org> wrote:
>
> cpu_capacity relflects the maximum available capacity of a cpu. Thermal

s/relflects/reflects

> pressure on a cpu means this maximum available capacity is reduced. This
> patch reduces the average thermal pressure for a cpu from its maximum
> available capacity so that cpu_capacity reflects the actual
> available capacity.
>
> Other signals that are deducted from cpu_capacity to reflect the actual
> capacity available are rt and dl util_avg. util_avg tracks a binary signal
> and uses the weights 1024 and 0. Whereas thermal pressure is tracked
> using load_avg. load_avg uses the actual "delta" capacity as the weight.

Consider rephrasing as,

Currently, effective cpu capacity is calculated by deducting RT and DL
average utilization (util_avg) from cpu_capacity. For thermal
pressure, we use load_avg instead of util_avg which is a binary signal
(0 or 1024) because <put why here>


> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  kernel/sched/fair.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9fb0494..5f6c371 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7738,6 +7738,7 @@ static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
>
>         used = READ_ONCE(rq->avg_rt.util_avg);
>         used += READ_ONCE(rq->avg_dl.util_avg);
> +       used += READ_ONCE(rq->avg_thermal.load_avg);
>
>         if (unlikely(used >= max))
>                 return 1;
> --
> 2.1.4
>
