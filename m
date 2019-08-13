Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21E9C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870822067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NfTsfbgV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfHMRoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 13:44:05 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34782 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfHMRoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 13:44:05 -0400
Received: by mail-ot1-f66.google.com with SMTP id c7so3173886otp.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 10:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=e//tFyHxvVn4RxWw0GV+f727CP/Uza8Mg4HOvjD9WwM=;
        b=NfTsfbgV5WGpTvlyy9A2mUGXaPdLqooU2lc+4m1FQdAHncqrJoJ61g1Z/JBUHlUuFo
         +dA4vaoxJ7F+AQcVHAKmchrxWvSscoyuSUif6QJ0ONNejw3dWzOxsSa1qEqhuwI5pEdz
         u/uBFATnFPuT5dIsF6QYDaDvDP6kZJffd6sQqhyDTwHgzxET4apWFXmw8w1hjDkuZi7s
         ilIa0b46bfzxj+OcIFG+xqhYhiVnO8tIJjLYRY+CjN4z2RiC2V97fHg2bEaBh/2/7P7h
         3B+qDE8umFimLohSegAxkrj35As+rRFinFw7yZgAYV6yEdkBpPQPPWoQFXtlvOhaZkYu
         GVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=e//tFyHxvVn4RxWw0GV+f727CP/Uza8Mg4HOvjD9WwM=;
        b=H+1Fpzpyr9/96tUXlPitta8n1mYX3YZig/ZPZVVd9XWwIp1xL7AeDph1lYs2Z60Ixb
         ZiBBmhaJ8MHSLT8gjUx5rbIbOhNY4ueSuqhKpUw6Vxpmlek9Qa7VwKSQdqODX7oVHGw3
         miX5uxxGa0tZOAVHhChhmYZD6h61B1eKx/O0LtKGyyBrQiXaFiy5Cw9QY24kaDqFOR1i
         +P9KarzQ91Hg5RVmW+A2WRDofBoaMwCptODzdFXvioLbmIgyzHPswvdxP1yOBD32vDLJ
         pEjPFHU9Oreoh+cECZu6QTiCW7vZ0GwAGvcwb5NzI0l8WJ/ENTbyQWbL6tcbmu255HMp
         Wi9g==
X-Gm-Message-State: APjAAAWry1WRWJ/dpCTTpgHL0bJ6NDiCyjEVIzmre8R/XWQD/x865GLV
        T9nCxz2z6qKBRWpNI4hmhDjkbkQwvuM=
X-Google-Smtp-Source: APXvYqycnXJThie+s/45ClHCc8Nm2hhnBi6KBWzn8Vazilpo9gUuJDafqhZi+w14fYjO2RKqUobGyA==
X-Received: by 2002:a02:cb51:: with SMTP id k17mr9208388jap.4.1565718243824;
        Tue, 13 Aug 2019 10:44:03 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id s3sm88083226iob.49.2019.08.13.10.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 10:44:03 -0700 (PDT)
Date:   Tue, 13 Aug 2019 10:44:02 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org
cc:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] irqchip/sifive-plic: set max threshold for ignored
 handlers
In-Reply-To: <20190813154747.24256-2-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1908131032260.30024@viisi.sifive.com>
References: <20190813154747.24256-1-hch@lst.de> <20190813154747.24256-2-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas, Jason, Marc,

On Tue, 13 Aug 2019, Christoph Hellwig wrote:

> When running in M-mode we still the S-mode plic handlers in the DT.
> Ignore them by setting the maximum threshold.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

If you're happy with this, could one of you ack it so we can merge it 
with the rest of this series through the RISC-V tree?

thanks

- Paul

> ---
>  drivers/irqchip/irq-sifive-plic.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index cf755964f2f8..c72c036aea76 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -244,6 +244,7 @@ static int __init plic_init(struct device_node *node,
>  		struct plic_handler *handler;
>  		irq_hw_number_t hwirq;
>  		int cpu, hartid;
> +		u32 threshold = 0;
>  
>  		if (of_irq_parse_one(node, i, &parent)) {
>  			pr_err("failed to parse parent for context %d.\n", i);
> @@ -266,10 +267,16 @@ static int __init plic_init(struct device_node *node,
>  			continue;
>  		}
>  
> +		/*
> +		 * When running in M-mode we need to ignore the S-mode handler.
> +		 * Here we assume it always comes later, but that might be a
> +		 * little fragile.
> +		 */
>  		handler = per_cpu_ptr(&plic_handlers, cpu);
>  		if (handler->present) {
>  			pr_warn("handler already present for context %d.\n", i);
> -			continue;
> +			threshold = 0xffffffff;
> +			goto done;
>  		}
>  
>  		handler->present = true;
> @@ -279,8 +286,9 @@ static int __init plic_init(struct device_node *node,
>  		handler->enable_base =
>  			plic_regs + ENABLE_BASE + i * ENABLE_PER_HART;
>  
> +done:
>  		/* priority must be > threshold to trigger an interrupt */
> -		writel(0, handler->hart_base + CONTEXT_THRESHOLD);
> +		writel(threshold, handler->hart_base + CONTEXT_THRESHOLD);
>  		for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
>  			plic_toggle(handler, hwirq, 0);
>  		nr_handlers++;
> -- 
> 2.20.1
> 
> 

