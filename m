Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A4EC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2472321741
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b9U7ovKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfK1KME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:12:04 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54028 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfK1KMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:12:03 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xASAC0Nw088155;
        Thu, 28 Nov 2019 04:12:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574935920;
        bh=fUJokwFNOJXpknCrMcpTrziKaDtWMVGaJuYHRrG6Rm8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=b9U7ovKZraVzYMXkUIiwnORlbBokw3ywoFl1iccuIGg3caScMd8Mv4QwHYCVcryXQ
         vcD+fuRj4km9GQf4wEDAbe1ZkdidY4zBg9VP9t0RlA08eHwV6JMxNHsvidCK+nCn7s
         TtCxnW3FccsUhwgnXKySLfm+jsDsdRMKagfZLc24=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xASAC0nP063319;
        Thu, 28 Nov 2019 04:12:00 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 28
 Nov 2019 04:11:59 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 28 Nov 2019 04:11:59 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xASABvep023862;
        Thu, 28 Nov 2019 04:11:58 -0600
Subject: Re: [PATCH] mmc: sdhci: Fix incorrect switch to HS mode
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Alan Cooper <alcooperx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <20190903115114.33053-1-alcooperx@gmail.com>
 <CAPDyKFqaNBH3Thwy1O+KXkcsgM2gMrm9zNGYWH8vVP+Y2vSLdA@mail.gmail.com>
 <CAOGqxeUJD7eQxRnH1rep=m2+Ga5DDF=uWMsc_j2NZgC+EnZqsg@mail.gmail.com>
 <7e495749-1539-9164-d801-305a918318d6@ti.com>
 <6de5746e-bca2-fbe7-ff48-46103b9500a7@intel.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <18618a7b-3ba4-86b3-b6db-29cc501e4594@ti.com>
Date:   Thu, 28 Nov 2019 15:42:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6de5746e-bca2-fbe7-ff48-46103b9500a7@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian,

On 28/11/19 2:56 PM, Adrian Hunter wrote:
> On 28/11/19 10:21 AM, Faiz Abbas wrote:
>> Hi,
>>
>> On 19/09/19 5:27 PM, Alan Cooper wrote:
>>> This does correct the sequence of switching to HS400 but it might be
>>> safest to just add this to the latest until it gets a little testing
>>> to make sure it doesn't expose some bug in existing controllers.
>>>
>>> Thanks
>>> Al
>>>
>>> On Tue, Sep 3, 2019 at 10:52 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>>
>>>> On Tue, 3 Sep 2019 at 13:51, Al Cooper <alcooperx@gmail.com> wrote:
>>>>>
>>>>> When switching from any MMC speed mode that requires 1.8v
>>>>> (HS200, HS400 and HS400ES) to High Speed (HS) mode, the system
>>>>> ends up configured for SDR12 with a 50MHz clock which is an illegal
>>>>> mode.
>>>>>
>>>>> This happens because the SDHCI_CTRL_VDD_180 bit in the
>>>>> SDHCI_HOST_CONTROL2 register is left set and when this bit is
>>>>> set, the speed mode is controlled by the SDHCI_CTRL_UHS field
>>>>> in the SDHCI_HOST_CONTROL2 register. The SDHCI_CTRL_UHS field
>>>>> will end up being set to 0 (SDR12) by sdhci_set_uhs_signaling()
>>>>> because there is no UHS mode being set.
>>>>>
>>>>> The fix is to change sdhci_set_uhs_signaling() to set the
>>>>> SDHCI_CTRL_UHS field to SDR25 (which is the same as HS) for
>>>>> any switch to HS mode.
>>
>> This change has broken High speed mode in SD card for me in AM65x-evm. I
>> guess this change only needs to be done for eMMC. SDR25 is decidedly not
>> the same as high speed for SD card.
> 
> Shall we revert c894e33ddc1910e14d6f2a2016f60ab613fd8b37 and then Alan
> could send a patch providing the desired behaviour in ->set_uhs_signaling()
> of the relevant driver e.g.
> 
> void ???_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)
> {
> 	if (timing == MMC_TIMING_SD_HS || timing == MMC_TIMING_MMC_HS)
> 		timing = MMC_TIMING_UHS_SDR25;
> 	sdhci_set_uhs_signaling(host, timing);
> }
> 
Yes. Lets do that. I will send the revert.

Thanks,
Faiz
