Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D351AC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 23:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34CC2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 23:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Z9RbQk9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfD2XuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 19:50:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45615 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbfD2XuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 19:50:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id i21so2479262pgi.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 16:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=iki8lEciOli5KOvhEgs9JNfHNGA2ZFukuxTBdMWWHqg=;
        b=Z9RbQk9f9/Px7IbWu4Gh/AbhBLH1/XY5qaP4iXWOCmDcvgzOpHbN9FfhX4JvspNEQJ
         Jx0GSeCf+B9lSir3UxYBQb3OOsHCNQQnirb4zuBR4E4gdALFi+3nR4MgVBiXrfWOVWRt
         TDe5iG2xuVMaaKSKVgatTMI1v03YB+Fg67QBZG4j2mbu4mPcAmDikXOOadBmqymfhDlK
         zFBlEHDkoUYhem00EIGOEKMQkwl0AWonW82q5zT/+GffjfXhSFYl6U7RdqM+NCOvRcXH
         WPgMrKCEGu1aR7Q5aDIttO8ku2+lVuXIYbHbeEBNBIqTXNHVQQkJxi1KnTECOZuRivTp
         f5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=iki8lEciOli5KOvhEgs9JNfHNGA2ZFukuxTBdMWWHqg=;
        b=NOfEPpx2d0q5GfUYS0QS5Sjv7vHb7L88qs/Z7hiBmixDWowdIOKVsYHb1Xt/mAiU0+
         h0QaAyuHYz+7tmIEBQ/UT4qvlRP4NbWbtirrEJTa6DNjxV2Vwqh3gfFWQj3EXE77y4dC
         ratfYsyZHgXMRqGof7ew11veB4vYEKdUEBdRa2JTtgyRRy5LLULWZWwd5lqzOzO7JS6T
         I/CS8QTmSIvlzkSSpc/fLs6vf6xWMeR3LaonwaqG19uye/jKZCgcw9vx8nks4MfxGaDs
         YoasF69lhRIYnmPGgQhdhYa1uzVPdn3Gp+2rhQtRTJeMkufRA6QFUs6ghPnhXsuUYtXQ
         Uqcw==
X-Gm-Message-State: APjAAAWLKsFPHVkfv7eYRPYxWCjucrPktNv8Ypj7E72yzqJ90YMfd3RX
        KdnhJ5qjlhH5jLWs4fmm0cjFUL1eI8uHAw==
X-Google-Smtp-Source: APXvYqwe6A2MY53MJJ1uot3hhk0ZU6yNlSb8vhR9KPE/rerJcUMCruUKZf3B4asJaZ1rBqcFeWpckw==
X-Received: by 2002:a63:6fcf:: with SMTP id k198mr61685712pgc.158.1556581804682;
        Mon, 29 Apr 2019 16:50:04 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id e13sm52032242pgb.37.2019.04.29.16.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 16:50:03 -0700 (PDT)
Date:   Mon, 29 Apr 2019 16:50:03 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 16:49:07 PDT (-0700)
Subject:     Re: [PATCH v3 2/3] RISC-V: Implement nosmp commandline option.
In-Reply-To: <20190424000227.3085-3-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, atish.patra@wdc.com,
        aou@eecs.berkeley.edu, schwab@suse.de, anup@brainfault.org,
        dmitriy@oss-tech.org, johan@kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de,
        Christoph Hellwig <hch@infradead.org>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     atish.patra@wdc.com
Message-ID: <mhng-56c3b718-eda9-4f5b-8124-7dee869fde1d@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 17:02:26 PDT (-0700), atish.patra@wdc.com wrote:
> nosmp command line option sets max_cpus to zero. No secondary harts
> will boot if this is enabled. But present cpu mask will still point to
> all possible masks.
>
> Fix present cpu mask for nosmp usecase.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/kernel/smpboot.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index eb533b5c2c8c..a8ad200581aa 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -47,6 +47,17 @@ void __init smp_prepare_boot_cpu(void)
>
>  void __init smp_prepare_cpus(unsigned int max_cpus)
>  {
> +	int cpuid;
> +
> +	/* This covers non-smp usecase mandated by "nosmp" option */
> +	if (max_cpus == 0)
> +		return;
> +
> +	for_each_possible_cpu(cpuid) {
> +		if (cpuid == smp_processor_id())
> +			continue;
> +		set_cpu_present(cpuid, true);
> +	}
>  }
>
>  void __init setup_smp(void)
> @@ -74,7 +85,6 @@ void __init setup_smp(void)
>
>  		cpuid_to_hartid_map(cpuid) = hart;
>  		set_cpu_possible(cpuid, true);
> -		set_cpu_present(cpuid, true);
>  		cpuid++;
>  	}

Thanks.  I've taken all three of these into for-next.
