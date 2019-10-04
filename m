Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FD6C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899AC21D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 12:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="r+ZnBViD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfJDM7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 08:59:30 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:58483 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbfJDM73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:59:29 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x94Ctm2V004005;
        Fri, 4 Oct 2019 14:59:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=jdYkwnHIKXfltbtMEhWAa+g48yPJwrWjJwMzruN2kFY=;
 b=r+ZnBViDiiS3beRXVQVIfZbNkup4XzntMEAd9nv8kDfTNCwK3VdudSION9cWUlUheAnR
 Qlu8gnAqpcZncN0lkCOUGgni+UD6aFuha2LjF+W1+wuEKiJpkg3JetOFOp/QjVVIG6hs
 IFpNc+8NQMBrxJpZiGt5+ybchhDr0xTa/r00mtCQ8puGtBvMopJiQwfOqCXvj5v/pFMH
 15pWA0vfQi64+RIV7cFyE4TKFLtIShTgIFMCKM5Gvlyn9r8F+Fvifg8b9zacoc3nYIsC
 UXeUj9uctUM3W1WvbV86+SFd/9u+hOZtwWs5rlydgpQgIW7kGjXGSeKWZM+r6RwmQ0Mk HA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2v9w9wb2aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Oct 2019 14:59:18 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AEA6010002A;
        Fri,  4 Oct 2019 14:59:17 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9CD8F2BFE06;
        Fri,  4 Oct 2019 14:59:17 +0200 (CEST)
Received: from lmecxl0923.lme.st.com (10.75.127.49) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Oct
 2019 14:59:16 +0200
Subject: Re: [PATCH V6 1/3] mmc: mmci: add hardware busy timeout feature
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
References: <20190905122112.29672-1-ludovic.Barre@st.com>
 <20190905122112.29672-2-ludovic.Barre@st.com>
 <CAPDyKFpcb=dT0XBAGVL68t--xi5853Dzsgak-vbx5VcvxLZ4zA@mail.gmail.com>
 <CAPDyKFrRDHeVs6RpM=qTT1AogLnFWJLh2S4-wCcrYAON9XVKCA@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <da9072ce-852c-a46c-ecdf-ea6bfd89ef79@st.com>
Date:   Fri, 4 Oct 2019 14:59:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrRDHeVs6RpM=qTT1AogLnFWJLh2S4-wCcrYAON9XVKCA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-04_06:2019-10-03,2019-10-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ulf

Le 10/4/19 à 8:20 AM, Ulf Hansson a écrit :
> On Fri, 4 Oct 2019 at 08:12, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On Thu, 5 Sep 2019 at 14:21, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>>
>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>
>>> In some variants, the data timer starts and decrements
>>> when the DPSM enters in Wait_R or Busy state
>>> (while data transfer or MMC_RSP_BUSY), and generates a
>>> data timeout error if the counter reach 0.
>>
>>
>>>
>>> -Define max_busy_timeout (in ms) according to clock.
>>> -Set data timer register if the command has rsp_busy flag.
>>>   If busy_timeout is not defined by framework, the busy
>>>   length after Data Burst is defined as 1 second
>>>   (refer: 4.6.2.2 Write of sd specification part1 v6-0).
>>
>> How about re-phrasing this as below:
>>
>> -----
>> In the stm32_sdmmc variant, the datatimer is active not only during
>> data transfers with the DPSM, but also while waiting for the busyend
>> IRQs from commands having the MMC_RSP_BUSY flag set. This leads to an
>> incorrect IRQ being raised to signal MCI_DATATIMEOUT error, which
>> simply breaks the behaviour.
>>
>> Address this by updating the datatimer value before sending a command
>> having the MMC_RSP_BUSY flag set. To inform the mmc core about the
>> maximum supported busy timeout, which also depends on the current
>> clock rate, set ->max_busy_timeout (in ms).

Thanks for the re-phrasing.

>> -----
>>
>> Regarding the busy_timeout, the core should really assign it a value
>> for all commands having the RSP_BUSY flag set. However, I realize the
>> core needs to be improved to cover all these cases - and I am looking
>> at that, but not there yet.
>>
>> I would also suggest to use a greater value than 1s, as that seems a
>> bit low for the "undefined" case. Perhaps use the max_busy_timeout,
>> which would be nice a simple or 10s, which I think is used by some
>> other drivers.

OK, I will set 10s, the max_busy_timeout could be very long for small 
frequencies (example, 25Mhz => 171s).

>>
>>> -Add MCI_DATATIMEOUT error management in mmci_cmd_irq.
>>>
>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>> ---
>>>   drivers/mmc/host/mmci.c | 42 ++++++++++++++++++++++++++++++++++++-----
>>>   drivers/mmc/host/mmci.h |  3 +++
>>>   2 files changed, 40 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>>> index c37e70dbe250..c30319255dc2 100644
>>> --- a/drivers/mmc/host/mmci.c
>>> +++ b/drivers/mmc/host/mmci.c
>>> @@ -1075,6 +1075,7 @@ static void
>>>   mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>>>   {
>>>          void __iomem *base = host->base;
>>> +       unsigned long long clks;
>>>
>>>          dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
>>>              cmd->opcode, cmd->arg, cmd->flags);
>>> @@ -1097,6 +1098,16 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>>>                  else
>>>                          c |= host->variant->cmdreg_srsp;
>>>          }
>>> +
>>> +       if (host->variant->busy_timeout && cmd->flags & MMC_RSP_BUSY) {
>>> +               if (!cmd->busy_timeout)
>>> +                       cmd->busy_timeout = 1000;
>>> +
>>> +               clks = (unsigned long long)cmd->busy_timeout * host->cclk;
>>> +               do_div(clks, MSEC_PER_SEC);
>>> +               writel_relaxed(clks, host->base + MMCIDATATIMER);
>>> +       }
>>> +
>>>          if (/*interrupt*/0)
>>>                  c |= MCI_CPSM_INTERRUPT;
>>>
>>> @@ -1201,6 +1212,7 @@ static void
>>>   mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>>               unsigned int status)
>>>   {
>>> +       u32 err_msk = MCI_CMDCRCFAIL | MCI_CMDTIMEOUT;
>>>          void __iomem *base = host->base;
>>>          bool sbc, busy_resp;
>>>
>>> @@ -1215,8 +1227,11 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>>           * handling. Note that we tag on any latent IRQs postponed
>>>           * due to waiting for busy status.
>>>           */
>>> -       if (!((status|host->busy_status) &
>>> -             (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|MCI_CMDSENT|MCI_CMDRESPEND)))
>>> +       if (host->variant->busy_timeout && busy_resp)
>>> +               err_msk |= MCI_DATATIMEOUT;
>>> +
>>> +       if (!((status | host->busy_status) &
>>> +             (err_msk | MCI_CMDSENT | MCI_CMDRESPEND)))
>>>                  return;
>>>
>>>          /* Handle busy detection on DAT0 if the variant supports it. */
>>> @@ -1235,8 +1250,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>>                   * while, to allow it to be set, but tests indicates that it
>>>                   * isn't needed.
>>>                   */
>>> -               if (!host->busy_status &&
>>> -                   !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
>>> +               if (!host->busy_status && !(status & err_msk) &&
>>>                      (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
>>>
>>>                          writel(readl(base + MMCIMASK0) |
>>> @@ -1290,6 +1304,9 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>>                  cmd->error = -ETIMEDOUT;
>>>          } else if (status & MCI_CMDCRCFAIL && cmd->flags & MMC_RSP_CRC) {
>>>                  cmd->error = -EILSEQ;
>>> +       } else if (host->variant->busy_timeout && busy_resp &&
>>> +                  status & MCI_DATATIMEOUT) {
>>> +               cmd->error = -ETIMEDOUT;
>>
>> It's not really clear to me what happens with the busy detection
>> status bit (variant->busy_detect_flag), in case a MCI_DATATIMEOUT IRQ
>> is raised, while also having host->busy_status set (waiting for
>> busyend).
>>
>> By looking at the code a few lines above this, we may do a "return;"
>> while waiting for the busyend IRQ even if MCI_DATATIMEOUT also is
>> raised, potentially losing that from being caught. Is that really
>> correct?
> 
> A second thought. That "return;" is to manage the busyend IRQ being
> raised of the first edge due to broken HW. So I guess, this isn't an
> issue for stm32_sdmmc variant after all?
>
> I have a look at the next patches in the series..

you're referring to "return" of ?
	if (host->busy_status &&
	    (status & host->variant->busy_detect_flag)) {
		writel(host->variant->busy_detect_mask,
		       host->base + MMCICLEAR);
		return;
	}

For stm32 variant (in patch 3/3): the "busy completion" is
released immediately if there is an error or busyd0end,
and cleans: irq, busyd0end mask, busy_status variable.

I could add similar action in patch 2/3 function: "ux500_busy_complete"

static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 
err_msk)
{
	void __iomem *base = host->base;

	if (status & err_msk)
		goto complete;
...
complete:
	/* specific action to clean busy detection, irq, mask, busy_status */
}

what do you think about it?

> 
> [...]
> 
> Kind regards
> Uffe
> 
