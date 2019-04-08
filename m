Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B68C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564C520883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="erxinA3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfDHItP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:49:15 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44378 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfDHItP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:49:15 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x388mJ3s090780;
        Mon, 8 Apr 2019 03:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554713299;
        bh=ATcM+ICuYD+MCg10D90c3cNVqQZYFkdw+5cTQSel2Tk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=erxinA3cBLpshfyIdEQVcZoXPMbCQu6Xad143X79cTA7lh6GvkMwPnOQA+t/B6vKj
         gcPQevIaT32HSs+UBt6aCKcDoYPiJdFnyDuHLN1NuP7n0hBSgvjj7kgTxqA06h+UaI
         HNue2/p6NEKtNRQDIVbZBv83HGH104nNmGKy+D0U=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x388mJHX122208
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Apr 2019 03:48:19 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 8 Apr
 2019 03:48:18 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 8 Apr 2019 03:48:18 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x388mFts031384;
        Mon, 8 Apr 2019 03:48:15 -0500
Subject: Re: [PATCH v2 1/4] ARM: davinci: fix cpufreq registration on
 da850-evm
To:     Adam Ford <aford173@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
References: <20190322133105.5945-1-brgl@bgdev.pl>
 <20190322133105.5945-2-brgl@bgdev.pl>
 <CAHCN7xJj_aA8XFR6=ZxO-WrfkJRY5fS6NgjHbeqpdfhUnn1apA@mail.gmail.com>
 <CAMpxmJVBTny7kzADSZHQXk_ZUjnRaNWu0Ly3WC8v+zPmR8Dizg@mail.gmail.com>
 <bb734e20-d2c7-73f4-e2c5-3b810ccf4c81@ti.com>
 <CAMRc=MdYhaED30Xu8oJiJD7F9z=SPu6u+1p32mQnX0tEL=iOiA@mail.gmail.com>
 <CAHCN7x+-GRBygMt9APi9sf19PQksfmXk9sOZUo-1YY40RhUmng@mail.gmail.com>
 <CAMRc=Md-XtFYP_c4afNDHdYDUV77tGpvau8AsG1KGwQ6Hm+FhQ@mail.gmail.com>
 <CAHCN7x+kAPYgFJ9iZQTPm2Vypni4CgmWmBw96fgbQr0ch456bw@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <3a31a498-232c-5f8f-5f4c-9dfaee0ad15a@ti.com>
Date:   Mon, 8 Apr 2019 14:18:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHCN7x+kAPYgFJ9iZQTPm2Vypni4CgmWmBw96fgbQr0ch456bw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/19 4:44 PM, Adam Ford wrote:
> On Thu, Apr 4, 2019 at 5:01 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> śr., 3 kwi 2019 o 17:49 Adam Ford <aford173@gmail.com> napisał(a):
>>>
>>> On Wed, Apr 3, 2019 at 7:50 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>>
>>>> śr., 27 mar 2019 o 12:14 Sekhar Nori <nsekhar@ti.com> napisał(a):
>>>>>
>>>>> Hi Bart,
>>>>>
>>>>> On 26/03/19 11:21 PM, Bartosz Golaszewski wrote:
>>>>>> wt., 26 mar 2019 o 15:00 Adam Ford <aford173@gmail.com> napisał(a):
>>>>>>>
>>>>>>> On Fri, Mar 22, 2019 at 8:31 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>>>>>>
>>>>>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>>>>>
>>>>>>>> The system_rev variable is never set on davinci and is always 0, so
>>>>>>>> we're using the default max operating point of 300MHz. The cvdd supply
>>>>>>>> comes from the tps6507 pmic and the voltage can go all the way to 1.3V
>>>>>>>> so the maximum supported rate should be 456MHz.
>>>>>>>
>>>>>>> My understanding is that only certain revisions of the silicon can go
>>>>>>> to 456MHz.   The L138's Datasheet lists both a 456 and 375 version.  I
>>>>>>> cannot find a way to read a register to determine which version of the
>>>>>>> silicon is available. Maybe Sekhar can confirm.
>>>>>>>
>>>>>>
>>>>>> Commit 28bd2c341120 ("davinci: am18x/da850/omap-l138 evm: add support
>>>>>> for higher speed grades") mentions the following:
>>>>>>
>>>>>> ---
>>>>>> U-Boot on the EVM sets up ATAG_REVISION to inform the OS
>>>>>> regarding the speed grade supported by the silicon. We use
>>>>>> this information to pass on the speed grade information to
>>>>>> the SoC code.
>>>>>> ---
>>>>>>
>>>>>> Should the system_rev somehow reflect that revision? Any way I can check it?
>>>>>
>>>>> Can you check if the procedure in doc/README.davinci in U-Boot sources
>>>>> still works?
>>>>>
>>>>> Environment Variables
>>>>> =====================
>>>>>
>>>>> The DA850 EVM allows the user to specify the maximum cpu clock allowed by the
>>>>> silicon, in Hz, via an environment variable "maxcpuclk".
>>>>>
>>>>> The maximum clock rate allowed depends on the silicon populated on the EVM.
>>>>> Please make sure you understand the restrictions placed on this clock in the
>>>>> device specific datasheet before setting up this variable. This information is
>>>>> passed to the Linux kernel using the ATAG_REVISION atag.
>>>>>
>>>>> If "maxcpuclk" is not defined, the configuration CONFIG_DA850_EVM_MAX_CPU_CLK
>>>>> is used to obtain this information.
>>>>>
>>>>> Thanks,
>>>>> Sekhar
>>>>
>>>> Hi Sekhar,
>>>>
>>>> I built the current upstream u-boot and the get_board_rev() function
>>>> for da850-evm doesn't seem to be called at all. For instance the
>>>> lego-ev3 platform does this:
>>>>
>>>> ./lego/ev3/legoev3.c:108: board_rev = get_board_rev();
>>>>
>>>> but in davinci this function seems to be unused and I don't see it
>>>> called from any other core u-boot component. I don't see any commit
>>>> that would mention this function but there are a lot of commits
>>>> removing get_board_rev() for other boards in git log. Is it possible
>>>> it stopped being used at some point?
>>>
>>> Look for setup_revision_tag in arch/arm/lib/bootm.c
>>>
>>> The function appears to be called from there.
>>>
>>> There is a __weak reference in the header file which I think allows
>>> people to remove them without breaking bootm.
>>>
>>> adam
>>>>
>>>> Bart
>>
>> Thanks, now verified that this still works in board file mode for
>> da850-evm. Now the questions is - what about DT mode? Should we only
>> enable the lowest possible mode (300MHz) and leave it to the user to
>> enable any higher frequencies?
> 
> From everything that I can find in Logic PD's database, the standard
> da850-evm kits and SOM's are 375MHz, so I think it's safe to run up to
> that speed.  I would disable the speed options for 408 and 456, but
> leave them shown for anyone who may have purchased a custom version
> with the 456MHz variant which I can also see there are some.  At least
> for the L138 and AM1808 SOM's, those customers who who they are, so
> making it obvious how to enable it would be a good thing.
> 
> Just my two cents.

Sounds good to me.

Thanks,
Sekhar
