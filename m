Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEA5C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A43A22CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbfHZJw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 05:52:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:18290 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfHZJw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:52:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 02:52:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,431,1559545200"; 
   d="scan'208";a="181327932"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 26 Aug 2019 02:52:57 -0700
Received: from [10.226.39.22] (ekotax-mobl.gar.corp.intel.com [10.226.39.22])
        by linux.intel.com (Postfix) with ESMTP id B73805807C5;
        Mon, 26 Aug 2019 02:52:55 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] dt-bindings: reset: Add YAML schemas for the Intel
 Reset controller
To:     Rob Herring <robh@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
References: <42039170811f798b8edc66bf85166aefe7dbc903.1566531960.git.eswara.kota@linux.intel.com>
 <CAL_JsqJxh5TzDb8kOFm+F5Gs4WXF6BP5uaNPLcyx+srtaDisMw@mail.gmail.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <746ed130-a1ae-0cc2-5060-70de95cdf2fe@linux.intel.com>
Date:   Mon, 26 Aug 2019 17:52:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJxh5TzDb8kOFm+F5Gs4WXF6BP5uaNPLcyx+srtaDisMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 8/23/2019 8:25 PM, Rob Herring wrote:
> On Fri, Aug 23, 2019 at 12:28 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
>> Add YAML schemas for the reset controller on Intel
>> Lightening Mountain (LGM) SoC.
>>
>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
>> ---
>> Changes on v2:
>>      Address review comments
>>        Update the compatible property definition
>>        Add description for reset-cells
>>        Add 'additionalProperties: false' property
>>
>>   .../bindings/reset/intel,syscon-reset.yaml         | 53 ++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml b/Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml
>> new file mode 100644
>> index 000000000000..3403a967190a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml
>> @@ -0,0 +1,53 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/reset/intel,syscon-reset.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Intel Lightening Mountain SoC System Reset Controller
>> +
>> +maintainers:
>> +  - Dilip Kota <eswara.kota@linux.intel.com>
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: intel,rcu-lgm
>> +      - const: syscon
>> +
>> +  reg:
>> +    description: Reset controller register base address and size
>> +
>> +  intel,global-reset:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description: Global reset register offset and bit offset.
>> +
>> +  "#reset-cells":
>> +    const: 2
>> +    description: |
>> +      The 1st cell is the register offset.
>> +      The 2nd cell is the bit offset in the register.
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
>> +    rcu0: reset-controller@00000000 {
>> +        compatible = "intel,rcu-lgm", "syscon";
>> +        reg = <0x000000 0x80000>;
>> +        intel,global-reset = <0x10 30>;
>> +        #reset-cells = <2>;
>> +    };
>> +
>> +    pcie_phy0: pciephy@... {
>> +        ...
> You need to run 'make dt_binding_check' and fix the warnings. The
> example has to be buildable and it is not.

Sure, i  will correct this pcie_phy0 node. But i didn't get any warnings 
for make dt_binding_check

   CHKDT Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml
DTC Documentation/devicetree/bindings/arm/renesas.example.dt.yaml
FATAL ERROR: Unknown output format "yaml"

Will DTC report about the example node errors? But, DTC is failing with 
FATAL_ERROR.
I tried it even after installing libyaml and headers in my local 
directory and export the path, but no luck.(ref: 
https://lkml.org/lkml/2018/12/3/951)
Could you please let me know if i miss anything and help me to proceed 
further.

Regards,
Dilip
>
>> +        /* address offset: 0x10, bit offset: 12 */
>> +        resets = <&rcu0 0x10 12>;
>> +        ...
>> +    };
>> --
>> 2.11.0
>>
