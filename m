Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88F1C43141
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 06:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8591C20722
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 06:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfKYGuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 01:50:10 -0500
Received: from mga05.intel.com ([192.55.52.43]:40999 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfKYGuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 01:50:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2019 22:50:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,240,1571727600"; 
   d="scan'208";a="198356887"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 24 Nov 2019 22:50:09 -0800
Received: from [10.226.39.11] (unknown [10.226.39.11])
        by linux.intel.com (Postfix) with ESMTP id 87D3D580495;
        Sun, 24 Nov 2019 22:50:07 -0800 (PST)
Subject: Re: [PATCH v3 1/2] dt-bindings: reset: Add YAML schemas for the Intel
 Reset controller
To:     Rob Herring <robh@kernel.org>
Cc:     p.zabel@pengutronix.de, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
References: <0c53fd1100e357f6793f792c1de218f7de013393.1574153939.git.eswara.kota@linux.intel.com>
 <20191123004219.GA14198@bogus>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <e2ba7c95-ce75-22d8-d70e-0cc8d04b5c49@linux.intel.com>
Date:   Mon, 25 Nov 2019 14:50:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191123004219.GA14198@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/23/2019 8:42 AM, Rob Herring wrote:
> On Wed, Nov 20, 2019 at 02:10:23PM +0800, Dilip Kota wrote:
>> Add YAML schemas for the reset controller on Intel
>> Gateway SoC.
>>
>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
>> ---
>> Changes on v3:
>> 	Fix DTC warnings
>> 	Add support to legacy xrx200 SoC
>> 	Change file name to intel,rcu-gw.yaml
>>
>>   .../devicetree/bindings/reset/intel,rcu-gw.yaml    | 59 ++++++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
>> new file mode 100644
>> index 000000000000..743be2c49fb8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
>> @@ -0,0 +1,59 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/reset/intel,rcu-gw.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: System Reset Controller on Intel Gateway SoCs
>> +
>> +maintainers:
>> +  - Dilip Kota <eswara.kota@linux.intel.com>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
> You can drop oneOf and items here.
Ok.
Got it, mentioning 'enum:' tells that compatible will take one of the 
enum values. (Again, I just gone through existing yaml files after 
reading your comment).

So, no need of oneOf and items:,  I will update in the next patch revision.

>
>> +          - enum:
>> +              - intel,rcu-lgm
>> +              - intel,rcu-xrx200
>> +
>> +  reg:
>> +    description: Reset controller registers.
> maxItems: 1
Ok. I will add it.
>
>> +
>> +  intel,global-reset:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description: Global reset register offset and bit offset.
> maxItems: 2
Ok. I will add it.

Regards,
Dilip
>
>> +
>> +  "#reset-cells":
>> +    minimum: 2
>> +    maximum: 3
>> +    description: |
>> +      First cell is reset request register offset.
>> +      Second cell is bit offset in reset request register.
>> +      Third cell is bit offset in reset status register.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - intel,global-reset
>> +  - "#reset-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    rcu0: reset-controller@e0000000 {
>> +        compatible = "intel,rcu-lgm";
>> +        reg = <0xe0000000 0x20000>;
>> +        intel,global-reset = <0x10 30>;
>> +        #reset-cells = <2>;
>> +    };
>> +
>> +    pwm: pwm@e0d00000 {
>> +        status = "disabled";
>> +        compatible = "intel,lgm-pwm";
>> +        reg = <0xe0d00000 0x30>;
>> +        clocks = <&cgu0 1>;
>> +        #pwm-cells = <2>;
>> +        resets = <&rcu0 0x30 21>;
>> +    };
>> -- 
>> 2.11.0
>>
