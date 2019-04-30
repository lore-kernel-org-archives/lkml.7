Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AB1C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913012075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="NmBhW31f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfD3MHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 08:07:00 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:51322 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727948AbfD3MG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 08:06:58 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3UBv3l2016156;
        Tue, 30 Apr 2019 14:06:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=0TJCqpAByJcnuLJ0JtSeGC0DKLxILjaYjgU3/kNbuek=;
 b=NmBhW31fR9zLCaqeXjHXtkG5/BQARi8G719yE+lA8MT+RIjgdhnjtI1rVcuizf7yT2ha
 fjDWIVwaVZSlTvU+BQ5dakHKoI4uCLaihfSydWw9ymEnQMIQw/okuMvLQsvrMGWXKxXZ
 GvMl+PTikZK8q0t2qdIM6Wp0qCLDy9SPY+96JOdYQJcfWmBAHr/aaxtWiOTacXyqWHrf
 OhfzASaUV7E5u14LxjwzJJcXL1ttxOO+/P3p/A2fZvY4GtqzZxcfIFzrtwOb5hAL8VqO
 AezCbzmDnt4DyRPwqmw/Ndi+MwL2iff+nGvUwXGhPOUAN1SdbLZ9QxNc/dxu4MPizXjI 7Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2s61q8dqy5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 30 Apr 2019 14:06:47 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 082673A;
        Tue, 30 Apr 2019 12:06:47 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D06F22516;
        Tue, 30 Apr 2019 12:06:46 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.48) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 30 Apr
 2019 14:06:46 +0200
Subject: Re: [PATCH V2 0/5] mmc: mmci: add busy detect for stm32 sdmmc variant
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
References: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFqbn=UcbwoH_z+yjrjvHQZaMtmsD=n0yrBV7DAK5VRJEQ@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <74b91eb4-e5a3-38b2-f732-29cdd058eb6a@st.com>
Date:   Tue, 30 Apr 2019 14:06:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqbn=UcbwoH_z+yjrjvHQZaMtmsD=n0yrBV7DAK5VRJEQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-30_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/30/19 1:13 PM, Ulf Hansson wrote:
> On Fri, 26 Apr 2019 at 09:46, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch series adds busy detect for stm32 sdmmc variant.
>> Some adaptations are required:
>> -Avoid to check and poll busy status when is not expected.
>> -Clear busy status bit if busy_detect_flag and busy_detect_mask are
>>   different.
>> -Add hardware busy timeout with MMCIDATATIMER register.
>>
>> V2:
>> -mmci_cmd_irq cleanup in separate patch.
>> -simplify the busy_detect_flag exclude
>> -replace sdmmc specific comment in
>> "mmc: mmci: avoid fake busy polling in mmci_irq"
>> to focus on common behavior
>>
>> Ludovic Barre (5):
>>    mmc: mmci: cleanup mmci_cmd_irq for busy detect feature
>>    mmc: mmci: avoid fake busy polling in mmci_irq
>>    mmc: mmci: fix clear of busy detect status
>>    mmc: mmci: add hardware busy timeout feature
>>    mmc: mmci: add busy detect for stm32 sdmmc variant
>>
>>   drivers/mmc/host/mmci.c | 61 ++++++++++++++++++++++++++++++++++++++-----------
>>   drivers/mmc/host/mmci.h |  3 +++
>>   2 files changed, 51 insertions(+), 13 deletions(-)
>>
>> --
>> 2.7.4
>>
> 
> Ludovic, just wanted to let you know that I am reviewing and testing
> this series.
> 
> However, while running some tests on Ux500 for validating the busy
> detection code, even without your series applied, I encounter some odd
> behaviors. I am looking into the problem to understand better and will
> let you know as soon as I have some more data to share.

Oops, don't hesitate to share your status, if I could help.

> 
> Kind regards
> Uffe
> 
