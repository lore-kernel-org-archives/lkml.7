Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC3DC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2812173C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408911AbfFLKiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:38:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51727 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408930AbfFLKiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:38:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so6033611wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 03:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=A1jkMuy2ezqCdqyisgnv02b0t1awTPsqQ7eTgJGgrxg=;
        b=dD/2W5FpBEIoalknSO3MTwFyvZXcRU3d6LPIgqoSL4DLRm4Thw84yw0Be5Xqv5jxd3
         vjJmumiAgUKhqWs5dTWSVUauCBcbdtkqPh6GgaQ5xSemuT+7JO7HfOgyN8zKJcoD4H/S
         1I/6LTEhTlUpgp5S0JZFUnrioax4tPd8f6Yl/eVHHHtHl81yYtlhXGevYNQ10hFMldDG
         Nmh4dSF0eoz3whzejus8IA3eAbHlpDzZUxwznYgKCB8zbOefa1yq/ooHnUEmxc1V5Pa5
         bya3d+eNgO0H1WEbwuHF1fRWtxeWucin3UPCa1ecIEZkvZ/2+sPrjSbeIfN4EyucO51a
         H5tA==
X-Gm-Message-State: APjAAAUwUS8IIMFRuOFsMpwWGadpzwTFre407ahXlWYzFaXx4K6CfWg9
        vKupuHVYgoVJSosQ5X6wBU4ziQ==
X-Google-Smtp-Source: APXvYqxXO+6aHPpfLeLSipxttxiVN8qTTbQpyRvwqi+hESAewbXZNZZ6k/FIv5A28SvjTqPy+7RCkA==
X-Received: by 2002:a7b:cc09:: with SMTP id f9mr13723692wmh.68.1560335889404;
        Wed, 12 Jun 2019 03:38:09 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 6sm17809682wrd.51.2019.06.12.03.38.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 03:38:08 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maya Nakamura <m.maya.nakamura@gmail.com>
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Subject: Re: [PATCH v2 3/5] hv: vmbus: Replace page definition with Hyper-V specific one
In-Reply-To: <210c56ddb1dafc20ba289e6be9165efe8a5e818c.1559807514.git.m.maya.nakamura@gmail.com>
References: <cover.1559807514.git.m.maya.nakamura@gmail.com> <210c56ddb1dafc20ba289e6be9165efe8a5e818c.1559807514.git.m.maya.nakamura@gmail.com>
Date:   Wed, 12 Jun 2019 12:38:08 +0200
Message-ID: <87k1drdr73.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maya Nakamura <m.maya.nakamura@gmail.com> writes:

> Replace PAGE_SIZE with HV_HYP_PAGE_SIZE because the guest page size may
> not be 4096 on all architectures and Hyper-V always runs with a page
> size of 4096.
>
> Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
> ---
>  drivers/hv/hyperv_vmbus.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index e5467b821f41..5489b061d261 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -208,11 +208,11 @@ int hv_ringbuffer_read(struct vmbus_channel *channel,
>  		       u64 *requestid, bool raw);
>  
>  /*
> - * Maximum channels is determined by the size of the interrupt page
> - * which is PAGE_SIZE. 1/2 of PAGE_SIZE is for send endpoint interrupt
> - * and the other is receive endpoint interrupt
> + * Maximum channels, 16348, is determined by the size of the interrupt page,
> + * which is HV_HYP_PAGE_SIZE. 1/2 of HV_HYP_PAGE_SIZE is to send endpoint
> + * interrupt, and the other is to receive endpoint interrupt.
>   */
> -#define MAX_NUM_CHANNELS	((PAGE_SIZE >> 1) << 3)	/* 16348 channels */
> +#define MAX_NUM_CHANNELS	((HV_HYP_PAGE_SIZE >> 1) << 3)
>  
>  /* The value here must be in multiple of 32 */
>  /* TODO: Need to make this configurable */

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly
