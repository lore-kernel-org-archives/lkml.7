Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D008C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06999206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ON5xaAw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfDZNlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:41:24 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:49882 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726120AbfDZNlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:41:23 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QDWBEP017163;
        Fri, 26 Apr 2019 15:41:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=ykuZA6DtzWG+MyyQPuNhTSp+xxbJHKfVbR5sDbF/lDk=;
 b=ON5xaAw/hw/j6/88plqbTWYuSDppPRq/mFgS/iNqiSkwC8JN3COfTHGkdVMKkuHqdQWA
 0CpT44udCpDWXNxj1fG4iaehdn/Ro/mjzfsVX+t3LnuU1CJ7gLKJMA53G+ice1TJMHl7
 Aq6HxAkV+yyw/9yHn/8oK3cF03m1BrBlg9+HfoAmz90sTT03TsIzeRCgEVVgvhwgZEhO
 dvSTpsLkuxDiRc3+A6BtvUoB5lLNTP4CU9X6i597w4UneGRuEhPJUOKY94gKWx3AmWec
 Urih1obylI5b6qw7jjOIc0Hp1+bkIuFjyYcQLq+xSEcf4LxZ9ApH+wVmAk23YxDkfCDw Ag== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rytadmsm3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 26 Apr 2019 15:41:14 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EB3FB38;
        Fri, 26 Apr 2019 13:41:09 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C33BA2645;
        Fri, 26 Apr 2019 13:41:09 +0000 (GMT)
Received: from [10.48.0.131] (10.75.127.47) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 26 Apr
 2019 15:41:09 +0200
Subject: Re: [PATCH] dmaengine: stm32-dma: fix residue calculation in
 stm32-dma
To:     Vinod Koul <vkoul@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
References: <1553689316-6231-1-git-send-email-arnaud.pouliquen@st.com>
 <20190426121751.GC28103@vkoul-mobl>
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arnaud.pouliquen@st.com; prefer-encrypt=mutual; keydata=
 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
 8mOik8I/F6EW8XyQAA2P
Message-ID: <6894b54e-651f-1caf-d363-79d1ef0eee14@st.com>
Date:   Fri, 26 Apr 2019 15:41:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426121751.GC28103@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod

On 4/26/19 2:17 PM, Vinod Koul wrote:
> Hi Arnaud,
> 
> Sorry for delay in review, the conference travel/vacation plan delayed
> this.
no problem, just a rememder to be sure that you not missed it in the
patch stream.

> 
> On 27-03-19, 13:21, Arnaud Pouliquen wrote:
>> During residue calculation. the DMA can switch to the next sg. When
>> this race condition occurs, the residue returned value is not valid.
>> Indeed the position in the sg returned by the hardware is the position
>> of the next sg, not the current sg.
>> Solution is to check the sg after the calculation to verify it.
>> If a transition is detected we consider that the DMA has switched to
>> the beginning of next sg.
> 
> Now, that sounds like duct tape. Why should we bother doing that.
> 
> Also looking back at the stm32_dma_desc_residue() and calls to it from
> stm32_dma_tx_status() am not sure we are doing the right thing
Please, could you explain what you have in mind here?

> 
> why are we looking at next_sg here, can you explain me that please

This solution is similar to one implemented in the at_hdmac.c driver
(atc_get_bytes_left function).

Yes could be consider as a workaround for a hardware issue...

In stm32 DMA Peripheral, we can register up to 2 sg descriptors (sg1 &
sg2)in DMA registers, and use it in a cyclic mode (auto reload). This
mode is mainly use for audio transfer initiated by an ALSA driver.

From hardware point of view the DMA transfers first block based on sg1,
then it updates registers to prepare sg2 transfer, and then generates an
IRQ to inform that it issues the next transfer (sg2).

Then driver can update sg1 to prepare the third transfer...

In parallel the client driver can requests status to get the residue to
update internal pointer.
The issue is in the race condition between the call of the
device_tx_status ops and the update of the DMA register on sg switch.

During a short time the hardware updated the registers containing the
sg ID but not the transfer counter(SxNDTR). In this case there is a
mismatch between the Sg ID and the associated transfer counter.
So residue calculation is wrong.
Idea of this patch is to perform the calculation and then to crosscheck
that the hardware has not switched to the next sg during the
calculation. The way to crosscheck is to compare the the sg ID before
and after the calculation.

I tested the solution to force a new recalculation but no real solution
to trust the registers during this phase. In this case an approximation
is to consider that the DMA is transferring the first bytes of the next sg.
So we return the residue corresponding to the beginning of the next buffer.

Don't hesitate if it is still not clear

Thanks
Arnaud

> 
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
>> ---
>>  drivers/dma/stm32-dma.c | 70 ++++++++++++++++++++++++++++++++++++++++---------
>>  1 file changed, 57 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
>> index 4903a40..30309d2 100644
>> --- a/drivers/dma/stm32-dma.c
>> +++ b/drivers/dma/stm32-dma.c
>> @@ -1038,33 +1038,77 @@ static u32 stm32_dma_get_remaining_bytes(struct stm32_dma_chan *chan)
>>  	return ndtr << width;
>>  }
>>  
>> +static bool stm32_dma_is_current_sg(struct stm32_dma_chan *chan)
>> +{
>> +	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
>> +	struct stm32_dma_sg_req *sg_req;
>> +	u32 dma_scr, dma_smar, id;
>> +
>> +	id = chan->id;
>> +	dma_scr = stm32_dma_read(dmadev, STM32_DMA_SCR(id));
>> +
>> +	if (!(dma_scr & STM32_DMA_SCR_DBM))
>> +		return true;
>> +
>> +	sg_req = &chan->desc->sg_req[chan->next_sg];
>> +
>> +	if (dma_scr & STM32_DMA_SCR_CT) {
>> +		dma_smar = stm32_dma_read(dmadev, STM32_DMA_SM0AR(id));
>> +		return (dma_smar == sg_req->chan_reg.dma_sm0ar);
>> +	}
>> +
>> +	dma_smar = stm32_dma_read(dmadev, STM32_DMA_SM1AR(id));
>> +
>> +	return (dma_smar == sg_req->chan_reg.dma_sm1ar);
>> +}
>> +
>>  static size_t stm32_dma_desc_residue(struct stm32_dma_chan *chan,
>>  				     struct stm32_dma_desc *desc,
>>  				     u32 next_sg)
>>  {
>>  	u32 modulo, burst_size;
>> -	u32 residue = 0;
>> +	u32 residue;
>> +	u32 n_sg = next_sg;
>> +	struct stm32_dma_sg_req *sg_req = &chan->desc->sg_req[chan->next_sg];
>>  	int i;
>>  
>> +	residue = stm32_dma_get_remaining_bytes(chan);
>> +
>>  	/*
>> -	 * In cyclic mode, for the last period, residue = remaining bytes from
>> -	 * NDTR
>> +	 * Calculate the residue means compute the descriptors
>> +	 * information:
>> +	 * - the sg currently transferred
>> +	 * - the remaining position in this sg (NDTR).
>> +	 *
>> +	 * The issue is that a race condition can occur if DMA is
>> +	 * running. DMA can have started to transfer the next sg before
>> +	 * the position in sg is read. In this case the remaing position
>> +	 * can correspond to the new sg position.
>> +	 * The strategy implemented in the stm32 driver is to check the
>> +	 * sg transition. If detected we can not trust the SxNDTR register
>> +	 * value, this register can not be up to date during the transition.
>> +	 * In this case we can assume that the dma is at the beginning of next
>> +	 * sg so we calculate the residue in consequence.
>>  	 */
>> -	if (chan->desc->cyclic && next_sg == 0) {
>> -		residue = stm32_dma_get_remaining_bytes(chan);
>> -		goto end;
>> +
>> +	if (!stm32_dma_is_current_sg(chan)) {
>> +		n_sg++;
>> +		if (n_sg == chan->desc->num_sgs)
>> +			n_sg = 0;
>> +		residue = sg_req->len;
>>  	}
>>  
>>  	/*
>> -	 * For all other periods in cyclic mode, and in sg mode,
>> -	 * residue = remaining bytes from NDTR + remaining periods/sg to be
>> -	 * transferred
>> +	 * In cyclic mode, for the last period, residue = remaining bytes
>> +	 * from NDTR,
>> +	 * else for all other periods in cyclic mode, and in sg mode,
>> +	 * residue = remaining bytes from NDTR + remaining
>> +	 * periods/sg to be transferred
>>  	 */
>> -	for (i = next_sg; i < desc->num_sgs; i++)
>> -		residue += desc->sg_req[i].len;
>> -	residue += stm32_dma_get_remaining_bytes(chan);
>> +	if (!chan->desc->cyclic || n_sg != 0)
>> +		for (i = n_sg; i < desc->num_sgs; i++)
>> +			residue += desc->sg_req[i].len;
>>  
>> -end:
>>  	if (!chan->mem_burst)
>>  		return residue;
>>  
>> -- 
>> 2.7.4
> 
