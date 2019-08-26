Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58882C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 04:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1ED217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 04:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfHZEBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 00:01:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:15516 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfHZEBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 00:01:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Aug 2019 21:01:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,431,1559545200"; 
   d="scan'208";a="379508788"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 25 Aug 2019 21:01:07 -0700
Received: from [10.226.39.5] (leichuan-mobl.gar.corp.intel.com [10.226.39.5])
        by linux.intel.com (Postfix) with ESMTP id C8AAE580444;
        Sun, 25 Aug 2019 21:01:05 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] reset: Reset controller driver for Intel LGM SoC
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        eswara.kota@linux.intel.com
Cc:     cheol.yong.kim@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        qi-ming.wu@intel.com, robh@kernel.org, hauke@hauke-m.de
References: <90cc600d6f7ded68f5a618b626bd9cffa5edf5c3.1566531960.git.eswara.kota@linux.intel.com>
 <20190824211158.5900-1-martin.blumenstingl@googlemail.com>
From:   "Chuan Hua, Lei" <chuanhua.lei@linux.intel.com>
Message-ID: <3813e658-1600-d878-61a4-29b4fe51b281@linux.intel.com>
Date:   Mon, 26 Aug 2019 12:01:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190824211158.5900-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thanks for your comment.

On 8/25/2019 5:11 AM, Martin Blumenstingl wrote:
> Hi Dilip,
>
>> Add driver for the reset controller present on Intel
>> Lightening Mountain (LGM) SoC for performing reset
>> management of the devices present on the SoC. Driver also
>> registers a reset handler to peform the entire device reset.
> [...]
>> +static const struct of_device_id intel_reset_match[] = {
>> +	{ .compatible = "intel,rcu-lgm" },
>> +	{}
>> +};
> how is this IP block differnet from the one used in many Lantiq SoCs?
> there is already an upstream driver for the RCU IP block on the Lantiq
> SoCs: drivers/reset/reset-lantiq.c
>
> some background:
> Lantiq was started as a spinoff from Infineon in 2009. Intel then
> acquired Lantiq in 2015. source: [0]
> Intel is re-using some of the IP blocks from the MIPS Lantiq SoCs
> (Intel even has some own MIPS SoCs as part of the Lantiq acquisition,
> typically used for PON/GPON/ADSL/VDSL capable network devices).
> Thus I think it is likely that the new "Lightening Mountain" SoCs use
> an updated version of the Lantiq RCU IP.

I would not say there is a fundamental difference since reset is a 
really simple

stuff from all reset drivers.  However, it did have some difference

from existing reset-lantiq.c since SoC becomes more and more complex.

1. reset-lantiq.c use index instead of register offset + bit position.

index reset is good for a small system (< 64). However, it will become very

difficult to use if you have  > 100 reset. So we use register offset + 
bit position

2. reset-lantiq.c does not support device restart which is part of the 
reset in

old lantiq SoC. It moved this part into arch/mips/lantiq directory.

3. reset-lantiqc reset callback doesn't implement what hardware implemented

function. In old SoCs, some bits in the same register can be hardware 
reset clear.

It just call assert + assert. For these SoCs, we should only call 
assert, hardware

will auto deassert.

4. Code not optimized and intel internal review not assessed.

Based on the above findings, I would suggest reset-lantiq.c to move to 
reset-intel-syscon.c

What is your opinion?


Chuanhua

>
>
> Martin
>
>
> [0] https://wikidevi.com/wiki/Lantiq
