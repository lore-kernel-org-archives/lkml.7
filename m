Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6A3C32771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E553C21D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgACDyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 22:54:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:43296 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgACDyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 22:54:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2020 19:54:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,389,1571727600"; 
   d="scan'208";a="209975425"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 02 Jan 2020 19:54:54 -0800
Received: from [10.226.39.29] (unknown [10.226.39.29])
        by linux.intel.com (Postfix) with ESMTP id 52AE1580277;
        Thu,  2 Jan 2020 19:54:52 -0800 (PST)
Subject: Re: [PATCH v5 2/2] reset: intel: Add system reset controller driver
To:     Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     robh@kernel.org, martin.blumenstingl@googlemail.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
References: <a58894158cba812e6d35df165252772b07c8a0b6.1576202050.git.eswara.kota@linux.intel.com>
 <decb025c9bd0ddc1da96801e57242bc8f5ce35d0.1576202050.git.eswara.kota@linux.intel.com>
 <fe55d2c00eda2d1b94e69fe2df05114ba88b5128.camel@pengutronix.de>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <ad18d120-e943-57ff-de58-4812fc415cd0@linux.intel.com>
Date:   Fri, 3 Jan 2020 11:54:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <fe55d2c00eda2d1b94e69fe2df05114ba88b5128.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/2/2020 7:43 PM, Philipp Zabel wrote:
> On Mon, 2019-12-16 at 14:55 +0800, Dilip Kota wrote:
>> Add driver for the reset controller present on Intel
>> Gateway SoCs for performing reset management of the
>> devices present on the SoC. Driver also registers a
>> reset handler to peform the entire device reset.
>>
>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
>> ---
>> Changes on v5:
>> 	Rebase patches on v5.5-rc1 kernel
>>
>> Changes on v4:
>> 	No Change
>>
>> Changes on v3:
>> 	Address review comments:
>> 		Remove intel_reset_device() as not supported
>> 	reset-intel-syscon.c renamed to reset-intel-gw.c
>> 	Remove syscon and add regmap logic
>> 	Add support to legacy xrx200 SoC
>> 	Use bitfield helper functions for bit operations.
>> 	Change config RESET_INTEL_SYSCON-> RESET_INTEL_GW
>>   drivers/reset/Kconfig          |   9 ++
>>   drivers/reset/Makefile         |   1 +
>>   drivers/reset/reset-intel-gw.c | 262 +++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 272 insertions(+)
>>   create mode 100644 drivers/reset/reset-intel-gw.c
[...]
>> +					set == !!(val & BIT(stat_bit)),
>> +					20, timeout);
>> +}
>> +
>> +static int intel_assert_device(struct reset_controller_dev *rcdev,
>> +			       unsigned long id)
>> +{
>> +	struct intel_reset_data *data = to_reset_data(rcdev);
>> +	int ret;
>> +
>> +	ret = intel_set_clr_bits(data, id, true, 200);
> timeout doesn't have to be a parameter to intel_set_clr_bits.
Agree, not required to be a parameter.
Will update in the next patch version.
>
> [...]
>> +struct intel_reset_soc xrx200_data = {
>> +	.legacy =		true,
>> +	.reset_cell_count =	3,
>> +};
>> +
>> +struct intel_reset_soc lgm_data = {
>> +	.legacy =		false,
>> +	.reset_cell_count =	2,
>> +};
> Please make these two static const, otherwise this looks fine to me.
My miss, could have taken care.

I will update them in the next patch version.

Thanks Philipp for your time in reviewing the patch and giving the inputs.

Regards,
Dilip

>
> regards
> Philipp
>
