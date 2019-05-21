Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE5DC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DA72173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfEUMCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 08:02:40 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40264 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfEUMCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:02:39 -0400
Received: by mail-qk1-f193.google.com with SMTP id q197so10834436qke.7;
        Tue, 21 May 2019 05:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFHpERDGAM7rYKa/XXAMVPCU2p7ieNvbmiVwbMmHz6o=;
        b=J7csQ2EyXN5MA9+ERyPqulTgBOzYTO3OU25CWnCnnnR249XtZCaYgiQtWYUcnFhyd0
         NsylALsY1NZ6yOwJJQAykAOTNE16ecjiLSMKVq4sqH1WPLD2MG6pz0jQYKZ7N5oVKEYG
         ieCXNLD7tjey47F589gYEMjBBuucwfZs4uKcQkYt7pS92sEbfU7UQ63NsNLyzw5f+WjJ
         n0SlKgptlDL2m93jtg/KxB0aesQ75EB44wbUeqLfS8VrDAjQue5KZXxMUjvsh0qgEz7d
         lwaLW4B+hpQiV4ZlWe166NJgQ1OHDcgaK7qBIYsI0M9UiOEeWmOCImdQQDCediybjsgb
         kZCQ==
X-Gm-Message-State: APjAAAVVn7U3BK7wAlRJBedJ99LlZjEDpu8mgbJ6BZqQ2TzCYB0LxOVW
        DuqBiMT/iV7jz6N1zVj09RWla0VhraHe3Y8QdKE=
X-Google-Smtp-Source: APXvYqz+JNxFrC1K8efOBIeJxisvtNkhhdYJVswIOoiVcFFJwa08OrBzOczrjY+m5IfqdGqcpIBYRLgf3CiTps9SNfc=
X-Received: by 2002:a05:620a:1085:: with SMTP id g5mr46695715qkk.182.1558440159035;
 Tue, 21 May 2019 05:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <1558383565-11821-1-git-send-email-eajames@linux.ibm.com> <1558383565-11821-3-git-send-email-eajames@linux.ibm.com>
In-Reply-To: <1558383565-11821-3-git-send-email-eajames@linux.ibm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 May 2019 14:02:22 +0200
Message-ID: <CAK8P3a2HSOsw33VhAk4Z8ARiYn4jG68Ec7fynKbrFWUNDo37Wg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] drivers/soc: Add Aspeed XDMA Engine Driver
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 10:19 PM Eddie James <eajames@linux.ibm.com> wrote:
> diff --git a/include/uapi/linux/aspeed-xdma.h b/include/uapi/linux/aspeed-xdma.h
> new file mode 100644
> index 0000000..2a4bd13
> --- /dev/null
> +++ b/include/uapi/linux/aspeed-xdma.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* Copyright IBM Corp 2019 */
> +
> +#ifndef _UAPI_LINUX_ASPEED_XDMA_H_
> +#define _UAPI_LINUX_ASPEED_XDMA_H_
> +
> +#include <linux/types.h>
> +
> +/*
> + * aspeed_xdma_op
> + *
> + * upstream: boolean indicating the direction of the DMA operation; upstream
> + *           means a transfer from the BMC to the host
> + *
> + * host_addr: the DMA address on the host side, typically configured by PCI
> + *            subsystem
> + *
> + * len: the size of the transfer in bytes; it should be a multiple of 16 bytes
> + */
> +struct aspeed_xdma_op {
> +       __u32 upstream;
> +       __u64 host_addr;
> +       __u32 len;
> +};
> +
> +#endif /* _UAPI_LINUX_ASPEED_XDMA_H_ */

If this is a user space interface, please remove the holes in the
data structure.

I don't see how this is actually used in this patch, maybe you meant
the definition to be part of another patch?

    Arnd
