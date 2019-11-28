Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64BAC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD65217BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="vIJ88MNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfK1OGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:06:40 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47710 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726227AbfK1OGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:06:40 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xASDwESB019195;
        Thu, 28 Nov 2019 15:06:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : from : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=6O/j6MGqOKMtgKJfgVAZVQ2jgcvQt1zJuaK51nFnaBA=;
 b=vIJ88MNdBALWDygbA9SUOPFIiE/2WtzdEE95ym1KKkwpLiPQl/zmuCgATWMDjnuvfw80
 FzentWNZOMquoYHvacn6P1LuF0I1StXh+SjVFe3mw+LM48kqWjEyD8Hxyy8qbMWVI3da
 q9c93eY2cD7c4Ducgg1vM+mCYbE0isicKDS9i1HJoQ9jXBtkyBjIoHqgiRF/OeKVChNY
 7xrjzuGgOMJIIC1KGoeIAjer0Z9xlQGulxCTaOKNlUAFWhFVsQe4tcEY32LAVccHeVev
 7C+NT5vdDdQKXJCEGNqXbv8xM1cF9sv/T+JrdhK7DEYoHiuU9PxEUNNO1F27I/pwHQCF OQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2whcxyjg0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Nov 2019 15:06:26 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A82E010002A;
        Thu, 28 Nov 2019 15:06:25 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8D4C42B9F87;
        Thu, 28 Nov 2019 15:06:25 +0100 (CET)
Received: from lmecxl0923.lme.st.com (10.75.127.45) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Nov
 2019 15:06:24 +0100
Subject: Re: [Linux-stm32] [PATCH 1/1] mmc: mmci: add threaded irq to abort
 DPSM of non-functional state
From:   Ludovic BARRE <ludovic.barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20191113172514.19052-1-ludovic.Barre@st.com>
 <CAPDyKFooSJUn6UCE6QkFmJOCovm00ehz_nAPbiNQM3AcJT_bJQ@mail.gmail.com>
 <c8311933-d129-4618-b81b-aa627b7b6de0@st.com>
Message-ID: <e80f76d3-0414-4f65-c2eb-4b09aaba3840@st.com>
Date:   Thu, 28 Nov 2019 15:06:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <c8311933-d129-4618-b81b-aa627b7b6de0@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_03:2019-11-28,2019-11-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ulf

just a gentleman ping about this thread.

small summarize:
This patch return an IRQ_WAKE_THREAD only when the variant is
busy_timeout capable and a datatimeout occurs on R1B request.

So the threaded irq is called only to treat this specific error.
Normally, there is no impact on HW flow control or for legacy variants.

In your previous message, you seem to suggest using threaded irq to
manage HW flow control (pio mode). But Like you mention below, the mmci
legacy could timing sensitive.

For the moment, I prefer to use the threaded irq just to manage this
error. If needed, the irq threade could be extended later.

What do you think about that?

Kind regards
Ludo

Le 11/15/19 à 3:59 PM, Ludovic BARRE a écrit :
> hi Ulf
> 
> Le 11/14/19 à 4:09 PM, Ulf Hansson a écrit :
>> On Wed, 13 Nov 2019 at 18:25, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>>
>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>
>>> If datatimeout occurs on R1B request, the Data Path State Machine stays
>>> in busy and is non-functional. Only a reset aborts the DPSM.
>>
>> Please clarify/extend this information to tell that this is for the
>> variant, that keeps DPSM enabled and uses the data timer while sending
>> a CMD12. Or something along those lines.
>>
> 
> yes, of course.
> 
>>>
>>> Like a reset must be outside of critical section, this patch adds
>>
>> /s/critical section/atomic context
> 
> OK, thanks
> 
>>
>>> threaded irq function to release state machine. In this case,
>>> the mmc_request_done is called at the end of threaded irq and
>>> skipped into irq handler.
>>>
>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>> ---
>>>   drivers/mmc/host/mmci.c | 44 ++++++++++++++++++++++++++++++++++++-----
>>>   drivers/mmc/host/mmci.h |  1 +
>>>   2 files changed, 40 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>>> index 40e72c30ea84..ec6e249c87ca 100644
>>> --- a/drivers/mmc/host/mmci.c
>>> +++ b/drivers/mmc/host/mmci.c
>>> @@ -556,6 +556,9 @@ static void mmci_dma_error(struct mmci_host *host)
>>>   static void
>>>   mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
>>>   {
>>> +       if (host->irq_action == IRQ_WAKE_THREAD)
>>> +               return;
>>> +
>>>          writel(0, host->base + MMCICOMMAND);
>>>
>>>          BUG_ON(host->data);
>>> @@ -1321,6 +1324,7 @@ mmci_cmd_irq(struct mmci_host *host, struct 
>>> mmc_command *cmd,
>>>          } else if (host->variant->busy_timeout && busy_resp &&
>>>                     status & MCI_DATATIMEOUT) {
>>>                  cmd->error = -ETIMEDOUT;
>>> +               host->irq_action = IRQ_WAKE_THREAD;
>>>          } else {
>>>                  cmd->resp[0] = readl(base + MMCIRESPONSE0);
>>>                  cmd->resp[1] = readl(base + MMCIRESPONSE1);
>>> @@ -1532,9 +1536,9 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>>>   {
>>>          struct mmci_host *host = dev_id;
>>>          u32 status;
>>> -       int ret = 0;
>>>
>>>          spin_lock(&host->lock);
>>> +       host->irq_action = IRQ_HANDLED;
>>>
>>>          do {
>>>                  status = readl(host->base + MMCISTATUS);
>>> @@ -1574,12 +1578,41 @@ static irqreturn_t mmci_irq(int irq, void 
>>> *dev_id)
>>>                  if (host->variant->busy_detect_flag)
>>>                          status &= ~host->variant->busy_detect_flag;
>>>
>>> -               ret = 1;
>>>          } while (status);
>>>
>>>          spin_unlock(&host->lock);
>>>
>>> -       return IRQ_RETVAL(ret);
>>> +       return host->irq_action;
>>> +}
>>> +
>>> +/*
>>> + * mmci_irq_threaded is call if the mmci host need to release state 
>>> machines
>>> + * before to terminate the request.
>>> + * If datatimeout occurs on R1B request, the Data Path State Machine 
>>> stays
>>> + * in busy and is non-functional. Only a reset can to abort the DPSM.
>>> + */
>>> +static irqreturn_t mmci_irq_threaded(int irq, void *dev_id)
>>> +{
>>> +       struct mmci_host *host = dev_id;
>>> +       unsigned long flags;
>>> +
>>> +       if (host->rst) {
>>> +               reset_control_assert(host->rst);
>>> +               udelay(2);
>>> +               reset_control_deassert(host->rst);
>>> +       }
>>> +
>>> +       spin_lock_irqsave(&host->lock, flags);
>>> +       writel(host->clk_reg, host->base + MMCICLOCK);
>>> +       writel(host->pwr_reg, host->base + MMCIPOWER);
>>> +       writel(MCI_IRQENABLE | host->variant->start_err,
>>> +              host->base + MMCIMASK0);
>>> +
>>> +       host->irq_action = IRQ_HANDLED;
>>> +       mmci_request_end(host, host->mrq);
>>> +       spin_unlock_irqrestore(&host->lock, flags);
>>> +
>>> +       return host->irq_action;
>>>   }
>>>
>>>   static void mmci_request(struct mmc_host *mmc, struct mmc_request 
>>> *mrq)
>>> @@ -2071,8 +2104,9 @@ static int mmci_probe(struct amba_device *dev,
>>>                          goto clk_disable;
>>>          }
>>>
>>> -       ret = devm_request_irq(&dev->dev, dev->irq[0], mmci_irq, 
>>> IRQF_SHARED,
>>> -                       DRIVER_NAME " (cmd)", host);
>>> +       ret = devm_request_threaded_irq(&dev->dev, dev->irq[0], 
>>> mmci_irq,
>>> +                                       mmci_irq_threaded, IRQF_SHARED,
>>> +                                       DRIVER_NAME " (cmd)", host);
>>
>> In general it's a good idea to move drivers into using a threaded IRQ 
>> handler.
>>
>> However, the reason this hasn't been done for mmci before, is because
>> there are some legacy variants, that doesn't support HW flow control.
> 
> With this patch, the mmci_irq_threaded is called only when
> a datatimeout occurs on R1B request else the mmci_irq return IRQ_HANDLED
> and the threaded irq is not called.
> So normally, there is no impact for legacy variants.
> 
>>
>> Unless I am mistaken, that means when the fifo gets full during data
>> transfers - it's too late to act. In other words, running the handler
>> in hard IRQ context, should increase the probability of not missing
>> the deadline.
>>
>> If a threaded IRQ handler also is sufficient for these legacy
>> variants, only tests can tell.
>>
>> An option, would be to use a threaded handler for those variants that
>> supports HW flow control. Not sure how messy the code would be with
>> this option, perhaps you can give this a try?
> For all these reasons you mentioned above, I'm not sure it's safe to 
> extend the thread manager to anything other than "aborting the DPSM" on
> R1B datatiemout ? what do you think about that?
> 
> I prefer just used the irq threaded for specific errors case which need
> be outside of atomic context.
> 
>>
>>
>>>          if (ret)
>>>                  goto clk_disable;
>>>
>>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>>> index 158e1231aa23..5e63c0596364 100644
>>> --- a/drivers/mmc/host/mmci.h
>>> +++ b/drivers/mmc/host/mmci.h
>>> @@ -412,6 +412,7 @@ struct mmci_host {
>>>
>>>          struct timer_list       timer;
>>>          unsigned int            oldstat;
>>> +       u32                     irq_action;
>>>
>>>          /* pio stuff */
>>>          struct sg_mapping_iter  sg_miter;
>>> -- 
>>> 2.17.1
>>>
>>
>> Kind regards
>> Uffe
>>
> _______________________________________________
> Linux-stm32 mailing list
> Linux-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32
