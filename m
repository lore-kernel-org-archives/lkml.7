Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8D9C04AAA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24046205ED
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ypZr4/Ix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfECPPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 11:15:20 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9842 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728153AbfECPPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 11:15:19 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x43F62RV017185;
        Fri, 3 May 2019 17:15:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=8DawQvv/zqFabgNWPmRdhTtTHiA+WeCJUXr6hjLZOlM=;
 b=ypZr4/Ixn6xpsm+n6FkR9Ojs95HhY2gKyCQFM9XvUW1RCzOTZfGvANzDvPIx5rfxc8Kr
 /J000WheVL2zFf8UXmTXEEq8SsxtUKt4sCD9dwwGSyxlACXuaFuklqptWSYdpSSF6asY
 Ta8IMT3DuoQoYEuZ+cUUjbolCImAEEKVRw3Ks7xuxHCjmTfO914H0aRpLYOuTgcAdlPj
 kdTTz3aFbOCAVea3udPeu0rdWTGWAdUASenQzFp1Rt25TYG4KJUaKqE758lOgsFJ7+Hi
 GjW5ufiQRtEDX/0Q9aUoXPCRFdZDIoDVQRCHjlCQqDbXMjbcL/h9xLeUnlZGTN45gzGD oQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2s6xgrxnrc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 03 May 2019 17:15:05 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7D0323A;
        Fri,  3 May 2019 15:15:04 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 588042930;
        Fri,  3 May 2019 15:15:04 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.45) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 3 May
 2019 17:15:03 +0200
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
 <74b91eb4-e5a3-38b2-f732-29cdd058eb6a@st.com>
 <CAPDyKFoURwnai1hbCbO+Uh6+hc7A4dYHjWkqeFAEgMQET-BzwA@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <bccca4e0-849d-2589-c144-296cc273245d@st.com>
Date:   Fri, 3 May 2019 17:15:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoURwnai1hbCbO+Uh6+hc7A4dYHjWkqeFAEgMQET-BzwA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-03_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ulf

On 5/3/19 3:29 PM, Ulf Hansson wrote:
> On Tue, 30 Apr 2019 at 14:06, Ludovic BARRE <ludovic.barre@st.com> wrote:
>>
>>
>>
>> On 4/30/19 1:13 PM, Ulf Hansson wrote:
>>> On Fri, 26 Apr 2019 at 09:46, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>>>
>>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>>
>>>> This patch series adds busy detect for stm32 sdmmc variant.
>>>> Some adaptations are required:
>>>> -Avoid to check and poll busy status when is not expected.
>>>> -Clear busy status bit if busy_detect_flag and busy_detect_mask are
>>>>    different.
>>>> -Add hardware busy timeout with MMCIDATATIMER register.
>>>>
>>>> V2:
>>>> -mmci_cmd_irq cleanup in separate patch.
>>>> -simplify the busy_detect_flag exclude
>>>> -replace sdmmc specific comment in
>>>> "mmc: mmci: avoid fake busy polling in mmci_irq"
>>>> to focus on common behavior
>>>>
>>>> Ludovic Barre (5):
>>>>     mmc: mmci: cleanup mmci_cmd_irq for busy detect feature
>>>>     mmc: mmci: avoid fake busy polling in mmci_irq
>>>>     mmc: mmci: fix clear of busy detect status
>>>>     mmc: mmci: add hardware busy timeout feature
>>>>     mmc: mmci: add busy detect for stm32 sdmmc variant
>>>>
>>>>    drivers/mmc/host/mmci.c | 61 ++++++++++++++++++++++++++++++++++++++-----------
>>>>    drivers/mmc/host/mmci.h |  3 +++
>>>>    2 files changed, 51 insertions(+), 13 deletions(-)
>>>>
>>>> --
>>>> 2.7.4
>>>>
>>>
>>> Ludovic, just wanted to let you know that I am reviewing and testing
>>> this series.
>>>
>>> However, while running some tests on Ux500 for validating the busy
>>> detection code, even without your series applied, I encounter some odd
>>> behaviors. I am looking into the problem to understand better and will
>>> let you know as soon as I have some more data to share.
>>
>> Oops, don't hesitate to share your status, if I could help.
> 
> Thanks! Good and bad news here, then.
> 
> I now understand what is going on - and there is certainly room for
> improvements here, but more importantly the actual mmci busy detection
> works as expected.
> 
> When it comes to improvements, the main issue I have found is how we
> treat DATA WRITES. In many cases we simply don't use the HW busy
> detection at all, but instead rely on the mmc core to send CMD13 in a
> loop to poll. Well, then if the polling would have consisted of a
> couple of CMD13s that wouldn't be an issue, but my observations is
> rather that the numbers of CMD13 sent to poll is in the range or
> hundreds/thousands - per each WRITE request!
> 
> I am going to send a patch (or two) that improves the behavior. It
> might even involve changing parts in core layer, not sure how the end
> result will look like yet.

yes, these will improve the drivers without hardware busy completion.
great

> 
> In any case, I have applied patch 1 and patch2 for next, as the tests
> turned out well at my side. I also took the liberty of updating some
> of the comments/changelogs, please have look and tell if there is
> something you want to change.
> 
> I will continue with the rest of series next week.

thanks, and good week-end.

> 
> Kind regards
> Uffe
> 
