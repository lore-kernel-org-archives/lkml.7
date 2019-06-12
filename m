Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B35C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464582082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408054AbfFLKgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:36:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39687 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406315AbfFLKgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:36:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so5968833wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 03:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=F2AOmZb2yguiGSmSU0nhevs48sI1vSX5WkrCsfTsjyQ=;
        b=uRyybPEz4Hz2+UVMXlYpC0r6dnErBYwu9/NcEQdk9+InexsF3K+Re2aEFjvPhXpr1X
         A2OFbhJd5dNJag4/oNJyIwbwj2/qXcA6KlIt9r4tM/j6jZp0aRH6x2w2yJHgQxoT0RK6
         dUwXisv5W+ppM4nxVqZHX5Uu4r+yhxxulu7w/XDUXwiMdLDjtkNEHTtTJgGBFxUA5Onu
         v2yCQr3JcAbC81yKdSHlIFdolCeS7bi73HeCyAj7wtVjf/YtVCMBvPVa2y/mhR9wkj7A
         ivv3dTz/XbCHmewrHdmKa47xZIQEMhHZJgmA1lKthKunGJ+z6YCVDBMOgkhp7FLje8a5
         F3AQ==
X-Gm-Message-State: APjAAAW39JVz3SBLfXulThbgV+yu0CNm1yHt/fq0wODmW5g/fS10CTlp
        yCeznvkPXiVfy7OfGtMVUVZu5w==
X-Google-Smtp-Source: APXvYqxNR2gVHhO6j5Y+UrOQNTZS2wito02Q/MeNcfwjcH9EZhZUbFaMW+BWDVTz7rkhc+WsLQVgMg==
X-Received: by 2002:a7b:c933:: with SMTP id h19mr22587462wml.52.1560335762925;
        Wed, 12 Jun 2019 03:36:02 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q21sm4318286wmq.13.2019.06.12.03.36.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 03:36:02 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maya Nakamura <m.maya.nakamura@gmail.com>
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Subject: Re: [PATCH v2 1/5] x86: hv: hyperv-tlfs.h: Create and use Hyper-V page definitions
In-Reply-To: <67be3e283c0f28326f9c31a64f399fe659ad5690.1559807514.git.m.maya.nakamura@gmail.com>
References: <cover.1559807514.git.m.maya.nakamura@gmail.com> <67be3e283c0f28326f9c31a64f399fe659ad5690.1559807514.git.m.maya.nakamura@gmail.com>
Date:   Wed, 12 Jun 2019 12:36:01 +0200
Message-ID: <87pnnjdram.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maya Nakamura <m.maya.nakamura@gmail.com> writes:

> Define HV_HYP_PAGE_SHIFT, HV_HYP_PAGE_SIZE, and HV_HYP_PAGE_MASK because
> the Linux guest page size and hypervisor page size concepts are
> different, even though they happen to be the same value on x86.
>
> Also, replace PAGE_SIZE with HV_HYP_PAGE_SIZE.
>
> Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index cdf44aa9a501..44bd68aefd00 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -12,6 +12,16 @@
>  #include <linux/types.h>
>  #include <asm/page.h>
>  
> +/*
> + * While not explicitly listed in the TLFS, Hyper-V always runs with a page size
> + * of 4096. These definitions are used when communicating with Hyper-V using
> + * guest physical pages and guest physical page addresses, since the guest page
> + * size may not be 4096 on all architectures.
> + */
> +#define HV_HYP_PAGE_SHIFT	12
> +#define HV_HYP_PAGE_SIZE	BIT(HV_HYP_PAGE_SHIFT)
> +#define HV_HYP_PAGE_MASK	(~(HV_HYP_PAGE_SIZE - 1))
> +
>  /*
>   * The below CPUID leaves are present if VersionAndFeatures.HypervisorPresent
>   * is set by CPUID(HvCpuIdFunctionVersionAndFeatures).
> @@ -841,7 +851,7 @@ union hv_gpa_page_range {
>   * count is equal with how many entries of union hv_gpa_page_range can
>   * be populated into the input parameter page.
>   */
> -#define HV_MAX_FLUSH_REP_COUNT ((PAGE_SIZE - 2 * sizeof(u64)) /	\
> +#define HV_MAX_FLUSH_REP_COUNT ((HV_HYP_PAGE_SIZE - 2 * sizeof(u64)) /	\
>  				sizeof(union hv_gpa_page_range))
>  
>  struct hv_guest_mapping_flush_list {

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly
