Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4482DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B332075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfKKH5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 02:57:38 -0500
Received: from spam01.hygon.cn ([110.188.70.11]:17136 "EHLO spam1.hygon.cn"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726808AbfKKH5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 02:57:38 -0500
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam1.hygon.cn with ESMTP id xAB7rSnO056256;
        Mon, 11 Nov 2019 15:53:28 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-FE.hygon.cn with ESMTP id xAB7rM6t085027;
        Mon, 11 Nov 2019 15:53:22 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from [172.20.21.12] (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Mon, 11 Nov
 2019 15:53:23 +0800
Subject: Re: [PATCH] NTB: ntb_perf: Fix address err in perf_copy_chunk
To:     Logan Gunthorpe <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        <jdmason@kudzu.us>
CC:     <allenbh@gmail.com>, <dave.jiang@intel.com>
References: <1573097913-104555-1-git-send-email-linjiasen@hygon.cn>
 <7ea7ef5d-7e46-396a-8d70-2c6c333a4508@deltatee.com>
From:   Jiasen Lin <linjiasen@hygon.cn>
Message-ID: <8973e56c-ccce-2884-f4dc-4d0f8072a948@hygon.cn>
Date:   Mon, 11 Nov 2019 15:51:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <7ea7ef5d-7e46-396a-8d70-2c6c333a4508@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam1.hygon.cn xAB7rSnO056256
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/9 1:04, Logan Gunthorpe wrote:
> 
> 
> On 2019-11-06 8:38 p.m., Jiasen Lin wrote:
>> peer->outbuf is a virtual address which is get by ioremap, it can not
>> be converted to a physical address by virt_to_page and page_to_phys.
>> This conversion will result in DMA error, because the destination address
>> which is converted by page_to_phys is invalid.
> 
> Hmm, yes, ntb_perf is obviously wrong. I never noticed this, how did
> this ever work?
> 

The default value of use_dma which is used to enable DMA engine to 
measure NTB performance is zero, in other words, DMA engine is not used 
by default. Thus, olny memcpy_toio is called in perf_copy_chunk and not 
trigger this bug.

If we install driver with specified dma-enabled flag like this:
insmod ntb_perf.ko use_dma=1, this issue will be triggered.

>> We Save the physical address in perf_setup_peer_mw, it is MMIO address
>> of NTB BARx. Then fill the destination address of DMA descriptor with
>> this physical address to guarantee that the address of memory write
>> requests fall in memory window of NBT BARx.
> 
> Using the physical address directly is also wrong and will not work in
> the presence of an IOMMU. You should use dma_map_resource() for this.
> See what was done in ntb_transport[1].
> 

Yes, my mistake. I will modify the code according to your suggestion and 
test it on AMD and HYGON platforms with the IOMMU enabled. Maybe the 
following patches are relied on, when IOMMU is enabled on AMD and HYGON 
plartforms.

https://lore.kernel.org/patchwork/cover/1143155/
https://lore.kernel.org/patchwork/patch/1143156/
https://lore.kernel.org/patchwork/patch/1143157/

Thanks,

Jiasen Lin

> Thanks,
> 
> Logan
> 
> [1] c59666bb32b9 ("NTB: ntb_transport: Ensure the destination buffer is
> mapped for TX DMA")
> 
>> Signed-off-by: Jiasen Lin <linjiasen@hygon.cn>
>> ---
>>   drivers/ntb/test/ntb_perf.c | 28 +++++++++++++++++++++++-----
>>   1 file changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
>> index e9b7c2d..1c2fd1a 100644
>> --- a/drivers/ntb/test/ntb_perf.c
>> +++ b/drivers/ntb/test/ntb_perf.c
>> @@ -149,6 +149,7 @@ struct perf_peer {
>>   	u64 outbuf_xlat;
>>   	resource_size_t outbuf_size;
>>   	void __iomem *outbuf;
>> +	phys_addr_t out_phys_addr;
>>   
>>   	/* Inbound MW params */
>>   	dma_addr_t inbuf_xlat;
>> @@ -776,7 +777,8 @@ static void perf_dma_copy_callback(void *data)
>>   }
>>   
>>   static int perf_copy_chunk(struct perf_thread *pthr,
>> -			   void __iomem *dst, void *src, size_t len)
>> +			   void __iomem *dst, void *src, size_t len,
>> +			   phys_addr_t dst_phys_addr)
>>   {
>>   	struct dma_async_tx_descriptor *tx;
>>   	struct dmaengine_unmap_data *unmap;
>> @@ -807,8 +809,7 @@ static int perf_copy_chunk(struct perf_thread *pthr,
>>   	}
>>   	unmap->to_cnt = 1;
>>   
>> -	unmap->addr[1] = dma_map_page(dma_dev, virt_to_page(dst),
>> -		offset_in_page(dst), len, DMA_FROM_DEVICE);
>> +	unmap->addr[1] = dst_phys_addr;
>>   	if (dma_mapping_error(dma_dev, unmap->addr[1])) {
>>   		ret = -EIO;
>>   		goto err_free_resource;
>> @@ -901,6 +902,8 @@ static int perf_run_test(struct perf_thread *pthr)
>>   	u64 total_size, chunk_size;
>>   	void *flt_src;
>>   	int ret = 0;
>> +	phys_addr_t flt_phys_addr;
>> +	phys_addr_t bnd_phys_addr;
>>   
>>   	total_size = 1ULL << total_order;
>>   	chunk_size = 1ULL << chunk_order;
>> @@ -909,12 +912,15 @@ static int perf_run_test(struct perf_thread *pthr)
>>   	flt_src = pthr->src;
>>   	bnd_dst = peer->outbuf + peer->outbuf_size;
>>   	flt_dst = peer->outbuf;
>> +	bnd_phys_addr = peer->out_phys_addr + peer->outbuf_size;
>> +	flt_phys_addr = peer->out_phys_addr;
>>   
>>   	pthr->duration = ktime_get();
>>   
>>   	/* Copied field is cleared on test launch stage */
>>   	while (pthr->copied < total_size) {
>> -		ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size);
>> +		ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size,
>> +				flt_phys_addr);
>>   		if (ret) {
>>   			dev_err(&perf->ntb->dev, "%d: Got error %d on test\n",
>>   				pthr->tidx, ret);
>> @@ -925,8 +931,15 @@ static int perf_run_test(struct perf_thread *pthr)
>>   
>>   		flt_dst += chunk_size;
>>   		flt_src += chunk_size;
>> -		if (flt_dst >= bnd_dst || flt_dst < peer->outbuf) {
>> +		flt_phys_addr += chunk_size;
>> +
>> +		if (flt_dst >= bnd_dst ||
>> +		    flt_dst < peer->outbuf ||
>> +		    flt_phys_addr >= bnd_phys_addr ||
>> +		    flt_phys_addr < peer->out_phys_addr) {
>> +
>>   			flt_dst = peer->outbuf;
>> +			flt_phys_addr = peer->out_phys_addr;
>>   			flt_src = pthr->src;
>>   		}
>>   
>> @@ -1195,6 +1208,9 @@ static ssize_t perf_dbgfs_read_info(struct file *filep, char __user *ubuf,
>>   			"\tOut buffer addr 0x%pK\n", peer->outbuf);
>>   
>>   		pos += scnprintf(buf + pos, buf_size - pos,
>> +			"\tOut buff phys addr %pa[p]\n", &peer->out_phys_addr);
>> +
>> +		pos += scnprintf(buf + pos, buf_size - pos,
>>   			"\tOut buffer size %pa\n", &peer->outbuf_size);
>>   
>>   		pos += scnprintf(buf + pos, buf_size - pos,
>> @@ -1388,6 +1404,8 @@ static int perf_setup_peer_mw(struct perf_peer *peer)
>>   	if (!peer->outbuf)
>>   		return -ENOMEM;
>>   
>> +	peer->out_phys_addr = phys_addr;
>> +
>>   	if (max_mw_size && peer->outbuf_size > max_mw_size) {
>>   		peer->outbuf_size = max_mw_size;
>>   		dev_warn(&peer->perf->ntb->dev,
>>
