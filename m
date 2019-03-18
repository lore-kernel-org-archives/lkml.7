Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB59C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3A620850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfCRNcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:32:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:14016 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfCRNcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:32:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 06:32:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="scan'208";a="329640905"
Received: from mdziegie-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.237.142.141])
  by fmsmga005.fm.intel.com with ESMTP; 18 Mar 2019 06:32:43 -0700
Subject: Re: [PATCH] nvme: lightnvm: expose OC devices as zero size to OS
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc:     igor.j.konopko@intel.com, Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1552570910-11706-1-git-send-email-marcin.dziegielewski@intel.com>
 <4e43d40a-b253-1493-da38-70a8c062749e@lightnvm.io>
From:   Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Message-ID: <16807f7f-075b-aa27-72c3-a905772ac36d@intel.com>
Date:   Mon, 18 Mar 2019 14:32:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <4e43d40a-b253-1493-da38-70a8c062749e@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/19 2:56 PM, Matias Bjørling wrote:
> On 3/14/19 6:41 AM, Marcin Dziegielewski wrote:
>> Open channel devices are not able to handle traditional
>> IO requests addressed by LBA, so following current
>> approach to exposing special nvme devices as zero size
>> (e.g. with namespace formatted to use metadata) also
>> open channel devices should be exposed as zero size
>> to OS.
>>
>> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
>> ---
>>   drivers/nvme/host/core.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 07bf2bf..52cd5c8 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1606,7 +1606,8 @@ static void nvme_update_disk_info(struct gendisk 
>> *disk,
>>       if (ns->ms && !ns->ext &&
>>           (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
>>           nvme_init_integrity(disk, ns->ms, ns->pi_type);
>> -    if (ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk))
>> +    if ((ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk)) ||
>> +        ns->ndev)
>>           capacity = 0;
>>       set_capacity(disk, capacity);
>>
> 
> Marcin,
> 
> The read/write as traditional I/Os feature is supported in OCSSD 2.0. 
> For example, one can hook support up through the zone device support in 
> the kernel. There is a patch here that enables it here:
> 
> https://github.com/OpenChannelSSD/linux/commit/e79e747601a315784e505d51a9265e82a3e7613c 
> 
> 
> With that, an OCSSD device can be used as a traditional zoned block 
> device, and use the existing infrastructure. Which is really neat.
> 
> It is not upstream, since it depends on some features that we introduce 
> with zoned namespaces, but in general, tools can read/write from a block 
> device as any other, just honoring the special write rules that are for 
> OCSSD/zoned block devices.
> 
> -Matias

Matias,

If zone related changes will be in upstream soon, I agree that this 
patch is not needed.

But, I can not agree that tools can use OCSSD device as normal block 
device - for example in current implementation I don't see way to send 
erase request and of course without it we can not send write. Because of 
that, it was my intention to block normal IO to OCSSD device by default.

Marcin
