Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8352EC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC3E216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T3t4EFAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfEHQjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:39:42 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38607 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfEHQjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:39:41 -0400
Received: by mail-io1-f68.google.com with SMTP id y6so17653129ior.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xu3J6eI9YLyb944dtXSWpBpCLJN0nrV0r6Vm0VQQ9gQ=;
        b=T3t4EFADgm+deSPmD7ufZCY5hGmKwOgHct0KLcslcbnCkpC1AL67cQgdcIw9SW0FNZ
         hW4ZHC9W/BgoxLIsXc4egBsLd6KplP2uJDramkLPJ5iQipJzckhpceum3LKqwRA+cMDA
         /Rk1sDFN+OEueV7uiaCm8B4KHisDvDtunqANHv5C8RpeH2sgzGu1k2w03tYujkVEEJOS
         ivGM+zc6xb/g33h6073ueh2TI0wkAhlCDNAIEqIVwEugYVlXxtnqaHFYdBpr5t6vOCHj
         4ni/CXM33+/XefpawlCA2TkiV9yyo/rdZAC3XG0hIAhkMOntWo5Js0HVQoSpYcL/7rSS
         ve4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xu3J6eI9YLyb944dtXSWpBpCLJN0nrV0r6Vm0VQQ9gQ=;
        b=Qo3WLIvnbckMu1QJimpljIGdV+A5jMyFKEGOLSrvO7z2KNK1nkVPyGCR1X2pAb9JSs
         BZTZwsMsLOGwUeRi2rgqaw48mGBYlTR2JcA3mnXNE75CQzxUeFB7CfB1oFLa4k2Gk5q+
         Q1lry4weQCV6CWyq8mZb23ON8V4ZiWNZb6GDL1VqsUQ+K+HEK1Zrnud47BnTCsoDVAOZ
         mLUP75HonPrfx8Y9bmU2EZF/Z9gU0b5UhovSNI1o2yN+e/2I0RBBzOGM81ex/VutOOSW
         X14S8LsguNuN6QahxWZGqC6ynWs7CrNQbsUdRAWeIwM7gbiWI1dRY5ZTKXW3Nv2+P7vJ
         SH8Q==
X-Gm-Message-State: APjAAAWQT0x/NPa1keEccPJRI8yDAI3zsyoWVU/bDnnYFh9SBUrFVT8t
        g9kC2UwuZOfDLuPhK5kPxdLX0KbvbwYQU1ZqBtQDHW3o
X-Google-Smtp-Source: APXvYqznO+r3GY4eu2dyOQXLeapEbXWlznUlhxXvlK5nhKconmio83XGvtE2VgAT/1UhV6MP0P+4rJaLxXgPsMc+FAU=
X-Received: by 2002:a6b:6d06:: with SMTP id a6mr10717892iod.11.1557333580937;
 Wed, 08 May 2019 09:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <1556899459-27785-1-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1556899459-27785-1-git-send-email-suzuki.poulose@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 8 May 2019 10:39:30 -0600
Message-ID: <CANLsYkyxDY8g9zyhTyTqALgF5dmVX1F7DA_93ECpnvAaACYX8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] coresight: Do not call smp_processor_id() from preemptible
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Fri, 3 May 2019 at 10:04, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Instead of using smp_processor_id() to figure out the node,
> use the numa_node_id() for the current CPU node to avoid
> splats like :
>
>  BUG: using smp_processor_id() in preemptible [00000000] code: perf/1743
>  caller is alloc_etr_buf.isra.6+0x80/0xa0
>  CPU: 1 PID: 1743 Comm: perf Not tainted 5.1.0-rc6-147786-g116841e #344
>  Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Feb  1 2019
>   Call trace:
>    dump_backtrace+0x0/0x150
>    show_stack+0x14/0x20
>    dump_stack+0x9c/0xc4
>    debug_smp_processor_id+0x10c/0x110
>    alloc_etr_buf.isra.6+0x80/0xa0
>    tmc_alloc_etr_buffer+0x12c/0x1f0
>    etm_setup_aux+0x1c4/0x230
>    rb_alloc_aux+0x1b8/0x2b8
>    perf_mmap+0x35c/0x478
>    mmap_region+0x34c/0x4f0
>    do_mmap+0x2d8/0x418
>    vm_mmap_pgoff+0xd0/0xf8
>    ksys_mmap_pgoff+0x88/0xf8
>    __arm64_sys_mmap+0x28/0x38
>    el0_svc_handler+0xd8/0x138
>    el0_svc+0x8/0xc
>

That is very interesting...

> Fixes: 855ab61c16bf70b646 ("coresight: tmc-etr: Refactor function tmc_etr_setup_perf_buf()")
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 793639f..74578bd 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1323,13 +1323,11 @@ static struct etr_perf_buffer *
>  tmc_etr_setup_perf_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
>                        int nr_pages, void **pages, bool snapshot)
>  {
> -       int node, cpu = event->cpu;
> +       int node;
>         struct etr_buf *etr_buf;
>         struct etr_perf_buffer *etr_perf;
>
> -       if (cpu == -1)
> -               cpu = smp_processor_id();
> -       node = cpu_to_node(cpu);
> +       node = (event->cpu == -1)? numa_node_id() : cpu_to_node(event->cpu);

Seems to me using numa_node_id() simply circumvent function
debug_smp_processor_id() and using get_cpu() and put_cpu() would be
more appropriate.  But I'll trust the NUMA people have thought about
this long before me.  Would you mind sending another revision that fix
the same code for ETB and ETF?

Thanks,
Mathieu

>
>         etr_perf = kzalloc_node(sizeof(*etr_perf), GFP_KERNEL, node);
>         if (!etr_perf)
> --
> 2.7.4
>
