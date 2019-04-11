Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB5DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1804B2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="aLZGy6/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfDKNvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:51:25 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37065 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726106AbfDKNvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:51:24 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3BDkYDe025112;
        Thu, 11 Apr 2019 15:51:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=ntcwIbTwd44AUt8hPXYJEOojEPeZpDfeAqcuc0hDPOs=;
 b=aLZGy6/OL/C43liXNhuV108NBbAyM3m4IhYpdqgZNThU9EDvvQBqHhwqCugO8KhULocI
 76Ps9NoKrc4wQN6ioyb1MEDnrP0G1jBgX+1evXvibGkD02WW12P2uSFNrAi/TkIpe9ci
 nY64M5YzLcdLCnqZNXvjJYMKvAOGRlbu/684IEWrfshNfX7a1BVrI0gt7OYLHxSy0ldX
 10In38KM86hc2llFi+GjaADRcCJqGlGXVHyMadeWPjZ2Ac8p5RO1i8UH0XVYrzXPpaD+
 u6Po0X3s1f18SKGFeGinyRibHWq+XX7iF17U9jAO37ztt22AfVgpWxqEo80V3sD6QeE3 Rw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rse78ff6v-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 11 Apr 2019 15:51:12 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0F69A3D;
        Thu, 11 Apr 2019 13:51:12 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A8B7D2555;
        Thu, 11 Apr 2019 13:51:11 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.46) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 11 Apr
 2019 15:51:10 +0200
Subject: Re: [PATCH 0/4] mmc: mmci: add busy detect for stm32 sdmmc variant
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
 <5b9fe100-6147-d64f-f676-6a5370a03016@st.com>
 <CAPDyKFpRA4mP-SHt_JuWk-Ee7=2Jgv6jKFh_08n_V20czKyvNg@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <6cae3029-b40c-d43c-0712-47a472e8b1af@st.com>
Date:   Thu, 11 Apr 2019 15:51:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpRA4mP-SHt_JuWk-Ee7=2Jgv6jKFh_08n_V20czKyvNg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-11_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ulf

On 4/11/19 3:29 PM, Ulf Hansson wrote:
> On Thu, 11 Apr 2019 at 14:37, Ludovic BARRE <ludovic.barre@st.com> wrote:
>>
>> Hi Ulf
>>
>> Just a gentleman ping about this series.
>> I sent this series at same time of dt_mode
>> (no dependence between both).
> 
> Thanks for pinging.
> 
> It's been a busy period, with travels etc. I am just catching up on
> everything and I will soon come back to this.

No problem, I saw lot of power group presentations at linaro connect :-)

> 
> I haven't tried to apply this on top of the other recent queued
> changes for mmci, but perhaps you can check if a rebase is needed?

I try on the last mmc next, rebase, build and stm32mp157 test OK

> Especially since I plan to run this on my ux500 board.
> 
> Kind regards
> Uffe
> 
>>
>> BR
>> Ludo
>>
>> On 3/5/19 5:10 PM, Ludovic Barre wrote:
>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>
>>> This patch series adds busy detect for stm32 sdmmc variant.
>>> Some adaptations are required:
>>> -Avoid to check and poll busy status when is not expected.
>>> -Clear busy status bit if busy_detect_flag and busy_detect_mask are
>>>    different.
>>> -Add hardware busy timeout with MMCIDATATIMER register.
>>>
>>> Ludovic Barre (4):
>>>     mmc: mmci: avoid fake busy polling
>>>     mmc: mmci: fix clear of busy detect status
>>>     mmc: mmci: add hardware busy timeout feature
>>>     mmc: mmci: add busy detect for stm32 sdmmc variant
>>>
>>>    drivers/mmc/host/mmci.c | 67 +++++++++++++++++++++++++++++++++++++++----------
>>>    drivers/mmc/host/mmci.h |  3 +++
>>>    2 files changed, 57 insertions(+), 13 deletions(-)
>>>
