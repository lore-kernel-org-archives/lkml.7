Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FC3C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA75206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="hsURZtvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfKMQy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:54:26 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:50698 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727159AbfKMQy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:54:26 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xADGfrfA024544;
        Wed, 13 Nov 2019 17:54:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=VFn0eBZgGYEiMFMrOw2KqgKEpuSqhhGhp31gWjHVpIY=;
 b=hsURZtvc70Mxytq8Bx4tkyLXmCu0cgC1DHsI8AKaBkBUDEyRu+g4tarQrRNvhFuNVf7u
 EElA+JiSFdYle0L8zJ6bAPNLtV218Zw3kGUVM1YJihYuve0n2LG/6Pru72ybpu/Ka6qV
 oylheGp68LCmGUwpw0yqLR/u0nBxRi1VMxQOTDCyNEU49BvE0WCiRQ2+GfLMXQfV0Gv8
 fr93vk1dd9H6GtJ0k2J9xtMIJ7cpqBGdiOpkSMy4oesOk6ZM7TSP5fQrsNj7xcWkJ3NE
 JH5XOeOSDmGLVyD4hRdvnmZ59M3LTdzuCQi2EEu6n1SBvKHvnfvgyEukM1wgKMseKbEb 9A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w7psu1bmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Nov 2019 17:54:13 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C8BD410002A;
        Wed, 13 Nov 2019 17:54:12 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B08252C38D5;
        Wed, 13 Nov 2019 17:54:12 +0100 (CET)
Received: from lmecxl0923.lme.st.com (10.75.127.48) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Nov
 2019 17:54:11 +0100
Subject: Re: [PATCH 1/2] mmc: add unstuck function if host is in deadlock
 state
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20191011131502.29579-1-ludovic.Barre@st.com>
 <20191011131502.29579-2-ludovic.Barre@st.com>
 <CAPDyKFqE09nqdev_qewwNzjjUuhm0UUC03tgvY=ZukYY4az7wg@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <d8d82f39-319b-c8f8-255a-a02a81980671@st.com>
Date:   Wed, 13 Nov 2019 17:54:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqE09nqdev_qewwNzjjUuhm0UUC03tgvY=ZukYY4az7wg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-13_04:2019-11-13,2019-11-13 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 10/21/19 à 3:35 PM, Ulf Hansson a écrit :
> On Fri, 11 Oct 2019 at 15:15, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> After a request a host may be in deadlock state, and wait
>> a specific action to unstuck the hardware block before
>> re-sending a new command.
> 
> Rather than talking about "unstuck" and "deadlock", how about instead
> describing that an MMC controller, may end up in an non-functional
> state hanging on something. Then to allow it to serve new requests it
> needs to be reset.
> 

Ok, deadlock naming is perhaps too stronght and scary.

>>
>> This patch adds an optional callback mmc_hw_unstuck which
>> allows the host to unstuck the controller. In order to avoid
>> a critical context, this callback must be called when the
>> request is completed. Depending the mmc request, the completion
>> function is defined by mrq->done and could be in block.c or core.c.
> 
> I think it's important to state exactly what is expected from the core
> perspective, by the mmc host driver when it calls this new host ops.
> We need to clarify that.
> 
>>
>> mmc_hw_unstuck is called if the host returns an cmd/sbc/stop/data
>> DEADLK error.
> 
> To me, this approach seems a bit upside-down. Although, I have to
> admit that I haven't thought through this completely yet.
> 
> The thing is, to make this useful for host drivers in general, I
> instead think we need to add timeout to each request that the core
> sends to the host driver. In other words, rather than waiting forever
> in the core for the completion variable to be set, via calling
> wait_for_completion() we could call wait_for_completion_timeout(). The
> tricky part is to figure out what timeout to use for each request.
> Perhaps that is even why you picked the approach as implemented in
> @subject patch instead?

On STM32 SDMMC variant, If datatimeout occurs on R1B request the Data
Path State Machine stays in busy and only the DPSM is non-functional.
The hardware block waits a software action to abort the DPSM.

Like the CPSM stay alive, the framework can sent some requests
(without data, example cmd13:status) before to had this
timeout issue.

POV framework I understand the possibility to have a completion_timeout,
for more safety. But for this specific sdmmc case, I'm not fan, because 
the completion timeout error will occur several requests after the real 
issue (which put the DPSM non-functional). when the completion timeout
occurs we can't know if it's due to R1B timeout or an other issue.

To resolve the SDMMC's specificity, I can proposed you to add a threaded
irq in mmci drivers to abort the DPSM and terminate the request.

> 
> Anyway, the typical scenario I see, is that the host driver is
> hanging, likely waiting for an IRQ that never get raised. So, unless
> it implements it own variant of a "request timeout" mechanism, it
> simple isn't able to call mmc_request_done() to inform the core about
> that the request has failed.
> 
> For comments to the code, I defer that to the next step, when we have
> agreed on the way forward.
> 
> Kind regards
> Uffe
> 
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   drivers/mmc/core/block.c | 11 +++++++++++
>>   drivers/mmc/core/core.c  | 35 +++++++++++++++++++++++++++++++++--
>>   include/linux/mmc/core.h |  1 +
>>   include/linux/mmc/host.h |  7 +++++++
>>   4 files changed, 52 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>> index 2c71a434c915..2f723e2f5fde 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -1799,6 +1799,17 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue *mq, struct request *req)
>>          u32 blocks;
>>          int err;
>>
>> +       /*
>> +        * if the host return a deadlock, it needs to be unstuck
>> +        * before to send a new command.
>> +        */
>> +       if (brq->sbc.error == -EDEADLK || brq->cmd.error == -EDEADLK ||
>> +           brq->stop.error == -EDEADLK || brq->data.error == -EDEADLK) {
>> +               pr_err("%s: host is in bad state, must be unstuck\n",
>> +                      req->rq_disk->disk_name);
>> +               mmc_hw_unstuck(card->host);
>> +       }
>> +
>>          /*
>>           * Some errors the host driver might not have seen. Set the number of
>>           * bytes transferred to zero in that case.
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 221127324709..43fe59a7403b 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -397,6 +397,7 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
>>   void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
>>   {
>>          struct mmc_command *cmd;
>> +       int sbc_err, stop_err, data_err;
>>
>>          while (1) {
>>                  wait_for_completion(&mrq->completion);
>> @@ -420,8 +421,24 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
>>                                         mmc_hostname(host), __func__);
>>                          }
>>                  }
>> -               if (!cmd->error || !cmd->retries ||
>> -                   mmc_card_removed(host->card))
>> +
>> +               sbc_err =  mrq->sbc ? mrq->sbc->error : 0;
>> +               stop_err = mrq->stop ? mrq->stop->error : 0;
>> +               data_err =  mrq->data ? mrq->data->error : 0;
>> +
>> +               /*
>> +                * if the host return a deadlock, it needs to be unstuck
>> +                * before to send a new command.
>> +                */
>> +               if (cmd->error == -EDEADLK || sbc_err == -EDEADLK ||
>> +                   stop_err == -EDEADLK || data_err == -EDEADLK) {
>> +                       pr_debug("%s: host is in bad state, must be unstuck\n",
>> +                                mmc_hostname(host));
>> +                       mmc_hw_unstuck(host);
>> +               }
>> +
>> +               if ((!cmd->error && !sbc_err && !stop_err && !data_err) ||
>> +                   !cmd->retries || mmc_card_removed(host->card))
>>                          break;
>>
>>                  mmc_retune_recheck(host);
>> @@ -430,6 +447,12 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
>>                           mmc_hostname(host), cmd->opcode, cmd->error);
>>                  cmd->retries--;
>>                  cmd->error = 0;
>> +               if (mrq->sbc)
>> +                       mrq->sbc->error = 0;
>> +               if (mrq->stop)
>> +                       mrq->stop->error = 0;
>> +               if (mrq->data)
>> +                       mrq->data->error = 0;
>>                  __mmc_start_request(host, mrq);
>>          }
>>
>> @@ -2161,6 +2184,14 @@ int mmc_sw_reset(struct mmc_host *host)
>>   }
>>   EXPORT_SYMBOL(mmc_sw_reset);
>>
>> +void mmc_hw_unstuck(struct mmc_host *host)
>> +{
>> +       if (!host->ops->hw_unstuck)
>> +               return;
>> +       host->ops->hw_unstuck(host);
>> +}
>> +EXPORT_SYMBOL(mmc_hw_unstuck);
>> +
>>   static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
>>   {
>>          host->f_init = freq;
>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
>> index b7ba8810a3b5..eb10b8194073 100644
>> --- a/include/linux/mmc/core.h
>> +++ b/include/linux/mmc/core.h
>> @@ -173,6 +173,7 @@ void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq);
>>   int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd,
>>                  int retries);
>>
>> +void mmc_hw_unstuck(struct mmc_host *host);
>>   int mmc_hw_reset(struct mmc_host *host);
>>   int mmc_sw_reset(struct mmc_host *host);
>>   void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card);
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index ba703384bea0..8b52cafcd1eb 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -163,6 +163,13 @@ struct mmc_host_ops {
>>          void    (*hw_reset)(struct mmc_host *host);
>>          void    (*card_event)(struct mmc_host *host);
>>
>> +       /*
>> +        * Optional callback, if your host could be in deadlock after a command
>> +        * and need a specific action to unstuck the controller before sending
>> +        * new command.
>> +        */
>> +       void    (*hw_unstuck)(struct mmc_host *host);
>> +
>>          /*
>>           * Optional callback to support controllers with HW issues for multiple
>>           * I/O. Returns the number of supported blocks for the request.
>> --
>> 2.17.1
>>
