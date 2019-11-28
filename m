Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993A5C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FAD216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfK1J11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 04:27:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:2166 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbfK1J11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 04:27:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 01:27:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,253,1571727600"; 
   d="scan'208";a="217563143"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.70]) ([10.237.72.70])
  by fmsmga001.fm.intel.com with ESMTP; 28 Nov 2019 01:27:24 -0800
Subject: Re: [PATCH] mmc: sdhci: Fix incorrect switch to HS mode
To:     Faiz Abbas <faiz_abbas@ti.com>, Alan Cooper <alcooperx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <20190903115114.33053-1-alcooperx@gmail.com>
 <CAPDyKFqaNBH3Thwy1O+KXkcsgM2gMrm9zNGYWH8vVP+Y2vSLdA@mail.gmail.com>
 <CAOGqxeUJD7eQxRnH1rep=m2+Ga5DDF=uWMsc_j2NZgC+EnZqsg@mail.gmail.com>
 <7e495749-1539-9164-d801-305a918318d6@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <6de5746e-bca2-fbe7-ff48-46103b9500a7@intel.com>
Date:   Thu, 28 Nov 2019 11:26:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7e495749-1539-9164-d801-305a918318d6@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/19 10:21 AM, Faiz Abbas wrote:
> Hi,
> 
> On 19/09/19 5:27 PM, Alan Cooper wrote:
>> This does correct the sequence of switching to HS400 but it might be
>> safest to just add this to the latest until it gets a little testing
>> to make sure it doesn't expose some bug in existing controllers.
>>
>> Thanks
>> Al
>>
>> On Tue, Sep 3, 2019 at 10:52 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>
>>> On Tue, 3 Sep 2019 at 13:51, Al Cooper <alcooperx@gmail.com> wrote:
>>>>
>>>> When switching from any MMC speed mode that requires 1.8v
>>>> (HS200, HS400 and HS400ES) to High Speed (HS) mode, the system
>>>> ends up configured for SDR12 with a 50MHz clock which is an illegal
>>>> mode.
>>>>
>>>> This happens because the SDHCI_CTRL_VDD_180 bit in the
>>>> SDHCI_HOST_CONTROL2 register is left set and when this bit is
>>>> set, the speed mode is controlled by the SDHCI_CTRL_UHS field
>>>> in the SDHCI_HOST_CONTROL2 register. The SDHCI_CTRL_UHS field
>>>> will end up being set to 0 (SDR12) by sdhci_set_uhs_signaling()
>>>> because there is no UHS mode being set.
>>>>
>>>> The fix is to change sdhci_set_uhs_signaling() to set the
>>>> SDHCI_CTRL_UHS field to SDR25 (which is the same as HS) for
>>>> any switch to HS mode.
> 
> This change has broken High speed mode in SD card for me in AM65x-evm. I
> guess this change only needs to be done for eMMC. SDR25 is decidedly not
> the same as high speed for SD card.

Shall we revert c894e33ddc1910e14d6f2a2016f60ab613fd8b37 and then Alan
could send a patch providing the desired behaviour in ->set_uhs_signaling()
of the relevant driver e.g.

void ???_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)
{
	if (timing == MMC_TIMING_SD_HS || timing == MMC_TIMING_MMC_HS)
		timing = MMC_TIMING_UHS_SDR25;
	sdhci_set_uhs_signaling(host, timing);
}
