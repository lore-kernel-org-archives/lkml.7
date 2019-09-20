Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEFDC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED7F2070C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568971736;
	bh=ihjiVUv9GSb8O9idPtaSb9OO46g5Lg9zuTz9g7+Q6hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cOisY8x+DJzWfKyeRQ7qbpXXNwAeePenRq5Q6nq9KuAY1/xy6Us8jsAr+0sJAm/ri
	 36h1t4FbzlFGefGntJuWrgGHxSOonLREfqaAVKaoChpQQXdxAcavoOjD8t0X1uXyhG
	 s+J26ySC8HLIQPIa7stzEyR1w0766MHSt01G6+kE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405866AbfITJ2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 05:28:55 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33743 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405691AbfITJ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 05:28:55 -0400
Received: by mail-lf1-f65.google.com with SMTP id y127so4581232lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 02:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bG7+Pg8Q+CShjcdcuKpBik9DbTJfigLoE4b+qNvDbfA=;
        b=E/bZGR8zUyfxCRkRd0wvTvWIR7xIKg2fy/haL8Wi5uzYV0/6UyQGwf4RIMDpyfMszl
         bnqnojpY1rn7lwpEtyuUaXoI8qEMFwUTUrm9Vb2h71pbRRUtpSub9B7HCGcl9+Ka9TI8
         52880pshKW+fy9l0E4Ac1OmQP1wnZ4xOnDzkehsRNJ/nJGB9zQrgQ5zCKDRtnK3uMVb3
         ub/Y3tGIIt16ZcS8zFv5bFokNXIOj64yhCa4q78QQVLQgVgRyym5u59YsQCClf2tinjE
         7bmQcE/rrPDtyAaaY+hj1df3nAKDZzcH9xitoOmsWV1PnSID7ZjvVWgFCs9DtQz/NLd8
         fYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bG7+Pg8Q+CShjcdcuKpBik9DbTJfigLoE4b+qNvDbfA=;
        b=kN5JtkDAUGpagc8YhmL8BF0tAqgIdiYLL2Ton3drtyp9/KMsE6ZFbW0WKrqSTBSX5E
         qZXgAyF+ZwgIMrjBYBIqLz5qW315T3mQLt4sLl63wOXxghkdCGF9XopDQ636pyNMqRZI
         4PykTo5jcKuGs1saCKgCme0KoOeLsrIbazEXO8KmHRtbYFyCAGolHlTAoDeu9rDQiIuV
         CVjfh90+DxVUz6alYRzBZkQ2yrZb2oUjqrMXhxJpy6044zvuCuctdTP2OXJQv895Ba3m
         HScpWe1Z18BxOuiSSOXXP0vWVCgtIqOMfb87RoeOFfriwFsgB3Of7sl3h536Sg40RruJ
         O7/A==
X-Gm-Message-State: APjAAAXT5aWO7HkSZqWgPsHxSikncyP+0bt+PFEmE98TcKBL4r2S0sCU
        S03SSEnO1IwwvE56VXMCGhw=
X-Google-Smtp-Source: APXvYqw9GyJOm7OxHbSfNw3+sOxVnmYYmh6VTCqcmNGNXqhJtU/32l4PLWqPVm9tX9PI+2AmNf383Q==
X-Received: by 2002:ac2:4552:: with SMTP id j18mr8389273lfm.120.1568971733834;
        Fri, 20 Sep 2019 02:28:53 -0700 (PDT)
Received: from rric.localdomain (31-208-96-227.cust.bredband2.com. [31.208.96.227])
        by smtp.gmail.com with ESMTPSA id t4sm306236lji.40.2019.09.20.02.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Sep 2019 02:28:53 -0700 (PDT)
Date:   Fri, 20 Sep 2019 11:28:50 +0200
From:   Robert Richter <rric@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [PATCH 07/32] x86: Use pr_warn instead of pr_warning
Message-ID: <20190920092850.26usohzmatmqrlor@rric.localdomain>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
 <20190920062544.180997-8-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920062544.180997-8-wangkefeng.wang@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.09.19 14:25:19, Kefeng Wang wrote:
> As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
> pr_warning"), removing pr_warning so all logging messages use a
> consistent <prefix>_warn style. Let's do it.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Robert Richter <rric@kernel.org>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/x86/kernel/amd_gart_64.c          | 11 ++++---
>  arch/x86/kernel/apic/apic.c            | 41 ++++++++++++--------------
>  arch/x86/kernel/setup_percpu.c         |  4 +--
>  arch/x86/kernel/tboot.c                | 15 +++++-----
>  arch/x86/kernel/tsc_sync.c             |  8 ++---
>  arch/x86/kernel/umip.c                 |  6 ++--
>  arch/x86/mm/kmmio.c                    |  7 ++---
>  arch/x86/mm/mmio-mod.c                 |  6 ++--
>  arch/x86/mm/numa_emulation.c           |  4 +--
>  arch/x86/mm/testmmiotrace.c            |  6 ++--
>  arch/x86/oprofile/op_x86_model.h       |  6 ++--

For oprofile:

Acked-by: Robert Richter <rric@kernel.org>

But see below:

>  arch/x86/platform/olpc/olpc-xo15-sci.c |  2 +-
>  arch/x86/platform/sfi/sfi.c            |  3 +-
>  arch/x86/xen/setup.c                   |  2 +-
>  14 files changed, 57 insertions(+), 64 deletions(-)
> 
> diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
> index a585ea6f686a..53545c9c7cad 100644
> --- a/arch/x86/kernel/amd_gart_64.c
> +++ b/arch/x86/kernel/amd_gart_64.c

> @@ -665,7 +664,7 @@ static __init int init_amd_gatt(struct agp_kern_info *info)
>  
>   nommu:
>  	/* Should not happen anymore */
> -	pr_warning("PCI-DMA: More than 4GB of RAM and no IOMMU\n"
> +	pr_warn("PCI-DMA: More than 4GB of RAM and no IOMMU\n"
>  	       "falling back to iommu=soft.\n");

This indentation should be fixed too, while at it.

>  	return -1;
>  }

-Robert
