Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A22C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C280E2070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgAHVug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:50:36 -0500
Received: from ale.deltatee.com ([207.54.116.67]:50166 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgAHVuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 16:50:35 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ipJDT-00014M-FT; Wed, 08 Jan 2020 14:50:16 -0700
To:     Max Gurtovoy <maxg@mellanox.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20200108174030.3430-1-logang@deltatee.com>
 <20200108174030.3430-7-logang@deltatee.com>
 <707b39a3-b58a-44b7-7ffa-0c2bd3f28e21@mellanox.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2d8a1cc2-be58-176e-b12b-8dbc5dab8739@deltatee.com>
Date:   Wed, 8 Jan 2020 14:50:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <707b39a3-b58a-44b7-7ffa-0c2bd3f28e21@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: hch@lst.de, kbusch@kernel.org, axboe@fb.com, sbates@raithlin.com, chaitanya.kulkarni@wdc.com, sagi@grimberg.me, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, maxg@mellanox.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v10 6/9] nvme: Export existing nvme core functions
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-01-08 2:48 p.m., Max Gurtovoy wrote:
> 
> On 1/8/2020 7:40 PM, Logan Gunthorpe wrote:
>> Export nvme_put_ns(), nvme_command_effects(), nvme_execute_passthru_rq()
>> and nvme_find_get_ns() for use in the nvmet passthru code.
>>
>> The exports are conditional on CONFIG_NVME_TARGET_PASSTHRU.
>>
>> Based-on-a-patch-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>   drivers/nvme/host/core.c | 14 +++++++++-----
>>   drivers/nvme/host/nvme.h |  5 +++++
>>   2 files changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index d7912e7a9911..037415882d46 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -463,7 +463,7 @@ static void nvme_free_ns(struct kref *kref)
>>       kfree(ns);
>>   }
>>   -static void nvme_put_ns(struct nvme_ns *ns)
>> +void nvme_put_ns(struct nvme_ns *ns)
>>   {
>>       kref_put(&ns->kref, nvme_free_ns);
>>   }
>> @@ -896,8 +896,8 @@ static void *nvme_add_user_metadata(struct bio
>> *bio, void __user *ubuf,
>>       return ERR_PTR(ret);
>>   }
>>   -static u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct
>> nvme_ns *ns,
>> -                u8 opcode)
>> +u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>> +             u8 opcode)
>>   {
>>       u32 effects = 0;
>>   @@ -982,7 +982,7 @@ static void nvme_passthru_end(struct nvme_ctrl
>> *ctrl, u32 effects)
>>           nvme_queue_scan(ctrl);
>>   }
>>   -static void nvme_execute_passthru_rq(struct request *rq)
>> +void nvme_execute_passthru_rq(struct request *rq)
>>   {
>>       struct nvme_command *cmd = nvme_req(rq)->cmd;
>>       struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
>> @@ -3441,7 +3441,7 @@ static int ns_cmp(void *priv, struct list_head
>> *a, struct list_head *b)
>>       return nsa->head->ns_id - nsb->head->ns_id;
>>   }
>>   -static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl,
>> unsigned nsid)
>> +struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>>   {
>>       struct nvme_ns *ns, *ret = NULL;
>>   @@ -4225,6 +4225,10 @@ EXPORT_SYMBOL_GPL(nvme_sync_queues);
>>    * use by the nvmet-passthru and should not be used for
>>    * other things.
>>    */
>> +EXPORT_SYMBOL_GPL(nvme_put_ns);
>> +EXPORT_SYMBOL_GPL(nvme_command_effects);
>> +EXPORT_SYMBOL_GPL(nvme_execute_passthru_rq);
>> +EXPORT_SYMBOL_GPL(nvme_find_get_ns);
> 
> Since this is the convention in the driver, can you export the symbols
> at the end of each function ?

Christoph specifically asked for these to be exported at the end of the
file within an #ifdef CONFIG_NVME_TARGET_PASSTHRU.

Logan
