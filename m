Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B737C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E772176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfLRHhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 02:37:43 -0500
Received: from spam01.hygon.cn ([110.188.70.11]:40211 "EHLO spam2.hygon.cn"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726682AbfLRHhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 02:37:43 -0500
Received: from MK-DB.hygon.cn ([172.23.18.60])
        by spam2.hygon.cn with ESMTP id xBI7YsLc029176;
        Wed, 18 Dec 2019 15:34:54 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-DB.hygon.cn with ESMTP id xBI7YjaX044964;
        Wed, 18 Dec 2019 15:34:45 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from [172.20.21.12] (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 18 Dec
 2019 15:34:54 +0800
Subject: Re: [PATCH] NTB: ntb_perf: Add more debugfs entries for ntb_perf
To:     Logan Gunthorpe <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        <jdmason@kudzu.us>
CC:     <allenbh@gmail.com>, <dave.jiang@intel.com>, <sanju.mehta@amd.com>
References: <1576550536-84697-1-git-send-email-linjiasen@hygon.cn>
 <d4f679cd-739b-fd80-8344-7da475937835@deltatee.com>
From:   Jiasen Lin <linjiasen@hygon.cn>
Message-ID: <fd3efeba-40f0-3933-af48-d74486ddea86@hygon.cn>
Date:   Wed, 18 Dec 2019 15:32:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <d4f679cd-739b-fd80-8344-7da475937835@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam2.hygon.cn xBI7YsLc029176
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/12/18 0:42, Logan Gunthorpe wrote:
> 
> 
> On 2019-12-16 7:42 p.m., Jiasen Lin wrote:
>> Currently, read input and output buffer is not supported yet in
>> debugfs of ntb_perf. We can not confirm whether the output data is
>> transmitted to the input buffer at peer memory through NTB.
>>
>> This patch add new entries in debugfs which implement interface to read
>> a part of input and out buffer. User can dump output and input data at
>> local and peer system by hexdump command, and then compare them manually.
> 
> Do we even initialize inbuf and outbuf? Probably not a good idea to
> expose them to userspace if it's not initialized.
> 

Good catch! Input buffer(peer->inbuf) should be initialized after call
dma_alloc_coherent in perf_setup_inbuf, but output buffer(peer->outbuf)
that point to NTB BARx MMIO address can not be initialized. The address 
of memory request that fall in NTB memory windown will be translated 
into an address that point to input buffer at peer memory system through 
NTB XLAT register in ntb_perf. In other words, only input buffer should 
be initialized.
Will fix it for v2 as a separate patch.

> Really, ntb_tool should be used to check if memory windows work,
> ntb_perf is just to see the maximum transfer rate.
> 

Yes, you are right! ntb_tool could be used to check memory window
by hexdmup mw and peer_mw after write mw_trans and peer_mw_trans,
but this is only one ntb client be probed although we can insmod both
ntb_tool.ko and ntb_perf.ko, That's to say, only one modulue can create
files in debugFS. So, I suggest that add debugfs entries that can read
input and output buffer in ntb_perf.

Thanks,
Jiasen Lin

> Logan
> 
