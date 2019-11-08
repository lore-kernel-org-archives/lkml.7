Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1837C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C860B206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbfKHREm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:04:42 -0500
Received: from ale.deltatee.com ([207.54.116.67]:46266 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729847AbfKHREl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:04:41 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1iT7ga-0008P8-D6; Fri, 08 Nov 2019 10:04:37 -0700
To:     Jiasen Lin <linjiasen@hygon.cn>, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com, jdmason@kudzu.us
Cc:     allenbh@gmail.com, dave.jiang@intel.com
References: <1573097913-104555-1-git-send-email-linjiasen@hygon.cn>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7ea7ef5d-7e46-396a-8d70-2c6c333a4508@deltatee.com>
Date:   Fri, 8 Nov 2019 10:04:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573097913-104555-1-git-send-email-linjiasen@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: dave.jiang@intel.com, allenbh@gmail.com, jdmason@kudzu.us, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linjiasen@hygon.cn
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] NTB: ntb_perf: Fix address err in perf_copy_chunk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-11-06 8:38 p.m., Jiasen Lin wrote:
> peer->outbuf is a virtual address which is get by ioremap, it can not
> be converted to a physical address by virt_to_page and page_to_phys.
> This conversion will result in DMA error, because the destination address
> which is converted by page_to_phys is invalid.

Hmm, yes, ntb_perf is obviously wrong. I never noticed this, how did
this ever work?

> We Save the physical address in perf_setup_peer_mw, it is MMIO address
> of NTB BARx. Then fill the destination address of DMA descriptor with
> this physical address to guarantee that the address of memory write
> requests fall in memory window of NBT BARx.

Using the physical address directly is also wrong and will not work in
the presence of an IOMMU. You should use dma_map_resource() for this.
See what was done in ntb_transport[1].

Thanks,

Logan

[1] c59666bb32b9 ("NTB: ntb_transport: Ensure the destination buffer is
mapped for TX DMA")

> Signed-off-by: Jiasen Lin <linjiasen@hygon.cn>
> ---
>  drivers/ntb/test/ntb_perf.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index e9b7c2d..1c2fd1a 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -149,6 +149,7 @@ struct perf_peer {
>  	u64 outbuf_xlat;
>  	resource_size_t outbuf_size;
>  	void __iomem *outbuf;
> +	phys_addr_t out_phys_addr;
>  
>  	/* Inbound MW params */
>  	dma_addr_t inbuf_xlat;
> @@ -776,7 +777,8 @@ static void perf_dma_copy_callback(void *data)
>  }
>  
>  static int perf_copy_chunk(struct perf_thread *pthr,
> -			   void __iomem *dst, void *src, size_t len)
> +			   void __iomem *dst, void *src, size_t len,
> +			   phys_addr_t dst_phys_addr)
>  {
>  	struct dma_async_tx_descriptor *tx;
>  	struct dmaengine_unmap_data *unmap;
> @@ -807,8 +809,7 @@ static int perf_copy_chunk(struct perf_thread *pthr,
>  	}
>  	unmap->to_cnt = 1;
>  
> -	unmap->addr[1] = dma_map_page(dma_dev, virt_to_page(dst),
> -		offset_in_page(dst), len, DMA_FROM_DEVICE);
> +	unmap->addr[1] = dst_phys_addr;
>  	if (dma_mapping_error(dma_dev, unmap->addr[1])) {
>  		ret = -EIO;
>  		goto err_free_resource;
> @@ -901,6 +902,8 @@ static int perf_run_test(struct perf_thread *pthr)
>  	u64 total_size, chunk_size;
>  	void *flt_src;
>  	int ret = 0;
> +	phys_addr_t flt_phys_addr;
> +	phys_addr_t bnd_phys_addr;
>  
>  	total_size = 1ULL << total_order;
>  	chunk_size = 1ULL << chunk_order;
> @@ -909,12 +912,15 @@ static int perf_run_test(struct perf_thread *pthr)
>  	flt_src = pthr->src;
>  	bnd_dst = peer->outbuf + peer->outbuf_size;
>  	flt_dst = peer->outbuf;
> +	bnd_phys_addr = peer->out_phys_addr + peer->outbuf_size;
> +	flt_phys_addr = peer->out_phys_addr;
>  
>  	pthr->duration = ktime_get();
>  
>  	/* Copied field is cleared on test launch stage */
>  	while (pthr->copied < total_size) {
> -		ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size);
> +		ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size,
> +				flt_phys_addr);
>  		if (ret) {
>  			dev_err(&perf->ntb->dev, "%d: Got error %d on test\n",
>  				pthr->tidx, ret);
> @@ -925,8 +931,15 @@ static int perf_run_test(struct perf_thread *pthr)
>  
>  		flt_dst += chunk_size;
>  		flt_src += chunk_size;
> -		if (flt_dst >= bnd_dst || flt_dst < peer->outbuf) {
> +		flt_phys_addr += chunk_size;
> +
> +		if (flt_dst >= bnd_dst ||
> +		    flt_dst < peer->outbuf ||
> +		    flt_phys_addr >= bnd_phys_addr ||
> +		    flt_phys_addr < peer->out_phys_addr) {
> +
>  			flt_dst = peer->outbuf;
> +			flt_phys_addr = peer->out_phys_addr;
>  			flt_src = pthr->src;
>  		}
>  
> @@ -1195,6 +1208,9 @@ static ssize_t perf_dbgfs_read_info(struct file *filep, char __user *ubuf,
>  			"\tOut buffer addr 0x%pK\n", peer->outbuf);
>  
>  		pos += scnprintf(buf + pos, buf_size - pos,
> +			"\tOut buff phys addr %pa[p]\n", &peer->out_phys_addr);
> +
> +		pos += scnprintf(buf + pos, buf_size - pos,
>  			"\tOut buffer size %pa\n", &peer->outbuf_size);
>  
>  		pos += scnprintf(buf + pos, buf_size - pos,
> @@ -1388,6 +1404,8 @@ static int perf_setup_peer_mw(struct perf_peer *peer)
>  	if (!peer->outbuf)
>  		return -ENOMEM;
>  
> +	peer->out_phys_addr = phys_addr;
> +
>  	if (max_mw_size && peer->outbuf_size > max_mw_size) {
>  		peer->outbuf_size = max_mw_size;
>  		dev_warn(&peer->perf->ntb->dev,
> 
