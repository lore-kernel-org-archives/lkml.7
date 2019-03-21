Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65CCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701882183E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H13JTAYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfCUUfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:35:22 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59458 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbfCUUfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:35:22 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2LKZBoM111007;
        Thu, 21 Mar 2019 15:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553200511;
        bh=8EB4pwzpi/5uZX2UpyrhROnNLUB21aYbj943IX6vshI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=H13JTAYlmier44kew1KAhuOdm1P79/REqTDhMA8hVQHGpXOv3fVdG/B5UQT95Zo+k
         jNlCYtH7fWqJX7f3SEFUtP8wzjDpDSy/bAN9s4VjzJ3pkLJ7DRzvSkZWyGWC91MTs0
         wyN9o/QFhafLRNVgC+zceiSPazX2I2ABQcXueMkc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2LKZBlH092809
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Mar 2019 15:35:11 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 21
 Mar 2019 15:35:11 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Thu, 21 Mar 2019 15:35:11 -0500
Received: from [10.250.67.168] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2LKZAF3029073;
        Thu, 21 Mar 2019 15:35:10 -0500
Subject: Re: [RFC][PATCH 2/5 v2] dma-buf: heaps: Add heap helpers
To:     Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-3-git-send-email-john.stultz@linaro.org>
 <20190319142604.f6puq3ugxrcxsrjs@DESKTOP-E1NTVVP.localdomain>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <9be37cc0-6eae-9bae-d8ee-89a91d7a4d89@ti.com>
Date:   Thu, 21 Mar 2019 15:35:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190319142604.f6puq3ugxrcxsrjs@DESKTOP-E1NTVVP.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/19 9:26 AM, Brian Starkey wrote:
> Hi John,
> 
> On Tue, Mar 05, 2019 at 12:54:30PM -0800, John Stultz wrote:
> 
> ...
> 
>> +
>> +void dma_heap_buffer_destroy(struct dma_heap_buffer *heap_buffer)
>> +{
>> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
>> +
>> +	if (buffer->kmap_cnt > 0) {
>> +		pr_warn_once("%s: buffer still mapped in the kernel\n",
>> +			     __func__);
> 
> Could be worth something louder like a full WARN.
> 
>> +		vunmap(buffer->vaddr);
>> +	}
>> +
>> +	buffer->free(buffer);
>> +}
>> +
> 
> ...
> 
>> +
>> +static void *dma_heap_dma_buf_kmap(struct dma_buf *dmabuf,
>> +					unsigned long offset)
>> +{
>> +	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
>> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
>> +
>> +	return buffer->vaddr + offset * PAGE_SIZE;
> 
> I think it'd be good to check for NULL vaddr and return NULL in that
> case. Less chance of an invalid pointer being accidentally used then.
> 

Why do we assume vaddr is set at all here? I'm guessing we expected
dma_heap_map_kernel to have been called, that is not going to always be
the case. kmap should perform it's own single page kmap here and not
rely on the clunky full buffer vmap (which is probably broken on 32bit
systems here when the buffers are large).

Andrew

> Thanks,
> -Brian
> 
