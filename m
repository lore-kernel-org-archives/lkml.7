Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15965C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 05:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E670D23404
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 05:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfIDFyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 01:54:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:57925 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfIDFyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 01:54:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 22:54:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,465,1559545200"; 
   d="scan'208";a="212262724"
Received: from mylly.fi.intel.com (HELO [10.237.72.68]) ([10.237.72.68])
  by fmsmga002.fm.intel.com with ESMTP; 03 Sep 2019 22:54:08 -0700
Subject: Re: Tweak I2C SDA hold time on GemniLake to make touchpad work
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lee.jones@linaro.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
References: <CAB4CAwdo7H3QNEHLgG-h1Z_eRYkb+pc=V3Wvrmeju8fBByYJzw@mail.gmail.com>
 <20190903081858.GA2691@lahna.fi.intel.com>
 <3141a819-5964-4082-6f05-1926e16468b4@linux.intel.com>
 <CAB4CAwdRHQOiqrK5utgCzZKB-X+mDcJePBLa7o0rTWzAogo5vw@mail.gmail.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <63364b2f-dc55-4fcb-5de5-d09c9622943a@linux.intel.com>
Date:   Wed, 4 Sep 2019 08:54:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAB4CAwdRHQOiqrK5utgCzZKB-X+mDcJePBLa7o0rTWzAogo5vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/19 7:38 AM, Chris Chiu wrote:
> On Tue, Sep 3, 2019 at 8:03 PM Jarkko Nikula
> <jarkko.nikula@linux.intel.com> wrote:
>>
>> Hi Chris
>>
>> On 9/3/19 11:18 AM, Mika Westerberg wrote:
>>> +Jarkko
>>>
>>> On Tue, Sep 03, 2019 at 04:10:27PM +0800, Chris Chiu wrote:
>>>> Hi,
>>>>
>>>> We're working on the acer Gemnilake laptop TravelMate B118-M for
>>>> touchpad not working issue. The touchpad fails to bring up and the
>>>> i2c-hid ouput the message as follows
>>>>       [    8.317293] i2c_hid i2c-ELAN0502:00: hid_descr_cmd failed
>>>> We tried on latest linux kernel 5.3.0-rc6 and it reports the same.
>>>>
>>>> We then look into I2C signal level measurement to find out why.
>>>> The following is the signal output from LA for the SCL/SDA.
>>>> https://imgur.com/sKcpvdo
>>>> The SCL frequency is ~400kHz from the SCL period, but the SDA
>>>> transition is quite weird. Per the I2C spec, the data on the SDA line
>>>> must be stable during the high period of the clock. The HIGH or LOW
>>>> state of the data line can only change when the clock signal on the
>>>> SCL line is LOW. The SDA period span across 2 SCL high, I think
>>>> that's the reason why the I2C read the wrong data and fail to initialize.
>>>>
>>>> Thus, we treak the SDA hold time by the following modification.
>>>>
>>>> --- a/drivers/mfd/intel-lpss-pci.c
>>>> +++ b/drivers/mfd/intel-lpss-pci.c
>>>> @@ -97,7 +97,8 @@ static const struct intel_lpss_platform_info bxt_uart_info = {
>>>>    };
>>>>
>>>>    static struct property_entry bxt_i2c_properties[] = {
>>>> -       PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 42),
>>>> +       PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 230),
>>>>           PROPERTY_ENTRY_U32("i2c-sda-falling-time-ns", 171),
>>>>           PROPERTY_ENTRY_U32("i2c-scl-falling-time-ns", 208),
>>>>           { },
>>>>
>>>> The reason why I choose sda hold time is by the Table 10 of
>>>> https://www.nxp.com/docs/en/user-guide/UM10204.pdf, the device
>>>> must provide a hold time at lease 300ns and and 42 here is relatively
>>>> too small. The signal measurement result for the same pin on Windows
>>>> is as follows.
>>>> https://imgur.com/BtKUIZB
>>>> Comparing to the same result running Linux
>>>> https://imgur.com/N4fPTYN
>>>>
>>>> After applying the sda hold time tweak patch above, the touchpad can
>>>> be correctly initialized and work. The LA signal is shown as down below.
>>>> https://imgur.com/B3PmnIp
>>>>
>> Could you try does attached patch work for you?
>>
>> It's from last year for another related issue but there platform was
>> actually Apollo Lake instead of Gemini Lake but anyway it was found out
>> that Windows uses different timing parameters than Linux on Gemini Lake.
>>
>> I didn't take patch forward back then due known Gemini Lake machines
>> were working with the Broxton I2C timing parameters but now it's time if
>> attached patch fixes the issue on your machine.
>>
>> Patch is from top of v5.3-rc7 but should probably apply also to older
>> kernels.
>>
>> --
>> Jarkko
> 
> Thanks, Jarkko, the patche works on my acer laptops.
> 
Thanks. I'll send the patch out with Cc'ing you. I took the freedom to 
add your Tested-by tag if you don't mind :-)

-- 
Jarkko
