Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A21C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D44520721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfKUDKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:10:51 -0500
Received: from spam01.hygon.cn ([110.188.70.11]:21574 "EHLO spam2.hygon.cn"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbfKUDKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:10:51 -0500
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam2.hygon.cn with ESMTP id xAL37FXW036107;
        Thu, 21 Nov 2019 11:07:15 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-FE.hygon.cn with ESMTP id xAL372eZ030228;
        Thu, 21 Nov 2019 11:07:02 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from [172.20.21.12] (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Thu, 21 Nov
 2019 11:07:10 +0800
Subject: Re: [PATCH v2] NTB: ntb_perf: Fix address err in perf_copy_chunk
To:     Logan Gunthorpe <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        <jdmason@kudzu.us>
CC:     <allenbh@gmail.com>, <dave.jiang@intel.com>
References: <1574136121-7941-1-git-send-email-linjiasen@hygon.cn>
 <c487042e-471b-dd99-37a6-2119b4115283@deltatee.com>
From:   Jiasen Lin <linjiasen@hygon.cn>
Message-ID: <c09e061e-43ba-773f-a964-1ff629e06cb5@hygon.cn>
Date:   Thu, 21 Nov 2019 11:04:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c487042e-471b-dd99-37a6-2119b4115283@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam2.hygon.cn xAL37FXW036107
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/20 0:50, Logan Gunthorpe wrote:
> 
> 
> On 2019-11-18 9:02 p.m., Jiasen Lin wrote:
>> peer->outbuf is a virtual address which is get by ioremap, it can not
>> be converted to a physical address by virt_to_page and page_to_phys.
>> This conversion will result in DMA error, because the destination address
>> which is converted by page_to_phys is invalid.
>>
>> This patch save the MMIO address of NTB BARx in perf_setup_peer_mw,
>> and map the BAR space to DMA address after we assign the DMA channel.
>> Then fill the destination address of DMA descriptor with this DMA address
>> to guarantee that the address of memory write requests fall into
>> memory window of NBT BARx with IOMMU enabled and disabled.
>>
>> Changes since v1:
>>    * Map NTB BARx MMIO address to DMA address after assign the DMA channel,
>>      to ensure the destination address in valid. (per suggestion from Logan)
>>
>> Fixes: 5648e56d03fa ("NTB: ntb_perf: Add full multi-port NTB API support")
>> Signed-off-by: Jiasen Lin <linjiasen@hygon.cn>
> 
> Thanks, looks good to me except for the one nit below.
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> 
>> ---
>>   drivers/ntb/test/ntb_perf.c | 69 ++++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 56 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
>> index e9b7c2d..dfca7e1 100644
>> --- a/drivers/ntb/test/ntb_perf.c
>> +++ b/drivers/ntb/test/ntb_perf.c
>> @@ -149,7 +149,8 @@ struct perf_peer {
>>   	u64 outbuf_xlat;
>>   	resource_size_t outbuf_size;
>>   	void __iomem *outbuf;
>> -
>> +	phys_addr_t out_phys_addr;
>> +	dma_addr_t dma_dst_addr;
>>   	/* Inbound MW params */
>>   	dma_addr_t inbuf_xlat;
>>   	resource_size_t inbuf_size;
>> @@ -776,7 +777,8 @@ static void perf_dma_copy_callback(void *data)
>>   }
>>   
>>   static int perf_copy_chunk(struct perf_thread *pthr,
>> -			   void __iomem *dst, void *src, size_t len)
>> +			   void __iomem *dst, void *src, size_t len,
>> +			   dma_addr_t dst_dma_addr)
>>   {
>>   	struct dma_async_tx_descriptor *tx;
>>   	struct dmaengine_unmap_data *unmap;
>> @@ -807,8 +809,7 @@ static int perf_copy_chunk(struct perf_thread *pthr,
>>   	}
>>   	unmap->to_cnt = 1;
>>   
>> -	unmap->addr[1] = dma_map_page(dma_dev, virt_to_page(dst),
>> -		offset_in_page(dst), len, DMA_FROM_DEVICE);
>> +	unmap->addr[1] = dst_dma_addr;
>>   	if (dma_mapping_error(dma_dev, unmap->addr[1])) {
>>   		ret = -EIO;
>>   		goto err_free_resource;
>> @@ -865,6 +866,7 @@ static int perf_init_test(struct perf_thread *pthr)
>>   {
>>   	struct perf_ctx *perf = pthr->perf;
>>   	dma_cap_mask_t dma_mask;
>> +	struct perf_peer *peer = pthr->perf->test_peer;
>>   
>>   	pthr->src = kmalloc_node(perf->test_peer->outbuf_size, GFP_KERNEL,
>>   				 dev_to_node(&perf->ntb->dev));
>> @@ -882,15 +884,33 @@ static int perf_init_test(struct perf_thread *pthr)
>>   	if (!pthr->dma_chan) {
>>   		dev_err(&perf->ntb->dev, "%d: Failed to get DMA channel\n",
>>   			pthr->tidx);
>> -		atomic_dec(&perf->tsync);
>> -		wake_up(&perf->twait);
>> -		kfree(pthr->src);
>> -		return -ENODEV;
>> +		goto err_free;
>> +	}
>> +	peer->dma_dst_addr =
>> +		dma_map_resource(pthr->dma_chan->device->dev,
>> +				 peer->out_phys_addr, peer->outbuf_size,
>> +				 DMA_FROM_DEVICE, 0);
>> +	if (dma_mapping_error(pthr->dma_chan->device->dev,
>> +			      peer->dma_dst_addr)) {
>> +		dev_err(pthr->dma_chan->device->dev, "%d: Failed to map DMA addr\n",
>> +			pthr->tidx);
>> +		peer->dma_dst_addr = 0;
>> +		dma_release_channel(pthr->dma_chan);
>> +		goto err_free;
>>   	}
>> +	dev_dbg(pthr->dma_chan->device->dev, "%d: Map MMIO %pa to DMA addr %pad\n",
>> +			pthr->tidx,
>> +			&peer->out_phys_addr,
>> +			&peer->dma_dst_addr);
>>   
>>   	atomic_set(&pthr->dma_sync, 0);
>> -
>>   	return 0;
>> +
>> +err_free:
>> +	atomic_dec(&perf->tsync);
>> +	wake_up(&perf->twait);
>> +	kfree(pthr->src);
>> +	return -ENODEV;
>>   }
>>   
>>   static int perf_run_test(struct perf_thread *pthr)
>> @@ -901,6 +921,8 @@ static int perf_run_test(struct perf_thread *pthr)
>>   	u64 total_size, chunk_size;
>>   	void *flt_src;
>>   	int ret = 0;
>> +	dma_addr_t flt_dma_addr;
>> +	dma_addr_t bnd_dma_addr;
>>   
>>   	total_size = 1ULL << total_order;
>>   	chunk_size = 1ULL << chunk_order;
>> @@ -910,11 +932,15 @@ static int perf_run_test(struct perf_thread *pthr)
>>   	bnd_dst = peer->outbuf + peer->outbuf_size;
>>   	flt_dst = peer->outbuf;
>>   
>> +	flt_dma_addr = peer->dma_dst_addr;
>> +	bnd_dma_addr = peer->dma_dst_addr + peer->outbuf_size;
>> +
>>   	pthr->duration = ktime_get();
>>   
>>   	/* Copied field is cleared on test launch stage */
>>   	while (pthr->copied < total_size) {
>> -		ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size);
>> +		ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size,
>> +				flt_dma_addr);
>>   		if (ret) {
>>   			dev_err(&perf->ntb->dev, "%d: Got error %d on test\n",
>>   				pthr->tidx, ret);
>> @@ -925,8 +951,15 @@ static int perf_run_test(struct perf_thread *pthr)
>>   
>>   		flt_dst += chunk_size;
>>   		flt_src += chunk_size;
>> -		if (flt_dst >= bnd_dst || flt_dst < peer->outbuf) {
>> +		flt_dma_addr += chunk_size;
>> +
>> +		if (flt_dst >= bnd_dst ||
>> +		    flt_dst < peer->outbuf ||
>> +		    flt_dma_addr >= bnd_dma_addr ||
> 
> Nit: I'm pretty sure the check against bnd_dma_addr is redundant with
> the check on bnd_dst.
> 

Maybe, it would be better to calculate destination address in version 3 
patch. It will be reduce one input argument for perf_copy_chunk, so 
flt_dma_addr and bnd_dma_addr are no longer needed.
Take a look at this link:
https://lore.kernel.org/patchwork/patch/1156715/

Thanks,
Jiasen Lin

>> +		    flt_dma_addr < peer->dma_dst_addr) {
>> +
>>   			flt_dst = peer->outbuf;
>> +			flt_dma_addr = peer->dma_dst_addr;
>>   			flt_src = pthr->src;
>>   		}
>>   
>> @@ -978,8 +1011,13 @@ static void perf_clear_test(struct perf_thread *pthr)
>>   	 * We call it anyway just to be sure of the transfers completion.
>>   	 */
>>   	(void)dmaengine_terminate_sync(pthr->dma_chan);
>> -
>> -	dma_release_channel(pthr->dma_chan);
>> +	if (pthr->perf->test_peer->dma_dst_addr)
>> +		dma_unmap_resource(pthr->dma_chan->device->dev,
>> +				   pthr->perf->test_peer->dma_dst_addr,
>> +				   pthr->perf->test_peer->outbuf_size,
>> +				   DMA_FROM_DEVICE, 0);
>> +	if (pthr->dma_chan)
>> +		dma_release_channel(pthr->dma_chan);
>>   
>>   no_dma_notify:
>>   	atomic_dec(&perf->tsync);
>> @@ -1195,6 +1233,9 @@ static ssize_t perf_dbgfs_read_info(struct file *filep, char __user *ubuf,
>>   			"\tOut buffer addr 0x%pK\n", peer->outbuf);
>>   
>>   		pos += scnprintf(buf + pos, buf_size - pos,
>> +			"\tOut buff phys addr %pa[p]\n", &peer->out_phys_addr);
>> +
>> +		pos += scnprintf(buf + pos, buf_size - pos,
>>   			"\tOut buffer size %pa\n", &peer->outbuf_size);
>>   
>>   		pos += scnprintf(buf + pos, buf_size - pos,
>> @@ -1388,6 +1429,8 @@ static int perf_setup_peer_mw(struct perf_peer *peer)
>>   	if (!peer->outbuf)
>>   		return -ENOMEM;
>>   
>> +	peer->out_phys_addr = phys_addr;
>> +
>>   	if (max_mw_size && peer->outbuf_size > max_mw_size) {
>>   		peer->outbuf_size = max_mw_size;
>>   		dev_warn(&peer->perf->ntb->dev,
>>
