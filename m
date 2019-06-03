Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B82CC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A11E27212
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVXt972j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfFCT3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:29:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34078 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFCT3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:29:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so3016097plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XjbgWtoecpGGajCSSxHkoYg0HmkkYE0g6rtDFZJfqLM=;
        b=aVXt972j+L4QJiEfQu9yr9mHi5NHN1WOMWIQZ0VhO/k4Y+NVMjTZKbIZQ9w+A3J55Y
         BQSwuX/Jvgk2KwytF567CvYv4/bqZ8+E4IW0GXiLmpdt3lGZ1AMIF6ZQxiH6IiacZKRh
         QFDE+hIpEw0KQDaoFae4M/TDkVXeFYx4CkYNzcFASTDTkE6cniX/id0RMVqNVocpTj0c
         wsFYEFub/ywol1MOSNLsQVTN750ucmNxYvoDpKis8RQmY59V5+AnW6xdXlFnEUDNVBBc
         EArKbtntvQk1kG9VOjhbRMMPGSreb0hekgCqKWxpH0hL1RsNBwrvaYKpqUSgjMQ753yI
         /AWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XjbgWtoecpGGajCSSxHkoYg0HmkkYE0g6rtDFZJfqLM=;
        b=JbrDAKktqAlYg3zh3fnU2+v5RLh+mNPs0u8uOLGSB+hyBsg/7bd/vvFcpjfBEd2I+F
         mxHdqnO5jljocmXkPnvnR62qQvWLYjMbLj/hNamN8HwMgFyXtJfM0Nn4Y6aiV8sJJTZ7
         NJ1DzBOJgqq7RlQ9bP7Sncxpp8DIsN2s3UoRBRjJaW+YSbpZbtY7X/qhbILzYv5wvg9C
         XqAD/hX7kYPGjsxmPdESVlN9HE0t64iXCkdawVf1puMsDMh+mkXZUfU8kDTj9OBajI0S
         +xbYuxMlu9kRPnB6V+XjEbWIzskEoaGoJYx3nCpfRKn8vt5h/YEaVfNo/8h07cwiW1ki
         22pQ==
X-Gm-Message-State: APjAAAXwtq+yzT/MAeOM2/0sF4nqoc+XSYPBTSm0u50fKAdx9B/bU4Yy
        IWy/ZZGRrMC2PbbsBu+uGPbeT8bKgHA=
X-Google-Smtp-Source: APXvYqytyDKluUAQxYCRbUH9nLXS/merzNWi5SCHyS7kQ56eMr5A31BrUtpLE/l2IiEjLGoxkEEOvA==
X-Received: by 2002:a17:902:728b:: with SMTP id d11mr2108640pll.78.1559590145287;
        Mon, 03 Jun 2019 12:29:05 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id n35sm14099984pgl.44.2019.06.03.12.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 12:29:04 -0700 (PDT)
Date:   Mon, 3 Jun 2019 13:29:02 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, robin.murphy@arm.com
Subject: Re: [PATCH v3 1/4] coresight: tmc-etr: Do not call
 smp_processor_id() from preemptible
Message-ID: <20190603192902.GB20462@xps15>
References: <1559235267-25232-1-git-send-email-suzuki.poulose@arm.com>
 <1559235267-25232-2-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559235267-25232-2-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 05:54:24PM +0100, Suzuki K Poulose wrote:
> Instead of using smp_processor_id() to figure out the node,
> use the numa_node_id() for the current CPU node to avoid
> splats like :

I was in the process of applying this set when I noticed the changelogs are
still referring to numa_node_id(), which is not part of the solution anymore.
Please address in all 4 patches.

Mathieu

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
> Fixes: 855ab61c16bf70b646 ("coresight: tmc-etr: Refactor function tmc_etr_setup_perf_buf()")
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index ce0114a..7c81f63 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1323,13 +1323,11 @@ static struct etr_perf_buffer *
>  tmc_etr_setup_perf_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
>  		       int nr_pages, void **pages, bool snapshot)
>  {
> -	int node, cpu = event->cpu;
> +	int node;
>  	struct etr_buf *etr_buf;
>  	struct etr_perf_buffer *etr_perf;
>  
> -	if (cpu == -1)
> -		cpu = smp_processor_id();
> -	node = cpu_to_node(cpu);
> +	node = (event->cpu == -1) ? NUMA_NO_NODE : cpu_to_node(event->cpu);
>  
>  	etr_perf = kzalloc_node(sizeof(*etr_perf), GFP_KERNEL, node);
>  	if (!etr_perf)
> -- 
> 2.7.4
> 
