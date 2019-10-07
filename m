Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2355DC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F3C20867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ANrNw1ik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbfJGVVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 17:21:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41042 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbfJGVVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 17:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N5EcAmKjzPUXozCqPG1kX/cDR4yO/jPB64zcL2DCNeY=; b=ANrNw1ikjbWO3futfL+1WVHL8
        QSJs5oZujkWlghJJ0qq4RQ00Kcw0cYIf0SqEoB5kiNDn6Bf6Nwy/l0I/+ur7XrHSxwxf8veOgmrgR
        8FwsrZuHma7vRG2EVwkJOB5f7mGzFbxCs/5EbtGw4SEzrQ9tq1Q3caFBgvSCxF4kvn1Pkv2KHKocU
        Dgolk7MNOh+vVKSSsjYVUg+5FA9ms9FpQKk9a9jIz7QP/C2AQuMcTcXnuc5sIW0hqdkJQMaGe5Ei+
        viHJi22wWdlZvi8SRLmQ6CYZgmM0RrCt78sUJiontCuaTXRzjpfMLufs6Fb+e/XuWQGdalJ2tK3j9
        P5xK5v2Rg==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHaRg-0007ca-D6; Mon, 07 Oct 2019 21:21:32 +0000
Subject: Re: [PATCH v10 1/5] dma-buf: Add dma-buf heaps framework
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Hillf Danton <hdanton@sina.com>,
        dri-devel@lists.freedesktop.org
References: <20191007211830.42838-1-john.stultz@linaro.org>
 <20191007211830.42838-2-john.stultz@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ad064efe-4d86-3b81-ace2-152e90c72e94@infradead.org>
Date:   Mon, 7 Oct 2019 14:21:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191007211830.42838-2-john.stultz@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/19 2:18 PM, John Stultz wrote:
> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index a23b6752d11a..6e9c7c4d7447 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -44,4 +44,13 @@ config DMABUF_SELFTESTS
>  	default n
>  	depends on DMA_SHARED_BUFFER
>  
> +menuconfig DMABUF_HEAPS
> +	bool "DMA-BUF Userland Memory Heaps"
> +	select DMA_SHARED_BUFFER
> +	help
> +	  Choose this option to enable the DMA-BUF userland memory heaps,

	                                                           heaps.

> +	  this options creates per heap chardevs in /dev/dma_heap/ which

	  This

> +	  allows userspace to use to allocate dma-bufs that can be shared

??	                   to allocate & use

> +	  between drivers.
> +
>  endmenu


-- 
~Randy
