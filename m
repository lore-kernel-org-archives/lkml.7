Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0B1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D73C2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfCLTNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 15:13:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:56185 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727091AbfCLTNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 15:13:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 12:13:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,471,1544515200"; 
   d="scan'208";a="151074269"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by fmsmga002.fm.intel.com with ESMTP; 12 Mar 2019 12:13:36 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCHv2 1/5] Documentation: dt: edac: Fix Stratix10 IRQ bindings
To:     Rob Herring <robh@kernel.org>
Cc:     bp@alien8.de, dinguyen@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1551288445-22335-1-git-send-email-thor.thayer@linux.intel.com>
 <1551288445-22335-2-git-send-email-thor.thayer@linux.intel.com>
 <20190312160057.GA31306@bogus>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <8b18501b-e120-97f2-f6b5-4771dc0f613f@linux.intel.com>
Date:   Tue, 12 Mar 2019 14:15:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190312160057.GA31306@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 3/12/19 11:00 AM, Rob Herring wrote:
> On Wed, Feb 27, 2019 at 11:27:21AM -0600, thor.thayer@linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> Fix Stratix10 ECC bindings to specify only the single
>> bit error. On Stratix10 double bit errors are handled
>> as SErrors instead of interrupts.
>> Indicate the differences between the ARM64 and ARM32
>> EDAC architecture in the bindings.
>>
>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
>> ---
>> v2 No change
>> ---
>>   .../devicetree/bindings/edac/socfpga-eccmgr.txt    | 23 +++++++++++++++-------
>>   1 file changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
>> index 5626560a6cfd..a0ac50e15912 100644
>> --- a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
>> +++ b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
>> @@ -236,33 +236,42 @@ Stratix10 SoCFPGA ECC Manager
>>   The Stratix10 SoC ECC Manager handles the IRQs for each peripheral
>>   in a shared register similar to the Arria10. However, ECC requires
>>   access to registers that can only be read from Secure Monitor with
>> -SMC calls. Therefore the device tree is slightly different.
>> +SMC calls. Therefore the device tree is slightly different. Note that
>> +only 1 interrupt is sent because the double bit errors are treated as
>> +SErrors instead of IRQ.
>>   
>>   Required Properties:
>>   - compatible : Should be "altr,socfpga-s10-ecc-manager"
>> -- interrupts : Should be single bit error interrupt, then double bit error
>> -	interrupt.
>> +- altr,sysgr-syscon : phandle to Stratix10 System Manager Block
>> +	              containing the ECC manager registers.
> 
> Seems this was already in use, but why not just make this node a child
> of the System Manager Block and remove this phandle?
> 
Yes, this was already in use but I'm trying to fix that oversight with 
this patch.

The System Manager is a collection of registers used by different 
peripherals including EMAC and ECC.

I view ECC Manager as a separate entity as is the Ethernet MAC which is 
why I have it separate. Using the phandle also follows the convention 
established with the Arria10 ECC Manager.

Thanks for the comments and for reviewing!

Thor

>> +- interrupts : Should be single bit error interrupt.
>>   - interrupt-controller : boolean indicator that ECC Manager is an interrupt controller
>>   - #interrupt-cells : must be set to 2.
>> +- #address-cells: must be 1
>> +- #size-cells: must be 1
>> +- ranges : standard definition, should translate from local addresses
>>   
>>   Subcomponents:
>>   
>>   SDRAM ECC
>>   Required Properties:
>>   - compatible : Should be "altr,sdram-edac-s10"
>> -- interrupts : Should be single bit error interrupt, then double bit error
>> -	interrupt, in this order.
>> +- interrupts : Should be single bit error interrupt.
>>   
>>   Example:
>>   
>>   	eccmgr {
>>   		compatible = "altr,socfpga-s10-ecc-manager";
>> -		interrupts = <0 15 4>, <0 95 4>;
>> +		altr,sysmgr-syscon = <&sysmgr>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		interrupts = <0 15 4>;
>>   		interrupt-controller;
>>   		#interrupt-cells = <2>;
>> +		ranges;
>>   
>>   		sdramedac {
>>   			compatible = "altr,sdram-edac-s10";
>> -			interrupts = <16 4>, <48 4>;
>> +			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
>>   		};
>>   	};
>> -- 
>> 2.7.4
>>
> 

