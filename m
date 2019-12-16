Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1865C2D0CE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 03:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18E92465E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 03:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfLPDXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 22:23:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:13122 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbfLPDXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 22:23:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Dec 2019 19:23:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,320,1571727600"; 
   d="scan'208";a="212096532"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 15 Dec 2019 19:23:04 -0800
Received: from [10.226.38.59] (unknown [10.226.38.59])
        by linux.intel.com (Postfix) with ESMTP id 2A22F580479;
        Sun, 15 Dec 2019 19:23:01 -0800 (PST)
Subject: Re: [PATCH v8 1/2] dt-bindings: phy: intel-emmc-phy: Add YAML schema
 for LGM eMMC PHY
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
References: <20191212015320.20969-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191212015320.20969-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191213190819.GA19560@bogus>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <fc4a2812-56d8-3008-151a-d143993da803@linux.intel.com>
Date:   Mon, 16 Dec 2019 11:23:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191213190819.GA19560@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    Thank you for the review comments.

On 14/12/2019 3:08 AM, Rob Herring wrote:
> On Thu, Dec 12, 2019 at 09:53:19AM +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add a YAML schema to use the host controller driver with the
>> eMMC PHY on Intel's Lightning Mountain SoC.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   .../bindings/phy/intel,lgm-emmc-phy.yaml           | 62 ++++++++++++++++++++++
>>   1 file changed, 62 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>> new file mode 100644
>> index 000000000000..aed11258d96d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>> @@ -0,0 +1,62 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/intel,lgm-emmc-phy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Intel Lightning Mountain(LGM) eMMC PHY Device Tree Bindings
>> +
>> +maintainers:
>> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> +
>> +description: |+
>> +  Bindings for eMMC PHY on Intel's Lightning Mountain SoC, syscon
>> +  node is used to reference the base address of eMMC phy registers.
>> +
>> +  The eMMC PHY node should be the child of a syscon node with the
>> +  required property:
>> +
>> +  - compatible:         Should be one of the following:
>> +                        "intel,lgm-syscon", "syscon"
>> +  - reg:
>> +      maxItems: 1
>> +
>> +properties:
>> +  compatible:
>> +    contains:
> You need to drop 'contains'. That implies other strings can also be
> present.
Sure, I will drop contains..
>> +      const: intel,lgm-emmc-phy
>> +
>> +  "#phy-cells":
>> +    const: 0
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    maxItems: 1
> Drop maxItems. It should be:
>
> const: emmcclk
>
> Or just drop clock-names because you don't really need *-names when
> there is only 1.

Noted, fix it.

With Best Regards
Vadivel
>> +
>> +required:
>> +  - "#phy-cells"
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +
>> +examples:
>> +  - |
>> +    sysconf: chiptop@e0200000 {
>> +      compatible = "intel,lgm-syscon", "syscon";
>> +      reg = <0xe0200000 0x100>;
>> +
>> +      emmc-phy: emmc-phy@a8 {
>> +        compatible = "intel,lgm-emmc-phy";
>> +        reg = <0x00a8 0x10>;
>> +        clocks = <&emmc>;
>> +        clock-names = "emmcclk";
>> +        #phy-cells = <0>;
>> +      };
>> +    };
>> +...
>> -- 
>> 2.11.0
>>
