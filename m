Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AABC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8FF214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="WJM3T3AC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfDYJWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:22:51 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33352 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726751AbfDYJWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:22:51 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3P9LdWc029803;
        Thu, 25 Apr 2019 11:22:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=WcuHKJfM5j820wRvLkM1dMYymsb2tMZRLxr/JHKEm1I=;
 b=WJM3T3ACu7OxFg1gyz9WGUsucfg1nOnaTa84OS4r7o9pYdaXueDN0vcRIR8ycZJ4oHpH
 Rl2hA0R+1Msg8jjk9uAL7pv5/ELVxTArCRMRVVPppl1ZqDiBaE8rW3RwDzk83Ju9S9lM
 i8T0tpOXe47gY2RxL3d7tR4X9PfLxhuYhHnS/tp1yhK4qfgV2buikzMPwTmZcMrr+EqX
 ePzem9yN2LlBOq9SbU0Pud00ajTDDC55C2wm6e2O7VbNLOfPF8/iUCnqb2UaJeRDpTnM
 dMFXtpUuyJDH3/SPodHDq1tmC+tZ1dHQpt+hoSHpypiOis3+ruDOnI4/o4CZqrEGo/qY 4w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rytadc10d-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 25 Apr 2019 11:22:40 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3592A31;
        Thu, 25 Apr 2019 09:22:39 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0A0E51635;
        Thu, 25 Apr 2019 09:22:39 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.45) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 25 Apr
 2019 11:22:38 +0200
Subject: Re: [PATCH 1/4] mmc: mmci: avoid fake busy polling
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
References: <1551802205-32188-1-git-send-email-ludovic.Barre@st.com>
 <1551802205-32188-2-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFoZuQ+hshZpj-qjchKf7enW4ChPd=r_QhK2xtuJcSvqxQ@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <fd57fd63-093e-dd23-5ca4-6bd4f99ecda9@st.com>
Date:   Thu, 25 Apr 2019 11:22:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoZuQ+hshZpj-qjchKf7enW4ChPd=r_QhK2xtuJcSvqxQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ulf

On 4/23/19 3:39 PM, Ulf Hansson wrote:
> On Tue, 5 Mar 2019 at 17:10, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> The busy status bit could occurred even if no busy response is
>> expected (example cmd11). On sdmmc variant, the busy_detect_flag
>> reflects inverted value of d0 state, it's sampled at the end of a
>> CMD response and a second time 2 clk cycles after the CMD response.
>> To avoid a fake busy, the busy status could be checked and polled
>> only if the command has RSP_BUSY flag.
> 
> I would appreciate a better explanation of what this patch really changes.
> 
> The above is giving some background to the behavior of sdmmc variant,
> but at this point that variant doesn't even have the
> ->variant->busy_detect flag set.
> 

Yes, I will try to explain more and focus on common behavior.

>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   drivers/mmc/host/mmci.c | 19 +++++++++++++------
>>   1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index 387ff14..4901b73 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -1220,12 +1220,13 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>               unsigned int status)
>>   {
>>          void __iomem *base = host->base;
>> -       bool sbc;
>> +       bool sbc, busy_resp;
>>
>>          if (!cmd)
>>                  return;
>>
>>          sbc = (cmd == host->mrq->sbc);
>> +       busy_resp = !!(cmd->flags & MMC_RSP_BUSY);
>>
>>          /*
>>           * We need to be one of these interrupts to be considered worth
>> @@ -1239,8 +1240,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>          /*
>>           * ST Micro variant: handle busy detection.
>>           */
>> -       if (host->variant->busy_detect) {
>> -               bool busy_resp = !!(cmd->flags & MMC_RSP_BUSY);
>> +       if (busy_resp && host->variant->busy_detect) {
>>
>>                  /* We are busy with a command, return */
>>                  if (host->busy_status &&
>> @@ -1253,7 +1253,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>                   * that the special busy status bit is still set before
>>                   * proceeding.
>>                   */
>> -               if (!host->busy_status && busy_resp &&
>> +               if (!host->busy_status &&
>>                      !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
>>                      (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
> 
> All the changes above makes perfect sense to me, but looks more like a
> cleanup of the code, rather than actually changing the behavior.

yes, few changing (this just avoid to enter in
"if (host->variant->busy_detect)") at each time.
I could move this part in cleanup patch (before this patch)

> 
>>
>> @@ -1508,6 +1508,7 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>>   {
>>          struct mmci_host *host = dev_id;
>>          u32 status;
>> +       bool busy_resp;
>>          int ret = 0;
>>
>>          spin_lock(&host->lock);
>> @@ -1550,9 +1551,15 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>>                  }
>>
>>                  /*
>> -                * Don't poll for busy completion in irq context.
>> +                * Don't poll for:
>> +                * -busy completion in irq context.
>> +                * -no busy response expected.
>>                   */
>> -               if (host->variant->busy_detect && host->busy_status)
>> +               busy_resp = host->cmd ?
>> +                       !!(host->cmd->flags & MMC_RSP_BUSY) : false;
> 
> This doesn't make sense to me, but I may be missing something.
> 
> host->busy_status is being updated by mmci_cmd_irq() and only when
> MMC_RSP_BUSY is set for the command in flight. In other words,
> checking for MMC_RSP_BUSY here as well is redundant. No?

In mmci_irq the "do while" loops until the status is totally cleared.

Today (for variant with busy_detect option), the status busy_detect_flag
is excluded only while busy_status period (command with MMC_RSP_BUSY and 
while busy line is low => "busy_status=1")

On SDMMC variant I noticed that busy_detect_flag status could be enabled
even if the command is not MMC_RSP_BUSY, for example sdmmc variant stay
in loop while cmd11 voltage switch.

So I wish extend host->variant->busy_detect_flag exclusion for all
commands which is not a MMC_RSP_BUSY. I suppose that other variants
could have the same behavior, and else there is no impact, normally.

> 
>> +
>> +               if (host->variant->busy_detect &&
>> +                   (!busy_resp || host->busy_status))
>>                          status &= ~host->variant->busy_detect_flag;
>>
>>                  ret = 1;
>> --
>> 2.7.4
>>
> 
> Kind regards
> Uffe
> 
