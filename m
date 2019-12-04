Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA52C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8932073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4ksMM3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfLDUdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:33:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36567 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727978AbfLDUdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 15:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575491616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VqWpHduLSdryiBD/wNg+ALzMYenu5uhkg+/MeSPFPhI=;
        b=Q4ksMM3EsINTgvVm+byGSUg2gZ1EPmBqUcbJrC60hVHJAEWiBUWVQVTeInLgAaMRtaNkgz
        fq/uDtmMfnDWGoM0e6mPxNwLakhVlCwjJbHwxE/DrgNRL8L8DuubowlNelAgrKLgsJj2mW
        Sp070uedlsf3OauBcXftI40IRPDQ1Vo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-HfkgTBmTMbqhyqD71Bm_DQ-1; Wed, 04 Dec 2019 15:33:35 -0500
Received: by mail-pj1-f72.google.com with SMTP id e7so488361pjt.22
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 12:33:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VqWpHduLSdryiBD/wNg+ALzMYenu5uhkg+/MeSPFPhI=;
        b=S5VPWBWzJ259CH2yAU821vC9EmI2548OxfrXFItnbghUVDCmM98Gn/7t1Ll5CFgft1
         L3YOMtEIJ4K7PaOZd8qk8KN/Tg+xK1m/X0Z0CR2B53iNMVK0ESYANadO3fsYr+m0We2y
         Zj5S93RorCHKIzEIyO0TPlKeNtNlITDkm8itMH5LjJhHhhpQS4SYu1ucUXSNEZs967/G
         sLXLndFSTvzWlZu1NmS2E/eF5MGMZkOrEtBq61oDKwOtZkLsy8HBiwnv6Mnia/aH1GE6
         fU5au4kY3m9tBg406mOdwkoWrhbgmS2o0i8doPx6n9u5qgTT/GPSAxvUkqGt/5QlcX8C
         VcSA==
X-Gm-Message-State: APjAAAUMhsBXZnzrd8MJjwas18307rPeeyePwV+V9X3MiG5ZOn5oE+du
        /thdX4fsY4119y0WWTq6Mv7zCNHuS0El0truHLnWCq3hA1aG3k6aGR5IHFc9FrOXXRA1CUZV/9w
        zYJDWXg66vdIr0tekpEedyQDT
X-Received: by 2002:a63:a508:: with SMTP id n8mr5357181pgf.278.1575491613893;
        Wed, 04 Dec 2019 12:33:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqwZ8ga+0nB8RcZ015GxrcjdELQpTQGHI2J3TBcNJcfd2TECtitej4fzrQmYOQ8647WmvK++NA==
X-Received: by 2002:a63:a508:: with SMTP id n8mr5357147pgf.278.1575491613580;
        Wed, 04 Dec 2019 12:33:33 -0800 (PST)
Received: from localhost.localdomain ([122.177.160.143])
        by smtp.gmail.com with ESMTPSA id k4sm1789624pfk.11.2019.12.04.12.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 12:33:32 -0800 (PST)
Subject: Re: [PATCH v2 1/3] libfdt: define UINT32_MAX in libfdt_env.h
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     kexec@lists.infradead.org, james.morse@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20191114051510.17037-1-takahiro.akashi@linaro.org>
 <20191114051510.17037-2-takahiro.akashi@linaro.org>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <aa35893d-fadc-be2a-1295-a986ced017fe@redhat.com>
Date:   Thu, 5 Dec 2019 02:03:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20191114051510.17037-2-takahiro.akashi@linaro.org>
Content-Language: en-US
X-MC-Unique: HfkgTBmTMbqhyqD71Bm_DQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 11/14/2019 10:45 AM, AKASHI Takahiro wrote:
> In the implementation of kexec_file_load-based kdump for arm64,
> fdt_appendprop_addrrange() will be used, but fdt_addresses.c
> will fail to compile due to missing UINT32_MAX.
> 
> So just define it in libfdt_env.h.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> ---
>   include/linux/libfdt_env.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/libfdt_env.h b/include/linux/libfdt_env.h
> index edb0f0c30904..9ca00f11d9b1 100644
> --- a/include/linux/libfdt_env.h
> +++ b/include/linux/libfdt_env.h
> @@ -3,6 +3,7 @@
>   #define LIBFDT_ENV_H
>   
>   #include <linux/kernel.h>	/* For INT_MAX */
> +#include <linux/limits.h>	/* For UINT32_MAX */
>   #include <linux/string.h>
>   
>   #include <asm/byteorder.h>
> @@ -11,6 +12,8 @@ typedef __be16 fdt16_t;
>   typedef __be32 fdt32_t;
>   typedef __be64 fdt64_t;
>   
> +#define UINT32_MAX U32_MAX
> +
>   #define fdt32_to_cpu(x) be32_to_cpu(x)
>   #define cpu_to_fdt32(x) cpu_to_be32(x)
>   #define fdt64_to_cpu(x) be64_to_cpu(x)
> 

With following upstream patches accepted already in Linus's tree (see 
[0] and [1]), so we can drop this patch from the v3:

[0] 26ed19adbab1 ("libfdt: reduce the number of headers included from 
libfdt_env.h")
[1] a8de1304b7df ("libfdt: define INT32_MAX and UINT32_MAX in libfdt_env.h")

Thanks,
Bhupesh

