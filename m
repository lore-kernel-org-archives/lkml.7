Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFA8C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEA720679
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKKQ7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:59:09 -0500
Received: from ale.deltatee.com ([207.54.116.67]:41668 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfKKQ7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:59:09 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1iUD1s-00083M-Nn; Mon, 11 Nov 2019 09:59:05 -0700
To:     Jiasen Lin <linjiasen@hygon.cn>, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com, jdmason@kudzu.us
Cc:     allenbh@gmail.com, dave.jiang@intel.com
References: <1573097913-104555-1-git-send-email-linjiasen@hygon.cn>
 <7ea7ef5d-7e46-396a-8d70-2c6c333a4508@deltatee.com>
 <8973e56c-ccce-2884-f4dc-4d0f8072a948@hygon.cn>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c340cb9e-9dcc-39f7-1e12-198ad2a47861@deltatee.com>
Date:   Mon, 11 Nov 2019 09:59:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8973e56c-ccce-2884-f4dc-4d0f8072a948@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: dave.jiang@intel.com, allenbh@gmail.com, jdmason@kudzu.us, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linjiasen@hygon.cn
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] NTB: ntb_perf: Fix address err in perf_copy_chunk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-11-11 12:51 a.m., Jiasen Lin wrote:
> 
> 
> On 2019/11/9 1:04, Logan Gunthorpe wrote:
>>
>>
>> On 2019-11-06 8:38 p.m., Jiasen Lin wrote:
>>> peer->outbuf is a virtual address which is get by ioremap, it can not
>>> be converted to a physical address by virt_to_page and page_to_phys.
>>> This conversion will result in DMA error, because the destination address
>>> which is converted by page_to_phys is invalid.
>>
>> Hmm, yes, ntb_perf is obviously wrong. I never noticed this, how did
>> this ever work?
>>
> 
> The default value of use_dma which is used to enable DMA engine to 
> measure NTB performance is zero, in other words, DMA engine is not used 
> by default. Thus, olny memcpy_toio is called in perf_copy_chunk and not 
> trigger this bug.
> 
> If we install driver with specified dma-enabled flag like this:
> insmod ntb_perf.ko use_dma=1, this issue will be triggered.

I've definitely tested with use_dma=1 in the past. But it looks like it
was broken by this problematic commit and I must have never personally
run the DMA tests after it:

5648e56d03fa ("NTB: ntb_perf: Add full multi-port NTB API support")

So it's probably worth adding a fixes tag to your patch.

>>> We Save the physical address in perf_setup_peer_mw, it is MMIO address
>>> of NTB BARx. Then fill the destination address of DMA descriptor with
>>> this physical address to guarantee that the address of memory write
>>> requests fall in memory window of NBT BARx.
>>
>> Using the physical address directly is also wrong and will not work in
>> the presence of an IOMMU. You should use dma_map_resource() for this.
>> See what was done in ntb_transport[1].
>>
> 
> Yes, my mistake. I will modify the code according to your suggestion and 
> test it on AMD and HYGON platforms with the IOMMU enabled. Maybe the 
> following patches are relied on, when IOMMU is enabled on AMD and HYGON 
> plartforms.
> 
> https://lore.kernel.org/patchwork/cover/1143155/
> https://lore.kernel.org/patchwork/patch/1143156/
> https://lore.kernel.org/patchwork/patch/1143157/

Thanks!

Logan
