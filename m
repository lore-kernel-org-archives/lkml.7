Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B43CC31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8012D20874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408866AbfFLKgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:36:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52717 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408253AbfFLKgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:36:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so6029973wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 03:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iB7poecQTyOsB8cRpdZU55/OXu7pHm3+QgOZegkblOA=;
        b=RinAxVF0nn3BgErIz6g3jFZ4X2kXZfqiqsyAsho7boVRauD90R4MCJg3vNTmDYFhdV
         C8hlzOUu/7wj8Ow+5zzJnC/pUE6E9m3saMQ5dIcO5YdrW1FolE8CPm/OyRP5qwsqH9FP
         I6RjE2Qp/w++ZhK3hj1xdoyJajjRm++w8I0KKoL0bn7AeERoypP9tFdFkukA6KgzsReZ
         QxVIaKwy0pWSB/I8m+6CdEarQedm0Pap4QKfis8dBYl1/tXJjLoK6LxEqVKIBmAQ6Am2
         HnGimfumSuiiTRjyPcEVLQSZm5ioS06suayxXSA6eUlVlZttnK7PxO+cPDP6Cc4KH5pP
         E8rQ==
X-Gm-Message-State: APjAAAX5CiJc/M+NXkW+sflNgQIPqarKgeoXMQrP58iG9m4CTjtlRqBm
        fYaksbC8XIzX6kr2ELAoWyI5ebj2t3E=
X-Google-Smtp-Source: APXvYqy2Lghsff9p2s0NVwakfOM4HR5RGFJK7Z2VwhreSAptAgNhXLLGpYIKpQpgKAuNvJTn5PVdng==
X-Received: by 2002:a1c:a6d1:: with SMTP id p200mr22496960wme.169.1560335808470;
        Wed, 12 Jun 2019 03:36:48 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q15sm9705618wrr.19.2019.06.12.03.36.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 03:36:48 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maya Nakamura <m.maya.nakamura@gmail.com>
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Subject: Re: [PATCH v2 2/5] x86: hv: hv_init.c: Add functions to allocate/deallocate page for Hyper-V
In-Reply-To: <5cf4ad6f3fae8dec33e364b367b99cbb5b0f2ba4.1559807514.git.m.maya.nakamura@gmail.com>
References: <cover.1559807514.git.m.maya.nakamura@gmail.com> <5cf4ad6f3fae8dec33e364b367b99cbb5b0f2ba4.1559807514.git.m.maya.nakamura@gmail.com>
Date:   Wed, 12 Jun 2019 12:36:47 +0200
Message-ID: <87muindr9c.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maya Nakamura <m.maya.nakamura@gmail.com> writes:

> Introduce two new functions, hv_alloc_hyperv_page() and
> hv_free_hyperv_page(), to allocate/deallocate memory with the size and
> alignment that Hyper-V expects as a page. Although currently they are
> not used, they are ready to be used to allocate/deallocate memory on x86
> when their ARM64 counterparts are implemented, keeping symmetry between
> architectures with potentially different guest page sizes.
>
> Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
> ---
>  arch/x86/hyperv/hv_init.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index e4ba467a9fc6..84baf0e9a2d4 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -98,6 +98,20 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
>  u32 hv_max_vp_index;
>  EXPORT_SYMBOL_GPL(hv_max_vp_index);
>  
> +void *hv_alloc_hyperv_page(void)
> +{
> +	BUILD_BUG_ON(!(PAGE_SIZE == HV_HYP_PAGE_SIZE));

(nit)

PAGE_SIZE != HV_HYP_PAGE_SIZE ?

> +
> +	return (void *)__get_free_page(GFP_KERNEL);
> +}
> +EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
> +
> +void hv_free_hyperv_page(unsigned long addr)
> +{
> +	free_page(addr);
> +}
> +EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
> +
>  static int hv_cpu_init(unsigned int cpu)
>  {
>  	u64 msr_vp_index;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly
