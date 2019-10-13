Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F89AC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 11:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340D62084D
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 11:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfJMLwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 07:52:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728620AbfJMLwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 07:52:34 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4B805AFF8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 11:52:33 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id w198so14134956qka.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 04:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jwWOYBcdL+FwVmThH20DZa26zpPO65kQYvR5F6FTbNE=;
        b=NjBX+/++SODgXc6i15Y+svy77ulRNxnJe93xk0gxC93FzPfaYYQ3fHIXi3wZ6p73jE
         7w4aUY0RP2Ie2JzQNhLcgjhX7r8glVhyMMNQte8zivvEarFTpgx/o30Jnramve1G/lxw
         eMKt8Y81A5yMOLFM3DKS6hgAwCBzyE9m0mS7KuSK6on4tCzywc2As6WiCLcZ5vTRf6j0
         frSX7Hl5YYyHe4trZOKZxM9vXEGGx5duBMXSGJGwqKZDgfPmJ7FR8h1qJXSr0P8tIAL4
         sY/DxIcCq8LSvMPoOjJFsXFSjc+3+FwCT6oPsfRZwq4egBbJlwAwWXp2obuKtY2K91xT
         lAvg==
X-Gm-Message-State: APjAAAVUDyL5ftuPKqzSDzhzXftSrjMM7fL5FG+2XzZfrYMdx61v+8Ds
        dRSgBRwhsi84ri0cVTzn+QprSY0CbW+9GQksEW81WxgPAOPxdKYlGyFcFDEeBy2V4Zd4JEDLohv
        hVdpSDYeGB6CReoRxuNOhWSKy
X-Received: by 2002:ac8:145:: with SMTP id f5mr27764094qtg.44.1570967552663;
        Sun, 13 Oct 2019 04:52:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxN/2XdDR7sYa6uOVIhJGXLQk/ZKI4RjasPsuZJqmI3iyCmuePxmDioaM2ULCIpeXuq/AD/vQ==
X-Received: by 2002:ac8:145:: with SMTP id f5mr27764084qtg.44.1570967552501;
        Sun, 13 Oct 2019 04:52:32 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id c14sm7871766qta.80.2019.10.13.04.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 04:52:31 -0700 (PDT)
Date:   Sun, 13 Oct 2019 07:52:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jan Kiszka <jan.kiszka@web.de>
Cc:     Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/virtio: Fix build
Message-ID: <20191013075107-mutt-send-email-mst@kernel.org>
References: <4b686914-075b-a0a9-c97b-9def82ee0336@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b686914-075b-a0a9-c97b-9def82ee0336@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2019 at 11:03:30AM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Various changes in the recent kernel versions broke the build due to
> missing function and header stubs.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Thanks!
I think it's already fixes in the vhost tree.
That tree also includes a bugfix for the test.
Can you pls give it a spin and report?
Thanks!

> ---
>  tools/virtio/crypto/hash.h       | 0
>  tools/virtio/linux/dma-mapping.h | 2 ++
>  tools/virtio/linux/kernel.h      | 2 ++
>  3 files changed, 4 insertions(+)
>  create mode 100644 tools/virtio/crypto/hash.h
> 
> diff --git a/tools/virtio/crypto/hash.h b/tools/virtio/crypto/hash.h
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/tools/virtio/linux/dma-mapping.h b/tools/virtio/linux/dma-mapping.h
> index f91aeb5fe571..db96cb4bf877 100644
> --- a/tools/virtio/linux/dma-mapping.h
> +++ b/tools/virtio/linux/dma-mapping.h
> @@ -29,4 +29,6 @@ enum dma_data_direction {
>  #define dma_unmap_single(...) do { } while (0)
>  #define dma_unmap_page(...) do { } while (0)
> 
> +#define dma_max_mapping_size(d)	0
> +
>  #endif
> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> index 6683b4a70b05..ccf321173210 100644
> --- a/tools/virtio/linux/kernel.h
> +++ b/tools/virtio/linux/kernel.h
> @@ -141,4 +141,6 @@ static inline void free_page(unsigned long addr)
>  #define list_for_each_entry(a, b, c) while (0)
>  /* end of stubs */
> 
> +#define xen_domain() 0
> +
>  #endif /* KERNEL_H */
> --
> 2.16.4
