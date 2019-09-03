Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545E9C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D38206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfICMDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:03:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:15387 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbfICMDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:03:53 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 05:03:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,462,1559545200"; 
   d="scan'208,223";a="187232392"
Received: from mylly.fi.intel.com (HELO [10.237.72.183]) ([10.237.72.183])
  by orsmga006.jf.intel.com with ESMTP; 03 Sep 2019 05:03:50 -0700
Subject: Re: Tweak I2C SDA hold time on GemniLake to make touchpad work
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Chris Chiu <chiu@endlessm.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lee.jones@linaro.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
References: <CAB4CAwdo7H3QNEHLgG-h1Z_eRYkb+pc=V3Wvrmeju8fBByYJzw@mail.gmail.com>
 <20190903081858.GA2691@lahna.fi.intel.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <3141a819-5964-4082-6f05-1926e16468b4@linux.intel.com>
Date:   Tue, 3 Sep 2019 15:03:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903081858.GA2691@lahna.fi.intel.com>
Content-Type: multipart/mixed;
 boundary="------------B8C321BFAC96BDF0C1C05235"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B8C321BFAC96BDF0C1C05235
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chris

On 9/3/19 11:18 AM, Mika Westerberg wrote:
> +Jarkko
> 
> On Tue, Sep 03, 2019 at 04:10:27PM +0800, Chris Chiu wrote:
>> Hi,
>>
>> We're working on the acer Gemnilake laptop TravelMate B118-M for
>> touchpad not working issue. The touchpad fails to bring up and the
>> i2c-hid ouput the message as follows
>>      [    8.317293] i2c_hid i2c-ELAN0502:00: hid_descr_cmd failed
>> We tried on latest linux kernel 5.3.0-rc6 and it reports the same.
>>
>> We then look into I2C signal level measurement to find out why.
>> The following is the signal output from LA for the SCL/SDA.
>> https://imgur.com/sKcpvdo
>> The SCL frequency is ~400kHz from the SCL period, but the SDA
>> transition is quite weird. Per the I2C spec, the data on the SDA line
>> must be stable during the high period of the clock. The HIGH or LOW
>> state of the data line can only change when the clock signal on the
>> SCL line is LOW. The SDA period span across 2 SCL high, I think
>> that's the reason why the I2C read the wrong data and fail to initialize.
>>
>> Thus, we treak the SDA hold time by the following modification.
>>
>> --- a/drivers/mfd/intel-lpss-pci.c
>> +++ b/drivers/mfd/intel-lpss-pci.c
>> @@ -97,7 +97,8 @@ static const struct intel_lpss_platform_info bxt_uart_info = {
>>   };
>>
>>   static struct property_entry bxt_i2c_properties[] = {
>> -       PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 42),
>> +       PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 230),
>>          PROPERTY_ENTRY_U32("i2c-sda-falling-time-ns", 171),
>>          PROPERTY_ENTRY_U32("i2c-scl-falling-time-ns", 208),
>>          { },
>>
>> The reason why I choose sda hold time is by the Table 10 of
>> https://www.nxp.com/docs/en/user-guide/UM10204.pdf, the device
>> must provide a hold time at lease 300ns and and 42 here is relatively
>> too small. The signal measurement result for the same pin on Windows
>> is as follows.
>> https://imgur.com/BtKUIZB
>> Comparing to the same result running Linux
>> https://imgur.com/N4fPTYN
>>
>> After applying the sda hold time tweak patch above, the touchpad can
>> be correctly initialized and work. The LA signal is shown as down below.
>> https://imgur.com/B3PmnIp
>>
Could you try does attached patch work for you?

It's from last year for another related issue but there platform was 
actually Apollo Lake instead of Gemini Lake but anyway it was found out 
that Windows uses different timing parameters than Linux on Gemini Lake.

I didn't take patch forward back then due known Gemini Lake machines 
were working with the Broxton I2C timing parameters but now it's time if 
attached patch fixes the issue on your machine.

Patch is from top of v5.3-rc7 but should probably apply also to older 
kernels.

-- 
Jarkko

--------------B8C321BFAC96BDF0C1C05235
Content-Type: text/x-patch;
 name="0001-mfd-intel-lpss-Add-default-I2C-device-properties-for.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-mfd-intel-lpss-Add-default-I2C-device-properties-for.pa";
 filename*1="tch"

From c1b1aa445838a67617bda5e8de47a0f25bea16df Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Date: Wed, 14 Nov 2018 13:37:16 +0200
Subject: [PATCH] mfd: intel-lpss: Add default I2C device properties for Gemini
 Lake

It turned out Intel Gemini Lake doesn't use the same I2C timing
parameters as Broxton.

I got confirmation from the Windows team that Gemini Lake systems should
use updated timing parameters that differ from those used in Broxton
based systems.

Fixes: f80e78aa11ad ("mfd: intel-lpss: Add Intel Gemini Lake PCI IDs")
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
This is not immediate stable material since there is no regression
related to this. Those machines that need updated parameters have
obviously never worked and I don't want this to cause regression either
so better to let this get some test coverage first.
---
 drivers/mfd/intel-lpss-pci.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index ade6e1ce5a98..269cb851a596 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -120,6 +120,18 @@ static const struct intel_lpss_platform_info apl_i2c_info = {
 	.properties = apl_i2c_properties,
 };
 
+static struct property_entry glk_i2c_properties[] = {
+	PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 313),
+	PROPERTY_ENTRY_U32("i2c-sda-falling-time-ns", 171),
+	PROPERTY_ENTRY_U32("i2c-scl-falling-time-ns", 290),
+	{ },
+};
+
+static const struct intel_lpss_platform_info glk_i2c_info = {
+	.clk_rate = 133000000,
+	.properties = glk_i2c_properties,
+};
+
 static const struct intel_lpss_platform_info cnl_i2c_info = {
 	.clk_rate = 216000000,
 	.properties = spt_i2c_properties,
@@ -172,14 +184,14 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x1ac6), (kernel_ulong_t)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x1aee), (kernel_ulong_t)&bxt_uart_info },
 	/* GLK */
-	{ PCI_VDEVICE(INTEL, 0x31ac), (kernel_ulong_t)&bxt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x31ae), (kernel_ulong_t)&bxt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x31b0), (kernel_ulong_t)&bxt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x31b2), (kernel_ulong_t)&bxt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x31b4), (kernel_ulong_t)&bxt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x31b6), (kernel_ulong_t)&bxt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x31b8), (kernel_ulong_t)&bxt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x31ba), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x31ac), (kernel_ulong_t)&glk_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x31ae), (kernel_ulong_t)&glk_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x31b0), (kernel_ulong_t)&glk_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x31b2), (kernel_ulong_t)&glk_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x31b4), (kernel_ulong_t)&glk_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x31b6), (kernel_ulong_t)&glk_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x31b8), (kernel_ulong_t)&glk_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x31ba), (kernel_ulong_t)&glk_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x31bc), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x31be), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x31c0), (kernel_ulong_t)&bxt_uart_info },
-- 
2.23.0.rc1


--------------B8C321BFAC96BDF0C1C05235--
