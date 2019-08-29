Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D872C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 01:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4FE233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 01:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfH2Bpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 21:45:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:18130 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbfH2Bpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 21:45:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 18:45:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="192795343"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 28 Aug 2019 18:45:39 -0700
Received: from [10.226.38.21] (vramuthx-mobl1.gar.corp.intel.com [10.226.38.21])
        by linux.intel.com (Postfix) with ESMTP id 2A1B8580107;
        Wed, 28 Aug 2019 18:45:36 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: intel-sdxc-phy: Add YAML schema
 for LGM SDXC PHY
To:     "Langer, Thomas" <thomas.langer@intel.com>,
        "kishon@ti.com" <kishon@ti.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Kim, Cheol Yong" <cheol.yong.kim@intel.com>,
        "Wu, Qiming" <qi-ming.wu@intel.com>,
        "Liem, Peter Harliman" <peter.harliman.liem@intel.com>
References: <20190828124315.48448-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190828124315.48448-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <0DAF21CFE1B20740AE23D6AF6E54843F1FDDE99F@IRSMSX108.ger.corp.intel.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <d14411be-434c-ed02-6d85-f70d4a0acded@linux.intel.com>
Date:   Thu, 29 Aug 2019 09:45:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0DAF21CFE1B20740AE23D6AF6E54843F1FDDE99F@IRSMSX108.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Langer,

Thank you for the review comments.

On 28/8/2019 11:37 PM, Langer, Thomas wrote:
> Hi Vadivel,
>
>> +...
>> diff --git a/Documentation/devicetree/bindings/phy/intel,syscon.yaml
>> b/Documentation/devicetree/bindings/phy/intel,syscon.yaml
>> new file mode 100644
>> index 000000000000..d0b78805e49f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/intel,syscon.yaml
>> @@ -0,0 +1,33 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/intel,syscon.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Syscon for eMMC/SDXC PHY Device Tree Bindings
> This says the binding is for eMMC/SDXC
Agreed, fix it.
>> +
>> +maintainers:
>> +  - Ramuthevar Vadivel Murugan
>> <vadivel.muruganx.ramuthevar@linux.intel.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: intel,syscon
> but this is a generic syscon, behind which are many registers, not only for
> eMMC/SDXC. Also, the registers will be different for each SoC and needed for
> many different drivers, that is why in your example it is called "chiptop"
> -> toplevel registers not belonging to a specific HW module.
>
> Rob: Do you also think this "intel,syscon" is too generic?
>       And the binding should be outside the "phy" folder?
>
> What is the way to support different SoCs with this?
> Must the driver referencing this syscon be aware of these differences?

[Vadivel] : most of the IP drivers are using syscon, please suggest me 
to keep in the right place since

it is common to all(w.r.t Intel's Lightning Mountain).

Best Regards
Vadivel
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#reset-cells":
>> +   const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - "#reset-cells"
>> +
>> +examples:
>> +  - |
>> +    sysconf: chiptop@e0020000 {
>> +       compatible = "intel,syscon", "syscon";
>> +       reg = <0xe0020000 0x100>;
>> +       #reset-cells = <1>;
>> +    };
>> --
>> 2.11.0
> Best regards,
> Thomas
