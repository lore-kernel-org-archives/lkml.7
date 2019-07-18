Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85804C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5864221783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i60kUnVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389828AbfGRKG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 06:06:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfGRKGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 06:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/kS2rXaksAmj+s4sQig9jjdPX4eWNwITjY+RW9O5jak=; b=i60kUnVXJLXTqH4dpM9I6Fmlw
        mnytrX+gEPFBLiL9AT19yLDetcuRrjN2l9xE3bPyurCs3I5+3uanIARk3L2IfLknWREvpigcMS6PO
        u8lIJ+qXQGtad9Dqwir0uGpUmw01uEtYC8Twi3i9E0AguB0xdU9p+BWQIhJVaB2jC9lBYFUt55FRw
        xiwwdyNm9CZH2/x+1sfpx/T80dd2YXMhA+jdLydVYFZ1lzX9TQUg8XquHYXZzZSzfERv680j8ovOm
        Jdhp798funmLjfb95M5SiZDJoD64U4u7PrNY2K6yzpYq0MBwSDSXCv0/5bdeXE8OlCx2AFCyAcuDK
        7JSa2BBRQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1ho3JO-0000Kx-K0; Thu, 18 Jul 2019 10:06:54 +0000
Date:   Thu, 18 Jul 2019 03:06:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 2/5] dma-buf: heaps: Add heap helpers
Message-ID: <20190718100654.GA19666@infradead.org>
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-3-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624194908.121273-3-john.stultz@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +void INIT_HEAP_HELPER_BUFFER(struct heap_helper_buffer *buffer,
> +			     void (*free)(struct heap_helper_buffer *))

Please use a lower case naming following the naming scheme for the
rest of the file.

> +static void *dma_heap_map_kernel(struct heap_helper_buffer *buffer)
> +{
> +	void *vaddr;
> +
> +	vaddr = vmap(buffer->pages, buffer->pagecount, VM_MAP, PAGE_KERNEL);
> +	if (!vaddr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return vaddr;
> +}

Unless I'm misreading the patches this is used for the same pages that
also might be dma mapped.  In this case you need to use
flush_kernel_vmap_range and invalidate_kernel_vmap_range in the right
places to ensure coherency between the vmap and device view.  Please
also document the buffer ownership, as this really can get complicated.

> +static vm_fault_t dma_heap_vm_fault(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct heap_helper_buffer *buffer = vma->vm_private_data;
> +
> +	vmf->page = buffer->pages[vmf->pgoff];
> +	get_page(vmf->page);
> +
> +	return 0;
> +}

Is there any exlusion between mmap / vmap and the device accessing
the data?  Without that you are going to run into a lot of coherency
problems.
