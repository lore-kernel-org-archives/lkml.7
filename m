Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848D6C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BA32146E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="cvvPy4qm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393320AbfIYUyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:54:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41712 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfIYUyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:54:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id n1so105327qtp.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P6vLeWnEYqV4tFnfzAqHfzzX8+aSxpM96Owo5DNjiwE=;
        b=cvvPy4qmHWKzDPqCIFjhh0dlq+VQiiZ6DxghvXz1mj3vqovV8bcPvXBc5fYoumFwuY
         +v3t+nkNu08B/qmVmFEK1IytWWuVftihw4lZx0xc4nYknmGliYIAZwl4MCMRp4ihlRcT
         eoqVImNRbxNiszuqciUnNyJNHs+rzudJs6r4pTBMKWA58IYjdrC2J8J/Iwgwh2Paf94y
         S5jc8MWaPzsVqsJYGPSoIwXdryOcSDytFfzGCGhPzkONNoJ3fY30TMqDbnqXHX9UKrJq
         40N4DczjLuMZY3z9E74eOLrSWzX8Nw50jClP1Hq+VMtZpZsMzVSQ+VezZxSrC8IfcvB2
         VA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P6vLeWnEYqV4tFnfzAqHfzzX8+aSxpM96Owo5DNjiwE=;
        b=d3iLYSt3i5r3EOcF9wr/NqfoeKwKoA5emkAcVUD1XGmuaAPyW9Bqp4xrr8AlPRVEib
         wwHrkf9B/2hTAYnDpoDbApx+qZK1+GqxeYSXV300WqX4Gu4rdDXE60CWwt6YgWWApH0V
         ymsakRtEsc/1IarYlZd7cP00Mn8V+FvQ2wHuW8sip7LFMfFiBRbV/j9JU1wFpQ65tkw1
         lmhlm+ZWJQgOCdcE5yqhyo4K2t77boIoP0pW/5waGiSV1q/NEX1xw7XJBHPHZ/U7loDF
         PzwPz3xu5o3N5C8g548ugsen8Ku6CnlGkb6TB4dv77dTe3Czb01GYvo6/4F5TYpR6xxs
         L+dQ==
X-Gm-Message-State: APjAAAXffvmZa1EJZAtH2dtXzGgFoHGQJk0dC/IZU0a6TXBHaGHHQty4
        j3qU3q+KWZyW/BEJryHz24tcgQ==
X-Google-Smtp-Source: APXvYqxGtU5QiJ2aaPvFP090kvgM+ZkYHsKw1Fm1HsrE4goEw1nRTxM7VqyGqTd3m3ABAknVQVKcCA==
X-Received: by 2002:a05:6214:1231:: with SMTP id p17mr1482204qvv.170.1569444879267;
        Wed, 25 Sep 2019 13:54:39 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q64sm3140720qkb.32.2019.09.25.13.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 13:54:38 -0700 (PDT)
Message-ID: <1569444877.5576.232.camel@lca.pw>
Subject: Re: [PATCH] dma/coherent: remove unused dma_get_device_base()
From:   Qian Cai <cai@lca.pw>
To:     hch@lst.de
Cc:     m.szyprowski@samsung.com, robin.murphy@arm.com,
        vladimir.murzin@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 25 Sep 2019 16:54:37 -0400
In-Reply-To: <1568725242-2433-1-git-send-email-cai@lca.pw>
References: <1568725242-2433-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping. Please take a look at this trivial patch.

On Tue, 2019-09-17 at 09:00 -0400, Qian Cai wrote:
> dma_get_device_base() was first introduced in the commit c41f9ea998f3
> ("drivers: dma-coherent: Account dma_pfn_offset when used with device
> tree"). Later, it was removed by the commit 43fc509c3efb ("dma-coherent:
> introduce interface for default DMA pool")
> 
> Found by the -Wunused-function compilation warning.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  kernel/dma/coherent.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
> index 29fd6590dc1e..909b38e1c29b 100644
> --- a/kernel/dma/coherent.c
> +++ b/kernel/dma/coherent.c
> @@ -28,15 +28,6 @@ static inline struct dma_coherent_mem *dev_get_coherent_memory(struct device *de
>  	return NULL;
>  }
>  
> -static inline dma_addr_t dma_get_device_base(struct device *dev,
> -					     struct dma_coherent_mem * mem)
> -{
> -	if (mem->use_dev_dma_pfn_offset)
> -		return (mem->pfn_base - dev->dma_pfn_offset) << PAGE_SHIFT;
> -	else
> -		return mem->device_base;
> -}
> -
>  static int dma_init_coherent_memory(phys_addr_t phys_addr,
>  		dma_addr_t device_addr, size_t size,
>  		struct dma_coherent_mem **mem)
